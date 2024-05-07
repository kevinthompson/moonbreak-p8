entity=gameobject:extend({

  -- static
  objects = {},

  --------------------

  -- position
  x=0,
	y=0,
  w=8,
  h=8,
  r=4,
  elevation = 0,

  -- collision
  map_collision = false,
  hitbox = {0,0,0,0},

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
  state = "idle",
  states = {
    idle = _noop
  },

  -- events
  on_map_collide = _noop,
  on_entity_collide = _noop,

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

  move = function(_ENV,nx,ny)
    if not _ENV:collide(nx,ny) then
      x = nx
      y = ny
      return true
    end

    return false
  end,

  collide = function(_ENV,cx,cy)
    cx = cx or x
    cy = cy or y

    local result = false

    -- map collision
    if map_collision and _ENV:map_collide(cx,cy) then
      _ENV:on_map_collide()
      result = true
    end

    -- entity collision
    if on_entity_collide != _noop then
			-- for e in all(entities) do
			-- 	if collide({ x=nx,y=ny,w=w,h=h },e) then
			-- 		on_entity_collide(_ENV,e)
			-- 	end
			-- end
		end

    return result
  end,

	-- movement
	map_collide = function(_ENV, cx, cy)
    local flag = flags.collision
    local x1,x2,y1,y2 = cx+hitbox[1],cx+hitbox[2],cy+hitbox[3],cy+hitbox[4]
    local points = {
      {x1,y1},
      {x2,y1},
      {x1,y2},
      {x2,y2},
    }

    for point in all(points) do
      if fget(mget(point[1]\8,point[2]\8),flag) then
        return true
      end
    end
	end,

  draw_shadow = function(_ENV)
    if shadow then
      local shadow_scale = 1 / (elevation + 1)
      local shadow_width = width * shadow_scale
      line(x-shadow_width/2,y+1,x-1+shadow_width/2,y+1,14)
    end
  end
})
