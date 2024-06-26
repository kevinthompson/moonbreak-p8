person = entity:extend({
  label = "person",

  x=64,
  y=64,
  angle = 0,
  width = 4,
  height = 2,
  map_collision = true,
  outside = true,

  speed=0.5,

  -- features
  dust_timer = 0,
  initial_bot_count = 1,
  player_control = false,

  animations = {
    idle = {16},
    walk = {18,17}
  },

  init = function(_ENV)
    entity.init(_ENV)

    if player_control then
      cursor = cursor:new({
        x = x + 24,
        y = y
      })
    end

    for i = 1, initial_bot_count do
      add(bots, bot:new({
        target = _ENV,
        x = x - 16 + rnd(16),
        y = y - 16 + rnd(16)
      }))
    end

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

    if player_control then
      if (btn(0)) dx-=1
      if (btn(1)) dx+=1
      if (btn(2)) dy-=1
      if (btn(3)) dy+=1
    end

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

      cursor.x = cx
      cursor.y = cy
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

    if player_control then
      camera(mid(0, x - 64, 896),mid(0, y - 64, 384))
    end
  end,

  draw=function(_ENV)
    local sprite = sprite or current_animation[frame]
    spr(sprite,x-3,y-7,1,1,flip)
    if (outside) sspr(24,4,4,3,x-1,y - (sprite == 18 and 5 or 6),4,3,flip)
  end,

  animate_walk = function(_ENV)
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
  end,

  states = {
    idle = function(_ENV)
      _ENV:animate("idle")
    end,

    follow = function(_ENV)
      _ENV:follow(target)
      _ENV:animate_walk()
    end,

    walking = function(_ENV)
      _ENV:animate_walk()
    end
  }
})
