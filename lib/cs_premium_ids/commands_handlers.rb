require_relative "./commands_handlers/handler"

Dir[File.join(File.dirname(__FILE__), "commands_handlers", "*.rb")].each { |f| require f }

class CSPremiumIDs
  class CommandsHandlers
    def initialize(event_store, time_now_proc)
      @handlers = self.class.find_handlers.map do |h|
        h.new(event_store, time_now_proc)
      end
    end

    def self.find_handlers
      constants.map(&method(:const_get))
    end

    def handle(command)
      handler = @handlers.find { |h| h.handles?(command) }
      return if handler.nil?
      handler.handle(command)
      nil
    end
  end
  private_constant :CommandsHandlers
end
