require "test_helper"

class TextUtilsTest < MiniTest::Unit::TestCase
  def test_fold_lines_shorter_than_75_chars
    line = "a" * 60
    folded = Kali::TextUtils.fold_line(line)
    assert_equal line, folded
  end

  def test_fold_lines_exactly_75_chars_long
    line = "a" * 75
    folded = Kali::TextUtils.fold_line(line)
    assert_equal line, folded
  end

  def test_fold_line_into_two_line_string
    line = "a" * 120
    folded = Kali::TextUtils.fold_line(line)
    expected = "#{"a" * 75}\r\n #{"a" * 45}"
    assert_equal expected, folded
  end

  def test_fold_line_into_three_line_string
    line = "a" * 200
    folded = Kali::TextUtils.fold_line(line)
    expected = "#{"a" * 75}\r\n #{"a" * 74}\r\n #{"a" * 51}"
    assert_equal expected, folded
  end

  def test_unfold_long_line
    lines = "#{"a" * 75}\r\n #{"a" * 74}\r\n #{"a" * 51}"
    actual = Kali::TextUtils.unfold_line(lines)
    expected = "a" * 200
    assert_equal expected, actual
  end

  def test_fold_unfold_is_idempotent
    expected = "a" * 200
    actual = Kali::TextUtils.unfold_line(Kali::TextUtils.fold_line(expected))
    assert_equal expected, actual
  end
end
