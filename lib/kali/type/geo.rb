require "kali/type"

module Kali
  # Meta type (not defined in the RFC) for parsing and serializing
  # GeographicPosition properties.
  class Type::Geo < Type
    def initialize(rule = nil)
      super(->(o) { Array === o && o.size == 2 && (rule.nil? || rule === o) })
      @latitude  = Type::Float.new(-90..90)
      @longitude = Type::Float.new(-180..180)
    end

    def encode!(object)
      [@latitude.encode(object.at(0)),
       @longitude.encode(object.at(1))].join(";")
    end

    def decode!(string)
      lat, lng = String(string).split(";")
      [@latitude.decode(lat), @longitude.decode(lng)]
    end
  end
end
