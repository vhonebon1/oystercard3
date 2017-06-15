require 'oystercard'
require 'journey'

describe Oystercard do

  let(:topped_up_card) { described_class.new(10) }

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
    let(:station) { double :station }

    it 'can be touched in' do
      expect(topped_up_card).to respond_to :touch_in
    end

    it 'doesn\'t allow you to touch in without a minimum balance' do
      expect { subject.touch_in(station) }.to raise_error("£#{Oystercard::MIN_FARE} balance required. Top up first")
    end
  end

  describe '#touch_out' do
    let(:entry_station) { double :entry_station }
    let(:exit_station) { double :exit_station }
    let(:journey) { double :journey }

    it 'can be touched out' do
      expect(subject).to respond_to :touch_out
    end

    it 'deducts the fare from the card' do

      expect { topped_up_card.touch_out(exit_station) }.to change { topped_up_card.balance }.by(journey.fare)
    end
  end
end
