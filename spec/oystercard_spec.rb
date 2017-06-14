require 'oystercard.rb'

describe Oystercard do

  let(:topped_up_card) { described_class.new(10) }

  describe '#initialize' do
    it 'starts with a default balance' do
      expect(subject.balance).to eq 0
    end

    it 'starts with an entry station set to nil' do
      expect(subject.entry_station).to eq nil
    end

    it 'starts with an empty journey history' do
      expect(subject.journeys).to be_empty
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
    let(:station) { double :station }
    it 'checks if the card is in use' do
      topped_up_card.touch_in(station)
      expect(topped_up_card).to be_in_journey
    end
  end

  describe '#touch_in' do
    let(:station) { double :station }

    it 'doesn\'t allow you to touch in without a minimum balance' do
      expect { subject.touch_in(station) }.to raise_error("£#{Oystercard::MIN_FARE} balance required. Top up first")
    end

    it 'saves the entry station' do
      topped_up_card.touch_in('London Bridge')
      expect(topped_up_card.journeys[0][:entry_station]).to eq 'London Bridge'
    end
  end

  describe '#touch_out' do
    let(:station) { double :station }
    let(:exit_station) { double :exit_station }

    it 'can be touched out' do
      expect(subject).to respond_to :touch_out
    end

    it 'deducts the fare from the card' do
      topped_up_card.touch_in(station)
      expect { topped_up_card.touch_out(exit_station) }.to change { topped_up_card.balance }.by(-Oystercard::MIN_FARE)
    end

    it 'forgets the entry station' do
      topped_up_card.touch_in(station)
      topped_up_card.touch_out(exit_station)
      expect(topped_up_card.entry_station).to eq nil
    end

    it 'saves the exit station' do
      topped_up_card.touch_in('London Bridge')
      topped_up_card.touch_out('Bank')
      expect(topped_up_card.journeys[0][:exit_station]).to eq 'Bank'
    end
  end
end
