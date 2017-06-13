# lib/oystercard.rb
class Oystercard
  attr_reader :balance
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(money)
    raise "Exceeded £#{MAX_LIMIT} limit" if limit_reached?(money)
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

private

  def limit_reached?(money)
    @balance + money > MAX_LIMIT
  end
end
