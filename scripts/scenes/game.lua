game = scene:extend({
  init=function(_ENV)
    reload(0x1000, 0x1000, 0x2000)
    autotile(0,0,128,64,93,tile_rules[1])
    autotile(0,0,128,64,90,tile_rules[2])

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
  end,

  update=function(_ENV)
    for e in all(entity.objects) do
      e:update()
    end

    local ship_instance = ship.objects[1]
    local cursor_instance = cursor.objects[1]

    if ship_instance
    and ship_instance:complete()
    and ccol(ship_instance,player) then
      if (cursor_instance) cursor_instance.enabled = false
      if btnp(5) then
        -- remove player control
        -- play animation
        scene:load(ending)
      end
    else
      if (cursor_instance) cursor_instance.enabled = true
    end
  end,

  draw=function(_ENV)
    cls(13)
    map()

    -- draw shadows
    for e in all(entity.visible) do
      local _ENV = e
      if shadow then
        local tile = mget(x\8,y\8)
        local sy = y

        if (fget(tile,flags.pit)) return
        if (fget(tile,flags.raised)) sy -= 2

        local shadow_scale = 1 / (elevation*.5 + 1)
        local shadow_width = width * shadow_scale
        line(
          x - shadow_width/2 + ox,
          sy + 1 + oy,
          x-1+shadow_width/2 + ox,
          sy + 1 + oy,
          14
        )
      end
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
      printc("press ❎ to leave", 104, 7)
    end
  end
})
