module Kali
  # Used to represent integer numbers.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.3.8
  class Type::Integer < Type
    def encode!(object)
      Integer(object).to_s
    end

    def decode!(string)
      Integer(string)
    end
  end
end
