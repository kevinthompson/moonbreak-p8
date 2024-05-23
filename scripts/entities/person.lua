person = entity:extend({
  x=64,
  y=64,
  angle = 0,
  width = 4,
  height = 2,
  map_collision = true,
  entity_collision = true,
  outside = true,

  speed=0.5,

  -- features
  dust_timer = 0,

  animations = {
    idle = {16},
    walk = {18,17}
  },

  init = function(_ENV)
    entity.init(_ENV)
    cursor.x = x + 24
    cursor.y = y
    _ENV:animate("idle")
  end,

  update = function(_ENV)
    entity.update(_ENV)

    -- position
    local nx = x
    local ny = y

    -- handle movement
    local dx=0
    local dy=0

    if (btn(0)) dx-=1
    if (btn(1)) dx+=1
    if (btn(2)) dy-=1
    if (btn(3)) dy+=1

    if (dx < 0) flip = true
    if (dx > 0) flip = false

    -- normalize movement speed
    if dx!=0 or dy != 0 then
      angle = atan2(dx,dy)
      nx += cos(angle) * speed
      ny += sin(angle) * speed

      local cdist = mid(0, dist(cursor, _ENV), 24)
      local mult = 1 + ((24 - cdist) / 24 * 1.5)
      local cx = cursor.x + dx * mult
      local cy = cursor.y + dy * mult

      if dist({ x = cx, y = cy }, _ENV) >= 24 then
        cx = lerp(cursor.x, x + cos(angle) * 24, .05)
        cy = lerp(cursor.y, y + sin(angle) * 24, .05)
      end

      cursor:move(cx, cy)
    end

    if _ENV:move(nx,ny) then
      if state == "idle" then
        state = "walking"
        sfx(4,3)
      end
    else
      if state == "walking" then
        state = "idle"
        sfx(-1,3)
      end
    end

    camera(mid(64, x - 64, 896),mid(64, y - 64, 384))
  end,

  draw=function(_ENV)
    local sprite = sprite or current_animation[frame]
    spr(sprite,x-3,y-7,1,1,flip)
    if (outside) sspr(24,4,4,3,x-1,y - (sprite == 18 and 5 or 6),4,3,flip)
  end,

  states = {
    idle = function(_ENV)
      _ENV:animate("idle")
    end,

    walking = function(_ENV)
      _ENV:animate("walk")

      dust_timer -= 1
      if dust_timer <= 0 then
        particle:new({
          x = x-2 + rnd(4),
          y = y-1 + rnd(2),
          color = rnd({6,7}),
          radius = rnd(1.5),
          dy = -.1
        })
        dust_timer = 4+rnd(8)
      end
    end
  }
})
