game = scene:extend({
  init=function(_ENV)
    reload(0x1000, 0x1000, 0x2000)
    autotile(0,0,128,64,93,tile_rules[1])
    autotile(0,0,128,64,90,tile_rules[2])
    music(0, 1000)

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
      [116] = ship,
      [117] = rover,
      [118] = crashed_rover,
      [26] = eggplant,
      [113] = building,
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

          local attrs = {
            x = 4 + mx * 8,
            y = 7 + my * 8
          }

          if tile_class == person then
            attrs.player_control = true
          end

          local obj = tile_class:new(attrs)

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
  end,

  update=function(_ENV)
    local ship_instance = ship.objects[1]
    local cursor_instance = cursor.objects[1]

    if ship_instance
    and ship_instance:complete()
    and ccol(ship_instance,player) then
      if (cursor_instance) cursor_instance.enabled = false
      if player.player_control and btnf(5) > 60 then
        player.player_control = false
        player.state = "follow"
        player.target = ship_instance
        player.on_follow_stop = function()
          player.state = "idle"
          transition:fade_out(function()
            _g.load("ending.p8")
          end)
        end
      end
    elseif player.player_control then
      if (cursor_instance) cursor_instance.enabled = true
    end
  end,

  draw=function(_ENV)
    cls(13)
    map()

    -- draw shadows
    for e in all(entity.visible) do
      e:draw_shadow()
    end

    -- draw entities
    for e in all(entity.visible) do
      if (e.flash_timer > 0) pal({7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7},0)
      e:draw()
      if (e.flash_timer > 0) pal(0)
    end

    local ship_instance = ship.objects[1]
    if ship_instance
    and ship_instance:complete()
    and ccol(ship_instance,player) then
      local bx = peek2(0x5f28) + 32
      local by = peek2(0x5f2a) + 104
      circfill(bx, by+2, 4, 1)
      rectfill(bx, by - 2, bx + 64, by + 6, 1)
      circfill(bx + 66, by + 2, 4, 1)
      printc("hold ❎ to leave", 104, 7)

      if btnf(5) > 0 then
        line(bx,by+7,bx+64 * btnf(5)/60,by+7,9)
      end
    end
  end
})
