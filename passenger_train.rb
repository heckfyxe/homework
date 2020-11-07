require_relative 'train'
require_relative 'train_type'

class PassengerTrain < Train
  def initialize(number)
    super(number, TrainType::PASSENGER)
  end
end
