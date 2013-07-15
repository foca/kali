require "kali"

cal = Kali::Calendar.new do |calendar|
  calendar.events.add do |event|
    event.uid = 1
    event.summary = "Conference Talk"
    event.description = "A description of the talk"
    event.location = "The Venue"
    event.geo = [-54.458594, -34.123310]
    event.categories = ["CATEGORY A", "CATEGORY B"]

    event.dtstart = DateTime.new(2013, 7, 31, 15, 00, 00)
    event.dtend = DateTime.new(2013, 7, 31, 16, 00, 00)

    event.comments.add "I'm sure the talk will be a disaster --The Speaker"
  end

  calendar.events.add do |event|
    event.uid = 2
    event.summary = "Another Thing"
    event.location = "The Venue"

    event.dtstart = DateTime.new(2013, 7, 31, 18, 00, 00)
    event.duration = { minute: 45 }
  end
end

puts cal.to_ics
