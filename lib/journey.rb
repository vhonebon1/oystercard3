class Journey
  attr_reader :entry_station, :journeys, :hash, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @journeys = []
    @hash = {}
  end

  def start_journey(entry_station)
    @hash.clear
    @hash[:entry_station] = entry_station
    @journeys << @hash
  end

  def finish_journey(exit_station)
    @hash[:exit_station] = exit_station
    @journeys << @hash
  end

  def fare
    (@hash[:entry_station] == nil || @hash[:exit_station] == nil) ? 6 : Oystercard::MIN_FARE
  end
end
