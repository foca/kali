require "time"

module Kali
  # Used to represent precise times of the day.
  #
  # FIXME: Not handling time zones. At all. Yet.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.3.12
  class Type::Time < Type::DateTime
    def encode!(*)
      super.split("T").last
    end

    def decode!(string)
      _, hour, minute, second, utc = *string.match(/(\d{2})(\d{2})(\d{2})?(Z)?/)
      ::Time.parse([hour, minute, second || "00"].join(":") + utc.to_s)
    end
  end
end
