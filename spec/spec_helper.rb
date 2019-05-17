require "cs_premium_ids"

class EventStoreFake
  def initialize
    @streams = Hash.new { |h, k| h[k] = [] }
    @subscribers = Hash.new { |h, k| h[k] = [] }
    @events = []
  end

  def all_events
    @events
  end

  def read
    self
  end

  def in_batches(*_)
    self
  end

  def each
    @events.each { |ev| yield ev }
  end

  def stream(name)
    @streams[String(name)]
  end

  def publish(events, options)
    @events.concat(events)
    @streams[String(options.fetch(:stream_name))].concat(events)
    events.each do |ev|
      @subscribers[ev.class].each { |s| s.call(ev) }
    end
  end

  def subscribe(handler, opts)
    Array(opts[:to]).each { |ev| @subscribers[ev] << handler }
  end
end

RSpec::Matchers.define :have_event do |expected|
  match do |es|
    es.all_events.any? { |ev| ev.class == expected.class && ev.data == expected.data }
  end

  failure_message do |es|
    "Expected event was:\n\n" \
      "#{expected.class}\n#{expected.data}\n\n" \
      "but got:\n\n" \
      "#{es.all_events.map { |ev| "#{ev.class}\n#{ev.data}" }.join("\n\n")}"
  end
end
