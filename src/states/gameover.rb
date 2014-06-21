class Gameover < State
	def initialize window, width, height, lasagna_counter
		@window = window
		@width = width
		@height = height
		puts @width.to_s + " " + @height.to_s
		@lasagna_counter = lasagna_counter
		@i = 1
		@cat_image = Gosu::Image.new(window, "../resources/graphics/garfield_sliding.png", false)
		@alf_image = Gosu::Image.new(window, "../resources/graphics/alf.png", false)
		@rainbow_image = Gosu::Image.new(window, "../resources/graphics/rainbow.png", false)
    	@font = Gosu::Font.new(window, Gosu::default_font_name, 30)
        @music = Gosu::Song.new("../resources/music/intro.ogg")
		@crash_image = Gosu::Image.new(window, "../resources/graphics/crash.png", false)
		@cat_spawn = Gosu::Sample.new("../resources/sounds/cat_spawn.wav")
		@cat_iek = Gosu::Sample.new("../resources/sounds/cat_iek.wav")
        @music.play(true)
        @has_spawned = false
        @has_ieked = false

		@backgroundScaleX = (10 + width) / @crash_image.width.to_f
		@backgroundScaleY = (10 + height) / @crash_image.height.to_f
	end


	def draw()
		if @i > 60 * 23
			 @window.currentState = Crash.new
		end

		text = "Hi"

		if @i < 60 * 2
			text = "Gameover"
		elsif @i < 60 * 4
			text = "Garfield was too fat to escape."
		elsif @i < 60 * 10
			text = "Putting garfield on diet."
		elsif @i < 60 * 14
			text = "It does not work..."
		else
			text = "Greetings by Jo-to+the+Hannes, Schoeni and penguinmenac3"
		end

		if @i < 60 * 20
		  x = 0
		  t = (@width-@i) * @width / (60.0 * 20.0)
		  until x > t
			shift = (0xFF * ((x-0.0) / (t-0.0))).to_i
			color = 0x00FFFFFF | (shift << 24)
			@rainbow_image.draw_rot(x, @height / 2 + Math.sin(0.05*(x+t))*10, 3, 0, 0.5, 0.5, 1, 1, color)
			x += 1
		  end
    	  @font.draw(text, 10, @window.height-40, 4, 1.0, 1.0, 0xffffff00)
        else
        	@crash_image.draw(- 5, - 5, 0, @backgroundScaleX, @backgroundScaleY)#@background.width / @width, @background.height / @height)
        end

		@i += 1
	end
end