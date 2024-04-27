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
  fps = 6,
  current_animation = nil,
  animation_timer = 12,
  frame = 0,

  animate = function(_ENV, name)
    local animation = animations[name]
    if (animation != current_animation) then
      current_animation = animation
      frame = 1
      animation_timer = fps
    else
      animation_timer -= 1
      if animation_timer <= 0 then
        frame = (frame + 1)
        if (frame > #current_animation) frame = 1
        animation_timer = fps
      end
    end
  end,

  draw_shadow = function(_ENV)
    local shadow_width = 1 / (elevation + 1)
    line(x-shadow_width/2,y,x+shadow_width/2,y,1)
  end
})
