person = entity:extend({
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

  animations = {
    idle = {16},
    walk = {18,17}
  },

  update=function(_ENV)
    current_bot = bots[1]

    if btn(4) then
      state = "aiming"
    else
      state = "walking"
      target = nil

      if current_bot then
        current_bot.state = "follow"
        current_bot.target = _ENV
      end
    end

    if state == "walking" then
      _ENV:handle_walk()
    elseif state == "aiming" then
      _ENV:animate("idle")
      _ENV:handle_aiming()
    end
  end,

  draw=function(_ENV)
    spr(current_animation[frame],x-3,y-3,1,2,flip)

    if state == "aiming" then
      -- draw arc to target position
      local px = cos(target.ang)
      local py = sin(target.ang)

      pset(target.x,target.y,1)

      for d=4,target.dist-1,2 do
        local h = point(target.dist,8,d)
        pset(x+px*d,y-h+py*d,d%4==0 and 7 or 6)
      end
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
    if (btn(2)) target.dist = mid(8,target.dist + 0.5,32)
    if (btn(3)) target.dist = mid(8,target.dist - 0.5,32)

    -- set target position
    target.x = x + cos(target.ang) * target.dist
    target.y = y + sin(target.ang) * target.dist

    -- detect throw input
    if current_bot then
      if current_bot.state != "throw" then
        current_bot.state = "aiming"
      end

      if btnp(5) then
        current_bot:throw_at(target)
        del(bots,current_bot)
      end
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
      _ENV:animate("walk")
    else
      _ENV:animate("idle")
    end

    x = mid(2,nx,894)
    y = mid(2,ny,382)
  end
})
