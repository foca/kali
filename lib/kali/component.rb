require "kali/property"
require "kali/typed_list"
require "kali/utils/named"

module Kali
  class Component
    extend Utils::Named

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
          property = type === value ? value : type.new(value)
          instance_variable_set("@#{name}", property)
        end
      else
        ivar = "@#{name}"
        define_method name do
          if instance_variable_get(ivar).nil?
            instance_variable_set(ivar, TypedList.new(type))
          end
          instance_variable_get(ivar)
        end
      end
    end

    # Public: Add a family of sub-components to this component.
    #
    # type - The type (class) of sub-component being added.
    #
    # Returns nothing.
    def self.sub_component(type)
      name = type.method_name
      sub_component_list << name

      ivar = "@#{name}"
      define_method name do
        if instance_variable_get(ivar).nil?
          instance_variable_set(ivar, TypedList.new(type))
        end
        instance_variable_get(ivar)
      end
    end

    # Internal: List of properties added to this component.
    def self.property_list
      @property_list ||= {}
    end

    # Internal: List of sub-components added to this component.
    def self.sub_component_list
      @sub_component_list ||= []
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

      sub_components = self.class.sub_component_list.map do |comp|
        public_send(comp).to_ics
      end

      lines = [
        "BEGIN:#{self.class.name}",
        *properties.compact,
        *sub_components.compact,
        "END:#{self.class.name}"
      ]

      lines.reject { |s| s.empty? }.join("\r\n")
    end
  end
end
