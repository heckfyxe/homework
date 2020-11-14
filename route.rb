require_relative 'instance_counter'
require_relative 'accessors'

class Route
  include InstanceCounter
  include Accessors

  attr_accessor_with_history :stations

  def initialize(start_station, end_station)
    self.stations = [start_station, end_station]

    register_instance
  end

  def add(station)
    self.stations = stations[0...(stations.length - 1)] + [station] + [stations.last] unless stations.include?(station)
  end

  def length
    stations.length
  end

  def delete(station)
    index = stations.index(station)
    self.stations = stations[0...index] + stations[(index + 1)..-1]
  end
end
