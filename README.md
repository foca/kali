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
calendar = Kali::Calendar.new do |cal|
  cal.event do |event|
    event.summary = "Lunch" # Or: event.summary = Kali::Properties::Summary.new("Lunch")
    event.description = "Let's get some food"
    event.dtstart = DateTime.civil(2013, 7, 31, 12, 30)
    event.dtend = DateTime.civil(2013, 7, 31, 14, 30)

    event.attendees.add do |attendee|
      attendee.participation_status = :accepted
      attendee.name = "Nicolás Sanguinetti"
      attendee.address = "hi@nicolassanguinetti.info"

      attendee.guest_count = 2 # Non-standard properties are automatically
                               # recognized as X-PROPs
    end

    event.attendees.add "someone@example.com" # Simplified attendee
  end
end

File.open("cal.ics", "w") { |f| f.puts(calendar.to_ics) }
```

### Timezones

Since the ICAL format is timezone agnostic, whenever a Time or DateTime instance
is in a specific timezone, Kali will automatically include the timezone
definition in the generated `.ics` file.

## Parsing an existing calendar:

``` ruby
calendar = Kali::Calendar.parse(io_or_string)
calendar.events #=> [#<Kali::Event>, #<Kali::Event>, ...]
```

[rfc5545]: http://tools.ietf.org/html/rfc5545
[wikipedia]: http://en.wikipedia.org/wiki/Kali
