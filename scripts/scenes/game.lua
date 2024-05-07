game = scene:extend({
  init=function(_ENV)
    -- time_limit = 601
    -- time_start = time()

    g.player = person:new()

    -- foreground tiles
    foreground = {}
    for mx=0,128 do
      for my=0,64 do
        local tile = mget(mx,my)
        if fget(tile,flags.foreground) then
          add(foreground,{tile,mx*8,my*8})
        end
      end
    end

    add(player.bots,bot:new({
      speed = 2,
      target = player,
      x = player.x - 32 + rnd(16),
      y = player.y - 32 + rnd(16)
    }))
  end,

  update=function(_ENV)
    for e in all(entity.objects) do
      e:update()
    end

    update_camera()
  end,

  draw=function(_ENV)
    sort(entity.objects)
    cls(13)
    map()

    -- draw shadows
    for e in all(entity.objects) do
      e:draw_shadow()
    end

    -- draw entities
    for e in all(entity.objects) do
      e:draw()
    end

    for t in all(foreground) do
      spr(t[1],t[2],t[3])
    end

    --_ENV:draw_ui()
  end,

  draw_ui = function(_ENV)
    -- draw ui background
    rectfill(cx,cy,cx+128,cy+10,0)
    rectfill(cx+45,cy,cx+80,cy+13,0)

    -- print time
    local time_left = (time_limit - time() - time_start) \ 1
    local m = pad(time_left \ 60,2,"0")
    local s = pad(time_left % 60,2,"0")

    poke(0x5f58,0x81)
    printc(m .. ":" .. s,4,7,6)
    poke(0x5f58,0x80)

    -- show bot count
    local mcy=2
    spr(2,cx+4,cy+mcy)
    spr(0,cx+12,cy+mcy+1)
    print(#player.bots,cx+20,cy+mcy+2,7)

    -- show energy count
    spr(4,cx+104,cy+mcy+1)
    spr(0,cx+112,cy+mcy+1)
    print(player.energy,cx+120,cy+mcy+2,7)
  end
})

function update_camera()
  cx = mid(0, player.x - 64, 896)
  cy = mid(0, player.y - 71, 384)
  camera(cx,cy)
end
