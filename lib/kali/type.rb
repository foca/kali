require "set"

module Kali
  # Public: Type classes are used to convert ruby objects from and to their
  # iCalendar representations.
  #
  # Examples:
  #   type = Kali::Type::Date.new
  #   type.encode(Date.today) #=> "20130712"
  #   type.decode("20130712") #=> Date.new(2013, 7, 12)
  #
  #   type = Kali::Type::Integer.new(0..9)
  #   type.encode(3) #=> "3"
  #   type.encode(15) #=> ArgumentError
  #   type.decode("7") #=> 7
  #
  #   type = Kali::Type::Text.new(->(s) { s.size > 3 })
  #   type.encode("x") #=> ArgumentError
  #   type.encode("long") #=> "long"
  #
  #   type = Kali::Type::Text.new(Enum["ACTIVE", "INACTIVE"])
  #   type.encode("ACTIVE") #=> "ACTIVE"
  #   type.encode("nope") #=> ArgumentError
  class Type
    # Public: Initialize the Type.
    #
    # restriction - An object that implenents the #=== operator. When we
    #               validate that a certain value is valid for this type, we
    #               will check the value against `restriction.===`. If it's
    #               `nil` then we don't restrict the value.
    def initialize(restriction = nil)
      @restriction = restriction
    end

    # Public: Encode an object into an iCalendar-compatible String using the
    # format specific to this Type.
    #
    # Requires a subclass to implement #encode!
    #
    # obj - An Object that matches this Type.
    #
    # Returns a String that matches the iCalendar representation of this Type.
    def encode(obj)
      encode!(validate(obj))
    end

    # Public: Decode an iCalendar-compatible String into an Object that matches
    # this Type.
    #
    # Requires a subclass to implement #decode!
    #
    # obj - A String that matches the iCalendar representation for this Type..
    #
    # Returns an Object that matches this Type.
    def decode(obj)
      validate(decode!(obj))
    end

    private

    # Internal: Check that an Object meets the restrictions of this particular
    # Type.
    #
    # value - An Object.
    #
    # Returns the value if it satisfies the restriction.
    # Raises ArgumentError if the restriction is not satisfied.
    def validate(value)
      if @restriction.nil? || @restriction === value
        value
      else
        raise ArgumentError, "#{value.inspect} does not satisfy the type restriction for #{self.class} (#{@restriction.inspect})"
      end
    end

    autoload :Text,       "kali/type/text"
    autoload :Integer,    "kali/type/integer"
    autoload :Float,      "kali/type/float"
    autoload :Geo,        "kali/type/geo"
    autoload :List,       "kali/type/list"
    autoload :DateTime,   "kali/type/date_time"
    autoload :Date,       "kali/type/date"
    autoload :Time,       "kali/type/time"
    autoload :Duration,   "kali/type/duration"
    autoload :URI,        "kali/type/uri"
    autoload :CalAddress, "kali/type/cal_address"
    autoload :Quoted,     "kali/type/quoted"
    autoload :Boolean,    "kali/type/boolean"
  end

  # Public: Helper class that allows us to easily restrict a value from a set of
  # predetermined values. It's just a Set that implements the case equality
  # operator to check for Set inclusion.
  #
  # This is meant to be used as a Type restriction. See Type for examples.
  #
  # Examples:
  #   Enum[1, 2, 3] === 1 #=> true
  #   Enum[1, 2, 3] === 5 #=> false
  class Enum < Set
    def self.[](*values)
      new(values).freeze
    end

    def ===(element)
      include?(element)
    end
  end
end
