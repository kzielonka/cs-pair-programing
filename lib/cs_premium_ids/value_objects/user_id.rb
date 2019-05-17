class CSPremiumIDs
  module ValueObjects
    class UserId
      def initialize(user_id)
        @user_id = String(user_id).dup.freeze
        raise ArgumentError, "invalid user id: #{user_id.inspect}" unless valid?
      end

      def to_s
        @user_id
      end

      def ==(other)
        to_s == other.to_s
      end

      def eql?(other)
        self == other
      end

      def set?
        !@user_id.empty?
      end

      def unset?
        !set?
      end

      private

      def valid?
        return true if @user_id.empty?
        @user_id.match(/\A[a-zA-Z0-9\-]{1,100}\z/)
      end
    end
  end
end
