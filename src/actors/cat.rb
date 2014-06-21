module MagicNumbers
  GRAVITY = -4.81
  ACCELERATE = 0
  SPEED = 1.0
  ELAPSED_TIME = 0.16
  CATSPEED = 1.0
  SPEEDUP = 0.01
  CAT_Y = 60
  MAX_Y_SPEED_DOWN = -100
  MAX_Y_SPEED_UP = 40
  MIN_X_SPEED_TERRAIN = 0.3
  MIN_X_SPEED_AIR = 0.5
  PI = 3.1416
  DOWNHILL_FORCE_FACTOR = 0.05
  MAGIC_ANGLE = 60
end

class Cat < Actor

  attr_reader :speed
  attr_accessor :boooom

  def initialize window, img, sound, terrain
    super window, img, sound, "cat"

    @gravity = MagicNumbers::GRAVITY # trololo
  	@accelerate = MagicNumbers::ACCELERATE
    @window = window
  	self.warp 300, 50
  	@speed = MagicNumbers::SPEED
  	@terrain = terrain
    #@local_angle = 0

    # cat is ready
    puts "miau"
  end

  def update elapsed_time = MagicNumbers::ELAPSED_TIME, catspeed = MagicNumbers::CATSPEED
    if @speed < MagicNumbers::SPEED
      @speed += MagicNumbers::SPEEDUP * elapsed_time
    end
  	prev_y = self.y
  	self.vel_y += @gravity * elapsed_time
  	self.vel_y -= @accelerate
    if self.vel_y < MagicNumbers::MAX_Y_SPEED_DOWN
      self.vel_y = MagicNumbers::MAX_Y_SPEED_DOWN
    end
  	self.y += self.vel_y * elapsed_time * 2

    # collide with terrain
  	if self.y < @terrain.get_height(self.x) + MagicNumbers::CAT_Y 
      self.y = @terrain.get_height(self.x) + MagicNumbers::CAT_Y 
      #self.vel_y = @terrain. + 1.0
      self.vel_y = @terrain.getCurrentSlope(self.x)

      prev_angle = @angle
      puts @angle
      tmp_angle = 180.0/MagicNumbers::PI*Math.atan2(-self.vel_y, 1)
      ###
      @speed += - self.vel_y*MagicNumbers::DOWNHILL_FORCE_FACTOR
      if @speed < MagicNumbers::MIN_X_SPEED_TERRAIN
        @speed = MagicNumbers::MIN_X_SPEED_TERRAIN
      end
      if (prev_angle-tmp_angle)*(prev_angle-tmp_angle) > MagicNumbers::MAGIC_ANGLE*MagicNumbers::MAGIC_ANGLE
        @boooom = true
      end
      ###
  	else
      @boooom = false
    end

    if @boooom and rand(0..1000) < 25
      @boooom = false
    end


  	# update velocity to actual velocity.
  	# self.vel_y = self.y - prev_y 
    if self.vel_y > MagicNumbers::MAX_Y_SPEED_UP
      self.vel_y = MagicNumbers::MAX_Y_SPEED_UP
    end

    @local_angle = 180.0/MagicNumbers::PI*Math.atan(-self.vel_y) / 2

    @angle += (@local_angle - @angle) * 0.1
    if @speed < MagicNumbers::MIN_X_SPEED_AIR
      @speed = MagicNumbers::MIN_X_SPEED_AIR
    end
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