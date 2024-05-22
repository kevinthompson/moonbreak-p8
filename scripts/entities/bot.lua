bot = entity:extend({
  width = 5,
  height = 4,

  follow_distance = 12,
  map_collide = false,

  speed = .40,
  state = "follow",

  target_radius = 12,
  attack_timer = 0,
  attack_frames = 45,

  elevation = 4,
  shadow = true,
  ox = 0,
  oy = 0,

  alert = 0,

  init = function(_ENV)
    entity.init(_ENV)
    time_offset = rnd()
    hover_distance = rnd(3)
    hover_direction = rnd({-1,1})
    hover_speed = .3 + rnd() * .2
    follow_distance = 6 + rnd(3)
  end,

  draw = function(_ENV)
    local alert_height = alert / 100 * 3
    local bx = x - width/2 + ox
    local by = y - height - elevation + oy
    sspr(40,0,5,4,bx, by, 5,4,rnd() > 0.5)
    sspr(47,0,1,3,bx + 2,by - 1 - alert_height,1,alert_height)

    local c = state == "idle" and 6 or 9
    pset(bx + 2, by + 2,c)
  end,

  throw_at = function(_ENV, t)
    if (target) del(target.bots,_ENV)
    start_pos = { x = x, y = y }
    state = "throw"
    target = { x=t.x, y=t.y }
    animation_frames = 30
    animation_frame = 0
    sfx(2)
    ox = 0
    oy = 0
  end,

  attack = function(_ENV, new_target)
    target = new_target
    state = "attack"
    attack_timer = attack_frames

    del(player.bots, _ENV)
    add(target.bots, _ENV)
  end,

  carry = function(_ENV, new_target)
    target = new_target
    target.state = "carry"
    state = "carry"

    del(player.bots, _ENV)
    add(target.bots, _ENV)
  end,

  hover = function(_ENV)
    local period = (t() + time_offset) * hover_speed
    elevation = 2.5 + sin(period)
    ox = lerp(ox, cos(period * hover_direction) * hover_distance, .1)
    oy = lerp(oy, sin(period * hover_direction) * hover_distance, .1)
  end,

  recall = function(_ENV)
    sfx(1)
    if (target) del(target.bots, _ENV)
    add(player.bots, _ENV)
    state = "follow"
    target = player

    async:call(function()
      for i = 1,9 do
        alert = i/9 * 100
        yield()
      end
      wait(60)
      for i = 9,0,-1 do
        alert = i/9 * 100
        yield()
      end
    end)
  end,

  -- states

  states = {
    idle = function(_ENV)
      _ENV:hover()
    end,

    follow = function(_ENV)
      if (dist(_ENV, player) > 64) then
        del(player.bots, _ENV)
        target = nil
        state = "idle"
        return
      end

      _ENV:follow(player)
      _ENV:hover()
    end,

    throw = function(_ENV)
      -- move towards ground target
      elevation = 2.5 + arc(animation_frames,8,animation_frame)

      local nx = lerp(start_pos.x, target.x, animation_frame / animation_frames)
      local ny = lerp(start_pos.y, target.y, animation_frame / animation_frames)

      _ENV:move(nx,ny)

      animation_frame = min(animation_frame + 1, animation_frames)

      if animation_frame == animation_frames then
        state = "targeting"
      end
    end,

    targeting = function(_ENV)
      target = nil
      local new_target = nil
      local new_target_dist = target_radius + 1

      -- find target
      for e in all(entity.objects) do
        if count({supply, obstacle, enemy}, e.class) > 0
        and (e.max_bots == 0 or #e.bots < e.max_bots)
        and ccol({ x=x, y=y, r=target_radius }, e)
        then
          local entity_dist = dist(_ENV, e)
          if entity_dist < new_target_dist then
            new_target_dist = entity_dist
            new_target = e
          end
        end
      end

      if (new_target) then
        if new_target.class == supply then
          _ENV:carry(new_target)
        elseif new_target.class == obstacle then
          _ENV:attack(new_target)
        end
      end

      if not target then
        state = "idle"
      end
    end,

    carry = function(_ENV)
      _ENV:follow(target)
    end,

    attack = function(_ENV)
      if not target or target.health <= 0 then
        add(player.bots, _ENV)
        target = player
        state = "follow"
        return
      end

      _ENV:follow(target)

      attack_timer -= 1

      if attack_timer == attack_frames \ 2 then
        target:hit()
      end

      if attack_timer <= 0 then
        attack_timer = attack_frames
      end

      local angle = atan2(target.x - x, target.y - y)
      local distance = dist(_ENV, target)
      local percent = sin(.5 + (attack_timer / attack_frames) * .5)
      elevation = 4 - percent * 4

      ox = cos(angle) * distance * percent
      oy = sin(angle) * distance * percent
    end
  }
})
