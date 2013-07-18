require "kali/component"
require "kali/properties"
require "kali/component/event"

module Kali
  class Calendar < Component
    name "VCALENDAR"

    component Event, :events

    property Property::ProductIdentifier
    property Property::Version
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
