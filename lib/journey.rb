class Journey
  attr_reader :entry_station, :journeys, :journey

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @journeys = []
    @journey = {}
  end

end
