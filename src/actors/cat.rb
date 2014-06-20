class Cat < Actor

  attr_reader :speed
  attr_accessor :boooom

  def initialize window, img, sound, terrain
    super window, img, sound, "cat"

    @gravity = -6.81 # trololo
  	@accelerate = 0
  	self.warp 100, 50
  	@speed = 1.0
  	@terrain = terrain

    # cat is ready
    puts "miau"
  end

  def update elapsed_time = 0.16
  	prev_y = self.y
  	self.vel_y += @gravity * elapsed_time
  	self.vel_y -= @accelerate
    if self.vel_y < -100
      self.vel_y = -100
    end
  	self.y += self.vel_y * elapsed_time * 2

    # collide with terrain
  	if self.y < @terrain.get_height(self.x)
      self.y = @terrain.get_height(self.x)
      #self.vel_y = @terrain. + 1.0
      self.vel_y = @terrain.getCurrentSlope(self.x)
      @boooom = true
  	else
      @boooom = false
    end

  	# update velocity to actual velocity.
  	# self.vel_y = self.y - prev_y 
    if self.vel_y > 40
      self.vel_y = 40
    end
    puts self.vel_y
  end

  # modify the speed required for effects
  def modify_speed modifier
  	@speed = @speed * modifier
  end

  # flip a cat (required for the flip paradoxon)
  def flip
    self.angle =  self.angle + 180
  end

  def accelerate_down active = true
  	if active
      @accelerate = 1
    else
	    @accelerate = 0
    end
  end

  def eaten_by_alf
  	puts "*fauch*"
  	puts "iiiek"
  end
end