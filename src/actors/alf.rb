class Alf < Actor
  def initialize window, img, sound, terrain, cat
    super window, img, sound, "alf"
    @cat = cat
  	@accelerate = 0
  	@terrain = terrain
  	self.warp -400, 0
  end

  def update elapsed_time = 0.16, catspeed = 1.0
  	self.x = self.x + elapsed_time * 10 * (1-@cat.speed)
  	if self.x < 0
      self.y = @terrain.get_height(0) + 60
  	else
  		self.y = @terrain.get_height(self.x) + 60
  	end
  	if self.x > -30 # magic value 30+20 = 50 pixel dist to cat
  		@cat.eaten_by_alf
      # TODO end game
  	end
  end
end