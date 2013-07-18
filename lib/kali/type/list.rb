module Kali
  # Meta type (not explicitly defined in the RFC as a property type) to parse
  # and serialize lists of other values. Lists are strongly typed, with elements
  # of only one type occurring inside a list.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.1.1
  class Type::List < Type
    def initialize(subtype, restriction = nil)
      super(restriction)
      @subtype = subtype
    end

    def encode!(object)
      object.map { |el| @subtype.encode(el) }.join(",")
    end

    def decode!(string)
      tentative_parts = string.split(",")
      parts = []
      in_group = false
      group_size = 1
      tentative_parts.each.with_index do |part, index|
        if part[-1] == "\\"
          group_size += 1
          in_group = true
        elsif in_group
          parts << tentative_parts[index - group_size + 1, group_size].join(",")
          group_size = 1
          in_group = false
        else
          parts << part
        end
      end
      parts.map { |part| @subtype.decode(part) }
    end
  end
end
