class State

	def initialize()
        # Define the next game state like this
        # @nextState = NextState
        # Where NextState is a class inheriting from State
    end

	def enter()
		puts "State #{self.name} entered."
	end

	def next() 
		puts "Going to next state #{nextState}"
	end

	def exit()
		puts "State #{self.name} exited."
	end

	def draw()
		puts "Draw screen in state #{self.name}"
	end

end