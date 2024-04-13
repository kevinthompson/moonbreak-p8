player = entity:new({
  x=64,
  y=64,
  speed=.5,
  r=5,
  ar = 16, -- attack radius
  target = nil,
  minions = {},
  energy = 0,
  attack_timer = 0,
  attack_time_limit = 60,

  update=function(_ENV)
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
    if target and btn(5) then
      if attack_timer <= 0 then
        attack_timer = attack_time_limit
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
          altar.energy += 1
        end
      else
        attack_timer -= 1
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
