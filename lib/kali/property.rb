require "kali/type"
require "kali/key_value_pair"
require "kali/text_utils"

module Kali
  # Public: Properties are the definition of an attribute describing a
  # component.
  class Property < KeyValuePair
    # Public: Add a new parameter to this Property.
    #
    # type - A subclass of Kali::Parameter.
    #
    # Returns nothing.
    def self.parameter(type, method = type.method_name)
      default_parameter_types[type.name] = type

      define_method method do
        parameters[type.name] ||= type.new
      end

      define_method "#{method}=" do |value|
        parameters[type.name] = type.wrap(value)
      end
    end

    # Internal: List of parameter types added to the class explicitly. Any
    # parameter added that is not in this store will be assumed to be a simple
    # Type::Text parameter. See `Property#[]=`.
    def self.default_parameter_types
      @parameter_types ||= {}
    end

    def initialize(*) # :nodoc:
      super
    end

    # Internal: Storage of parameters associated with this instance of the
    # property.
    #
    # Returns a Hash.
    def parameters
      @parameters ||= {}
    end

    # Public: Get a parameter by iCalendar name.
    #
    # name - The name of the parameter.
    #
    # Returns the passed in value.
    def [](name)
      parameters[name]
    end

    # Public: Set a parameter manually by explicitly passing the iCalendar name
    # (so, for example, "DELEGATED-TO" instead of calling `#delegated_to=`).
    #
    # name  - A String with the name of the parameter. If there's a typed
    #         parameter for this name already, this will be equivalent to
    #         setting that parameter via the setter. Otherwise it will assume
    #         this is a Text parameter and set it. Useful for setting
    #         experimental ("X-*") params, such as "X-GUEST-COUNT".
    # value - The value of the param.
    #
    # Returns the passed in value.
    def []=(name, value)
      param = if type = self.class.default_parameter_types.fetch(name, false)
        type.wrap(value)
      else
        Parameter::Default.new(name, value)
      end

      parameters[name] = param
    end

    # Public: Generate an iCalendar representation of this property.
    #
    # Returns a String.
    def to_ics
      params = parameters.map { |_, value| value.to_ics }.join("")
      encoded_value = self.class.type.encode(value)
      TextUtils.fold_line "#{self.class.name}#{params}:#{encoded_value}"
    end
  end
end
