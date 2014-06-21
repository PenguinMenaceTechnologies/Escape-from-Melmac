module Grassvalues
	BUFFER_SIZE = 10
	MIN_PHASE, MAX_PHASE = 600, 1000
	SCROLL_SPEED = 3
end

class Grass

	def initialize(window, randomness = 1)
		@randomness = randomness
		@grass_buffer = Array.new(Grassvalues::BUFFER_SIZE)
		@phase_buffer = Array.new
		@offset = 0
		@window = window
		initGrass()
		window.addGameObject self
	end

	def size()
		i = 0
		size = 0
		while i < Grassvalues::BUFFER_SIZE do
			size += @phase_buffer[i]
			i += 1
		end
		return size
	end

	def initGrass()
		i = 0
		while i < Grassvalues::BUFFER_SIZE do
			fillBuffer()
			i += 1
		end
	end

	def get_height x = 0
		if @grass_buffer[x + @offset] == nil
			return 0
		end
        return (@grass_buffer[x + @offset] * @window.height / 4) - @window.height / 6
	end

	def update(elapsedTime, catspeed)
		@offset += Grassvalues::SCROLL_SPEED * catspeed

		if (@offset > @phase_buffer[0])
			@offset -= @phase_buffer[0]
			# delete old phase length
			currentPhase = @phase_buffer.shift()
			@grass_buffer.shift(currentPhase)
			# fill new hill
			fillBuffer()
		end
	end

	def fillBuffer()
		currentPhase = rand(Grassvalues::MIN_PHASE..Grassvalues::MAX_PHASE)
		@phase_buffer.push(currentPhase)
		
		i = 0
		while i < currentPhase do
			@grass_buffer.push(0.3 * Math::sin((2 * Math::PI / currentPhase) * i))
			i += 1
		end
	end  

	def draw(window, dx, dy)
		light_green = Gosu::Color.argb(0xffb5e61d)
		dark_green = Gosu::Color.argb(0xff22b14c)
		if (@grass_buffer[@offset] == nil)
			return
		end 
		i = 0
		while i < window.width do
			window.draw_line(i, window.height, light_green, i, window.height / 1.7 - (@grass_buffer[i + @offset] * (window.height / 4)), dark_green, 1)
			i += 1
		end
	end
end