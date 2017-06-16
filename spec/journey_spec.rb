require "journey"
require "oystercard"

describe Journey do
  let(:trip) { described_class.new(entry_station = nil)}
  let(:card) { Oystercard.new(50) }
  let(:entry) { double ("Mile End") }
  let(:exit_stat) {double ("London Bridge")}

  describe '#initialize' do
    it 'initializes the journey with an entry_station set to nil' do
      expect(trip.entry_station).to eq nil
    end

    it 'starts with an empty journey history' do
      expect(trip.journeys).to eq []
    end
  end

  describe '#start_journey' do
    it 'saves the entry_station' do
      allow(entry).to receive(:name).and_return("Mile End")
      trip.start_journey(entry)
      expect(trip.journeys).to eq [{:entry_station => entry}]
    end
  end

  describe '#finish_journey' do
    it 'saves the exit_station' do
      trip.start_journey(entry)
      trip.finish_journey(exit_stat)
      expect(trip.journeys).to eq [{:entry_station => entry, :exit_station => exit_stat}]
    end
  end

  describe '#fare' do
    context 'returns the penalty fare if journey is not complete' do
      it 'has no touch in' do
        allow(exit_stat).to receive(:name).and_return("London Bridge")
        expect(trip.fare).to eq 6
      end
    end
  end
end
