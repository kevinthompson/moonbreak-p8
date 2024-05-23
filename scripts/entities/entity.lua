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
  layer = 1,

  -- follow
  follow_distance = 0,
  max_follow_distance = 24,

  -- collision
  map_collision = false,
  entity_collision = false,
  hitbox = {0,0,0,0}, -- offsets: left, right, up, down from origin

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

  max_bots = 0,

  extend = function(_ENV,tbl)
    tbl = class.extend(_ENV, tbl)
    tbl.objects = {}
    return tbl
  end,

  -- instance methods
  init = function(_ENV)
    add(entity.objects,_ENV)

    if objects != entity.objects then
      add(objects,_ENV)
    end

    _ENV:set_sort_value()
    _ENV:set_map_tiles(1)
    bots = {}
    path = {}
  end,

  update = function(_ENV)
    _ENV:set_sort_value()
    flash_timer = max(0,flash_timer - 1)
    local state_func = states[state]
    if (state_func) states[state](_ENV)
  end,

  draw = function(_ENV)
    local x,y = x - width/2, y - height + 1
    if sprite then
      spr(sprite,x,y,width/8,height/8,flip)
    end
  end,

  destroy = function(_ENV)
    _ENV:set_map_tiles(0)
    del(entity.objects,_ENV)
    if objects != entity.objects then
      del(objects,_ENV)
    end
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
      return true
    end

    -- entity collision
    if entity_collision then
      for e in all(entity.objects) do
        if e != _ENV
        and _ENV:entity_collide(cx,cy,e) then
          _ENV:on_entity_collide(e)
          result = result or e.solid
        end
      end
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

  entity_collide = function(_ENV, cx, cy, other)
    return aabb(_ENV:get_hitbox(cx,cy),other:get_hitbox())
  end,

  draw_shadow = function(_ENV)
    if shadow then
      local shadow_scale = 1 / (elevation*.5 + 1)
      local shadow_width = width * shadow_scale
      line(
        x - shadow_width/2 + ox,
        y + 1 + oy,
        x-1+shadow_width/2 + ox,
        y + 1 + oy,
        14
      )
    end
  end,

  get_hitbox = function(_ENV,hx,hy)
    hx = hx or x
    hy = hy or y
    local x1,x2,y1,y2 = hx+hitbox[1],hx+hitbox[2],hy+hitbox[3],hy+hitbox[4]
    return {x=x1,y=y1,width=x2-x1,height=y2-y1}
  end,

  follow = function(_ENV, new_target)
    target = new_target
    if (finding_path or not target) return

    if map_collide and not _ENV:can_see(target) then
      if #path == 0 then
        _ENV:find_path(target)
      else
        return _ENV:follow_path()
      end
    else
      path = {}
    end

    if (dist(_ENV, target) <= follow_distance) then
      _ENV:on_follow_stop()
      return false
    end

    return _ENV:move_toward(target)
  end,

  follow_path = function(_ENV)
    if (#path == 0) return

    local px = 4 + path[1].x * 8
    local py = 4 + path[1].y * 8

    local ret = _ENV:move_toward({x=px,y=py})

    if dist(_ENV, {x=px,y=py}) < 1 then
      deli(path,1)
      if (#path == 0) _ENV:on_path_end()
    end

    return ret
  end,

  find_path = function(_ENV, target)
    finding_path = true
    async:call(function()
      local full_path = astar({x\8,y\8}, {target.x\8, target.y\8})
      deli(full_path,1)
      path = full_path
      finding_path = false
      if #path == 0 then
        state = "idle"
        for b in all(bots) do
          b.state = "idle"
        end
        bots = {}
        sfx(5)
      end
    end)
  end,

  can_see = function(_ENV, other, distance)
    local d = distance or 512
    local x1,y1,x2,y2 = x,y,other.x,other.y
    local dx,dy=x2-x1,y2-y1
    local adx,ady=abs(dx),abs(dy)
    if (adx>d or ady>d) return --too far on any axis
    if ((dx/d)*(dx/d)+(dy/d)*(dy/d)>1) return --fails mot's "within dist"
    if (adx>ady) then
     for i=0,dx,sgn(dx) do
      if (fget(mget((x1+i)/8, (y1+i*dy/dx)/8),0)) return
     end
    else
     for i=0,dy,sgn(dy) do
      if (fget(mget((x1+i*dx/dy)/8, (y1+i)/8),0)) return
     end
    end
    return true
   end,

  set_sort_value = function(_ENV)
    sort_value = layer * 1000 + y
  end,

  set_map_tiles = function(_ENV, sprite)
    if solid then
      local hb = _ENV:get_hitbox()
      for x = hb.x,hb.x + hb.width - 1 do
        for y = hb.y,hb.y + hb.height - 1 do
          mset(x\8,y\8,sprite)
        end
      end
    end
  end
})
