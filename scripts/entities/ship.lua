ship = entity:extend({
  solid = true,
  hitbox = {-12,12,-7,1},
  parts = {},

  init = function(_ENV)
    entity.init(_ENV)
    parts = {}
  end,

  draw = function(_ENV)
    spr(69,x-14,y-6)
    spr(69,x+5,y-6,1,1,true)
    spr(33,x-20,y-17,4,1)
    spr(49,x-20,y-9,5,1)
  end,

  draw_shadow = function(_ENV)
    rectfill(x-12,y,x+11,y+2,14)
  end,

  add_part = function(_ENV,part)
    if count(parts,part) == 0 then
      _ENV:set_map_tiles(0)
      add(parts,part)

      if count(parts,cockpit) > 0 then
        hitbox[2] = 19
      end

      if count(parts,booster) > 0 then
        hitbox[1] = -20
      end
      _ENV:set_map_tiles(1)
    end
  end
})
