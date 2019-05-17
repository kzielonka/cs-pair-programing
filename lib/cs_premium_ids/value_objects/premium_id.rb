class CSPremiumIDs
  module ValueObjects
    class PremiumId
      def initialize(id)
        @id = String(id).dup.freeze
        raise ArgumentError, "invalid premium id" unless valid?
      end

      def to_s
        @id
      end

      def to_i
        @id.to_i
      end

      def ==(other)
        to_s == other.to_s
      end

      alias :eql? ==

      def <=>(other)
        case digits <=> other.digits
        when -1 then return -1
        when  0 then return to_s <=> other.to_s
        when  1 then return  1
        else raise "unexpected <=> result"
        end
      end

      def digits
        @id.size
      end

      private

      def valid?
        @id.match(/\A[1-9][0-9]{0,8}\z/)
      end
    end
  end
  private_constant :ValueObjects
end
