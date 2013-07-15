require "kali/type"

module Kali
  # Used to represent a duration of time, which can be nominal (days or weeks)
  # or accurate (hours, days, minutes, or seconds).
  #
  # See http://tools.ietf.org/html/rfc5545#section-3.3.6
  class Type::Duration < Type
    LABELS = { week: "W", day: "D", hour: "H", minute: "M", second: "S" }

    def encode!(obj)
      negative = obj.delete(:negative) { false }
      duration = obj.sort_by { |label, _| LABELS.key(label) }

      nominal = true
      duration = obj.each_with_object("") do |(label, amount), acc|
        suffix = LABELS.fetch(label) do
          raise ArgumentError, "#{label.inspect} is not a valid duration period. It must be one of #{labels.keys.inspect}"
        end

        acc << "T" if nominal && !(nominal = nominal?(label))
        acc << "#{amount}#{suffix}"
      end

      "#{"-" if negative}P#{duration}"
    end

    def decode!(string)
      duration = {}
      duration[:negative] = true if string.start_with?("-")
      matches = string.gsub(/\-\+PT/, "").scan(/((\d+)([WDHMS]))/)
      matches.each.with_object(duration) do |(_, n, suffix), duration|
        duration[LABELS.key(suffix)] = Integer(n)
      end
    end

    private

    def nominal?(key)
      [:week, :day].include?(key)
    end
  end
end
