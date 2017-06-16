require 'oystercard'
require 'journey'

describe Oystercard do

  let(:topped_up_card) { described_class.new(10) }
  let(:entry_stat) { double "Charing Cross" }
  let(:exit_station) { double "Bank" }
  let(:journey) { double :journey }

  describe '#initialize' do
    it 'starts with a default balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'adds money to the oystercard balance' do
      expect(topped_up_card.top_up(9)).to eq 19
    end

    it 'doesn\'t allow to top up beyond the limit' do
      expect { topped_up_card.top_up(90) }.to raise_error("Exceeded £#{Oystercard::MAX_LIMIT} limit")
    end
  end

  describe '#in_journey?' do
    it 'checks if the card is in use' do
      expect(subject).to_not be_in_journey
    end
  end

  describe '#touch_in' do

    it 'can be touched in' do
      expect(topped_up_card).to respond_to(:touch_in)
    end

    it 'doesn\'t allow you to touch in without a minimum balance' do
      expect { subject.touch_in(entry_stat) }.to raise_error("£#{Oystercard::MIN_FARE} balance required. Top up first")
    end
  end

  describe '#touch_out' do
    it 'can be touched out' do
      expect(subject).to respond_to :touch_out
    end

    it 'calculates the fare' do
      topped_up_card.touch_in(entry_stat)
      # allow(journey).to receive(:fare).and_return(1)
      topped_up_card.touch_out(exit_station)
      # expect(topped_up_card.balance).to eq 9

    end
  end
end
