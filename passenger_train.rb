require_relative 'train'
require_relative 'train_type'

class PassengerTrain < Train
  attr_reader :seats_count, :busy_seats_count

  def initialize(number, seat_count)
    @seats_count = seat_count
    @busy_seats_count = 0
    super(number, TrainType::PASSENGER)
  end

  def take_seat
    @busy_seats_count += 1 if @busy_seats_count < @seats_count
  end

  def free_seats_count
    @seats_count - @busy_seats_count
  end

  protected

  def valid!
    super
    raise 'Seats count must be non-negative' if @seats_count.negative?
  end
end
