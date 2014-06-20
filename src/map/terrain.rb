
module MagicNumbers
	BUFFER_SIZE = 2560
	MIN_AMP, MAX_AMP = 0.5, 1.5
	MIN_PHASE, MAX_PHASE = 80, 250
end
class Terrain
	attr_reader :terrainBuffer

	def initialize(window, randomness = 1)
		@randomness = randomness
		@terrainBuffer = Array.new(MagicNumbers::BUFFER_SIZE)
		fillBuffer()
		window.addGameObject self
	end

	def fillBuffer
		range = 0

		until range >= MagicNumbers::BUFFER_SIZE do
			currentPhase = rand(MagicNumbers::MIN_PHASE..MagicNumbers::MAX_PHASE)
			puts currentPhase
			currentAmplitude = rand(MagicNumbers::MIN_AMP..MagicNumbers::MAX_AMP)
			i = range
			while i < range + currentPhase do
				@terrainBuffer[i] = currentAmplitude * Math::cos((2 * Math::PI / currentPhase) * i)
				i += 1
			end

			range += currentPhase
		end
	end

	def draw(window)
		red = Gosu::Color.argb(0xffff0000)
		i = 0
		while i < window.width do
			window.draw_line(i, window.height, red, i, window.height / 2 - (@terrainBuffer[i] * window.height / 3), red)
			i += 1
		end
	end
end