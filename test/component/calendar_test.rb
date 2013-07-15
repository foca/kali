require "test_helper"

class CalendarTest < MiniTest::Unit::TestCase
  def test_calendar_defaults
    cal = Kali::Calendar.new
    assert_equal Kali::Property::ProductIdentifier.default, cal.prodid.to_s
    assert_equal Kali::Property::Version.default,           cal.version.to_s
    assert_equal Kali::Property::CalendarScale.default,     cal.calscale.to_s
  end

  def test_calendar_overwrites_default_properties
    cal = Kali::Calendar.new do |calendar|
      calendar.prodid = "Product Id"
      calendar.method = "REQUEST"
    end

    assert_equal "Product Id", cal.prodid.value
    assert_equal "REQUEST",    cal.method.value
  end
end
