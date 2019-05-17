require "bcrypt"

class CSPremiumIDs
  module ValueObjects
    class Code
      def initialize(code)
        if code == :not_set
          @code = :not_set
        else
          @code = String(code).dup.freeze
        end
        raise ArgumentError, "invalid code: #{code.inspect}" unless valid?
      end

      def to_s
        @code
      end

      def not_set?
        @code == :not_set
      end

      def ==(other)
        return false if not_set?
        BCrypt::Password.create(to_s) == other.to_s
      end

      def eql?(other)
        self == other
      end

      private

      def valid?
        # TODO: Refactor code to not allow empty codes
        return true if not_set?
        return true if @code.empty?
        @code.match(/\A[a-zA-Z0-9]{4,10}+\z/)
      end
    end
  end
end
