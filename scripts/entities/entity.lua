entity=gameobject:extend({

  -- static
  objects = {},

  --------------------

  -- position
  x=0,
	y=0,
  elevation = 0,

  -- drawing
  width = 8,
  height = 8,
  flip = false,
  shadow = false,

  -- animation
  fps = 6,
  current_animation = nil,
  animation_timer = 12,
  frame = 0,

  -- state
  states = {
    idle = _noop
  },

  -- instance methods
  init = function(_ENV)
    add(entity.objects,_ENV)
  end,

  update = function(_ENV)
    local state_func = states[state]
    if (state_func) states[state](_ENV)
  end,

  destroy = function(_ENV)
    del(entity.objects,_ENV)
  end,

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
    if shadow then
      local shadow_scale = 1 / (elevation + 1)
      local shadow_width = width * shadow_scale
      line(x+1-shadow_width/2,y+1,x+shadow_width/2,y+1,14)
    end
  end
})
