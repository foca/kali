module Kali
  module Utils
    module Named
      # Public: Get/Set the name of the property implemented by this class.
      def name(name = nil)
        @name = name if name
        @name
      end

      # Public: Get a default name for the method used as an accessor for this
      # property, based on the name of the property.
      def method_name
        @method_name ||= name.to_s.downcase.gsub("-", "_") unless name.nil?
      end
    end
  end
end
