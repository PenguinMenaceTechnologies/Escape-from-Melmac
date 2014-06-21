class Bird < Actor
	def initialize (window, img, sound, terrain)
		super(window, img, sound, "Bird")
		@window = window
		@terrain = terrain
		@sin = 0
		@last_sprite = 0
		@current_sprite = 0
		@sprites = Array.new
		@sprites.push(Gosu::Image.new(window, img, false, 0 , 0, 32, 32))
		@sprites.push(Gosu::Image.new(window, img, false, 32, 0, 32, 32))
		@sprites.push(Gosu::Image.new(window, img, false, 64, 0, 32, 32))
		@sprites.push(Gosu::Image.new(window, img, false, 96, 0, 32, 32))
	end

	def spawnLasagne()
		self.x = rand(1280..@terrain.size())
		self.y = rand(@terrain.get_height(self.x) + 40 ..@window.height / 2)
	end

	def collides(x, y)
		
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
			spawnLasagne()
		else
			self.x -= 5 * elapsedTime / 0.16 * catspeed
		end
	end

	def draw window, dx, dy
    	@sprites[@current_sprite].draw(self.x + dx, window.height / 2 - self.y + dy, 2, 3, 3)
  end
end