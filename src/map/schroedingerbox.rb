class SchroedingerBox < Item

	def initialize (window, img, sound, terrain)
		super(window, img, sound, "Schroedinger\'s Box", terrain)
		@window = window
		@terrain = terrain
		@sin = 0
	end
end