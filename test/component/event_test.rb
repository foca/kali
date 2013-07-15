require "test_helper"

class EventTest < MiniTest::Unit::TestCase
  def test_event_properties
    event = Kali::Event.new do |e|
      e.sequence = 0
      e.uid = 1
      e.description = "Some description about the event"
      e.geo = [-54.458594, -34.123310]
      e.categories = ["CATEGORY A", "CATEGORY B"]
      e.comments.add do |comment|
        comment.value = "This is a comment --John"
      end
      e.comments.add "This is another comment --Jane"
    end
  end
end
