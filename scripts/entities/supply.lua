supply = carryable:extend({
  label = "supply",
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
    if yclip > 0 then
      local lx = x - width/2
      local ly = y - yclip + 1
      line(lx, ly, lx + width - 1, ly, 7)
    end
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

    return new_target
  end
})
