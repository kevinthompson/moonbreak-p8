player = entity:new({
  x=64,
  y=64,
  speed=.5,
  r=5,
  ar = 16, -- attack radius
  target = nil,
  minions = {},
  energy = 0,

  update=function(_ENV)
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
      for m in all(global_minions) do
        if m.mode == "attack" then
          m.mode = "follow"
          m.target = nil
          add(minions,m)
          break
        end
      end
    end

    -- handle attack
    if target and btnp(5) then
      for m in all(minions) do
        if m.mode == "follow" then
          m.mode = "attack"
          m.target = target
          del(minions,m)
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

    if target then
      spr(3,target.x-3,target.y - target.r - 7)
    end
  end
})
