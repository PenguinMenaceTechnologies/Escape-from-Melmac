class Explosion < Actor
	def initialize (window, img, sound)
		@image = Gosu::Image.new(window, img, false)
    	@beep = Gosu::Sample.new(window, sound)
   		@x = @y = 0.0
		@last_sprite = 0
		@current_sprite = 0
		@sprites = Array.new
		for y in 0..3
			for x in 0..3
				@sprites.push(Gosu::Image.new(window, img, false, x * 64 , y * 64, 64, 64))
			end
		end
		window.addGameObject self
	end

	def explode x, y
		@x = x
		@y = y
		@is_running = true
	end

	def update elapsed_time = 0.16, catspeed = 1.0
		if @is_running
			if (@last_sprite > 0.1)
				@last_sprite = 0
				@current_sprite += 1
				if (@current_sprite == 16)
					@is_running = false
					@current_sprite = 0
				end
			else
				@last_sprite += elapsed_time
			end	
		end
    	@x -= 5 * elapsed_time / 0.16 * catspeed
	end

	def draw window, dx, dy
		if @is_running
    		@sprites[@current_sprite].draw(@x + dx, window.height / 2 - @y + dy, 3)
    	end
  	end
end