class CSPremiumIDs
  module ValueObjects
    class ActivationCode
      attr_reader :premium_id, :code

      def initialize(premium_id, code)
        @premium_id = PremiumId.new(premium_id)
        @code = Code.new(code)
      end

      def ==(other)
        (premium_id == other.premium_id) and (code == other.code)
      end

      def eql?(other)
        self == other
      end
    end
  end
  private_constant :ValueObjects
end
