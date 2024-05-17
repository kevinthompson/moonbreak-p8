obstacle = entity:extend({
  sprite = 67,
  health = 5,
  solid = true,
  hitbox = {-4,3,-7,1},

  hit = function(_ENV)
    sfx(0)
    health -= 1
    flash_timer = 5
  end,

  update = function(_ENV)
    entity.update(_ENV)

    if health <= 0 then
      _ENV:destroy()
    end
  end,

  draw = function(_ENV)
    spr(sprite, x - 4, y - 7)
  end
})
