class Cat < Actor

  attr_reader :speed

  def initialize window, img, sound, terrain
    super window, img, sound, "cat"

    @gravity = -98.1 # trololo
  	@accelerate = 0
  	self.warp 100, 50
  	@speed = 1.0
  	@terrain = terrain

    # cat is ready
    puts "miau"
  end

  def update elapsed_time = 0.16
  	prev_y = self.y
  	self.vel_y = self.vel_y + @gravity * elapsed_time
  	self.vel_y = self.vel_y - @accelerate
  	self.y = self.vel_y * elapsed_time + self.y

    # collide with terrain
  	if self.y < @terrain.terrainBuffer[self.x]
      self.y = @terrain.terrainBuffer[self.x]
  	end

  	# update velocity to actual velocity.
  	self.vel_y = prev_y - self.y
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