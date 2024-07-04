tiles = {
  player = 16,
  ship = 116,
  collector = 114
}

generator = scene:extend({
  init=function(_ENV)
    -- set all tiles solid
    for y=0,63 do
      for x=0,127 do
        mset(x,y,93)
      end
    end

    generate_start_area()

    map_string = "map_data=\""

    local tile = nil
    local prev_tile = nil
    local tile_count = 0

    for y=0,63 do
      for x=0,127 do
        prev_tile = tile
        tile = mget(x,y)

        local diff_tile = prev_tile != tile
        local last_tile = x == 127 and y == 63

        if tile == 0 then
          log({prev_tile, tile, tile_count})
        end

        if prev_tile and (diff_tile or last_tile) then
          map_string = map_string .. tile_count .. "," .. prev_tile .. ","
          tile_count = 1
        else
          tile_count += 1
        end
      end
    end

    map_string = map_string .. "\""
    printh(map_string, "map.lua", true)
  end,

  update=function(_ENV)
    if (btn(0)) camerax -= 1
    if (btn(1)) camerax += 1
    if (btn(2)) cameray -= 1
    if (btn(3)) cameray += 1

    camera(camerax,cameray)
  end,

  draw=function(_ENV)
    cls(13)
    map()

    local mapx=camerax\8
    local mapy=cameray\8

    prints(mapx..","..mapy,camerax+4,cameray+4,7)
  end
})

function generate_start_area()
  -- 32 x 16
  local roomw = 32
  local roomh = 16
  local roomx = 48
  local roomy = 24

  camerax=roomx*8
  cameray=roomy*8

  -- create empty space
  for y = roomy, roomy + roomh - 1 do
    for x = roomx, roomx + roomw - 1 do
      mset(x,y,0)
    end
  end

  -- add player to map
  mset(
    roomx + 1 + rnd(7),
    roomy + 1 + rnd(7),
    tiles.player
  )

  -- add ship to map
  mset(
    roomx + 8 + rnd(7),
    roomy + 4 + rnd(7),
    tiles.ship
  )

  -- add collector to map
  mset(
    roomx + 8 + rnd(7),
    roomy + 8 + rnd(7),
    tiles.collector
  )

  -- add supplies to map
  local scount = 0
  while scount < 3 do
    local sx=roomx+rnd(roomw)
    local sy=roomy+rnd(roomh)

    if mget(sx,sy) == 0 then
      mset(sx,sy,19)
      scount += 1
    end
  end
end
