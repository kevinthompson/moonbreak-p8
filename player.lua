player = entity:new({
  x=64,
  y=64,
  speed=.5,

  positions={},

  update=function(_ENV)
    if #positions == 0 or x != positions[1][1] or y != positions[1][2] then
      add(positions,{x,y},1)
      if (#positions > 20) deli(positions,#positions)
    end

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
