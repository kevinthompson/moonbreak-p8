player = entity:extend({
  x=64,
  y=64,
  speed=0.5,
  r=4,
  ar = 16, -- action radius
  target = nil,
  bots = {},
  energy = 0,
  flip = false,
  state = "walking",

  update=function(_ENV)
    if btn(4) then
      state = "aiming"
    else
      state = "walking"
      target = nil
    end

    if state == "walking" then
      _ENV:handle_walk()
    elseif state == "aiming" then
      _ENV:handle_aiming()
    end
  end,

  draw=function(_ENV)
    spr(16,x-3,y-3,1,2,flip)

    if state == "aiming" then
      -- draw arc to target position

      -- draw impact point
      circfill(target.x,target.y,1,7)
    end
  end,

  handle_aiming = function(_ENV)
    -- proposed input
    -- hold Z, left/right to adjust angle, up/down to adjust distance, X to throw

    if not target then
      target = {
        ang = ang,
        dist = 16
      }
    end

    -- adjust angle of throw
    if (btn(0)) target.ang = (target.ang + .01) % 1
    if (btn(1)) target.ang = (target.ang - .01) % 1

    -- adjust distance of throw
    if (btn(2)) target.dist = mid(8,target.dist + 0.5,24)
    if (btn(3)) target.dist = mid(8,target.dist - 0.5,24)

    -- set target position
    target.x = x + cos(target.ang) * target.dist
    target.y = y + sin(target.ang) * target.dist

    -- detect throw input
    if btnp(5)
    and #bots > 0 then
      local bot = bots[1]

      bot.state = "throw"
      bot.target = {
        x = target.x,
        y = target.y
      }
    end
  end,

  handle_walk = function(_ENV)
    local nx = x
    local ny = y

    -- handle movement
    local dx=0
    local dy=0

    if (btn(0)) dx-=1
    if (btn(1)) dx+=1
    if (btn(2)) dy-=1
    if (btn(3)) dy+=1

    if (dx < 0) flip = true
    if (dx > 0) flip = false

    -- normalize movement speed
    if dx!=0 or dy != 0 then
      local angle = atan2(dx,dy)
      nx+=cos(angle) * speed
      ny+=sin(angle) * speed
      ang = atan2(dx,dy)
    end

    x = mid(2,nx,894)
    y = mid(2,ny,382)

  end
})

--[[
  -- prototype input logic

  -- handle calling bots
  if btnp(4) then
    for m in all(global_bots) do
      if m.mode == "attack" then
        m.mode = "follow"
        m.target = nil
        add(bots,m)
        break
      end
    end
  end

  -- handle attack
  if target and btnp(5) then
    if target.type == "objective" then
      for m in all(bots) do
        if m.mode == "follow" then
          m.mode = "attack"
          m.target = target
          m.attack_timer = m.attack_speed
          del(bots,m)
          break
        end
      end
    elseif target.type == "terminal" and energy > 0 then
      energy -= 5
      create_bot()
    end
  end
]]
