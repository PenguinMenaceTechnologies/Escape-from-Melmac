class Lasagna < Actor

	def initialize (window, img, sound, terrain)
		super(window, img, sound, "Lasagna")
		@image = @image = Gosu::Image.new(window, "../resources/graphics/Lasagna.png", false)
		@window = window
		spawnLasagne()
	end

	def spawnLasagne()
		@x = rand(2600..20000)
		@y = rand(window.height * 0.66666..window.height)
	end

	def collides(x, y)
		
	end

	def update(elapsedTime)
		if (@x < 0)
			spawnLasagne()
		else
			@x -= 5
		end
	end
end