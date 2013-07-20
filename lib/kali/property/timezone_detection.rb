module Kali
  # Public: Mixin for properties that admit a DateTime or a Time that will set
  # the Timezone (if possible) from the incoming values.
  #
  # Given how ruby works for timezones, and that Time instances are timezone
  # agnostic sans for UTC / local time distinctions, this basically just makes
  # sure that, if the time is not in UTC, append the timezone abbreviation.
  #
  # If you use an alternative implementation of time, that does support
  # timezones, like ActiveSupport::TimeWithZone, and you pass an instance of
  # that to the property setter, then this will get the correct timezone
  # abbreviation.
  module Property::TimezoneDetection
    # Public: Set the value. If the value contains any relevant timezone
    # information, then try and set the TZID parameter to the appropriate
    # timezone.
    def value=(val)
      if zone = detect_timezone_for(val)
        self.tzid = zone
      end

      super
    end

    private

    # Internal: Detect the best matching timezone identifier given a Time
    # compatible object. If the time object knows about timezones (implements a
    # `#time_zone` method), we use that. Otherwise, we look for the first
    # timezone matching the abbreviation contained in the Time instance. If we
    # can't find a timezone for the time instance, or the time instance is in
    # UTC, then we return nil.
    #
    # time - A Time, DateTime, or another object that behaves like a Time object
    #
    # Returns a String or nil.
    def detect_timezone_for(time)
      return if utc?(time)

      if time.respond_to?(:time_zone)
        time.time_zone.name
      else
        time = time.to_time
        zone = TZInfo::Timezone.all.detect do |tz|
          tz.period_for_local(time).abbreviation.to_s == time.zone
        end
        zone && zone.name
      end
    end

    # Internal: Detect whether a time instance is in UTC or not. Given how ruby
    # implementations of time classes are quite inconsistent, then we need to
    # determine this on a class by class basis.
    #
    # time - A Time, DateTime, or any object with time information in it that
    #        can be converted to a Time object.
    #
    # Returns a Boolean.
    def utc?(time)
      case time
      when DateTime
        time.zone == "+00:00"
      when Time
        time.utc?
      else
        # Calling #to_time will always return a Time in local time. So there's
        # no point in doing `time.to_time.utc?`, as we can't really infer
        # anything useful from that.
        false
      end
    end
  end
end
