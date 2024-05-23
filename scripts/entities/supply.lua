supply = carryable:extend({
  width = 7,
  height = 8,
  hitbox = {-4,3,-6,1},
  yclip = 0,
  max_bots = 6,

  on_follow_stop = function(_ENV)
    carryable.on_follow_stop(_ENV)
    target:collect_supply(_ENV)
  end,

  draw = function(_ENV)
    sspr(24,8,width,height - yclip,x - width/2, y - height + 1 - elevation + yclip)
  end,

  find_target = function(_ENV)
    -- TODO find closest collector
    return collector.objects[1]
  end
})
