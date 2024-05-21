game = scene:extend({
  init=function(_ENV)
    reset_palette()
    autotile(0,0,128,64,93,tile_rules[1])
    autotile(0,0,128,64,90,tile_rules[2])

    time_start = time()
    time_limit = 601

    -- spawn entities tiles
    for mx=0,127 do
      for my=0,63 do
        local tile = mget(mx,my)

        local tiles = {}
        tiles[19] = supply
        tiles[67] = obstacle
        tiles[6] = part

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
    rover:new({ x = 28, y = 55 })
    g.collectors = {
      collector:new({ x = 40, y = 96 })
    }
  end,

  update=function(_ENV)
    sort(entity.objects, "sort_value")
    for e in all(entity.objects) do
      e:update()
    end
  end,

  draw=function(_ENV)
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
  end
})
