require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/room'
require_relative '../lib/house'

class HouseTest < Minitest::Test

  def setup
    @house = House.new("$400000", "123 sugar lane")

    @room_1 = room_1 = Room.new(:bedroom, 10, 13)

    @room_2 = Room.new(:bedroom, 11, 15)
  end

  def test_it_exists
    assert_instance_of House, @house
  end

  def test_initialize
    assert_equal 400000, @house.price

    assert_equal "123 sugar lane", @house.address

    assert_equal [], @house.rooms
  end

  def test_it_can_have_rooms
    assert_equal 0, @house.rooms.length

    @house.add_room(@room_1)

    assert_equal 1, @house.rooms.length
# Is it necessary here to show that room_2 is NOT in the @rooms array at this point or is that redundant? I'll put it as my next assertion anyways...
    assert_equal true, @house.rooms.include?(@room_1)
    assert_equal false, @house.rooms.include?(@room_2)

    @house.add_room(@room_2)

    assert_equal 2, @house.rooms.length

    assert_equal true, @house.rooms.include?(@room_2)
    assert_equal true, @house.rooms.include?(@room_1)

# Is this next assertion necessary since I tested that the rooms are included in the @rooms array above?
    assert_equal [@room_1, @room_2], @house.rooms
  end

end
