minion = entity:new({
  r = 3,

  update = function(_ENV)
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
  end,

  draw = function(_ENV)
    spr(2,x-4,y-4)
  end
})
