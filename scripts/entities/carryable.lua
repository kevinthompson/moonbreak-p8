carryable = targetable:extend({
  label = "carryable",
  bots_required = 1,
  use_pathfinding = true,
  find_target = _noop,
  carry_speed = .1,
  shadow = true,
  default_elevation = 0,

  on_follow_stop = function(_ENV)
    state = "idle"
    active = false
    for b in all(bots) do
      b:set_target(player)
    end
  end,

  states = {
    idle = function(_ENV)
      path = {}
      elevation = lerp(elevation, default_elevation, .8)
    end,

    carry = function(_ENV)
      if (#bots == 0) then
        state = "idle"
        return
      end

      if #bots >= bots_required then
        if not target then
          target = _ENV:find_target()
          if target then
            path = _ENV:find_path(target)
          else
            state = "idle"
          end
        end

        speed = carry_speed * #bots / bots_required
        elevation = lerp(elevation, 2, .8)

        if target then
          _ENV:follow(target)
        end
      end

      -- position bots
      local astep = 1/#bots
      for i=1,#bots do
        local starta = #bots == 2 and 0 or .25
        local bot = bots[i]
        local a = starta + i * astep
        bot.x = lerp(bot.x, x + cos(a) * 5, .4)
        bot.y = lerp(bot.y, y + sin(a) * 5, .4)
        bot.elevation = lerp(bot.elevation, 5, .1)
      end
    end
  }
})
