class Alf < Actor
  def initialize window, img, sound, terrain, cat
    super window, img, sound, "alf"
    @cat = cat
  	@accelerate = 0
  	@terrain = terrain
  	self.warp -400, 0
  end

  def update elapsed_time = 0.16
  	self.x = self.x + elapsed_time * 10 * (1-@cat.speed)
  	if self.x < 0
  		self.y = 0
  	else
  		self.y = @terrain.terrainBuffer[self.x]
  	end
  	if self.x > -30 # magic value 30+20 = 50 pixel dist to cat
  		puts "WARNING!"
  	end
  end
end