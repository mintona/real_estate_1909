require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/room'

class RoomTest < Minitest::Test

  def setup
    @room = Room.new(:bedroom, 10, 13)
  end

  def test_it_exists
    assert_instance_of Room, @room
  end

  def test_initialize
    assert_equal :bedroom, @room.category
    assert_equal 10, @room.width
    assert_equal 13, @room.length
  end

  def test_it_has_an_area
    assert_equal 130, @room.area
  end
end
