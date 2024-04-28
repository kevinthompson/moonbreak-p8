person = entity:extend({
  x=64,
  y=64,
  width = 4,

  speed=0.5,
  r=4,
  ar = 16, -- action radius
  target = nil,
  bots = {},
  energy = 0,
  state = "idle",
  ang = 0,
  dust_timer = 0,

  animations = {
    idle = {16},
    walk = {18,17}
  },

  init = function(_ENV)
    entity.init(_ENV)
    _ENV:animate("idle")
  end,

  draw=function(_ENV)
    spr(current_animation[frame],x-3,y-7,1,2,flip)

    if state == "aiming" and target then
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

  states = {
    idle = function(_ENV)
      _ENV:animate("idle")

      if btn(4) then
        state = "aiming"
      elseif btn(5) then
      elseif btn() > 0 then
        state = "walking"
      end
    end,

    aiming = function(_ENV)
      -- input
      -- hold Z, left/right to adjust angle, up/down to adjust distance, X to throw
      current_bot = bots[1]
      _ENV:animate("idle")

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

      if not btn(4) then
        state = "idle"
      end
    end,

    walking = function(_ENV)
      _ENV:animate("walk")

      -- clear aiming state
      target = nil

      if current_bot then
        current_bot.state = "follow"
        current_bot.target = _ENV
      end

      -- position
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
      else
        state = "idle"
      end

      dust_timer -= 1
      if dust_timer <= 0 then
        particle:new({
          x = x-2 + rnd(4),
          y = y-1 + rnd(2),
          color = rnd({6,7}),
          radius = rnd(1.5),
          dy = -.1
        })
        dust_timer = 4+rnd(8)
      end

      x = mid(2,nx,894)
      y = mid(2,ny,382)

      if btn(4) then
        state = "aiming"
      elseif btn(5) then
      elseif btn() == 0 then
        state = "idle"
      end
    end
  }
})
