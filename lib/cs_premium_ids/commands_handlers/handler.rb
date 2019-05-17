class CSPremiumIDs
  class CommandsHandlers
    class Handler
      include ValueObjects

      def initialize(event_store, time_now_proc)
        @event_store = event_store
        @time_now_proc = time_now_proc
      end

      def handles?
        raise NotImplementedError
      end

      private

      def with_premium_card(premium_id)
        stream = "CSPremiumIDs::PremiumCard$#{premium_id}"
        card = PremiumCard.new(premium_id, @time_now_proc)
        card.load(stream, event_store: @event_store)
        yield card
        card.store(event_store: @event_store)
      end
    end
    private_constant :Handler
  end
end
