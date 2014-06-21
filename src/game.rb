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
require './map/grass.rb'
require './actors/actor.rb'
require './actors/cat.rb'
require './actors/alf.rb'
require './map/item.rb'
require './map/schroedingerbox.rb'
require './map/bird.rb'
require './map/lasagna.rb'
require './map/explosion.rb'


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
		@groundeffect_table = Array.new
		@groundeffect_image = Gosu::Image.new(self, "../resources/graphics/groundeffect.png", false)
		@background = Gosu::Image.new(self, "../resources/graphics/background.png", true)
		@backgroundScaleX = (10 + width) / @background.width.to_f
		@backgroundScaleY = (10 + height) / @background.height.to_f
		puts @backgroundScaleX
		puts @backgroundScaleY
		@rainbow_offset = 0
		self.caption = caption

		# Set the current state to main menu
		@currentState = Menu.new(self)
		@terrain = Terrain.new self
		@grass = Grass.new self
        @cat = Cat.new self, "../resources/graphics/garfield_sliding.png", "../resources/music/cantina_band.ogg", @terrain
        @alf = Alf.new self, "../resources/graphics/Earth.png", "../resources/music/cantina_band.ogg", @terrain, @cat
        @lasagna = Lasagna.new self, "../resources/graphics/lasagna.png", "../resources/music/cantina_band.ogg", @terrain
        @box = SchroedingerBox.new self, "../resources/graphics/box.png", "../resources/music/cantina_band.ogg", @terrain
        @bird = Bird.new self, "../resources/graphics/bird_sprite.png", "../resources/music/cantina_band.ogg", @terrain
        @explosion = Explosion.new self, "../resources/graphics/explosion_sprite.png", "../resources/music/cantina_band.ogg"
	end

    def addGameObject gameObject
    	@gameObjects[@gameObjects.length] = gameObject
    end

	# Override ineherited update mehtod
	def update
    	if button_down? Gosu::KbUp
      		puts "up"
      		@cat.jump
    	end

    	if button_down? Gosu::KbDown
      		puts "Down"
      		@cat.accelerate_down
    	end

		elapsed_time = 0.16
		@gameObjects.each do |a|
		  if defined? a.update
            a.update elapsed_time, @cat.speed
            if (a.is_a? Item)
            	if (a.collides(@cat.x, @cat.y))
            		@explosion.explode(a.x, a.y)
            		a.spawnItem()
            	end
            end
          end
		end
	end

	def rainbow x, y, dx, dy
		i = 0
		until i >= x do
			@rainbow_table[i] = @rainbow_table[i + MagicNumbers::SCROLL_SPEED * @cat.speed * 1.15]
		    i += 1
		end
		i = x - MagicNumbers::SCROLL_SPEED * @cat.speed
		until i > x do
		  @rainbow_table[i] = y
		  i += 1
	    end
		i = 0
		until i >= x do
			if @rainbow_table[i] != nil
				shift = (0xFF * ((i-0.0) / (x-0.0))).to_i
				color = 0x00FFFFFF | (shift << 24)
		        @rainbow_image.draw_rot(i + dx, self.height / 2 - @rainbow_table[i] + dy + Math.sin(0.1*(i+@rainbow_offset))*5, 3, 0, 0.5, 0.5, 1, 1, color)
		    end
		    i += 1
	    end
	    @rainbow_offset += MagicNumbers::SCROLL_SPEED
	end

	def groundeffect x, y, dx, dy
		i = x - 100
		until i >= x do
			@groundeffect_table[i] = @groundeffect_table[i + MagicNumbers::SCROLL_SPEED * @cat.speed * 1.15]
		    i += 1
		end
		i = x - MagicNumbers::SCROLL_SPEED * @cat.speed
		until i > x do
		  if y < @terrain.get_height(x) + 15 and rand(0..100) < 10
		    @groundeffect_table[i] = y
		  else
		  	@groundeffect_table[i] = nil
		  end
		  i += 1
	    end
		i = 0
		until i >= x do
			if @groundeffect_table[i] != nil
				shift = (0xFF * ((i-(x-100.0)) / (100.0))).to_i
				color = 0x00FFFFFF | (shift << 24)
		        @groundeffect_image.draw_rot(i + dx, self.height / 2 - @groundeffect_table[i] + dy + Math.sin(0.1*(i+@rainbow_offset))*1, 1, 0, 0.5, 0.5, 1, 1, color)
		    end
		    i += 1
	    end
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
        	@background.draw(dx - 5, dy - 5, 0, @backgroundScaleX, @backgroundScaleY)#@background.width / @width, @background.height / @height)
        end
		rainbow @cat.x, @cat.y, dx, dy
        groundeffect @cat.x, @cat.y-50, dx, dy
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