player = entity:new({
  x=64,
  y=64,
  speed=0.5,
  r=4,
  ar = 16, -- action radius
  target = nil,
  bots = {},
  energy = 0,
  flip = false,

  update=function(_ENV)
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

    -- normalize movement speed
    if dx!=0 or dy != 0 then
      local angle = atan2(dx,dy)
      nx+=cos(angle) * speed
      ny+=sin(angle) * speed
    end

    x = mid(2,nx,894)
    y = mid(2,ny,382)

    -- find target
    _ENV:find_target()
  end,

  draw=function(_ENV)
    spr(16,x-3,y-3,1,2,flip)

    -- draw target indicator
    if target then
      sspr(24,0,3,3,target.x - 1,target.y - target.r - 4)
    end
  end,

  find_target=function(_ENV)
    target = nil

    for t in all(targets) do
      if (abs(t.y - y) < ar and abs(t.x - x) < ar)
      and ccol({x=x,y=y,r=ar},t) then
        target = t
      end
    end
  end
})
