class Lasagna < Actor

	def initialize window, img, sound, terrain
		super window, img, sound, "Lasagna"
		puts "foo"
		#@window = window
		#spawnLasagna()
	end

	def spawnLasagna()
		#self.x = rand(2600..20000)
		#minHeight = @window.height * 0.66666
		#maxHeight = @window.height
		#self.y = rand(minHeight..maxHeight)
	end

	def collides(x, y)
		
	end

	def update(elapsedTime, catspeed)
		if (self.x < 0)
			spawnLasagna()
		else
			self.x -= 5 * elapsedTime / 0.16 * catspeed
		end
	end
end