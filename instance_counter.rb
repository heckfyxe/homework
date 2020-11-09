module InstanceCounter
  def self.included(object)
    object.extend ClassMethods
    object.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    def instances=(instance)
      @instances = instance
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances += 1
    end
  end
end
