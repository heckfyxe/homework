require_relative 'carriage'
require_relative 'train_type'

class PassengerCarriage < Carriage
  def initialize
    super(TrainType::PASSENGER)
  end
end
