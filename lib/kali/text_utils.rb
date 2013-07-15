module Kali
  module TextUtils
    module_function

    # Public: Fold lines as indicated by the Content Lines section of
    # [RFC5545](http://tools.ietf.org/html/rfc5545#section-3.1).
    #
    # FIXME: This is splitting into 75 *character* long lines, and not 75
    # *octet* long lines. We should deal with UTF-8 properly.
    #
    # line - A String.
    #
    # Returns a multi-line String.
    def fold_line(line)
      head, tail = line[0...75], line[75..-1]
      tail &&= tail.scan(/.{0,74}/)
        .reject { |fragment| fragment.nil? || fragment.empty? }
        .map { |fragment| " #{fragment}" }
      [head, *tail].join("\r\n")
    end

    # Public: Collapse a folded line into a single line without line breaks. See
    # `TextUtils.fold_line`, and [RFC5545][rfc].
    #
    # [rfc]: http://tools.ietf.org/html/rfc5545#section-3.1
    #
    # FIXME: This isn't taking into account that the line could have been folded
    # in the middle of a multi-byte character.
    #
    # lines - A multi-line String that follows the folding format specified by
    # the RFC.
    #
    # Returns a String.
    def unfold_line(lines)
      head, *tail = lines.split("\r\n")
      tail.map! { |line| line[1..-1] }
      [head, *tail].join("")
    end
  end
end
