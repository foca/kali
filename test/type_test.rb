require "test_helper"

class TypeTest < MiniTest::Unit::TestCase
  def test_text
    type = Kali::Type::Text.new
    assert_equal "plain", type.encode("plain")
    assert_equal "escaped\\, characters", type.encode("escaped, characters")
    assert_equal "escaped\\ncharacters", type.encode("escaped\ncharacters")
    assert_equal "escaped\\;characters", type.encode("escaped;characters")
    assert_idempotent type, "idempotent;idempotent,idempotent\nidempotent"

    type = Kali::Type::Text.new(/[aeiou]/)
    assert_equal "a", type.encode("a")
    assert_equal "a", type.decode("a")
    assert_raises(ArgumentError) { type.encode("b") }
    assert_raises(ArgumentError) { type.decode("b") }
  end

  def test_integer
    type = Kali::Type::Integer.new
    assert_equal "0", type.encode(0)
    assert_equal "1", type.encode(1.3)
    assert_raises(ArgumentError) { type.encode("nope") }
    assert_idempotent type, 1

    type = Kali::Type::Integer.new(0..9)
    assert_equal "3", type.encode(3)
    assert_equal 5, type.decode("5")
    assert_raises(ArgumentError) { type.encode(15) }
    assert_raises(ArgumentError) { type.decode("10") }
  end

  def test_float
    type = Kali::Type::Float.new
    assert_equal "1.3", type.encode(1.3)
    assert_equal "0.0", type.encode(0)
    assert_raises(ArgumentError) { type.encode("nope") }
    assert_idempotent type, 1.5

    type = Kali::Type::Float.new(->(i) { i.between?(5.5, 10.0) })
    assert_equal "8.0", type.encode(8.0)
    assert_equal 9.2, type.decode("9.2")
    assert_raises(ArgumentError) { type.encode(5.0) }
    assert_raises(ArgumentError) { type.decode("10.1") }
  end

  def test_geo
    type = Kali::Type::Geo.new
    assert_equal "10.0;-3.0", type.encode([10.0, -3.0])
    assert_equal [-90.0, 180.0], type.decode("-90.000000;180.000000")
    assert_idempotent type, [-15.0001, -18.3456]
  end

  def test_list
    type = Kali::Type::List.new(Kali::Type::Text.new)
    assert_equal "a,b,c,d,e", type.encode(["a", "b", "c", "d", "e"])
    assert_equal ["x", "y", "z"], type.decode("x,y,z")
    assert_equal "test,with\\, one comma,with\\, two\\, commas",
      type.encode(["test", "with, one comma", "with, two, commas"])
    assert_idempotent type, ["test", "with, one comma", "with, two, commas"]

    type = Kali::Type::List.new(Kali::Type::Integer.new(0..9))
    assert_equal "1,2,3", type.encode([1, 2, 3])
    assert_equal [5, 6, 7], type.decode("5,6,7")
    assert_raises(ArgumentError) { type.encode([1, 2, 30]) }
    assert_raises(ArgumentError) { type.decode("10,5,1") }
  end

  def test_duration
    type = Kali::Type::Duration.new
    assert_equal("-PT15M", type.encode({ negative: true, minute: 15 }))
    assert_equal({ minute: 15, negative: true }, type.decode("-PT15M"))
    assert_equal("P3DT2H15M", type.encode({ day: 3, hour: 2, minute: 15 }))
    assert_equal({ minute: 0, hour: 3, week: 1 }, type.decode("P1WT3H0M"))
    assert_idempotent type, { week: 1, hour: 4, day: 2, minute: 5 }
  end

  def test_cal_address
    type = Kali::Type::CalAddress.new
    assert_equal "mailto:john@example.org", type.encode(URI("mailto:john@example.org"))
    assert_equal URI("mailto:jane@example.org"), type.decode("mailto:jane@example.org")
    assert_raises(ArgumentError) { type.encode(URI("https://example.org")) }
    assert_raises(ArgumentError) { type.decode("https://example.org") }
    assert_idempotent type, URI("mailto:jane@example.org")
  end

  def test_time
    type = Kali::Type::Time.new
    assert_equal "103000", type.encode(Time.parse("10:30"))
    assert_equal Time.parse("10:45:30"), type.decode("104530")

    assert_equal "103000Z", type.encode(Time.parse("10:30 UTC"))
    assert_equal Time.parse("10:45:30 UTC"), type.decode("104530Z")

    assert_idempotent type, Time.parse("13:10:05")
  end

  def test_date
    type = Kali::Type::Date.new
    assert_equal "20130731", type.encode(Date.parse("2013-07-31"))
    assert_equal Date.parse("2012-02-29"), type.decode("20120229")

    assert_idempotent type, Date.parse("2013-04-30")
  end

  def test_date_time
    type = Kali::Type::DateTime.new
    assert_equal "20130731T103000", type.encode(DateTime.parse("2013-07-31 10:30:00 +02:00"))
    assert_equal "20130731T103000", type.encode(DateTime.parse("2013-07-31 10:30:00 +09:00"))
    assert_equal DateTime.parse("1985-03-27 20:23:15"), type.decode("19850327T202315")

    assert_equal "20130731T103000Z", type.encode(DateTime.parse("2013-07-31 10:30:00 UTC"))
    assert_equal DateTime.parse("1985-03-27 20:23:15 UTC"), type.decode("19850327T202315Z")

    assert_idempotent type, DateTime.parse("2000-01-01 00:00:00")
  end

  def assert_idempotent(type, test_value)
    assert_equal test_value, type.decode(type.encode(test_value))
  end
end
