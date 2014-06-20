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
require './states/menu.rb'
require './map/terrain.rb'
require './actors/actor.rb'
require './actors/cat.rb'
require './actors/alf.rb'


module MagicNumbers
	SCROLL_SPEED = 5
end

class GameWindow < Gosu::Window
	attr_reader :currentState
	attr_accessor :backgroundImage

	def initialize(width, height, caption)
		super(width, height, false)
		@width = width
		@height = height
		@gameObjects = Array.new
		@rainbow_table = Array.new
		@rainbow_image = Gosu::Image.new(self, "../resources/graphics/rainbow.png", false)
		@background = Gosu::Image.new(self, "../resources/graphics/background.png", true)
		@rainbow_offset = 0
		self.caption = caption

		# Set the current state to main menu
		@currentState = Menu.new(self)
		@terrain = Terrain.new self
        @cat = Cat.new self, "../resources/graphics/garfield_sliding.png", "../resources/music/cantina_band.ogg", @terrain
        @alf = Alf.new self, "../resources/graphics/Earth.png", "../resources/music/cantina_band.ogg", @terrain, @cat
	end

    def addGameObject gameObject
    	@gameObjects[@gameObjects.length] = gameObject
    end

	# Override ineherited update mehtod
	def update
		elapsed_time = 0.16 * @cat.speed
		@gameObjects.each do |a|
		  if defined? a.update
            a.update elapsed_time
          end
		end
	end

	def rainbow x, y, dx, dy
		i = 0
		until i >= x do
			@rainbow_table[i] = @rainbow_table[i + MagicNumbers::SCROLL_SPEED]
		    i += 1
		end
		i = x - MagicNumbers::SCROLL_SPEED
		until i > x do
		  @rainbow_table[i] = y
		  i += 1
	    end
		i = 0
		until i > x do
			if @rainbow_table[i] != nil
		       @rainbow_image.draw_rot(i + dx, self.height / 2 - @rainbow_table[i] + dy + Math.sin(0.1*(i+@rainbow_offset))*5, 1, 0)
		    end
		    i += 1
	    end
	    @rainbow_offset += MagicNumbers::SCROLL_SPEED
	end

	# Override inherited draw method
	def draw
		shaky = @cat.boooom
		window = self
		dx = 0
		dy = 0
		if shaky 
         dx = rand (-5..5)
         dy = rand (-5..5)
		end
		if (@background)
			#puts "Background image width: #{@background.width} height: #{@background.height}"
        	@background.draw(dx - 5, dy - 5, 0, 0.5, 0.5)#@background.width / @width, @background.height / @height)
        end
		rainbow @cat.x, @cat.y, dx, dy
        @gameObjects.each do |a|
          if defined? a.draw
            a.draw window, dx, dy
          end
		end
	end
end

# Start the game720
window = GameWindow.new(1280, 720, "Escape from Melmac")
window.show