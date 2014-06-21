class Bird < Item
	def initialize (window, img, sound, terrain)
		super(window, img, sound, "Bird", terrain)
		@last_sprite = 0
		@current_sprite = 0
		self.width = @image.width / 4
    	self.height = @image.height
		@sprites = Array.new
		@sprites.push(Gosu::Image.new(window, img, false, 0 , 0, @width, @height))
		@sprites.push(Gosu::Image.new(window, img, false, 32, 0, @width, @height))
		@sprites.push(Gosu::Image.new(window, img, false, 64, 0, @width, @height))
		@sprites.push(Gosu::Image.new(window, img, false, 96, 0, @width, @height))
		@BB_RADIUS = 96
	end

	def update(elapsedTime, catspeed)
		if (@last_sprite > 0.25)
			@last_sprite = 0
			@current_sprite += 1
			@current_sprite %= 4
		else
			@last_sprite += elapsedTime
		end	


		if (@sin > 2* Math::PI)
			@sin = 0
		else
			@sin += 0.05
		end

		self.y += Math::sin(@sin) 
		if (self.x < 0)
			self.spawnItem()
		else
			self.x -= 5 * elapsedTime / 0.16 * catspeed
		end
	end

	def draw window, dx, dy
    	@sprites[@current_sprite].draw(self.x + dx, window.height / 2 - self.y + dy, 3, 3, 3)
  	end

  	def cat_action cat
  		cat.gravity = 1.0
  	end
end