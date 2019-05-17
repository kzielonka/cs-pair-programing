class CSPremiumIDs
  class CommandsHandlers
    class ChangeActivationCode < Handler
      def handles?(cmd)
        cmd.is_a?(Commands::ChangeActivationCode)
      end

      def handle(cmd)
        premium_id = fetch_premium_id(cmd)
        code = fetch_code(cmd)

        with_premium_card(premium_id) do |card|
          card.change_activation_code(code)
        end
      rescue PremiumCard::UpdateFrobiddenError
        raise Errors::PremiumIdUpdateDisallowed
      end

      private

      def fetch_premium_id(cmd)
        PremiumId(cmd.premium_id)
      rescue ArgumentError => e
        raise Errors::InvalidPremiumId, e.message
      end

      def fetch_code(cmd)
        Code(cmd.code)
      rescue ArgumentError => e
        raise Errors::InvalidCode, e.message
      end
    end
  end
end
