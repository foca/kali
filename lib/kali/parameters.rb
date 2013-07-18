module Kali
  # Public: Meta-property that represents any user-defined property not
  # currently implemented in the system.
  class Parameter::Default < Parameter
    type Type::Text.new

    def initialize(name, value)
      @name = name
      super(value)
    end
  end

  # URI pointing to an alternate representation of the value of the property to
  # which this parameter applies to.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.1
  class Parameter::AlternateRepresentation < Parameter
    name "ALTREP"
    type Type::Quoted.new(Type::URI.new)
  end

  # Common name of a calendar user. Specified in properties with the type
  # CalAddress.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.2
  class Parameter::CommonName < Parameter
    name "CN"
    type Type::Quoted.new(Type::Text.new)
  end

  # Identifies the type of user to which this property refers to.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.3
  class Parameter::CalendarUserType < Parameter
    name "CUTYPE"
    type Type::Text.new(Enum["INDIVIDUAL", "GROUP", "RESOURCE", "ROOM",
                             "UNKNOWN"])
    default "INDIVIDUAL"
  end

  # List of users that have delegated their participation to the calendar user
  # specified by the property to which this parameter applies.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.4
  class Parameter::Delegators < Parameter
    name "DELEGATED-FROM"
    type Type::List.new(Type::Quoted.new(Type::CalAddress.new))
  end

  # List of users to which the calendar user has delegated his/her participation
  # to.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.5
  class Parameter::Delegatees < Parameter
    name "DELEGATED-TO"
    type Type::List.new(Type::Quoted.new(Type::CalAddress.new))
  end

  # URI pointing to a directory entry associated with the calendar user to which
  # this parameter applies.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.6
  class Parameter::DirectoryEntry < Parameter
    name "DIR"
    type Type::Quoted.new(Type::URI.new)
  end

  # Alternate encoding for the value of this property.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.7
  class Parameter::Encoding < Parameter
    name "ENCODING"
    type Type::Text.new(Enum["8BIT", "BASE64"])
    default "8BIT"
  end

  # Specifies the content type of the referenced object.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.8
  class Parameter::ContentType < Parameter
    name "FMTTYPE"
    type Type::Text.new(/[a-z0-9\!\#\$\&\.\+\-\^\_]{1,127}\/[a-z0-9\!\#\$\&\.\+\-\^\_]{1,127}/i)
  end

  # Specifies the language of the associated property (using an identifier as
  # conceived by [RFC 5646](http://tools.ietf.org/html/rfc5646)).
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.10
  class Parameter::Language < Parameter
    name "LANGUAGE"
    type Type::Text.new
  end

  # Mailing lists/groups of which the calendar user is a member of.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.11
  class Parameter::GroupMemberships < Parameter
    name "MEMBER"
    type Type::List.new(Type::Quoted.new(Type::CalAddress.new))
  end

  # Current status of participation in an event of the calendar user.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.12
  class Parameter::EventParticipationStatus < Parameter
    name "PARTSTAT"
    type Type::Text.new(Enum["NEEDS-ACTION", "ACCEPTED", "DECLINED",
                             "TENTATIVE", "DELEGATED"])
  end

  # Role within the event of the calendar user described by this property.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.16
  class Parameter::ParticipationRole < Parameter
    name "ROLE"
    type Type::Text.new(Enum["CHAIR", "REQ-PARTICIPANT", "OPT-PARTICIPANT",
                             "NON-PARTICIPANT"])
    default "REQ-PARTICIPANT"
  end

  # Specified whether a reply is expected from the calendar user.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.17
  class Parameter::RSVPExpectation < Parameter
    name "RSVP"
    type Type::Boolean.new
    default false
  end

  # Specify that the described calendar user is acting on behalf of the calendar
  # user addressed by this parameter.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.18
  class Parameter::SentBy < Parameter
    name "SENT-BY"
    type Type::Quoted.new(Type::CalAddress.new)
  end

  # Specify the timezone in which this Time or DateTime is occurring.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.2.19
  class Parameter::TimeZoneIdentifier < Parameter
    name "TZID"
    type Type::Text.new
  end
end
