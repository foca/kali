require "test_helper"

class CalendarPropertiesTest < MiniTest::Unit::TestCase
  def test_prodid
    prop = Kali::Property::ProductIdentifier.new("-//ABC Corporation//NONSGML My Product//EN")
    assert_equal "PRODID:-//ABC Corporation//NONSGML My Product//EN", prop.to_ics

    default = Kali::Property::ProductIdentifier.new
    assert_equal "PRODID:Kali/#{Kali::VERSION}", default.to_ics
  end

  def test_version
    assert_raises ArgumentError do
      prop = Kali::Property::Version.new("2.5")
      assert_equal "VERSION:2.5", prop.to_ics
    end

    prop = Kali::Property::Version.new("2.0")
    assert_equal "VERSION:2.0", prop.to_ics

    default = Kali::Property::Version.new
    assert_equal "VERSION:2.0", default.to_ics
  end

  def test_calscale
    assert_raises ArgumentError do
      prop = Kali::Property::CalendarScale.new("JULIAN")
      assert_equal "CALSCALE:JULIAN", prop.to_ics
    end

    prop = Kali::Property::CalendarScale.new("GREGORIAN")
    assert_equal "CALSCALE:GREGORIAN", prop.to_ics

    default = Kali::Property::CalendarScale.new
    assert_equal "CALSCALE:GREGORIAN", default.to_ics
  end

  def test_method
    prop = Kali::Property::Method.new("REQUEST")
    assert_equal "METHOD:REQUEST", prop.to_ics

    default = Kali::Property::Method.new
    assert_raises(ArgumentError) { default.to_ics }
  end
end
