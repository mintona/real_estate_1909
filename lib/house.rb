class House
  attr_reader :price, :address, :rooms

  def initialize(price, address)
    @price = price.delete("$").to_i
    @address = address
    @rooms = []
  end

  def add_room(room)
    @rooms << room
  end

  def rooms_from_category(category)
    rooms_by_category = @rooms.find_all { |room| room if room.category == category }
  end

  def area
    total_area = @rooms.reduce(0) do |total_area, room|
      total_area + room.area
    end
  end

end
