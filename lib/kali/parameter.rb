module Kali
  # Public: Parameters are meta-information about a certain property.
  class Parameter < KeyValuePair
    # Public: See KeyValuePair#to_ics
    def to_ics
      ";#{super}"
    end

    # Internal: See KeyValuePair#separator
    def separator
      "="
    end
  end
end
