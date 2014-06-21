module MagicNumbers
    ACCELERATE = 0
    ELAPSED_TIME = 0.16
    CATSPEED = 1.0
    ALF_ACCELERATION_FAKTOR = 10
    ALF_X = 60
end
class Alf < Actor
  def initialize window, img, sound, terrain, cat
    super window, img, sound, "alf"
    @cat = cat
  	@accelerate = 0
  	@terrain = terrain
  	self.warp 0, 0
  end

  def update elapsed_time = MagicNumbers::ELAPSED_TIME, catspeed = MagicNumbers::CATSPEED
  	self.x = self.x + elapsed_time * MagicNumbers::ALF_ACCELERATION_FAKTOR * (1-@cat.speed)
  	if self.x < 0
      self.y = @terrain.get_height(0) + MagicNumbers::ALF_X
  	else
  		self.y = @terrain.get_height(self.x) + MagicNumbers::ALF_X
  	end
  	if self.x > @cat.x - 30 # magic value 30+20 = 50 pixel dist to cat
  		@cat.eaten_by_alf
      # TODO end game
  	end
  end
end