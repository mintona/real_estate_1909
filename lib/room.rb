class Room
  attr_reader :type, :width, :length

  def initialize(type, width, length)
    @type = type
    @width = width
    @length = length
  end

  def area
    @width * @length
  end

end
