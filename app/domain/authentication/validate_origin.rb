# frozen_string_literal: true

module Authentication
  ValidateOrigin = CommandClass.new(
    dependencies: {
      role_cls: ::Role
    },
    inputs:       %i(input)
  ) do

    def call
      raise InvalidOrigin unless role.valid_origin?(@input.origin)
    end

    private

    def role
      @role_cls.by_login(@input.username, account: @input.account)
    end
  end
end
