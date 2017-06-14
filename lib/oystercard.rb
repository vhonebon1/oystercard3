class Oystercard
  attr_reader :balance, :journeys
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
  end

  def top_up(money)
    raise "Exceeded £#{MAX_LIMIT} limit" if limit_reached?(money)
    @balance += money
  end

  def touch_in(entry_station)
    raise "£#{MIN_FARE} balance required. Top up first" unless has_min_balance?
    @journeys << { entry_station: entry_station }
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @journeys.last[:exit_station] = exit_station
  end

  def in_journey?
    !@journeys.last[:entry_station].nil? &&
    @journeys.last[:exit_station].nil?
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
