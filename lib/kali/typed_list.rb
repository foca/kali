module Kali
  # Public: List of objects that have a specific type in them. Useful for lists
  # of properties (like ATTENDEE or COMMENT, that can have multiple instances of
  # the same property in a component) or sub-components.
  class TypedList
    include Enumerable

    # Internal: Initialize the List.
    #
    # type - The type of objects that this list contains.
    def initialize(type)
      @type = type
      @items = []
    end

    # Public: Add a new item to the list.
    #
    # value - The item to be added. If it's an instance of the type of the list,
    #         then it adds it directly, otherwise it passes this to the
    #         constructor of that type. If it's `nil` it's ignored and just an
    #         empty new instance of the correct type is added to the list.
    #
    # Returns the list.
    # Yields the Property if a block is passed.
    def add(value = nil)
      item = case value
      when @type; value
      when nil;   @type.new
      else        @type.new(value)
      end

      yield item if block_given?
      @items << item
      self
    end
    alias_method :<<, :add

    # Public: Get an iCalendar representation of this list of properties.
    #
    # Returns a String.
    def to_ics
      @items.map(&:to_ics).join("\r\n")
    end

    # Internal: Iterate over the properties in this list.
    #
    # Yields each property in turn.
    def each(&block)
      @items.each(&block)
    end
  end
end
