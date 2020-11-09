require_relative 'brand'

class Carriage
  include Brand

  attr_reader :type

  def initialize(type)
    @type = type
  end
end
