require "cs_premium_ids/errors"
require "cs_premium_ids/value_objects"
require "cs_premium_ids/events"
require "cs_premium_ids/premium_card"
require "cs_premium_ids/commands"
require "cs_premium_ids/commands_handlers"

class CSPremiumIDs
  def initialize(event_store, time_now_proc = proc { Time.now.utc })
    @commands_handlers = CommandsHandlers.new(event_store, time_now_proc)
  end

  def exec(commands)
    Array(commands).each { |c| @commands_handlers.handle(c) }
  end
end
