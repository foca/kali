require "uri"

module Kali
  # The CAL-ADDRESS type represents a person involved with an event. It must be
  # an email URI.
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.3.3
  class Type::CalAddress < Type::URI
    def initialize
      super(::URI::MailTo)
    end

    def parameters
      {
        Parameter::CommonName               => :cn,
        Parameter::CalendarUserType         => :cutype,
        Parameter::Delegators               => :delegators,
        Parameter::Delegatees               => :delegatees,
        Parameter::DirectoryEntry           => :dir,
        Parameter::GroupMemberships         => :members,
        Parameter::EventParticipationStatus => :partstat,
        Parameter::ParticipationRole        => :role,
        Parameter::RSVPExpectation          => :rsvp,
        Parameter::SentBy                   => :sent_by
      }
    end
  end
end
