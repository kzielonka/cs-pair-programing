class CSPremiumIDs
  class CommandsHandlers
    class ActivateCard < Handler
      def handles?(cmd)
        cmd.is_a?(Commands::ActivateCard)
      end

      def handle(cmd)
        premium_id = PremiumId(cmd.premium_id)
        code = Code(cmd.code)
        activator_id = UserId(cmd.activator_id)

        with_premium_card(premium_id) do |card|
          card.activate_card(code, activator_id)
        end
      rescue PremiumCard::InvalidCodeError
        raise Errors::InvalidCode
      rescue PremiumCard::CardAlreadyAssignedError
        raise Errors::InvalidCode
      end
    end
  end
end
