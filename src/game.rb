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

class GameWindow < Gosu::Window
	attr_reader :currentState
	attr_accessor :backgroundImage

	def initialize(width, height, caption)
		super(width, height, false)
		@width = width
		@height = height
		@gameObjects = Array.new
		self.caption = caption

		# Set the current state to main menu
		@currentState = Menu.new(self)
	end

    def addGameObject gameObject
    	@gameObjects[@gameObjects.length] = gameObject
    end

	# Override ineherited update mehtod
	def update
		@background = Gosu::Image.new(self, backgroundImage, true)
		elapsed_time = 0.16
		@gameObjects.each do |a|
		  if defined? a.draw
            a.update elapsed_time
          end
		end
	end

	# Override inherited draw method
	def draw
		if (@background)
			#puts "Background image width: #{@background.width} height: #{@background.height}"
        	@background.draw(0, 0, 0, 0.2, 0.2)
        end
        @gameObjects.each do |a|
          if defined? a.draw
            a.draw self
          end
		end
	end
end

# Start the game
window = GameWindow.new(720, 360, "Escape from Melmac")
#cat = Cat.new window, "media/Starfighter.bmp", "media/Beep.wav", terrain
#alf = Alf.new window, "media/Starfighter.bmp", "media/Beep.wav", terrain, cat
window.show