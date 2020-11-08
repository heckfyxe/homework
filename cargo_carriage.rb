require_relative 'carriage'
require_relative 'train_type'

class CargoCarriage < Carriage
  def initialize
    super(TrainType::CARGO)
  end
end
