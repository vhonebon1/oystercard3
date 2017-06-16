require './lib/journey.rb'
require './lib/station.rb'


class Oystercard
  attr_reader :balance
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(money)
    raise "Exceeded £#{MAX_LIMIT} limit" if limit_reached?(money)
    @balance += money
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(entry_station)
    raise "£#{MIN_FARE} balance required. Top up first" unless has_min_balance?
    new_journey
    @journey.start_journey(entry_station)
  end

  def touch_out(exit_station)
    if @hash == {}
      new_journey.finish_journey(exit_station)
      deduct
    else
      @journey.finish_journey(exit_station)
      deduct
    end
  end

  def new_journey
    @journey = Journey.new
  end

  def deduct
    @balance - @journey.fare
  end

  private

  def limit_reached?(money)
    @balance + money > MAX_LIMIT
  end

  def has_min_balance?
    @balance >= MIN_FARE
  end
end

#
# card = Oystercard.new(20)
# station1 = Station.new("Mile End", 1)
# station2 = Station.new("Stepney Green", 1)
# card.touch_in(station1)
# card.touch_out(station2)
#
# puts card.balance
