energy = entity:new({
  speed = .8,
  r=3,
  a=0,

  update = function(_ENV)
    speed += .2

    local tx = cx + 108
    local ty = cy + 4
    local ta = atan2(tx-x,ty-y)

    a += ta > a and .05 or -.05
    x += cos(a) * speed
    y += sin(a) * speed

    if ccol(_ENV,{x=tx,y=ty,r=5}) then
      del(entities,_ENV)
      sfx(1)
      player.energy += 1
    end
  end,

  draw = function(_ENV)
    sspr(29,0,3,3,x,y)
  end
})
