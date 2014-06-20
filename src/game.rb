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
		@actors = Array.new
		self.caption = caption

		# Set the current state to main menu
		@currentState = Menu.new(self)
		@terrain = Terrain.new
	end

    def addActor actor
    	@actors[@actors.length] = actor
    end

	# Override ineherited update mehtod
	def update
		@background = Gosu::Image.new(self, backgroundImage, true)
		elapsed_time = 0.16
		@actors.each do |a|
          a.update elapsed_time
		end
	end

	# Override inherited draw method
	def draw
		if (@background)
			#puts "Background image width: #{@background.width} height: #{@background.height}"
        	@background.draw(0, 0, 0, 0.2, 0.2)
        end
        @actors.each do |a|
          a.draw
		end
	end
end

# Start the game
window = GameWindow.new(720, 360, "Escape from Melmac")
#cat = Cat.new window, "media/Starfighter.bmp", "media/Beep.wav", terrain
#alf = Alf.new window, "media/Starfighter.bmp", "media/Beep.wav", terrain, cat
window.show