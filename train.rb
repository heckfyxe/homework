class Train
  attr_accessor :speed
  attr_reader :carriage_count, :type

  def initialize(number, type, carriage_count)
    @number = number
    @type = type
    @carriage_count = carriage_count
    @speed = 0
  end

  def stop
    self.speed = 0
  end

  def attach_carriage
    @carriage_count += 1 if speed.zero?
  end

  def detach_carriage
    @carriage_count -= 1 if speed.zero? && @carriage_count.positive?
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
end
