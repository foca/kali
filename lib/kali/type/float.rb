require "kali/type"

module Kali
  # Used to represent floating point numbers.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.3.7
  class Type::Float < Type
    def encode!(object)
      Float(object).to_s
    end

    def decode!(string)
      Float(string)
    end
  end
end
