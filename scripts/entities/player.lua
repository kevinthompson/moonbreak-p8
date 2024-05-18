player = entity:new({
  x=64,
  y=64,
  width = 4,
  height = 2,
  follow_distance = 24,
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
    _ENV:animate("idle")
  end,

  update = function(_ENV)
    entity.update(_ENV)

    if _ENV:follow(cursor) then
      state = "walking"
    else
      state = "idle"
    end
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
