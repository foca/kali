module Kali
  # Used to represent strings of text.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.3.11
  class Type::Text < Type
    def parameters
      {
        Parameter::Language                => :language,
        Parameter::AlternateRepresentation => :altrep
      }
    end

    def encode!(object)
      str = object.to_s.dup
      str.gsub! "\\", "\\\\"
      str.gsub! "\n", "\\n"
      str.gsub! ";", "\\;"
      str.gsub! ",", "\\,"
      str
    end

    def decode!(string)
      str = string.to_s.dup
      str.gsub! "\\,", ","
      str.gsub! "\\;", ";"
      str.gsub! "\\n", "\n"
      str.gsub! "\\\\", "\\"
      str
    end
  end
end
