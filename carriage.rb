require_relative 'brand'
require_relative 'train_type'
require_relative 'validator'

class Carriage
  include Brand
  include Validator

  attr_reader :type

  def initialize(type)
    @type = type
    valid!
  end

  protected

  def valid!
    raise 'Invalid carriage type' unless TrainType.valid?(@type)
  end
end
