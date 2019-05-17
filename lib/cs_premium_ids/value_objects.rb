require_relative "./value_objects/user_id"
require_relative "./value_objects/premium_id"
require_relative "./value_objects/activation_code"
require_relative "./value_objects/code"

class CSPremiumIDs
  module ValueObjects
    def UserId(id)
      UserId.new(id)
    end

    def PremiumId(id)
      PremiumId.new(id)
    end

    def Code(code)
      Code.new(code)
    end
  end
  private_constant :ValueObjects
end
