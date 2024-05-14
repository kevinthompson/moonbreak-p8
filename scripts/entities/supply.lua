supply = entity:extend({
  width = 7,
  height = 7,

  solid = true,
  shadow = true,
  bots_required = 1,
  hitbox = {-3,3,-5,1},

  on_follow_stop = function(_ENV)
    state = "idle"
    for b in all(bots) do
      b.target = player
      b.state = "follow"
      add(player.bots, b)
    end
    bots = {}
    target:collect_supply(_ENV)
  end,

  update = function(_ENV)
    entity.update(_ENV)
  end,

  draw = function(_ENV)
    spr(19,x - width/2, y - 6 - elevation)
  end,

  states = {
    idle = function(_ENV)
      solid = true
      elevation = lerp(elevation, 0, .8)
    end,

    carry = function(_ENV)
      if (#bots == 0) then
        state = "idle"
        return
      end

      if #bots >= bots_required then
        solid = false

        if not target then
          target = collectors[1]
          path = _ENV:find_path(target)
        end

        speed = .25 * #bots / bots_required
        shadow = true
        elevation = lerp(elevation, 2, .8)

        _ENV:follow(target)
      else
        solid = true
      end

      -- position bots
      local astep = 1/#bots
      for i=1,#bots do
        local starta = #bots == 2 and 0 or .25
        local bot = bots[i]
        local a = starta + i * astep
        bot.x = lerp(bot.x, x + cos(a) * 5, .2)
        bot.y = lerp(bot.y, y + sin(a) * 5, .2)
      end
    end
  }
})
