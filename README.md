# Kali: iCalendar for the rest of us

Kali attempts to provide a simple and extensible implementation of [RFC
5545][rfc5545] and friends, which describe the iCalendar format, used for
representing and exchanging calendaring and scheduling information.

[Kālī][wikipedia] is also the Hindu Goddess of Time.

![Kali: Goddess of Time and Change, by Raja Ravi Varma](
  http://upload.wikimedia.org/wikipedia/commons/8/89/Kali_by_Raja_Ravi_Varma.jpg
)

## Generating Calendars

The simplest example possible:

``` ruby
require "uri"
require "kali"

calendar = Kali::Calendar.new do |cal|
  cal.event do |event|
    event.summary = "Lunch" # Or: event.summary = Kali::Property::Summary.new("Lunch")
    event.description = "Let's get some food"
    event.dtstart = DateTime.civil(2013, 7, 31, 12, 30)
    event.dtend = DateTime.civil(2013, 7, 31, 14, 30)

    event.attendees.add URI("mailto:hi@nicolassanguinetti.info") do |attendee|
      attendee.partstat = "ACCEPTED"
      attendee.cn = "Nicolás Sanguinetti"
      attendee["X-GUEST-COUNT"] = 2
    end

    event.attendees.add URI("mailto:someone@example.com") # Simplified attendee
  end
end

File.open("cal.ics", "w") { |f| f.puts(calendar.to_ics) }
```

[rfc5545]: http://tools.ietf.org/html/rfc5545
[wikipedia]: http://en.wikipedia.org/wiki/Kali
