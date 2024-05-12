player = entity:new({
  x=64,
  y=64,
  width = 4,
  height = 2,
  follow_distance = 24,
  map_collision = true,

  speed=0.5,
  bots = {},
  energy = 0,

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
    spr(current_animation[frame],x-3,y-7,1,2,flip)
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
