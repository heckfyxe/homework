module Validator
  def self.included(obj)
    obj.extend ClassMethods
    obj.send :include, InstanceMethods
  end

  Validation = Struct.new(:variable, :validation_type, :argument)

  module ClassMethods
    def validate(variable, validation_type, argument = nil)
      validation = Validation.new(variable, validation_type, argument)
      @validations ||= []
      @validations << validation
    end

    attr_reader :validations
  end

  module InstanceMethods
    def valid?
      valid!
      true
    rescue RuntimeError
      false
    end

    protected

    def valid!
      self.class.validations.each do |validation|
        validation!(validation.variable, validation.validation_type, validation.argument)
      end
    end

    private

    def validation!(variable, validation_type, argument)
      variable_value = instance_variable_get("@#{variable}")
      case validation_type
      when :presence
        presence_validation(variable, variable_value)
      when :format
        format_validation(variable, variable_value, argument)
      when :type
        type_validation(variable, variable_value, argument)
      else
        raise 'Unknown validation type'
      end
    end

    def presence_validation(variable_name, variable_value)
      raise "#{variable_name} variable is nil or empty!" if variable_value.nil? || (variable_value.is_a?(String) && variable_value.empty?)
    end

    def format_validation(variable_name, variable_value, format)
      raise "Needs 3'rd argument for #{variable_name} validation" if format.nil?
      raise "#{variable_name} variable doesn't match format" if variable_value !~ format
    end

    def type_validation(variable_name, variable_value, type)
      raise "Needs 3'rd argument for #{variable_name} validation" if type.nil?
      raise "#{variable_name} variable doesn't match #{type} type" unless variable_value.is_a? type
    end
  end
end
