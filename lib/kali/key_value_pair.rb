module Kali
  class KeyValuePair
    extend Utils::Named

    # Internal: Given a value for this KV-pair, if it's already of the pair's
    # type, return it as is, or otherwise instantiate a new pair with this as a
    # value.
    #
    # Returns an instance of this KV-pair's type.
    def self.wrap(value)
      self === value ? value : new(value)
    end

    # Public: Get/Set the Type of the KV-pair implemented by this class.
    def self.type(type = nil)
      @type = type if type
      @type
    end

    # Public: Get/Set a default value for this KV-pair.
    def self.default(default = nil)
      @default = default if default
      @default
    end

    # Public: Get/Set the value of this specific instance of the KV-pair.
    attr_accessor :value

    # Internal: Initialize the KV-pair.
    #
    # value - Any value that can be set for this KV-pair.
    def initialize(value = self.class.default)
      self.value = value
    end

    # Public: Generate an iCalendar representation of this KV-pair.
    #
    # Returns a String.
    def to_ics
      encoded_value = self.class.type.encode(value)
      "#{name}#{separator}#{encoded_value}"
    end

    # Public: Get the String representation of this KV-pair.
    def to_s
      value.to_s
    end

    # Internal: Get the name of the KV-pair.
    def name
      @name ||= self.class.name
    end

    # Internal: Separator of the key and value in iCalendar representations of
    # this KV-pair.
    #
    # Returns a String.
    def separator
      ":"
    end
  end
end
