class Loader < State
	def initialize window, width, height, lasagna_counter
		@window = window
		@width = width
		@height = height
		@lasagna_counter = lasagna_counter
		@i = 1
		@cat_image = Gosu::Image.new(window, "../resources/graphics/garfield_sliding.png", false)
		@lasagna_image = Gosu::Image.new(window, "../resources/graphics/lasagna.png", false)
		@pfudor_image = Gosu::Image.new(window, "../resources/graphics/pfudor.png", false)
		@alf_image = Gosu::Image.new(window, "../resources/graphics/alf_sprite.png", false, 0, 0, 97, 117)
		@rainbow_image = Gosu::Image.new(window, "../resources/graphics/rainbow.png", false)
    	@font = Gosu::Font.new(window, Gosu::default_font_name, 30)
        @music = Gosu::Song.new("../resources/music/intro.ogg")
		@crash_image = Gosu::Image.new(window, "../resources/graphics/crash.png", false)
		@cat_spawn = Gosu::Sample.new("../resources/sounds/cat_spawn.wav")
		@cat_iek = Gosu::Sample.new("../resources/sounds/cat_iek.wav")
        @music.play(true)
        @has_spawned = false
        @has_ieked = false
        @lasagnas = Array.new

		@backgroundScaleX = (10 + width) / @crash_image.width.to_f
		@backgroundScaleY = (10 + height) / @crash_image.height.to_f
	end


	def draw()
		if @i > 60 * 23
			 @window.currentState = Running.new @window, @width, @height, @lasagna_counter
		end

		text = "Hi"

		if @i < 60 * 2
			text = "Googling cat images"
		elsif @i < 60 * 10
			text = "Loading graphics for garfield. (This may take a while, he's fat...)"
		elsif @i < 60 * 13
			if @has_spawned == false
				@has_spawned = true
				@cat_spawn.play
			end
			text = "Feeding garfield with lasanga."
		elsif @i < 60 * 16
			text = "Feeding garfield with lasanga. (Running low on lasanga)"
		else
			text = "Shit alf is coming... RUN!"
			if @has_ieked == false
				@has_ieked = true
				@cat_iek.play
			end
		end

		if @i > 60 * 10 and rand(0..100) < 2
			@lasagnas[@lasagnas.length] = @width
		end

		if @i < 60 * 20
		  x = 0
		  t = @i * @window.width / (60.0 * 20.0)
		  until x > t
			shift = (0xFF * ((x-0.0) / (t-0.0))).to_i
			color = 0x00FFFFFF | (shift << 24)
			@rainbow_image.draw_rot(x, @height / 2 + Math.sin(0.05*(x+t))*10, 3, 0, 0.5, 0.5, 1, 1, color)
			x += 1
		  end
		  if @i > 60 * 10 and @i < 60 * 16
		    @cat_image.draw_rot(@width / 2, @height / 2 + Math.sin(0.05*(x+t))*10, 3 + 40, 0)
		  elsif @i >= 60 * 16
		  	@alf_image.draw_rot((@i - 60 * 16) * 4, @height / 2 + Math.sin(0.05*(x+t))*10, 3 + 40, 0)
		  	@pfudor_image.draw_rot((@i - 60 * 16) * 4 - 200, @height / 2 + Math.sin(0.05*(x+t)).abs*10, 3 + 40, 0)
		  	@cat_image.draw_rot(@width / 2 + (@i - 60 * 16) * 4, @height / 2 + Math.sin(0.1*(x+t))*10, 3 + 40, 0)
		  end

		  ite = @lasagnas.length - 3
		  until ite < 0
		  	dx = @width / 2 + (@i - 60 * 16) * 4
		  	if @lasagnas[ite] < dx + 10
		  		@lasagnas[ite] = -100
		  	end

		  	@lasagna_image.draw_rot(@lasagnas[ite], @height / 2 + Math.sin(0.05*(x+t))*10, 3 + 40, 0)
		  	@lasagnas[ite] = @lasagnas[ite]-1
		  	ite -= 1
		  end
    	  @font.draw(text, 10, @window.height-40, 4, 1.0, 1.0, 0xffffff00)
        else
        	@crash_image.draw(- 5, - 5, 0, @backgroundScaleX, @backgroundScaleY)#@background.width / @width, @background.height / @height)
        end

		@i += 1
	end
end