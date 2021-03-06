module MagicNumbers
    LASAGNA_COUNTER_POS_Y = 10
end

class Running < State

    attr_accessor :lasagna_counter

	def initialize window, width, height, lasagna_counter
		@window = window
		@width = width
		@height = height
        @lasagna_counter = lasagna_counter
        #@nextState = Running
        window.backgroundImage = "../resources/graphics/background.png"
        @music = Gosu::Song.new("../resources/music/copycat.ogg")
        # infinite cantina band loop
		@rainbow_offset = 0


		@rainbow_table = Array.new
		@rainbow_image = Gosu::Image.new(window, "../resources/graphics/rainbow.png", false)
		@groundeffect_table = Array.new
		@groundeffect_image = Gosu::Image.new(window, "../resources/graphics/groundeffect.png", false)
		@background = Gosu::Image.new(window, "../resources/graphics/background.png", true)
		@backgroundScaleX = (10 + width) / @background.width.to_f
		@backgroundScaleY = (10 + height) / @background.height.to_f
        @font = Gosu::Font.new(window, Gosu::default_font_name, 30)

		@terrain = Terrain.new window
		@grass = Grass.new window
		@pfudor = Pfudor.new window, "../resources/graphics/pfudor.png"
        @cat = Cat.new window, "../resources/graphics/garfield_sliding.png", "../resources/sounds/cat_spawn.wav", @terrain, @lasagna_counter
        @alf = Alf.new window, "../resources/graphics/alf_sprite.png", "../resources/sounds/cat_iek.wav", @terrain, @cat
        @lasagna = Lasagna.new window, "../resources/graphics/lasagna.png", "../resources/sounds/whoosh1.wav", @terrain
        @box = SchroedingerBox.new window, "../resources/graphics/box.png", "../resources/sounds/Explosion.wav", @terrain
        @bird = Bird.new window, "../resources/graphics/bird_sprite.png", "../resources/sounds/peacockscream.ogg", @terrain
        @explosion = Explosion.new window, "../resources/graphics/explosion_sprite.png", "../resources/sounds/Explosion.wav"
        @music.play(true)
    end

	def next() 
		puts "Going to next state #{nextState}"
	end

	def exit()
		puts "State #{self.name} exited."
	end

	def update
        if @window.button_down? Gosu::KbUp
      		@cat.jump
    	end

    	if @window.button_down? Gosu::KbDown
      		@cat.accelerate_down
    	else
    		@cat.accelerate_down false
    	end

		elapsed_time = 0.16
		@window.gameObjects.each do |a|
		  if defined? a.update
            a.update elapsed_time, @cat.speed
            if (a.is_a? Item)
            	if (a.collides(@cat.x, @cat.y, @cat.width / 2))
            		@explosion.explode(a.x, a.y)
            		a.play_sound
                    a.cat_action(@cat, self)
                    @cat.lasagna_counter = @lasagna_counter
            		a.spawnItem()
            	end
            end
          end
		end
	end

	def interpolate a, b, t
		if a == nil
			return b
		end
		if b == nil
			return a
		end
		return a + (b-a) * t
	end

	def rainbow x, y, dx, dy
		i = 0
		until i >= x do
			@rainbow_table[i] = @rainbow_table[i + MagicNumbers::SCROLL_SPEED * @cat.speed * 1.15]
		    i += 1
		end
		i = x - MagicNumbers::SCROLL_SPEED * @cat.speed * 1.15 - 1
		if i < 0
			i = 0
		end
		dif = x - i
		until i > x do
			a = y
			b = @rainbow_table[x-dif-1]
			c = (x-i) / dif.to_f
		  @rainbow_table[i] = interpolate a, b, c
		  i += 1
	    end
		i = 0
		until i >= x do
			if @rainbow_table[i] != nil
				shift = (0xFF * ((i-0.0) / (x-0.0))).to_i
				color = 0x00FFFFFF | (shift << 24)
		        @rainbow_image.draw_rot(i + dx, @height / 2 - @rainbow_table[i] + dy + Math.sin(0.1*(i+@rainbow_offset))*5, 3, 0, 0.5, 0.5, 1, 1, color)
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
		        @groundeffect_image.draw_rot(i + dx, @height / 2 - @groundeffect_table[i] + dy + Math.sin(0.1*(i+@rainbow_offset))*1, 1, 0, 0.5, 0.5, 1, 1, color)
		    end
		    i += 1
	    end
	end

	def draw()
		shaky = @cat.boooom
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
        @window.gameObjects.each do |a|
          if defined? a.draw
            a.draw @window, dx, dy
          end
		end

        text = "lasagna-counter: #{@lasagna_counter}"
        @font.draw(text, 10, MagicNumbers::LASAGNA_COUNTER_POS_Y, 4, 1.0, 1.0, 0xffffff00)
	end
end