require "test_helper"

class ComponentPropertiesTest < MiniTest::Unit::TestCase
  def test_uid
    prop = Kali::Property::UniqueIdentifier.new("event-1")
    assert_equal "UID:event-1", prop.to_ics
  end

  def test_sequence
    prop = Kali::Property::SequenceNumber.new(1)
    assert_equal "SEQUENCE:1", prop.to_ics

    default = Kali::Property::SequenceNumber.new
    assert_equal "SEQUENCE:0", default.to_ics

    assert_raises ArgumentError do
      prop = Kali::Property::SequenceNumber.new(-1)
      prop.to_ics
    end
  end

  def test_description
    prop = Kali::Property::Description.new("Some, long, description")
    assert_equal "DESCRIPTION:Some\\, long\\, description", prop.to_ics
  end

  def test_geo
    prop = Kali::Property::GeographicPosition.new([-54.00, -34.00])
    assert_equal "GEO:-54.0;-34.0", prop.to_ics
  end
end
