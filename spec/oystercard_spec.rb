require 'oystercard.rb'

describe Oystercard do
  describe '#initialize' do
    it 'starts with a default balance' do
      expect(subject.balance).to eq 0
    end

    it 'has an initial status' do
      expect(subject.status).to eq :not_in_use
    end
  end

  context 'Using a topped up card' do

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

  describe '#in_journey?' do
    it 'checks if the card is in use' do
      expect(subject).to_not be_in_journey
    end
  end

  describe '#touch_in' do
    it 'can be touched in' do
      expect(subject).to respond_to :touch_in
    end

    it 'changes the card status as in use' do
      subject.touch_in
      expect(subject.status).to eq :in_use
    end
  end

  describe '#touch_out' do
    it 'can be touched out' do
      expect(subject).to respond_to :touch_out
    end

    it 'changes the card status as not in use' do
      subject.touch_in
      subject.touch_out
      expect(subject.status).to eq :not_in_use
    end
  end
end
