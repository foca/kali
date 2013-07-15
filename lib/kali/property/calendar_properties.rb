require "kali/property"
require "kali/type"
require "kali/version"

module Kali
  # Identifier for the product that created this iCalendar object.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.7.3
  class Property::ProductIdentifier < Property
    name "PRODID"
    type Type::Text.new
    default "Kali/#{Kali::VERSION}"
  end

  # Version of the iCalendar protocol implemented in this iCalendar object.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.7.4
  class Property::Version < Property
    name "VERSION"
    type Type::Text.new("2.0")
    default "2.0"
  end

  # Calendar scale used in this iCalendar object.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.7.1
  class Property::CalendarScale < Property
    name "CALSCALE"
    type Type::Text.new("GREGORIAN")
    default "GREGORIAN"
  end

  # The iCalendar object method associated with this iCalendar object.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.7.2
  class Property::Method < Property
    name "METHOD"
    type Type::Text.new(
      Enum["PUBLISH", "REQUEST", "REPLY", "ADD", "CANCEL", "REFRESH", "COUNTER",
           "DECLINECOUNTER"]
    )
  end
end
