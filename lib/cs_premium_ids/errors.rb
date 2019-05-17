class CSPremiumIDs
  module Errors
    PremiumIdUpdateDisallowed = Class.new(RuntimeError)
    InvalidCode = Class.new(RuntimeError)
    InvalidPremiumId = Class.new(RuntimeError)
    CardUpdateIsForbidden = Class.new(RuntimeError)
  end
end
