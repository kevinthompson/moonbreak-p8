carryable = entity:extend({
  bots_required = 1,
  can_carry = true,
  find_target = _noop,
  carry_speed = .1,
  shadow = true,

  on_follow_stop = function(_ENV)
    state = "idle"
    for b in all(bots) do
      b.target = player
      b.state = "follow"
      add(player.bots, b)
    end
    bots = {}
  end,

  states = {
    idle = function(_ENV)
      path = {}
      elevation = lerp(elevation, 0, .8)
    end,

    carry = function(_ENV)
      if (#bots == 0) then
        state = "idle"
        return
      end

      if #bots >= bots_required then
        if not target then
          target = _ENV:find_target()
          path = _ENV:find_path(target)
        end

        speed = carry_speed * #bots / bots_required
        elevation = lerp(elevation, 2, .8)

        _ENV:follow(target)
      end

      -- position bots
      local astep = 1/#bots
      for i=1,#bots do
        local starta = #bots == 2 and 0 or .25
        local bot = bots[i]
        local a = starta + i * astep
        bot.x = lerp(bot.x, x + cos(a) * 5, .1)
        bot.y = lerp(bot.y, y + sin(a) * 5, .1)
        bot.elevation = lerp(bot.elevation, 5, .1)
      end
    end
  }
})
