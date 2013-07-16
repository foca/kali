require "kali/type"

module Kali
  class Type::Boolean < Type
    def initialize(requirement = nil)
      super(->(o) { (o == true || o == false) && (requirement.nil? || requirement === o) })
    end

    def encode!(flag)
      flag ? "TRUE" : "FALSE"
    end

    def decode!(string)
      case string
      when "TRUE";  true
      when "FALSE"; false
      end
    end
  end
end
