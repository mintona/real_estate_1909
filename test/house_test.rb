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

    @room_3 = Room.new(:living_room, 25, 15)

    @room_4 = Room.new(:basement, 30, 41)

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

  def test_it_can_get_rooms_from_category

    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)

    assert_equal 2, @house.rooms_from_category(:bedroom).length
    assert_equal true, @house.rooms_from_category(:bedroom).include?(@room_1)
    assert_equal true, @house.rooms_from_category(:bedroom).include?(@room_2)
    assert_equal false, @house.rooms_from_category(:bedroom).include?(@room_3)

    assert_equal 1, @house.rooms_from_category(:basement).length
    assert_equal true, @house.rooms_from_category(:basement).include?(@room_4)

    assert_equal 1, @house.rooms_from_category(:living_room).length
    assert_equal true, @house.rooms_from_category(:living_room).include?(@room_3)
  end

  def test_house_has_a_total_house_area

    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)

    assert_equal 1900, @house.area
  end

  def test_price_per_square_foot

    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)

    assert_equal 210.53, @house.price_per_square_foot
  end

  def test_house_has_rooms_sorted_by_area

    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)

    assert_equal @room_1, @house.rooms_sorted_by_area.first
    assert_equal @room_4, @house.rooms_sorted_by_area.last

    assert_equal [@room_1, @room_2, @room_3, @room_4], @house.rooms_sorted_by_area
  end

  def test_it_can_group_rooms_by_category

    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)

    assert_instance_of Hash, @house.rooms_by_category

    assert_equal true, @house.rooms_by_category.keys.include?(:bedroom && :basement && :living_room)
    assert_equal false, @house.rooms_by_category.keys.include?(:dining_room)

    assert_equal 2, @house.rooms_by_category[:bedroom].length
    assert_equal true, @house.rooms_by_category[:bedroom].include?(@room_2 && @room_1)

    assert_equal 1, @house.rooms_by_category[:basement].length
    assert_equal true, @house.rooms_by_category[:basement].include?(@room_4)

    assert_equal 1, @house.rooms_by_category[:living_room].length
    assert_equal false, @house.rooms_by_category[:living_room].include?(@room_4)
    assert_equal true, @house.rooms_by_category[:living_room].include?(@room_3)

  end

end
