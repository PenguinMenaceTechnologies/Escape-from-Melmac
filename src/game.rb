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
require './point.rb'
require './map/terrain.rb'
require './map/grass.rb'
require './actors/actor.rb'
require './actors/cat.rb'
require './actors/alf.rb'
require './map/item.rb'
require './map/schroedingerbox.rb'
require './map/bird.rb'
require './map/lasagna.rb'
require './map/explosion.rb'
require './states/gameover.rb'
require './states/running.rb'
require './states/loader.rb'
require './states/menu.rb'


module MagicNumbers
	SCROLL_SPEED = 5
end

class GameWindow < Gosu::Window
	attr_accessor :currentState
	attr_accessor :gameObjects
	attr_accessor :backgroundImage


	def initialize(width, height, caption)
		super(width, height, true)
		@width = width
		@height = height
		@gameObjects = Array.new
		self.caption = caption

		# Set the current state to main menu
		@currentState = Loader.new self, @width, @height
	end

    def addGameObject gameObject
    	@gameObjects[@gameObjects.length] = gameObject
    end

	# Override ineherited update mehtod
	def update
    	@currentState.update
	end

	# Override inherited draw method
	def draw
		@currentState.draw
	end
end

# Start the game720
window = GameWindow.new(1280, 720, "Escape from Melmac")
window.show