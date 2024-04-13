minion = entity:new({
  r = 3,

  mode = "follow",
  target = nil,

  update = function(_ENV)
    if (mode == "follow") _ENV:follow()
    if (mode == "attack") _ENV:attack()
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
    local pos = player.positions[#player.positions]
    local px = pos[1]
    local py = pos[2]

    tx = px --+ cos(a) * 10
    ty = py --+ sin(a) * 10

    local ox = x
    local oy = y

    x = lerp(x,tx,.1)
    y = lerp(y,ty,.1)

    if ccol(player,_ENV) then
      x = ox
      y = oy
    end
  end
})
