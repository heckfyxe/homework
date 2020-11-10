module TrainType
  PASSENGER = 'пассажирский'.freeze
  CARGO = 'грузовой'.freeze

  def self.all
    constants.map { |const| const_get(const) }
  end

  def self.valid?(type)
    all.include?(type)
  end
end
