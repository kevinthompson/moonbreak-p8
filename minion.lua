minion = entity:new({
  r = 3,
  speed = .25,
  mode = "follow",
  target = player,

  update = function(_ENV)
    if dist(_ENV,target) > 32 then
      speed = .35
    else
      speed = .25
    end

    if (mode == "attack") then
      _ENV:attack()
      speed = .5
    end

    _ENV:follow()
  end,

  draw = function(_ENV)
    spr(2,x-4,y-4)
  end,

  attack = function(_ENV)
    -- jump at target
    -- hit target
    -- bounce back to previous position
  end,

  follow = function(_ENV)
    local px = target.x
    local py = target.y

    local ox = x
    local oy = y

    local a = atan2(px-x,py-y)
    x = x + cos(a) * speed
    y = y + sin(a) * speed

    if ccol(target,_ENV) then
      x = ox
      y = oy
    end

    for m in all(global_minions) do
      if m != _ENV and ccol(_ENV, m) then
        local a = atan2(m.x - x,m.y - y)
        x = x + cos(a+.5)
        y = y + sin(a+.5)
      end
    end
  end
})
