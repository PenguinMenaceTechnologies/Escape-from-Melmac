class Actor
  attr_reader :type
  attr_accessor :x
  attr_accessor :y
  attr_accessor :width
  attr_accessor :height
  attr_accessor :vel_x
  attr_accessor :vel_y
   
  def initialize window, img, sound, type
    @image = Gosu::Image.new(window, img, false)
    @beep = Gosu::Sample.new(window, sound)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @width = @image.width
    @height = @image.height
    @score = 0
    @type = type
    window.addGameObject self
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def update elapsed_time = 0.16, catspeed = 1.0
  end

  def play_sound
    @beep.play
  end

  def draw window, dx, dy
    @image.draw_rot(@x + dx, window.height / 2 - @y + dy, 3, @angle)
    #color1 = Gosu::Color.argb(0xffff0000)
    #color2 = Gosu::Color.argb(0xff00ff00)
    #window.draw_quad(@x, -@y + window.height / 2, color1, @x + 10, -@y + window.height / 2, color1, @x + 10, -@y + window.height / 2 +10, color2, @x, -@y + window.height / 2 +10, color1, 4)
  end
end