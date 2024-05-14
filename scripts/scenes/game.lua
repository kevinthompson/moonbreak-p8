game = scene:extend({
  init=function(_ENV)
    autotile(0,0,128,64,93,tile_rules)

    time_start = time()
    time_limit = 601

    -- spawn entities tiles
    for mx=0,127 do
      for my=0,63 do
        local tile = mget(mx,my)

        local tiles = {}
        tiles[19] = supply
        tiles[67] = obstacle

        if tiles[tile] then
          tiles[tile]:new({
            x = 4 + mx * 8,
            y = 7 + my * 8
          })

          mset(mx,my,0)
        end
      end
    end

    -- testing bots
    for i=1,1 do
      add(player.bots,bot:new({
        target = player,
        x = player.x - 32 + rnd(16),
        y = player.y - 32 + rnd(16)
      }))
    end

    -- interactive elements
    rover:new({ x = 32, y = 55 })
    g.machines = {
      machine:new({ x = 40, y = 96 })
    }
  end,

  update=function(_ENV)
    for e in all(entity.objects) do
      e:update()
    end

    update_camera()
  end,

  draw=function(_ENV)
    sort(entity.objects, "y")
    sort(entity.objects, "layer")

    cls(13)

    -- draw shadows
    for e in all(entity.objects) do
      e:draw_shadow()
    end

    map()

    -- draw entities
    for e in all(entity.objects) do
      if (e.flash_timer > 0) pal({7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7},0)
      e:draw()
      if (e.flash_timer > 0) pal(0)
    end

    -- _ENV:draw_ui()
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
  end
})

function update_camera()
  cx = mid(0, player.x - 64, 896)
  cy = mid(0, player.y - 71, 384)
  camera(cx,cy)
end
