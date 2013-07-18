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
      date_time = object.to_datetime
      date_time.strftime("%Y%m%dT%H%M%S#{detect_timezone(date_time)}")
    end

    def decode!(string)
      ::DateTime.parse(string)
    end

    private

    def detect_timezone(date_time)
      offset = date_time.to_datetime.zone
      sign, hour, minute = offset.scan(/(\+|-)(\d{2}):(\d{2})/).flatten
      offset = Integer("#{sign}1") * (60 * Integer(minute) + 3600 * Integer(hour))

      if offset.zero?
        "Z"
      else
        ""
      end
    end
  end
end
