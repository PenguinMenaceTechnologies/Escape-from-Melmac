class Item
  attr_reader :type
  attr_accessor :x
  attr_accessor :y
  attr_accessor :width
  attr_accessor :height
   
  def initialize window, img, sound, type, terrain
    @image = Gosu::Image.new(window, img, false)
    @beep = Gosu::Sample.new(window, sound)
    @x = @y = 0.0
    @width = @image.width
    @height = @image.height
    @type = type
    @terrain = terrain
    @window = window
    @sin = 0
    spawnItem()
    window.addGameObject self
  end

  def play_sound
    @beep.play
  end

  def spawnItem()
    self.x = rand(1280..@terrain.size()*0.6)
    self.y = rand(@terrain.get_height(self.x) + 40 ..@window.height / 2)
  end

  def collides x, y, other_radius
    curr_x = x - (@x + @width / 2)
    curr_y = y - (@y - @height / 2)
    if (Math::sqrt(curr_x * curr_x + curr_y * curr_y) < @width / 4 + other_radius)
      return true
    end
    return false
  end

  def cat_action cat, state
  end

  def update elapsed_time = 0.16, catspeed = 1.0
    if (@sin > 2* Math::PI)
      @sin = 0
    else
      @sin += 0.05
    end
    @y += Math::sin(@sin) 
    if (@x < 0)
      spawnItem()
    else
      @x -= 5 * elapsed_time / 0.16 * catspeed
    end
  end
  

  def draw window, dx, dy
    @image.draw(@x + dx, window.height / 2 - @y + dy, 3)
    color1 = Gosu::Color.argb(0xffff0000)
    color2 = Gosu::Color.argb(0xff00ff00)

    curr_x = @x + @width / 2
    curr_y = @y - @height / 2
    window.draw_quad(curr_x, -curr_y + window.height / 2, color1, curr_x + 10, -curr_y + window.height / 2, color1, curr_x + 10, -curr_y + window.height / 2 +10, color2, curr_x, -curr_y + window.height / 2 +10, color1, 4)
  end
end