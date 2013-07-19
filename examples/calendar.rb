require "kali"
require "uri"

cal = Kali::Calendar.new do |calendar|
  calendar.events.add do |event|
    event.uid = 1
    event.summary = "Conference Talk"

    event.description = "A description of the talk"
    event.description.language = "en" # setting parameters on properties.

    event.location = "The Venue"
    event.geo = [-54.458594, -34.123310]
    event.categories = ["CATEGORY A", "CATEGORY B"]

    event.dtstart = DateTime.civil(2013, 7, 31, 15, 00, 00, "-07:00")
    event.dtstart.tzid = "America/Los_Angeles"
    event.dtend = DateTime.civil(2013, 7, 31, 16, 00, 00, "-07:00")
    event.dtend.tzid = "America/Los_Angeles"

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
