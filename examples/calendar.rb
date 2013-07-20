require "kali"

cal = Kali::Calendar.new do |calendar|
  calendar.events.add do |event|
    event.uid = 1
    event.summary = "Conference Talk"

    event.description = "A description of the talk"
    event.description.language = "en" # setting parameters on properties.

    event.location = "The Venue"
    event.geo = [-54.458594, -34.123310]
    event.categories = ["CATEGORY A", "CATEGORY B"]

    event.dtstart = Time.parse("2013-07-31T15:00:00-07:00")
    event.dtstart.tzid = "America/Los_Angeles"

    # Not specifying the tzid manually it will try to extract it from the
    # Time/DateTime instance. HOWEVER, given ruby's implementation of time, this
    # only works for the *local* time, or UTC.
    #
    # If you pass something with an offset that doesn't match the local time,
    # ruby will convert this to local time, and use that time instead.
    #
    # So if you want timezone detection, you probably want to pass in values
    # that use a more advanced Time implementation, like
    # ActiveSupport::TimeWithZone. Or just set the tzid parameter manually.
    event.dtend = Time.parse("2013-07-31T16:00:00-07:00")

    event.comments.add "I'm sure the talk will be a disaster --The Speaker"
    event.comments.add "Estoy convencido de que va a ser buena" do |comment|
      comment.language = "es"
    end

    event.attendees.add URI.parse("mailto:john@example.org") do |attendee|
      attendee.partstat = "ACCEPTED"
      attendee.role = "CHAIR"
    end

    event.attendees.add URI.parse("mailto:jane@example.org") do |attendee|
      # the property parameters can be specified as if the property was a Hash.
      attendee["PARTSTAT"] = "DECLINED"
    end
  end

  calendar.events.add do |event|
    event.uid = 2
    event.summary = "Another Thing"
    event.location = "The Venue"

    event.dtstart = DateTime.new(2013, 7, 31, 18, 00, 00, "+02:00")
    event.dtstart["TZID"] = "Europe/Berlin"
    event.duration = { minute: 45 }
  end
end

puts cal.to_ics
