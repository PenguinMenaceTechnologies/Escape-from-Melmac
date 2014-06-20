
module MagicNumbers
	BUFFER_SIZE = 10
	MIN_AMP, MAX_AMP = 0.7, 1.3
	MIN_PHASE, MAX_PHASE = 350, 650
	SCROLL_SPEED = 5
end
class Terrain
	attr_reader :terrainBuffer

	def initialize(window, randomness = 1)
		@randomness = randomness
		@terrainBuffer = Array.new(MagicNumbers::BUFFER_SIZE)
		@phaseBuffer = Array.new
		@amplitudeBuffer = Array.new
		@offset = 0
		@window = window
		initTerrain()
		window.addGameObject self
	end

	def initTerrain()
		i = 0
		while i < MagicNumbers::BUFFER_SIZE do
			fillBuffer()
			i += 1
		end
	end

	def get_height x = 0
        return (@terrainBuffer[x + @offset] * @window.height / 4) - @window.height / 6
	end

	def update(elapsedTime)
		@offset += 5 * elapsedTime / 0.16

		if (@offset > @phaseBuffer[0])
			@offset -= @phaseBuffer[0]
			# delete old phase length
			currentPhase = @phaseBuffer.shift()
			@terrainBuffer.shift(currentPhase)
			@amplitudeBuffer.shift()
			# fill new hill
			fillBuffer()
		end
	end

	def fillBuffer()
		currentPhase = rand(MagicNumbers::MIN_PHASE..MagicNumbers::MAX_PHASE)
		@phaseBuffer.push(currentPhase)
		currentAmplitude = rand(MagicNumbers::MIN_AMP..MagicNumbers::MAX_AMP)
		@amplitudeBuffer.push(currentAmplitude)
		# add new values to terrain height array
		
		i = 0
		while i < currentPhase do
			@terrainBuffer.push(currentAmplitude * Math::sin((2 * Math::PI / currentPhase) * i))
			i += 1
		end
	end  

	def getCurrentSlope(x = 0)
		return @amplitudeBuffer[0] * Math::cos((2 * Math::PI / @phaseBuffer[0]) * x) *@window.height / 4.0
	end
	
	def draw(window, dx, dy)
		red = Gosu::Color.argb(0xffff0000)
		if (@terrainBuffer[@offset] == nil)
			return
		end 
		i = 0
		while i < window.width do
			window.draw_line(i, window.height, red, i, window.height / 1.5 - (@terrainBuffer[i + @offset] * (window.height / 4)), red)
			i += 1
		end
	end
end