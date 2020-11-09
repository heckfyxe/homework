require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @stations = []

  class << self
    attr_accessor :stations

    def all
      @stations
    end
  end

  def initialize(name)
    @name = name
    @trains = []

    self.class.stations << self
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def remove_train(train)
    trains.delete(train)
  end
end
