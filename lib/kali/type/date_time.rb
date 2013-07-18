require "date"

module Kali
  # Used to represent a precise calendar date and time of day.
  #
  # FIXME: Not handling time zones. At all. Yet.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.3.5
  class Type::DateTime < Type
    def parameters
      { Parameter::TimeZoneIdentifier => :tzid }
    end

    def encode!(object)
      object.to_datetime.strftime("%Y%m%dT%H%M%S")
    end

    def decode!(string)
      ::DateTime.parse(string)
    end
  end
end
