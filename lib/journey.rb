class Journey
  attr_reader :entry_station, :journeys, :journey

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @journeys = []
    @journey = {}
  end

  def start_journey(entry_station)
    @journey.clear
    @journey[:entry_station] = entry_station.name
    @journeys << @journey
  end

  def finish_journey(exit_station)
    @journey[:exit_station] = exit_station.name
  end

  def fare
    (@journey[:entry_station] == nil || @journey[:exit_station] == nil) ? 6 : Oystercard::MIN_FARE
  end
end
