class Menu < State

	def initialize(window)
        #@nextState = Running
        window.backgroundImage = "../resources/graphics/menu.jpg"
        @music = Gosu::Song.new("../resources/music/cantina_band.ogg")
        # infinite cantina band loop
        @music.play(true)
    end

	def next() 
		puts "Going to next state #{nextState}"
	end

	def exit()
		puts "State #{self.name} exited."
	end

	def update
	end

	def draw()
		puts "Draw screen in state #{self.name}"
	end
end