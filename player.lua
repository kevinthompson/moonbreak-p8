player = entity:new({
  x=64,
  y=64,
  speed=.5,

  update=function(_ENV)
    local dx=0
    local dy=0

    if (btn(0)) dx-=1
    if (btn(1)) dx+=1
    if (btn(2)) dy-=1
    if (btn(3)) dy+=1

    -- normalize movement speed
    if dx!=0 or dy != 0 then
      local angle = atan2(dx,dy)
      x+=cos(angle) * speed
      y+=sin(angle) * speed
    end
  end,

  draw=function(_ENV)
    circfill(x,y,3,3)
  end
})
