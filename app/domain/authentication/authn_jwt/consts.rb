# frozen_string_literal: true

module Authentication
  module AuthnJwt
    PROVIDER_URI_RESOURCE_NAME = "provider-uri"
    JWKS_URI_RESOURCE_NAME = "jwks-uri"
    ISSUER_RESOURCE_NAME = "issuer"
    IDENTITY_FIELD_VARIABLE = "token-app-property"
    IDENTITY_NOT_RETRIEVED_YET = "Identity not retrieved yet"
    PRIVILEGE_AUTHENTICATE="authenticate"
    ISS_CLAIM_NAME = "iss"
    EXP_CLAIM_NAME = "exp"
    NBF_CLAIM_NAME = "nbf"
    IAT_CLAIM_NAME = "iat"
    RSA_ALGORITHMS = %w[RS256 RS384 RS512].freeze
    ECDSA_ALGORITHMS = %w[ES256 ES384 ES512].freeze
    SUPPORTED_ALGORITHMS = (RSA_ALGORITHMS + ECDSA_ALGORITHMS).freeze
    CACHE_REFRESHES_PER_INTERVAL = 10
    CACHE_RATE_LIMIT_INTERVAL = 300 # 300 seconds (every 5 mins)
    CACHE_MAX_CONCURRENT_REQUESTS = 3
  end
end
