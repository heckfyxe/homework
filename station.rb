require_relative 'instance_counter'
require_relative 'validator'

class Station
  include InstanceCounter
  include Validator

  attr_reader :name, :trains

  validate :stations, :presence
  validate :name, :type, String

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
    valid!
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

  def each(&block)
    @trains.each { |train| block.call(train) } if block_given?
  end
end
