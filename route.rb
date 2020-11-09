require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]

    register_instance
  end

  def add(station)
    @stations.insert(@stations.length - 1, station)
  end

  def length
    stations.length
  end

  def delete(station)
    @stations.delete(station)
  end
end
