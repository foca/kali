require "kali/component"
require "kali/property/component_properties"

module Kali
  class Event < Component
    name "VEVENT"
    method_name :events

    property Property::UniqueIdentifier, 1
    property Property::SequenceNumber, 1
    property Property::Summary
    property Property::Description
    property Property::GeographicPosition
    property Property::Location
    property Property::Priority
    property Property::Resources
    property Property::Categories
    property Property::Comment, 0..N
    property Property::EventStatus
    property Property::StartDateTime, 1
    property Property::EndDateTime
    property Property::Duration
    property Property::TimeTransparency
    property Property::Attendee, 0..N
    property Property::Organizer
    property Property::Contact

    def initialize
      self.sequence = Property::SequenceNumber.new
      super
    end
  end
end
