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
    def self.parameter(type)
      name = type.method_name
      parameters[type.name] = type

      define_method name do
        @parameters[type.name]
      end

      define_method "#{name}=" do |value|
        @parameters[type.name] = type.wrap(value)
      end
    end

    # Internal: Possible parameters that instances of this Property can have.
    def self.parameters
      @parameters ||= {}
    end

    def initialize(*) # :nodoc:
      super
      @parameters = {}
    end

    # Public: Get a parameter by iCalendar name.
    #
    # name - The name of the parameter.
    #
    # Returns the passed in value.
    def [](name)
      @parameters[name]
    end

    # Public: Set a parameter manually by explicitly passing the iCalendar name
    # (so, for example, "DELEGATED-TO" instead of calling `#delegated_to=`).
    #
    # name  - A String with the name of the parameter. If there's a typed
    #         parameter for this name already, this will be equivalent to
    #         setting that parameter via the setter. Otherwise it will assume
    #         this is a Text parameter and set it. This is the only way right
    #         now to set "experimental" (X-*) params.
    # value - The value of the param.
    #
    # Returns the passed in value.
    def []=(name, value)
      param = if type = lookup_parameter_type(name)
        type.wrap(value)
      else
        Parameter::Default.new(name, value)
      end

      @parameters[name] = param
    end

    # Public: Generate an iCalendar representation of this property.
    #
    # Returns a String.
    def to_ics
      params = @parameters.map { |_, value| value.to_ics }.join("")
      encoded_value = self.class.type.encode(value)
      TextUtils.fold_line "#{self.class.name}#{params}:#{encoded_value}"
    end

    # Internal: Determine the type for a parameter set via #[]=
    #
    # Returns a subclass of Kali::Type.
    def lookup_parameter_type(name)
      self.class.parameters.fetch(name, nil)
    end
  end
end
