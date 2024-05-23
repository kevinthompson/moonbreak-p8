ship = entity:extend({
  solid = true,
  hitbox = {-12,12,-7,1},
  parts = {},
  has_cockpit = false,
  has_booster = false,

  init = function(_ENV)
    entity.init(_ENV)
    parts = {}
    part_positions = {
      cockpit = {
        x = x + 16,
        y = y - 2
      },
      life_support = {
        x = x,
        y = y - 2
      },
      booster = {
        x = x - 16,
        y = y - 2
      },
    }
  end,

  draw = function(_ENV)
    spr(69,x-14,y-6)
    spr(69,x+5,y-6,1,1,true)
    spr(33,x-20,y-17,4,1)
    if (not has_booster) spr(49,x-20,y-9)
    spr(50,x-12,y-9,3,1)
    if (not has_cockpit) spr(53,x+12,y-9)
  end,

  draw_shadow = function(_ENV)
    rectfill(x-12,y,x+11,y+2,14)
  end,

  add_part = function(_ENV,part)
    if count(parts,part) == 0 then
      _ENV:set_map_tiles(0)
      add(parts,part)

      for p in all(parts) do
        if p.class == cockpit then
          has_cockpit = true
          hitbox[2] = 19
        end

        if p.class == booster then
          hitbox[1] = -20
          has_booster = true
        end
      end

      _ENV:set_map_tiles(1)
    end
  end
})
