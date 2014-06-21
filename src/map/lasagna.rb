module MagicNumbers
    LASAGNA_SPEED = 2.0
end

class Lasagna < Item

	def initialize (window, img, sound, terrain)
		super(window, img, sound, "Lasagna", terrain)
	end

    def cat_action cat
        cat.speed += MagicNumbers::LASAGNA_SPEED
    end
end