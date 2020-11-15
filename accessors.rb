module Accessors
  def self.included(obj)
    obj.extend ClassModule
    obj.send :include, InstanceModule
  end

  module ClassModule
    def attr_accessor_with_history(*args)
      args.each do |var|
        define_history_getter(var)
        define_history_setter(var)
        define_variable_history(var)
      end
    end

    def strong_attr_accessor(var, type)
      define_method("#{var}_strong_type") do
        type
      end
      send :private, "#{var}_strong_type".to_sym
      define_method(var) do
        instance_variable_get("@#{var}")
      end
      define_method("#{var}=") do |new_value|
        type = send "#{var}_strong_type".to_sym
        new_value_type = new_value.class
        raise "Method got #{new_value_type}, expected #{type} type" unless type == new_value_type

        instance_variable_set "@#{var}", new_value
      end
    end

    private

    def define_history_getter(variable)
      define_method(variable) do
        init_history(variable)
        @history[variable].last
      end
    end

    def define_history_setter(variable)
      define_method("#{variable}=") do |new_value|
        init_history(variable)
        @history[variable] << new_value
      end
    end

    def define_variable_history(variable)
      define_method("#{variable}_history") do
        init_history(variable)
        @history[variable]
      end
    end
  end

  module InstanceModule
    private

    def init_history(variable)
      @history ||= {}
      @history[variable] ||= []
    end
  end
end
