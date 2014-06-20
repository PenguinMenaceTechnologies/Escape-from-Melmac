################################################################################
# => Escape From Melmac
# 
# => Created for the Gamejam @GPN2014
# => Topic: Cats
# => Authors: Micheal Fürst, Manuel Schönheinz, Johannes Schuck
# => TODO: Copyleft
#################################################################################

require 'rubygems'
require 'gosu'
require './state.rb'
require './states/menu.rb'
require './map/terrain.rb'

class GameWindow < Gosu::Window
	attr_reader :currentState
	attr_accessor :backgroundImage

	def initialize(width, height, caption)
		super(width, height, false)
		@width = width
		@height = height
		self.caption = caption

		# Set the current state to main menu
		@currentState = Menu.new(self)
		@terrain = Terrain.new
	end

	# Override ineherited update mehtod

	def update
		@background = Gosu::Image.new(self, backgroundImage, true)
	end
	# Override inherited draw method
	def draw
		if (@background)
			#puts "Background image width: #{@background.width} height: #{@background.height}"
        	@background.draw(0, 0, 0, 0.2, 0.2)
        end
        @terrain.draw(self)
	end
end

# Start the game
window = GameWindow.new(720, 360, "Escape from Melmac")
window.show