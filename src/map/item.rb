class Item
  attr_reader :type
  attr_accessor :x
  attr_accessor :y
  attr_accessor :width
  attr_accessor :height
   
  def initialize window, img, sound, type
    @image = Gosu::Image.new(window, img, false)
    @beep = Gosu::Sample.new(window, sound)
    @x = @y = @vel_x = @width = @height = 0.0
    @type = type
    window.addGameObject self
  end

  def collides(x, y)
    
  end

  def update elapsed_time = 0.16, catspeed = 1.0
  end

  def draw window, dx, dy
    @image.draw(@x + dx, window.height / 2 - @y + dy, 3)
  end
end