class Actor
  attr_reader :type
  attr_reader :x
  attr_reader :y
   
  def initialize window, img, sound, type
    @image = Gosu::Image.new(window, img, false)
    @beep = Gosu::Sample.new(window, sound)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @type = type
    window.addGameObject self
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def update elapsed_time = 0.16
  end

  def draw window
    @image.draw_rot(@x, window.height / 2 - @y, ZOrder::Player, @angle)
  end
end