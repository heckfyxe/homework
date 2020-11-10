require_relative 'instance_counter'
require_relative 'validator'

class Route
  include InstanceCounter
  include Validator

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]

    register_instance
    valid!
  end

  def add(station)
    @stations.insert(@stations.length - 1, station) unless @stations.include?(station)
  end

  def length
    stations.length
  end

  def delete(station)
    @stations.delete(station)
  end

  protected

  def valid!
    raise 'Route has same stations' unless @stations.uniq.length == @stations.length
  end
end
