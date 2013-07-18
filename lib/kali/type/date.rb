require "date"

module Kali
  # Used to represent calendar dates.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.3.4
  class Type::Date < Type::DateTime
    def encode!(*)
      super.split("T").first
    end

    def decode!(string)
      ::Date.parse(string)
    end
  end
end
