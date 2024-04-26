player = entity:extend({
  x=64,
  y=64,
  speed=0.5,
  r=4,
  ar = 16, -- action radius
  target = nil,
  bots = {},
  energy = 0,
  state = "walking",
  ang = 0,

  update=function(_ENV)
    bot = bots[1]

    if bot and btn(4) then
      state = "aiming"
    else
      state = "walking"
      target = nil
      bot.state = "follow"
      bot.target = _ENV
    end

    if state == "walking" then
      _ENV:handle_walk()
    elseif state == "aiming" then
      _ENV:handle_aiming()
    end
  end,

  draw=function(_ENV)
    if state == "aiming" then
      -- draw arc to target position
      local px = cos(target.ang)
      local py = sin(target.ang)

      for d=0,target.dist,2 do
        local h = point(target.dist,8,d)
        pset(x+px*d,y-h+py*d,d%4==0 and 7 or 6)
      end
    end

    spr(16,x-3,y-3,1,2,flip)
  end,

  handle_aiming = function(_ENV)
    -- proposed input
    -- hold Z, left/right to adjust angle, up/down to adjust distance, X to throw

    if bot.state != "throw" then
      bot.state = "aiming"
    end

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
    if (btn(2)) target.dist = mid(8,target.dist + 0.5,32)
    if (btn(3)) target.dist = mid(8,target.dist - 0.5,32)

    -- set target position
    target.x = x + cos(target.ang) * target.dist
    target.y = y + sin(target.ang) * target.dist

    -- detect throw input
    if btnp(5) then
      bot:throw_at(target)
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
