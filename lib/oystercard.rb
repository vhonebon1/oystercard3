# lib/oystercard.rb
class Oystercard
  attr_reader :balance, :status
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE, status = :not_in_use)
    @balance = balance
    @status = status
  end

  def top_up(money)
    raise "Exceeded £#{MAX_LIMIT} limit" if limit_reached?(money)
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @status == :in_use
  end

  def touch_in
    @status = :in_use
  end

  def touch_out
    @status = :not_in_use
  end

private

  def limit_reached?(money)
    @balance + money > MAX_LIMIT
  end
end
