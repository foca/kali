require "kali/property"
require "kali/type"
require "kali/parameters"
require "securerandom"

module Kali
  # Globally unique identifier for this component.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.4.7
  class Property::UniqueIdentifier < Property
    name "UID"
    type Type::Text.new
  end

  # The "current version" of the component, according to the organizer's
  # judgement.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.7.4
  class Property::SequenceNumber < Property
    name "SEQUENCE"
    type Type::Integer.new(->(i) { i >= 0 })
    default 0
  end

  # Short summary of the current component.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.1.12
  class Property::Summary < Property
    name "SUMMARY"
    type Type::Text.new

    parameter Parameter::Language
    parameter Parameter::AlternateRepresentation
  end

  # Longer description of the current component.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.1.5
  class Property::Description < Property
    name "DESCRIPTION"
    type Type::Text.new

    parameter Parameter::Language
    parameter Parameter::AlternateRepresentation
  end

  # Lat/Lng pair indicating where this component takes place.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.1.6
  class Property::GeographicPosition < Property
    name "GEO"
    type Type::Geo.new
  end

  # Name/description of the venue where this component takes place.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.1.7
  class Property::Location < Property
    name "LOCATION"
    type Type::Text.new

    parameter Parameter::Language
    parameter Parameter::AlternateRepresentation
  end

  # How important is this component compared to others. Can be 0 (no special
  # priority), or range from 1 (high) to 9 (low).
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.1.9
  class Property::Priority < Property
    name "PRIORITY"
    type Type::Integer.new(0..9)
    default 0
  end

  # List of categories describing this component.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.1.2
  class Property::Categories < Property
    name "CATEGORIES"
    type Type::List.new(Type::Text.new)

    parameter Parameter::Language
    parameter Parameter::AlternateRepresentation
  end

  # List of resources needed to be able to fulfill this component. For example
  # ["PROJECTOR", "EASEL", "WHITEBOARD"].
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.1.10
  class Property::Resources < Property
    name "RESOURCES"
    type Type::List.new(Type::Text.new)

    parameter Parameter::Language
    parameter Parameter::AlternateRepresentation
  end

  # User provided comments about the current component. Can be specified
  # multiple times for a single component.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.1.4
  class Property::Comment < Property
    name "COMMENT"
    type Type::Text.new
    method_name :comments

    parameter Parameter::Language
    parameter Parameter::AlternateRepresentation
  end

  # Status representing whether the event is taking place or not.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.1.11
  class Property::EventStatus < Property
    name "STATUS"
    type Type::Text.new(Enum["TENTATIVE", "CONFIRMED", "CANCELLED"])
  end

  # End date of a component. This is required, unless there's a Duration, in
  # which case this can't appear.
  #
  # TODO: This can be a DateTime or a Date. We should take that into
  # consideration.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.2.2
  class Property::EndDateTime < Property
    name "DTEND"
    type Type::DateTime.new

    parameter Parameter::TimeZoneIdentifier
  end

  # Start date of a component.
  #
  # TODO: This can be a DateTime or a Date. We should take that into
  # consideration.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.2.4
  class Property::StartDateTime < Property
    name "DTSTART"
    type Type::DateTime.new

    parameter Parameter::TimeZoneIdentifier
  end

  # Duration of the component.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.2.5
  class Property::Duration < Property
    name "DURATION"
    type Type::Duration.new
  end

  # Does this event affect your free/busy schedule? Transparent events are the
  # ones that don't, while opaque events do.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.2.7
  class Property::TimeTransparency < Property
    name "TRANSP"
    type Type::Text.new(Enum["OPAQUE", "TRANSPARENT"])
    default "OPAQUE"
  end

  # Represent a person involved with this event.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.4.1
  class Property::Attendee < Property
    name "ATTENDEE"
    type Type::CalAddress.new
    method_name :attendees

    parameter Parameter::CommonName
    parameter Parameter::CalendarUserType
    parameter Parameter::Delegators
    parameter Parameter::Delegatees
    parameter Parameter::DirectoryEntry
    parameter Parameter::GroupMemberships
    parameter Parameter::EventParticipationStatus
    parameter Parameter::ParticipationRole
    parameter Parameter::RSVPExpectation
    parameter Parameter::SentBy
  end

  # Represent the party organizing the event.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.4.3
  class Property::Organizer < Property
    name "ORGANIZER"
    type Type::CalAddress.new
  end

  # This component is used to represent contact information for someone
  # associated with the Event's venue.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.4.3
  class Property::Contact < Property
    name "CONTACT"
    type Type::Text.new

    parameter Parameter::Language
    parameter Parameter::AlternateRepresentation
  end

  # External URL associated with this calendar component.
  #
  # As per http://tools.ietf.org/html/rfc5545#section-3.8.4.6
  class Property::URL < Property
    name "URL"
    type Type::URI.new
  end
end
