class Lasagna < Item

	def initialize (window, img, sound, terrain)
		super(window, img, sound, "Lasagna", terrain)
	end

    def cat_action cat
        cat.speed += 1.0
    end
end