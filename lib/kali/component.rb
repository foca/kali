require "kali/property"
require "kali/property_list"

module Kali
  class Component
    # Public: Sugar for specifying unbounded ranges.
    #
    # Examples:
    #
    #   0..N
    #   1..N
    N = 1 / 0.0

    # Public: Add a property to this component.
    #
    # type   - The class that defines the property. Must be a Kali::Property
    #          subclass.
    # amount - A Range specifying how many instances of this property are
    #          allowed in this component. If the range's `min` is 0 then this
    #          property is optional. If the `max` is 1 then this is a single
    #          instance property. If there's no limit to the amount of instances
    #          of this property, use `N` as the `max`.
    #
    # Returns nothing.
    def self.property(type, amount = 0..1)
      name = type.method_name
      amount = amount..amount if Numeric === amount
      property_list[name] = amount

      if amount.max == 1
        attr_reader name

        define_method "#{name}=" do |value|
          instance_variable_set("@#{name}", type.new(value))
        end
      else
        ivar = "@#{name}"
        define_method name do
          if instance_variable_get(ivar).nil?
            instance_variable_set(ivar, PropertyList.new(type))
          end
          instance_variable_get(ivar)
        end
      end
    end

    # Internal: List of properties added to this component.
    def self.property_list
      @property_list ||= {}
    end

    # Public: Get/Set the name of this component.
    def self.name(name = nil)
      @name = name if name
      @name
    end

    # Public: Initialize the component.
    #
    # Yields itself if a block is passed.
    def initialize
      yield self if block_given?
    end

    # Public: Generate an iCalendar representation of the component.
    #
    # Returns a String.
    def to_ics
      properties = self.class.property_list.keys.map do |prop|
        value = public_send(prop)
        value && value.to_ics
      end

      ["BEGIN:#{self.class.name}",
       *properties.compact,
       "END:#{self.class.name}"].join("\r\n")
    end
  end
end