require "kali/type"

module Kali
  # Meta-type that just wraps a different type in double quote characters when
  # encoding it, or takes out the quotes when decoding it.
  class Type::Quoted < Type
    def initialize(type, restriction = nil)
      super(restriction)
      @type = type
    end

    def encode!(object)
      %Q("#{@type.encode(object)}")
    end

    def decode!(string)
      @type.decode(string.gsub(/^"|"$/, ""))
    end
  end
end
