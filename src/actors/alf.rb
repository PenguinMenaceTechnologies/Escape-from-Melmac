module MagicNumbers
    ACCELERATE = 0
    ELAPSED_TIME = 0.16
    CATSPEED = 1.0
    ALF_ACCELERATION_FAKTOR = 50
    ALF_X = 60
end
class Alf < Actor
  def initialize window, img, sound, terrain, cat
    super window, img, sound, "alf"
    @last_sprite = 0
    @current_sprite = 0
    self.width = @image.width / 5
    @sprites = Array.new
    for i in 0..4
      @sprites.push(Gosu::Image.new(window, img, false, self.width * i, 0, self.width, self.height))
    end
    @cat = cat
  	@accelerate = 0
  	@terrain = terrain
  	self.warp -200, 0
  end

  def update elapsed_time = MagicNumbers::ELAPSED_TIME, catspeed = MagicNumbers::CATSPEED
    if (@last_sprite > 0.2)
      @last_sprite = 0
      @current_sprite += 1
      @current_sprite %= 5
    else
      @last_sprite += elapsed_time
    end 

  	self.x = self.x + elapsed_time * MagicNumbers::ALF_ACCELERATION_FAKTOR * (1-@cat.speed)
  	if self.x < 0
      self.y = @terrain.get_height(0) + MagicNumbers::ALF_X
  	else
  		self.y = @terrain.get_height(self.x) + MagicNumbers::ALF_X
  	end
    if self.x < -200
      self.x = -200
    end
  	if self.x > @cat.x - 30 # magic value 30+20 = 50 pixel dist to cat
  		@cat.eaten_by_alf
      # TODO end game
  	end
  end

  def draw window, dx, dy
    @sprites[@current_sprite].draw_rot(@x + dx, window.height / 2 - @y + dy, 3, self.angle)
    color1 = Gosu::Color.argb(0xffff0000)
    color2 = Gosu::Color.argb(0xff00ff00)
    window.draw_quad(@x, -@y + window.height / 2, color1, @x + 10, -@y + window.height / 2, color1, @x + 10, -@y + window.height / 2 +10, color2, @x, -@y + window.height / 2 +10, color1, 4)
  end
end