require_relative 'train'
require_relative 'train_type'

class CargoTrain < Train
  def initialize(number)
    super(number, TrainType::CARGO)
  end
end
