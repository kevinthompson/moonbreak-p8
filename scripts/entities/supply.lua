supply = carryable:extend({
  width = 7,
  height = 8,
  hitbox = {-4,3,-6,1},
  yclip = 0,

  on_follow_stop = function(_ENV)
    carryable.on_follow_stop(_ENV)
    target:collect_supply(_ENV)
  end,

  draw = function(_ENV)
    sspr(24,8,width,height - yclip,x - width/2, y - height + 1 - elevation)
  end,

  find_target = function(_ENV)
    local current_dist = 8129
    local new_target = nil

    for obj in all(collector.objects) do
      local new_dist = dist(_ENV,obj)
      if new_dist < current_dist then
        current_dist = new_dist
        new_target = obj
      end
    end

    log({new_target.x\8, new_target.y\8})

    return new_target
  end
})
