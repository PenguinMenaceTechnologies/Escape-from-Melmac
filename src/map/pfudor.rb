class Pfudor

	def initialize window, img
		@image = Gosu::Image.new(window, img, false)
		@x = 750
		@y = 330
		@sin = 0
		window.addGameObject self
	end

	def update(elapsedTime, catspeed)
		if (@sin > 4 * Math::PI)
    	  @sin = 0
    	else
    	  @sin += 0.1
    	end
    	@up = 16 * Math::sin(@sin).abs
	end

	def draw window, dx, dy
    	@image.draw(@x + dx, window.height / 2 - @y + dy - @up.to_i, 3)
  	end
end