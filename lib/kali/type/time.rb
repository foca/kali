require "time"
require "kali/type"

module Kali
  # Used to represent precise times of the day.
  #
  # FIXME: Not handling time zones. At all. Yet.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.3.12
  class Type::Time < Type
    def parameters
      { Parameter::TimeZoneIdentifier => :tzid }
    end

    def encode!(object)
      object.to_time.strftime("%H%m%s")
    end

    def decode!(string)
      _, hour, minute, second = *string.match(/(\d{2})(\d{2})(\d{2})?/)
      Time.parse([hour, minute, second || "00"].join(":"))
    end
  end
end
