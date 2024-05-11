entity=gameobject:extend({

  -- static
  objects = {},

  --------------------

  -- position
  x=0,
	y=0,
  ox = 0,
  oy = 0,
  r=4,
  elevation = 0,
  speed = 1,
  path = {},

  -- follow
  follow_distance = 0,
  max_follow_distance = 24,

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
  flash_timer = 0,

  -- state
  state = "idle",
  states = {
    idle = _noop
  },

  -- events
  on_path_end = _noop,
  on_follow_stop = _noop,
  on_map_collide = _noop,
  on_entity_collide = _noop,

  -- instance methods
  init = function(_ENV)
    add(entity.objects,_ENV)
  end,

  update = function(_ENV)
    flash_timer = max(0,flash_timer - 1)
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

  move = function(_ENV, nx, ny)
    local px = x
    local py = y

    if not _ENV:collide(nx,y) then
      x = nx
    end

    if not _ENV:collide(x,ny) then
      y = ny
    end

    -- flip sprite
    if (nx > px) flip = false
    if (nx < px) flip = true

    return px != nx or py != ny
  end,

  move_toward = function(_ENV, target)
    local dx = target.x - x
    local dy = target.y - y

    local a = atan2(dx, dy)
    local ax = cos(a)
    local ay = sin(a)

    local vx = sgn(ax) * min(abs(cos(a) * speed), abs(dx))
    local vy = sgn(ay) * min(abs(sin(a) * speed), abs(dy))

    return _ENV:move(x+vx, y+vy)
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
    local flag = flags.solid
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
      local tile = mget(x\8,y\8)
      local shadow_scale = 1 / (elevation*.5 + 1)
      local shadow_width = width * shadow_scale
      line(x-shadow_width/2 + ox,y + oy,x-1+shadow_width/2 + ox,y + oy,14)
    end
  end,

  follow = function(_ENV, new_target)
    target = new_target
    if (not target) return

    if (dist(_ENV, target) <= follow_distance) then
      _ENV:on_follow_stop()
      return false
    end

    if (#path > 0) return _ENV:follow_path()
    return _ENV:move_toward(target)
  end,

  follow_path = function(_ENV)
    if (#path == 0) return

    local px = 4 + path[1].x * 8
    local py = 4 + path[1].y * 8

    _ENV:move_toward({x=px,y=py})

    if dist(_ENV, {x=px,y=py}) < 1 then
      deli(path,1)
      if (#path == 0) _ENV:on_path_end()
    end
  end,

  find_path = function(_ENV, target)
    return astar({x\8,y\8}, {target.x\8, target.y\8})
  end
})
