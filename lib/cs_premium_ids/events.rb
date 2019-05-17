require 'ruby_event_store'

class CSPremiumIDs
  module Events
    CardActivationCodeChanged    = Class.new(RubyEventStore::Event)
    CardActivated                = Class.new(RubyEventStore::Event)
  end
end
