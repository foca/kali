require "kali/property"
require "kali/typed_list"
require "kali/utils/named"

module Kali
  class Component
    extend Utils::Named

    # Public: Add a property to this component. This property will appear 0 or 1
    # times in this component. If you want to add a property that can appear
    # multiple times in the component, look at `Component.property_list`.
    #
    # Example
    #
    #   class Event < Kali::Component
    #     property Kali::Property::Summary
    #     property Kali::Property::Description, :desc
    #   end
    #
    #   Event.new do |event|
    #     event.summary = "Summary"
    #     event.desc = "Description"
    #   end
    #
    # type   - The class that defines the property. Must be a Kali::Property
    #          subclass.
    # method - The name of the method under which to mount this property.
    #
    # Returns nothing.
    def self.property(type, method = type.method_name)
      define_method method do
        properties[type.name] ||= type.new
      end

      define_method "#{method}=" do |value|
        property = type === value ? value : type.new(value)
        properties[type.name] = property
      end
    end

    # Public: Add a family of properties to this component. This adds a property
    # that can appear multiple times in this component. If you need a property
    # that appears at most once in the component, look at `Component.property`.
    #
    # Example
    #
    #   class Event < Kali::Component
    #     property_list Kali::Property::Attendee, :attendees
    #   end
    #
    #   Event.new do |event|
    #     event.attendees.add do |attendee|
    #       ...
    #     end
    #   end
    #
    # type   - The class that defines the property. Must be a Kali::Property
    #          subclass.
    # method - The name of the method under which to mount this property.
    #
    # Returns nothing.
    def self.property_list(type, method = type.method_name)
      define_method method do
        properties[type.name] ||= TypedList.new(type)
      end
    end

    # Public: Add a family of components to this component. This exposes a list
    # to which you can add sub-components.
    #
    # Example
    #
    #   class Calendar < Kali::Component
    #     component Kali::Event, :events
    #   end
    #
    #   Calendar.new do |cal|
    #     cal.events.add do |event|
    #       ...
    #     end
    #   end
    #
    # type   - The class that defines the component. Must be a Kali::Component
    #          subclass.
    # method - The name of the method under which to mount this property.
    #
    # Returns nothing.
    def self.component(type, method = type.method_name)
      define_method method do
        components[type.name] ||= TypedList.new(type)
      end
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
      properties = self.properties.map { |_, value| value.to_ics }
      components = self.components.map { |_, value| value.to_ics }

      lines = [
        "BEGIN:#{self.class.name}",
        *properties.compact,
        *components.compact,
        "END:#{self.class.name}"
      ]

      lines.reject { |s| s.empty? }.join("\n")
    end

    # Internal: List of properties stored in this component.
    #
    # Returns a Hash.
    def properties
      @properties ||= {}
    end

    # Internal: List of sub-components that form this component.
    #
    # Returns a Hash.
    def components
      @components ||= {}
    end
  end
end
