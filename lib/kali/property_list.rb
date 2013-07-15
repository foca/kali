module Kali
  # Public: List of properties for a component that can have more than one of a
  # single property. For example, ATTENDEE or COMMENT.
  class PropertyList
    include Enumerable

    # Internal: Initialize the List.
    #
    # property_type - The subclass of Property that this list contains.
    def initialize(property_type)
      @property_type = property_type
      @properties = []
    end

    # Public: Add a new property to the list.
    #
    # value - The value passed to Property.new.
    #
    # Returns nothing.
    # Yields the Property if a block is passed.
    def add(value)
      property = @property_type.new(value)
      yield prop if block_given?
      @properties << prop
    end

    # Public: Get an iCalendar representation of this list of properties.
    #
    # Returns a String.
    def to_ics
      @properties.map(&:to_ics).join("\r\n")
    end

    # Internal: Iterate over the properties in this list.
    #
    # Yields each property in turn.
    def each(&block)
      @properties.each(&block)
    end
  end
end
