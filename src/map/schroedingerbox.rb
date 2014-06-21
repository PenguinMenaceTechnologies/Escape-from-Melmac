module MagicNumbers
    MIN_QUANTUM_GRAVITY = 0.5
    MAX_QUANTUM_GRAVITY = 1.5 
    MAX_QUANTUM_SPEED = 1.9
    MIN_QUANTUM_SPEED = 0.01
end

class SchroedingerBox < Item

	def initialize (window, img, sound, terrain)
		super(window, img, sound, "Schroedinger\'s Box", terrain)
	end

    def cat_action cat
        dice1 = rand(0.0..1.0)
        #dice2 = rand(0..10)
        if dice1 < 5
            speedup = rand(MagicNumbers::MIN_QUANTUM_SPEED..MagicNumbers::MAX_QUANTUM_SPEED)
            puts "speedup: "
            puts speedup
            cat.speed *= speedup
        else
            grav_mod = rand(MagicNumbers::MIN_QUANTUM_GRAVITY..MagicNumbers::MAX_QUANTUM_GRAVITY)
            puts "grav_mod: "
            puts grav_mod
            cat.gravity *= grav_mod
        end
    end
end