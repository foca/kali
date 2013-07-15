require "kali/type"
require "kali/text_utils"

module Kali
  # Public: Properties are the definition of an attribute describing a
  # component.
  class Property
    # Public: Get/Set the name of the property implemented by this class.
    def self.name(name = nil)
      @name = name if name
      @name
    end

    # Public: Get/Set the Type of the property implemented by this class.
    def self.type(type = nil)
      @type = type if type
      @type
    end

    # Public: Get/Set a default value for this property.
    def self.default(default = nil)
      @default = default if default
      @default
    end

    # Public: Get/Set a name for the method used as an accessor for this
    # property, based on the name of the property.
    def self.method_name(method_name = nil)
      @method_name ||= name.to_s.downcase.gsub("-", "_") unless name.nil?
      @method_name = method_name if method_name
      @method_name
    end

    # Public: Get/Set the value of this specific instance of the property.
    attr_accessor :value

    # Internal: Initialize the Property.
    #
    # value - Any value that can be set for this Property.
    def initialize(value = self.class.default)
      @value = value
    end

    # Public: Generate an iCalendar representation of this property.
    #
    # Returns a String.
    def to_ics
      encoded_value = self.class.type.encode(value)
      TextUtils.fold_line "#{self.class.name}:#{encoded_value}"
    end

    # Public: Get the String representation of this property.
    def to_s
      value.to_s
    end
  end
end
