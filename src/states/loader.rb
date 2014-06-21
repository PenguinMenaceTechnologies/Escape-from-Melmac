class Loader < State
	def initialize window, width, height
		@window = window
		@width = width
		@height = height
		@i = 1
		@rainbow_image = Gosu::Image.new(window, "../resources/graphics/rainbow.png", false)
    	@font = Gosu::Font.new(window, Gosu::default_font_name, 30)
        #@music = Gosu::Song.new("../resources/music/crash.ogg")
		@crash_image = Gosu::Image.new(window, "../resources/graphics/crash.png", false)
		@crash_plays = false

		@backgroundScaleX = (10 + width) / @crash_image.width.to_f
		@backgroundScaleY = (10 + height) / @crash_image.height.to_f
	end


	def draw()
		if @i > 60 * 22
			 @window.currentState = Running.new @window, @width, @height
		end

		text = "Hi"

		if @i < 60 * 2
			text = "Googling cat images"
		elsif @i < 60 * 10
			text = "Loading graphics for fat garfield. (This may take a while, he's fat...)"
		elsif @i < 60 * 13
			text = "Feeding garfield with lasanga."
		elsif @i < 60 * 16
			text = "Feeding garfield with lasanga. (Running low on lasanga)"
		else
			text = "Shit alf is coming... RUN!"
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
    	  @font.draw(text, 10, @window.height-40, 4, 1.0, 1.0, 0xffffff00)
        else
        	if @crash_plays == false
        		#@music.play(true)
        		@crash_plays = true
        	end
        	@crash_image.draw(- 5, - 5, 0, @backgroundScaleX, @backgroundScaleY)#@background.width / @width, @background.height / @height)
        end

		@i += 1
	end
end