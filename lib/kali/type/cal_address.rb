require "kali/type"
require "uri"

module Kali
  # The CAL-ADDRESS type represents a person involved with an event. It must be
  # an email URI.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.3.3
  class Type::CalAddress < Type::URI
    def initialize
      super(::URI::MailTo)
    end
  end
end
