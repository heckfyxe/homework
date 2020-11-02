class Train
  attr_accessor :speed
  attr_reader :carriage_count
  attr_reader :type

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
    self.carriage_count += 1 if speed.zero?
  end

  def detach_carriage
    self.carriage_count -= 1 if speed.zero? && self.carriage_count.positive?
  end

  def route=(route)
    @route = route
    @position = 0
    current_station.add_train(self)
  end

  def to_forward
    unless @position == @route.length - 1
      current_station.send_train(self, next_station)
      @position += 1
    end
  end

  def to_back
    unless @position.zero?
      current_station.send_train(self, previous_station)
      @position -= 1
    end
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
