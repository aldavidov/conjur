# frozen_string_literal: true

require 'types'

module Authentication

  # :reek:InstanceVariableAssumption
  class UpdateAuthenticatorConfigInput < ::Dry::Struct

    attribute :authenticator_name, ::Types::NonEmptyString
    attribute :service_id, ::Types::NonEmptyString.optional
    attribute :account, ::Types::NonEmptyString
    attribute :username, ::Types::NonEmptyString
    attribute :enabled, ::Types::NonEmptyString
    attribute :client_ip, ::Types::NonEmptyString

    def webservice
      @webservice ||= ::Authentication::Webservice.new(
        account: @account,
        authenticator_name: @authenticator_name,
        service_id: @service_id
      )
    end

    # :reek:NilCheck
    def role
      return nil if @username.nil?

      ::Role.by_login(@username, account: @account)
    end
  end
end
