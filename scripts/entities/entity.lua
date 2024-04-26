entity=gameobject:extend({
  -- position
  x=0,
	y=0,
  elevation = 0,

  -- drawing
  width = 8,
  height = 8,
  flip = false,

  -- animation
  animation_frame = 0,
  animation_frames = 0,

  draw_shadow = function(_ENV)
    local shadow_width = 1 / (elevation + 1)
    line(x-shadow_width/2,y,x+shadow_width/2,y,1)
  end
})
