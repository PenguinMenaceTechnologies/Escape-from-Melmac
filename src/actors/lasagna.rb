class Lasagna < Actor

	def initialize (window, img, sound, terrain)
		super(window, img, sound, "Lasagna")
		@image = @image = Gosu::Image.new(window, "../resources/graphics/lasagna.png", false)
		@window = window
		spawnLasagne()
	end

	def spawnLasagne()
		self.x = rand(2600..20000)
		self.y = rand(@window.height * 0.66666..@window.height)
	end

	def collides(x, y)
		
	end

	def update(elapsedTime, catspeed)
		if (self.x < 0)
			spawnLasagne()
		else
			self.x -= 5 * elapsedTime / 0.16 * catspeed
		end
	end
end