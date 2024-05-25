part = carryable:extend({
  hitbox = {-4,3,-6,1},
  bots_required = 1,
  carry_speed = .025,

  on_follow_stop = function(_ENV)
    carryable.on_follow_stop(_ENV)
    target_ship:add_part(_ENV)
    layer = 2
    sfx(6)
  end,

  draw = function(_ENV)
    spr(sprite,x-4,y-7)
  end,

  find_target = function(_ENV)
    target_ship = ship.objects[1]
    return target_ship.part_positions[target_key]
  end
})

cockpit = part:extend({
  target_key = "cockpit",
  sprite = 37,

  on_follow_stop = function(_ENV)
    part.on_follow_stop(_ENV)
    default_elevation = 3
    oy = 3
  end
})

life_support = part:extend({
  target_key = "life_support",
  sprite = 54,
  height = 6,

  draw = function(_ENV)
    spr(54,x-4,y-6-elevation)
  end,
})

booster = part:extend({
  target_key = "booster",
  sprite = 55,

  on_follow_stop = function(_ENV)
    part.on_follow_stop(_ENV)
    default_elevation = 3
    oy = 3
  end
})

eggplant = part:extend({
  target_key = "eggplant",
  sprite = 26,
  width = 5,
  ox = 2
})
