minion = entity:new({
  update = function(_ENV)
    local pos = player.positions[#player.positions]
    local px = pos[1]
    local py = pos[2]

    tx = px - 4 --+ cos(a) * 10
    ty = py - 4 --+ sin(a) * 10

    x = lerp(x,tx,.1)
    y = lerp(y,ty,.1)
  end,

  draw = function(_ENV)
    spr(2,x,y)
  end
})
