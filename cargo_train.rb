require_relative 'train'
require_relative 'train_type'

class CargoTrain < Train
  attr_reader :capacity, :busy_capacity

  def initialize(number, capacity)
    @capacity = capacity
    @busy_capacity = 0
    super(number, TrainType::CARGO)
  end

  def take_place(capacity)
    @capacity -= capacity if capacity <= @capacity
  end

  def free_capacity
    @capacity - @busy_capacity
  end

  protected

  def valid!
    super
    raise 'Capacity must be non-negative' if @capacity.negative?
  end
end
