bot = entity:new({
  r = 3,
  speed = .25,
  mode = "follow",
  target = player,
  attack_timer = 0,
  attack_speed = 60,
  flip = false,
  ox = 0,
  oy = 0,

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
    spr(5,x-2,y-2,1,1,flip)
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
      add(player.bots,_ENV)
    end
  end,

  follow = function(_ENV)
    local px = x
    local py = y

    local a = atan2(target.x-x,target.y-y)
    local dx = cos(a) * speed
    local dy = sin(a) * speed

    if (dx < 0) flip = true
    if (dx > 0) flip = false

    x = x + dx
    y = y + dy

    if ccol(target,_ENV) then
      x = px
      y = py
    end
  end
})
