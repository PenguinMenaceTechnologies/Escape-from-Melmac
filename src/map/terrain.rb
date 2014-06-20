
module MagicNumbers
	BUFFER_SIZE = 2560
	MIN_AMP, MAX_AMP = 0.7, 1.3
	MIN_PHASE, MAX_PHASE = 350, 650
end
class Terrain
	attr_reader :terrainBuffer

	def initialize(window, randomness = 1)
		@randomness = randomness
		@terrainBuffer = Array.new(MagicNumbers::BUFFER_SIZE)
		@phaseBuffer = Array.new
		@offset = 0
		fillBuffer()
		window.addGameObject self
	end

	def fillBuffer
		range = 0

		until range >= MagicNumbers::BUFFER_SIZE do
			currentPhase = rand(MagicNumbers::MIN_PHASE..MagicNumbers::MAX_PHASE)
			@phaseBuffer.push(currentPhase)
			puts currentPhase
			currentAmplitude = rand(MagicNumbers::MIN_AMP..MagicNumbers::MAX_AMP)
			i = 0
			while i < currentPhase do
				@terrainBuffer[range + i] = currentAmplitude * Math::sin((2 * Math::PI / currentPhase) * i)
				i += 1
			end

			range += currentPhase
		end

		puts @phaseBuffer
	end

	def update(elapsedTime)
		@offset += 5

		if (@offset > MagicNumbers::MAX_PHASE)
			# Shift terrain and phase arrays
			currentPhase = @phaseBuffer[0]
			@terrainBuffer.shift(currentPhase)
	
			newPhaseLength = rand(MagicNumbers::MIN_PHASE..MagicNumbers::MAX_PHASE)
			# update offset
			@offset = MagicNumbers::MAX_PHASE - newPhaseLength

			currentAmplitude = rand(MagicNumbers::MIN_AMP..MagicNumbers::MAX_AMP)	
			# add new values to terrain height array
			i = 0
			while i < newPhaseLength do
				@terrainBuffer[MagicNumbers::BUFFER_SIZE - newPhaseLength + i] = currentAmplitude * Math::sin((2 * Math::PI / currentPhase) * i)
				i += 1
			end

			# delete old phase length
			@phaseBuffer.shift()
			# add new one to the ned of the phase length array
			@terrainBuffer.push(newPhaseLength)
		end

	end

	def draw(window)
		red = Gosu::Color.argb(0xffff0000)
		i = 0
		while i < window.width do
			window.draw_line(i, window.height, red, i, window.height / 1.5 - (@terrainBuffer[i + @offset] * window.height / 4), red)
			i += 1
		end
	end
end