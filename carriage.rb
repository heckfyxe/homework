require_relative 'brand'
require_relative 'train_type'
require_relative 'validator'

class Carriage
  include Brand
  include Validator

  attr_reader :type

  validate :type, :presence
  validate :type, :type, String

  def initialize(type)
    @type = type
    valid!
  end
end
