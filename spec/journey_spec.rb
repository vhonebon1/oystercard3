require "journey"
require "oystercard"

describe Journey do
  let(:trip) { described_class.new(entry_station = nil)}
  let(:card) { Oystercard.new(50) }
  let(:entry_station) do
    entry_station = double "Mile End"
    allow(entry_station).to receive(:name) { "Mile End" }
    entry_station
  end

  let(:exit_station) do
    exit_station = double "London Bridge"
    allow(exit_station).to receive(:name) { "London Bridge" }
    exit_station
  end

  describe '#initialize' do
    it 'initializes the journey with an entry_station set to nil' do
      expect(trip.entry_station).to eq nil
    end

    it 'starts with an empty journey history' do
      expect(trip.journeys).to eq []
    end

    it 'starts with an empty journey' do
      expect(trip.journey).to be_empty
    end
  end

  describe '#start_journey' do
    it 'saves the entry_station' do
      trip.start_journey(entry_station)
      expect(trip.journeys).to eq [{:entry_station => "Mile End"}]
    end
  end

  describe '#finish_journey' do
    it 'saves the exit_station' do
      trip.start_journey(entry_station)
      trip.finish_journey(exit_station)
      expect(trip.journeys).to eq [{:entry_station => "Mile End", :exit_station => "London Bridge"}]
    end
  end

  describe '#fare' do
    it 'returns the penalty fare if the journey is incomplete' do
      allow(entry_station).to receive(:name).and_return(nil)
      expect(trip.fare).to eq 6
    end
  end
end




    #
    # it 'forgets the entry station' do
    #   topped_up_card.touch_in(station)
    #   topped_up_card.touch_out(exit_station)
    #   expect(topped_up_card.entry_station).to eq nil
    # end
