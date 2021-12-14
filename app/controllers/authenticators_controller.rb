# frozen_string_literal: true

class AuthenticatorsController < RestController
  include FindResource
  include AuthorizeResource
  
  before_action :current_user
  before_action :find_or_create_root_policy

  rescue_from Sequel::UniqueConstraintViolation, with: :concurrent_load

  def initialize_auth
    loaded_policy = _initialize_auth
    render(body: loaded_policy, content_type: "text/yaml", status: :created)
  end

  def initialize_auth_host
    loaded_policy = _initialize_auth_host
    render(body: loaded_policy, content_type: "text/yaml", status: :created)
  end

  protected

  def find_or_create_root_policy
    Loader::Types.find_or_create_root_policy(account)
  end

  private

  def _initialize_auth
    case params[:authenticator]
    when "authn-k8s"
      initialize_specific_auth(Authentication::AuthnK8s::K8sAuthenticatorData, Authentication::AuthnK8s::InitializeK8sAuth)
    when "authn-azure"
      initialize_specific_auth(Authentication::AuthnAzure::AzureAuthenticatorData)
    when "authn-oidc"
      initialize_specific_auth(Authentication::AuthnOidc::OidcAuthenticatorData)
    else
      raise ArgumentError, "Not implemented for authenticator %s" % params[:authenticator]
    end
  end

  def _initialize_auth_host
    case params[:authenticator]
    when "authn-k8s"
      initialize_k8s_auth_host
    else
      raise ArgumentError, "Not implemented for authenticator %s" % params[:authenticator]
    end
  end

  def initialize_k8s_auth_host
    request_data = JSON.parse(request.raw_post)
    Authentication::InitializeAuthHost.new.(
      conjur_account: params[:account],
      service_id: params[:service_id],
      authenticator: params[:authenticator],
      resource: find_or_create_root_policy,
      current_user: current_user,
      client_ip: request.ip,
      host_id: request_data['id'],
      annotations: request_data.include?('annotations') ? request_data['annotations'] : {}
    )
  end

  def initialize_specific_auth(auth_dataclass, auth_initializer=Authentication::Default::InitializeDefaultAuth)
    auth_data = auth_dataclass.new(request.raw_post)
    Authentication::InitializeAuth.new(
      auth_initializer: auth_initializer.new
    ).(
      conjur_account: params[:account],
      service_id: params[:service_id],
      resource: find_or_create_root_policy,
      current_user: current_user,
      client_ip: request.ip,
      auth_data: auth_data
    )
  end

  # TODO: This method is duplicated in the policies controller
  def concurrent_load(_exception)
    response.headers['Retry-After'] = retry_delay
    render(json: {
      error: {
        code: "policy_conflict",
        message: "Concurrent policy load in progress, please retry"
      }
    }, status: :conflict)
  end
end
