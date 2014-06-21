module MagicNumbers
  GRAVITY = -5.0
  GRAVITY_GROW = -0.2
  ACCELERATE = 0
  SPEED = 1.0
  ELAPSED_TIME = 0.16
  CATSPEED = 1.0
  SPEEDUP = 0.01
  CAT_Y = 60
  MAX_Y_SPEED_DOWN = -100
  MAX_Y_SPEED_UP = 40
  MIN_X_SPEED_TERRAIN = 0.4
  MIN_X_SPEED_AIR = 0.7
  PI = 3.1416
  DOWNHILL_FORCE_FACTOR = 1.0
  MAGIC_ANGLE = 30
  CONTACT_WITH_TERRAIN = false
  CONTACT_DELAY = 10
  JUMP = 40
end

class Cat < Actor

  attr_accessor :speed
  attr_accessor :boooom
  attr_accessor :gravity
  attr_accessor :lasagna_counter

  def initialize window, img, sound, terrain, lasagna_counter
    super window, img, sound, "cat"
    @lasagna_counter = lasagna_counter
    @gravity = MagicNumbers::GRAVITY # trololo
  	@accelerate = MagicNumbers::ACCELERATE
    @window = window
  	self.warp 300, 50
  	@speed = MagicNumbers::SPEED
  	@terrain = terrain
    @local_angle = 0
    @contact_with_terrain = MagicNumbers::CONTACT_WITH_TERRAIN
    @contact_delay = MagicNumbers::CONTACT_DELAY
    @contact_iter = 0
    @jump = Gosu::Sample.new(window, "../resources/sounds/jump_01.wav")

    # cat is ready
    puts "miau"
  end

  def update elapsed_time = MagicNumbers::ELAPSED_TIME, catspeed = MagicNumbers::CATSPEED
    if @speed < MagicNumbers::SPEED
      @speed += MagicNumbers::SPEEDUP * elapsed_time
    end

    if @gravity > MagicNumbers::GRAVITY
      @gravity += MagicNumbers::GRAVITY_GROW
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

      @contact_with_terrain = true

      prev_angle = @angle
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
      @contact_iter += 1
      if @contact_iter >= @contact_delay
        @contact_with_terrain = false
        @contact_iter = 0
      end
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

    if (@local_angle < 180)
      @local_angle = 180.0/MagicNumbers::PI*Math.atan(-self.vel_y) / 2
    end

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
    @local_angle = 180
  end

  def jump active = true
    if active and @contact_with_terrain
      self.vel_y += MagicNumbers::JUMP
      @contact_with_terrain = false
      @jump.play
    end
  end

  def accelerate_down active = true
  	if active
      @accelerate = 4
    else
	    @accelerate = 0
    end
  end

  def eaten_by_alf
    play_sound
    @window.currentState = Gameover.new @window, @window.width, @window.height, @lasagna_counter, self.x, self.y, self.angle
  end
end