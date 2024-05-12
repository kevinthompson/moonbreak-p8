objective = entity:extend({
  x = 64,
  y = 64,
  bots = {},

  solid = true,
  health = 5,
  energy_count = 5,
  bots_required = 3,

  hitbox = {-4,4,-4,1},

  on_follow_stop = function(_ENV)
    state = "idle"
    for b in all(bots) do
      b.target = player
      b.state = "follow"
    end
    bots = {}
  end,

  update = function(_ENV)
    entity.update(_ENV)
    if health <= 0 then
      _ENV:destroy()
    end
  end,

  draw = function(_ENV)
    spr(19,x - width/2, y - 7 - elevation)
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
  end,

  states = {
    idle = function(_ENV)
      solid = true
      shadow = false
      elevation = 0
    end,

    carry = function(_ENV)
      solid = false

      if (#bots == 0) then
        state = "idle"
        return
      end

      if #bots >= bots_required then
        if not target then
          target = machines[1]
          path = _ENV:find_path(target)
        end

        speed = .25 * #bots / bots_required
        shadow = true
        elevation = 2

        _ENV:follow(target)
      end

      -- position bots
      local astep = 1/#bots
      for i=1,#bots do
        local bot = bots[i]
        local a = i * astep
        bot.x = lerp(bot.x, x + cos(a) * 5, .2)
        bot.y = lerp(bot.y, y + sin(a) * 5, .2)
      end

      -- bots are recalled or reached target
      if (#bots == 0) state = "idle"
    end
  }
})
