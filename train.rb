require_relative 'instance_counter'
require_relative 'brand'
require_relative 'validator'
require_relative 'accessors'

class Train
  include InstanceCounter
  include Brand
  include Validator
  include Accessors

  NUMBER_FORMAT = /^[0-9a-zа-я]{3}-?[0-9a-zа-я]{2}$/i.freeze

  attr_accessor :speed
  attr_reader :number, :carriages

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :type, :type, String

  strong_attr_accessor :type, String

  @@trains = []

  class << self
    def find(number)
      @@trains.select { |train| train.number == number }.first
    end
  end

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @carriages = []

    @@trains << self
    register_instance
    valid!
  end

  def stop
    self.speed = 0
  end

  def attach_carriage(carriage)
    @carriages << carriage if speed.zero? && carriage.type == @type
  end

  def detach_carriage
    @carriages.delete_at(@carriages.length - 2) if speed.zero? && @carriages.length > 2
  end

  def route=(route)
    @route = route
    @position = 0
    current_station.add_train(self)
  end

  def to_forward
    return if @position == @route.length - 1

    current_station.remove_train(self)
    next_station.add_train(self)
    @position += 1
  end

  def to_back
    return if @position.zero?

    current_station.remove_train(self)
    previous_station.add_train(self)
    @position -= 1
  end

  def current_station
    @route.stations[@position]
  end

  def previous_station
    @route.stations[@position - 1] if @position.positive?
  end

  def next_station
    @route.stations[@position + 1] if @position < @route.length - 1
  end

  def each(&block)
    @carriages.each { |carriage| block.call(carriage) } if block_given?
  end
end
