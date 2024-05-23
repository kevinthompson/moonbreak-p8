game = scene:extend({
  init=function(_ENV)
    reset_palette()
    autotile(0,0,128,64,93,tile_rules[1])
    autotile(0,0,128,64,90,tile_rules[2])

    time_start = time()
    time_limit = 601

    local object_tiles = {
      [19] = supply,
      [67] = obstacle,
      [37] = cockpit,
      [54] = life_support,
      [55] = booster,
      [16] = person,
      [112] = pod_with_door,
      [115] = pod,
      [114] = collector,
      [116] = ship
    }

    local decor_tiles = {
      [0]  = {64},
      [93] = {110},
    }

    -- spawn entities tiles
    for mx=0,127 do
      for my=0,63 do
        local tile = mget(mx,my)
        local tile_class = object_tiles[tile]

        if tile_class then
          mset(mx,my,0)

          local obj = tile_class:new({
            x = 4 + mx * 8,
            y = 7 + my * 8
          })

          if tile == 16 then
            _g.player = obj
          end
        end
      end
    end

    for mx=0,127 do
      for my=0,63 do
        local tile = mget(mx,my)
        local tile_set = decor_tiles[tile]

        if tile_set and rnd() > .98 then
          mset(mx,my,rnd(tile_set))
        end
      end
    end

    -- testing bots
    for i=1,1 do
      add(player.bots,bot:new({
        target = player,
        x = player.x - 16 + rnd(16),
        y = player.y - 16 + rnd(16)
      }))
    end
  end,

  update=function(_ENV)
    sort(entity.objects, "sort_value")
    for e in all(entity.objects) do
      e:update()
    end

    -- update camera position
    camera.x = mid(64, player.x, 896)
    camera.y = mid(64, player.y, 384)
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
