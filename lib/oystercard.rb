class Oystercard
  attr_reader :balance, :entry_station, :journeys, :exit_station
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE, entry_station = nil)
    @balance = balance
    @entry_station = entry_station
    @journeys = []
  end

  def top_up(money)
    raise "Exceeded £#{MAX_LIMIT} limit" if limit_reached?(money)
    @balance += money
  end

  def in_journey?
    @entry_station == entry_station
  end

  def touch_in(entry_station)
    raise "£#{MIN_FARE} balance required. Top up first" unless has_min_balance?
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @entry_station = nil
    @exit_station = exit_station
  end

  private

  def limit_reached?(money)
    @balance + money > MAX_LIMIT
  end

  def has_min_balance?
    @balance >= MIN_FARE
  end

  def deduct(min_fare)
    @balance -= MIN_FARE
  end
end
