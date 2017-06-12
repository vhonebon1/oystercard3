# lib/oystercard.rb
class Oystercard
  DEFAULT_BALANCE = 0

  attr_reader :balance, :money

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(money)
    @balance += money
  end
end
