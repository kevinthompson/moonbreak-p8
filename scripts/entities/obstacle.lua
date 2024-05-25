obstacle = entity:extend({
  sprite = 67,
  health = 5,
  solid = true,
  hitbox = {-4,3,-7,1},
  can_attack = true,

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


    if #bots > 0 then
      -- position bots
      local astep = 1/#bots
      for i=1,#bots do
        local starta = -.05
        local bot = bots[i]
        local a = starta + i * astep * -.4
        bot.x = lerp(bot.x, x + cos(a) * 5, .1)
        bot.y = lerp(bot.y, y + sin(a) * 5, .1)
        bot.elevation = lerp(bot.elevation, 5, .1)
      end
    end
  end,

  destroy = function(_ENV)
    entity.destroy(_ENV)

    for b in all(bots) do
      b:set_target(player)
    end
  end
})
