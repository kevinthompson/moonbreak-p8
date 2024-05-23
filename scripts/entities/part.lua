part = carryable:extend({
  hitbox = {-4,3,-6,1},
  bots_required = 1,
  carry_speed = .5,

  on_follow_stop = function(_ENV)
    carryable.on_follow_stop(_ENV)
    target_ship:add_part(_ENV)
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
})

life_support = part:extend({
  target_key = "life_support",
  sprite = 54,
})

booster = part:extend({
  target_key = "booster",
  sprite = 55,
})
