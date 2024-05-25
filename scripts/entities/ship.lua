ship = entity:extend({
  parts = {},
  has_cockpit = false,
  has_booster = false,
  has_life_support = false,
  r = 24,

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
        y = y - 3
      },
      booster = {
        x = x - 16,
        y = y - 2
      },
      eggplant = {
        x = x,
        y = y - 12
      },
    }
  end,

  draw = function(_ENV)
    spr(69,x-14,y-6)
    spr(69,x+5,y-6,1,1,true)
    spr(33,x-20,y-17,4,1)

    if has_booster then
      rectfill(x-14,y-9,x-12,y-2,7)
    else
      spr(49,x-20,y-9)
    end

    spr(50,x-12,y-9,3,1)

    if (not has_cockpit) spr(53,x+12,y-9)
  end,

  draw_shadow = function(_ENV)
    rectfill(x-12,y,x+11,y+2,14)
  end,

  add_part = function(_ENV,part)
    if count(parts,part) == 0 then
      add(parts,part)

      for p in all(parts) do
        if p.class == cockpit then
          has_cockpit = true
        end

        if p.class == booster then
          has_booster = true
        end

        if p.class == life_support then
          has_life_support = true
        end
      end
    end
  end,

  complete = function(_ENV)
    return has_booster and has_cockpit and has_life_support
  end
})
