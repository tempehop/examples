=begin
Given an unsorted list of sale events, find the minimum number of most recent events where
the total items sold is at least MAX_ITEMS.

Since the source of sales data can be potentially unbounded, limiting us from sorting, lets keep track of just the items
 we care about.

For examples sake, a random number were generated and kept in memory.
=end
require 'date'

class SaleEvent

  attr_reader :item_number, :number_sold, :event_date_time

  @@no_events = 0
  def initialize(item_number, number_sold, event_date_time)
    @item_number = item_number
    @number_sold = number_sold
    @event_date_time = event_date_time
    @@no_events += 1
  end

  def print_event
    puts "#@item_number #@number_sold #@event_date_time"
  end
end

class LimitedQueue

  attr_reader :events

  def initialize(max_items)
    @max_items = max_items
    @events = []
  end


  # for truly large sets we should use a btree
  def push(event)
    event.print_event

    @events.push(event)
    # A bit messy to sort this way - but the intent is to keep the list small
    # keep the newest items
    # For much larger result sets we could use a binary heap
    @events.sort! { | first, second |
      second.event_date_time <=> first.event_date_time
    }

    # remove excess items
    if @events.length > MAX_ITEMS
      @events.pop
    end
  end

end


# Magic variables for testing
MAX_ITEMS = 10
NUM_TO_CREATE = 100
MAX_COUNT = 50
MAX_DAYS_AGO = 500

# Test Output please ignore
puts "Finding the events for the last #{MAX_ITEMS} sold items."

# Intentionally keep the same seed
random = Random.new(1234)

all_events = []

# Create some random events to simulate a data feed
NUM_TO_CREATE.times do |i|
  time = DateTime.now - random.rand(MAX_DAYS_AGO)
  event = SaleEvent.new(i, random.rand(MAX_COUNT), time)
  #event.print
  all_events.push(event)
end

queue = LimitedQueue.new(MAX_ITEMS)
all_events.each do |event|
  queue.push(event)
end

puts 'Results: '

num_items = 0
queue.events.each { | i |
  i.print_event unless num_items > MAX_ITEMS
  num_items += i.number_sold
}






