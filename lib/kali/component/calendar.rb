require "kali/component"
require "kali/property/calendar_properties"
require "kali/component/event"

module Kali
  class Calendar < Component
    name "VCALENDAR"

    sub_component Event

    property Property::ProductIdentifier, 1
    property Property::Version, 1
    property Property::CalendarScale
    property Property::Method

    def initialize
      self.prodid   = Property::ProductIdentifier.new
      self.version  = Property::Version.new
      self.calscale = Property::CalendarScale.new
      super
    end
  end
end
