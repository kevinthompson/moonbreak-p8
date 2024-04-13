player = entity:new({
  x=64,
  y=64,
  speed=.5,
  r=5,
  ar = 10, -- attack radius
  target = nil,

  positions={},

  update=function(_ENV)
    -- record last position
    if #positions == 0 or x != positions[1][1] or y != positions[1][2] then
      add(positions,{x,y},1)
      if (#positions > 20) deli(positions,#positions)
    end

    -- find target
    target = nil
    for objective in all(objectives) do
      if #minions >= objective.minions_required
      and ccol({x=x,y=y,r=ar}, objective) then
        target = objective
      end
    end

    -- handle movement
    local dx=0
    local dy=0

    if (btn(0)) dx-=1
    if (btn(1)) dx+=1
    if (btn(2)) dy-=1
    if (btn(3)) dy+=1

    -- handle calling minions
    if btn(4) then
      for m in all(minions) do
        if m.mode == "attack" then
          m.mode = "follow"
          m.target = nil
          break
        end
      end
    end

    -- handle attack
    if btnp(5) then
      for m in all(minions) do
        if m.mode == "follow" then
          m.mode = "attack"
          m.target = target
          break
        end
      end
    end


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