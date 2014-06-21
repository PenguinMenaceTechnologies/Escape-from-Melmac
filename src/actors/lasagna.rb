class Lasagna < Actor

	def initialize (window, img, sound, terrain)
		super(window, img, sound, "Lasagna")
		@image = @image = Gosu::Image.new(window, "../resources/graphics/lasagna.png", false)
		@window = window
		@terrain = terrain
		@sin = 0
		spawnLasagne()
	end

	def spawnLasagne()
		self.x = rand(1280..@terrain.size())
		self.y = rand(@terrain.get_height(self.x) + 40 ..@window.height / 2)
	end

	def collides(x, y)
		
	end

	def update(elapsedTime, catspeed)
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
end