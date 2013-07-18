require "date"
require "kali/type"

module Kali
  # Used to represent calendar dates.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.3.4
  class Type::Date < Type
    def parameters
      { Parameter::TimeZoneIdentifier => :tzid }
    end

    def encode!(object)
      object.to_date.strftime("%Y%m%d")
    end

    def decode!(string)
      Date.parse(string)
    end
  end
end
