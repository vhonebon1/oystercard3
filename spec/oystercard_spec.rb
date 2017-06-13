require 'oystercard.rb'

describe Oystercard do
  it { is_expected.to respond_to :balance }

  it { is_expected.to respond_to(:top_up).with(1).argument }

  let(:topped_up_card) { described_class.new(10)}

  describe '#top_up' do
    it 'adds money to the oystercard balance' do
      expect(topped_up_card.top_up(9)).to eq 19
    end

    it 'doesn\'t allow to top up beyond the limit' do
      expect { topped_up_card.top_up(90) }.to raise_error("Exceeded £#{Oystercard::MAX_LIMIT} limit")
    end
  end

  describe '#deduct' do
    it 'should deduct money from the balance' do
      expect(topped_up_card.deduct(5)).to eq 5
    end
  end
end
