require "kali/type"
require "kali/text_utils"
require "kali/utils/named"

module Kali
  # Public: Properties are the definition of an attribute describing a
  # component.
  class Property
    extend Utils::Named

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
