function autotile(map_x,map_y,map_w,map_h,sprite,rules)
  local tiles={}

  for y=map_y,map_y+map_h-1 do
    for x=map_x,map_x+map_w-1 do
      local new_sprite = mget(x,y)
      if (new_sprite==sprite) then
        local bitmask=0

        bit_mapping={
          {x-1,y-1,0b10000000},
          {x  ,y-1,0b01000000},
          {x+1,y-1,0b00100000},
          {x-1,y  ,0b00010000},
          {x+1,y  ,0b00001000},
          {x-1,y+1,0b00000100},
          {x  ,y+1,0b00000010},
          {x+1,y+1,0b00000001}
        }

        for pos in all(bit_mapping) do
          local px,py,bit=pos[1],pos[2],pos[3]
          if (mget(px,py)==sprite) bitmask=bor(bitmask,bit)
        end

        for rule in all(rules) do
          local rulemask,sprite=rule[1],rule[2]

          if type(sprite)=="table" then
            sprite=sprite[flr(rnd(#sprite))+1]
          end

          if (band(bitmask,rulemask)==rulemask) then
            new_sprite = sprite
          end
        end
      end

      add(tiles, new_sprite)
    end
  end

  for i=0,#tiles-1 do
    local x, y, new_sprite = i % map_w, i \ map_w, tiles[i+1]
    mset(x,y,new_sprite)
  end
end

tile_rules = {
  {
    {0b01000000,109},
    {0b00000010,79},

    {0b00001010,76},
    {0b00010010,78},

    {0b00011010,77},
    {0b01000010,95},

    {0b01010010,94},
    {0b01001010,92},
    {0b01010010,94},

    {0b01101010,95},

    {0b01101011,92},
    {0b01011010,93},

    {0b11111011,92},

    {0b11111110,94},
    {0b11111111,93},
  },{
    {0b01001000,105},
    {0b01010000,107},
    {0b01011000,106},

    {0b00001010,73},
    {0b00010010,75},

    {0b00011010,74},
    {0b01000010,91},

    {0b01010010,91},
    {0b01001010,89},
    {0b01010010,91},

    {0b01101011,89},
    {0b01011010,90},
    {0b11111111,90},
  }
}
