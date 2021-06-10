require_relative "station"
require_relative "journey"

class Oyster

  MAX_BALANCE = 90
  MIN_FARE = 1
  attr_reader :balance, :entry_station, :exit_station, :journey_history

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
    # @in_use = false
    @journey_history = []
  end

  # (card)
  def top_up(money)
    fail "Oh no! You reached the max balance" if money + balance > MAX_BALANCE
    @balance += money
  end

  def touch_in(entry_station)
    raise "Ops! Top it up!" if balance < MIN_FARE
    @entry_station = entry_station
    @journey.entry_station = entry_station
    @journey.start_journey
    # @in_use = true
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @exit_station = exit_station
    @journey.exit_station = exit_station
    @journey.end_journey
    @journey_history << {:entry => @entry_station, :exit => @exit_station}
    @entry_station = nil
    # @in_use = false
  end

  def in_journey?
    @journey.in_journey
    # @entry_station != nil
  end

  # (card)
  def deduct(money)
    @balance -= money
  end

end
