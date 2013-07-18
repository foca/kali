require "kali/component"
require "kali/properties"

module Kali
  class Event < Component
    name "VEVENT"

    property Property::UniqueIdentifier
    property Property::SequenceNumber
    property Property::Summary
    property Property::Description
    property Property::GeographicPosition
    property Property::Location
    property Property::Priority
    property Property::Resources
    property Property::Categories
    property Property::EventStatus
    property Property::StartDateTime
    property Property::EndDateTime
    property Property::Duration
    property Property::TimeTransparency
    property Property::Organizer
    property Property::Contact

    property_list Property::Comment, :comments
    property_list Property::Attendee, :attendees

    def initialize
      self.sequence = Property::SequenceNumber.new
      super
    end
  end
end
