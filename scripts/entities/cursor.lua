cursor = entity:new({
  x = 66,
  y = 76,
  map_collision = true,
  speed = 0.75,
  recall_radius = 0,

  update = function(_ENV)
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
      nx += cos(angle) * speed
      ny += sin(angle) * speed
    end

    _ENV:move(nx,ny)
    _ENV:handle_recall()
  end,

  draw = function(_ENV)
    circ(x,y,1,7)
    circ(x,y,3,9)

    if recall_radius > 3 then
      c=6
      step=3/(2*3.14*recall_radius)
      for a=0+t()*.02,1+t()*.02,step do
        pset(x+cos(a)*recall_radius,y+sin(a)*recall_radius,c)
        c=c==6 and 7 or 6
      end
    end

    if btn(5) then
      -- draw arc to target position
      local d = dist(_ENV, player)
      local a = atan2(player.x - x, player.y - y)
      local px = cos(a)
      local py = sin(a)

      pset(x,y,1)

      for step=4,d-1,2 do
        local h = point(d,8,step)
        pset(x+px*step,y-h+py*step,step%4==0 and 7 or 6)
      end
    end
  end,

  handle_recall = function(_ENV)
    if btn(4) then
      recall_radius = lerp(recall_radius, 16, .1)

      -- TODO: Iterate over only on-screen bots that are not in the player collection
      for e in all(entity.objects) do
        if e.type == bot
        and ccol({x=x,y=y,r=recall_radius},{x=e.x,y=e.y,r=1})
        and count(player.bots,e) <= 0
        then
          add(player.bots,e)
          e.state = "follow"
          e.target = player
        end
      end
    else
      recall_radius = lerp(recall_radius, 0, .25)
    end
  end,
})
