require "kali/type"
require "uri"

module Kali
  # Used to represent URIs in properties.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.3.13
  class Type::URI < Type
    def encode!(uri)
      uri.to_s
    end

    def decode!(string)
      ::URI.parse(string)
    end
  end
end
