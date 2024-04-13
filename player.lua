player = entity:new({
  x=64,
  y=64,
  speed=.5,
  r=4,
  ar = 16, -- attack radius
  target = nil,
  minions = {},
  energy = 0,
  flip = false,

  update=function(_ENV)
    local nx = x
    local ny = y

    -- find target
    target = nil

    for altar in all(altars) do
      if ccol({x=x,y=y,r=ar}, altar) then
        target = altar
      end
    end

    if target == nil then
      for objective in all(objectives) do
        if #minions >= objective.minions_required
        and ccol({x=x,y=y,r=ar}, objective) then
          target = objective
        end
      end
    end

    -- handle movement
    local dx=0
    local dy=0

    if (btn(0)) dx-=1
    if (btn(1)) dx+=1
    if (btn(2)) dy-=1
    if (btn(3)) dy+=1

    if (dx < 0) flip = true
    if (dx > 0) flip = false

    -- handle calling minions
    if btnp(4) then
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
      if target.type == "objective" then
        for m in all(minions) do
          if m.mode == "follow" then
            m.mode = "attack"
            m.target = target
            m.attack_timer = m.attack_speed
            del(minions,m)
            break
          end
        end
      elseif target.type == "altar" and energy > 0 then
        energy -= 1
        target:add_energy(1)
      end
    end

    -- normalize movement speed
    if dx!=0 or dy != 0 then
      local angle = atan2(dx,dy)
      nx+=cos(angle) * speed
      ny+=sin(angle) * speed
    end

    x = nx
    y = ny
  end,

  draw=function(_ENV)
    spr(1,x-3,y-3,1,1,flip)

    -- draw target indicator
    if target then
      sspr(24,0,3,3,target.x - 1,target.y - target.r - 4)
    end
  end
})
