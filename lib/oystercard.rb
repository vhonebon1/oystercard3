class Oystercard
  attr_reader :balance, :status, :min_fare
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE, status = :not_in_use)
    @status = status
    @balance = balance
  end

  def top_up(money)
    raise "Exceeded £#{MAX_LIMIT} limit" if limit_reached?(money)
    @balance += money
  end

  def in_journey?
    @status == :in_use
  end

  def touch_in
    raise "£#{MIN_FARE} balance required. Top up first" unless has_min_balance?
    @status = :in_use
  end

  def touch_out
    @status = :not_in_use
    deduct(MIN_FARE)
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
