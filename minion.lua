minion = entity:new({
  r = 2,
  speed = .25,
  mode = "follow",
  target = player,
  attack_timer = 0,
  attack_speed = 60,

  update = function(_ENV)
    if dist(_ENV,target) > 32 then
      speed = min(.5,speed + .05)
    else
      speed = max(.25,speed - .05)
    end

    if (mode == "attack") then
      _ENV:attack()
      speed = .5
    end

    _ENV:follow()
  end,

  draw = function(_ENV)
    spr(5,x-2,y-2)
  end,

  attack = function(_ENV)
    if attack_timer <= 0 then
      target:hit()
      attack_timer = attack_speed
    else
      attack_timer -= 1
    end

    if target.health <= 0 then
      target = nil
      mode = "follow"
      add(player.minions,_ENV)
    end
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
