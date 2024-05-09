objective = entity:extend({
  x = 64,
  y = 64,
  r = 4,

  health = 5,
  energy_count = 5,
  bots_required = 1,
  flash_timer = 0,

  update = function(_ENV)
    _ENV:destroy()
    flash_timer = max(0,flash_timer - 1)
  end,

  draw = function(_ENV)
    if (flash_timer > 0) pal({7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7},0)
    spr(19,x - w/2, y - w/2)
    if (flash_timer > 0) pal(0)
  end,

  hit = function(_ENV)
    sfx(0)
    health -= 1
    flash_timer = 5
  end,

  destroy = function(_ENV)
    if health <= 0 then
      entity.destroy(_ENV)

      for i=1, energy_count do
        energy:new({
          x = x,
          y = y,
          a = rnd()
        })
      end
    end
  end
})
