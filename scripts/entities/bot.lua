bot = entity:extend({
  width = 5,
  height = 4,

  follow_distance = 12,

  speed = .40,
  state = "follow",

  target_radius = 12,
  attack_timer = 0,
  attack_frames = 45,

  elevation = 4,
  shadow = true,
  ox = 0,
  oy = 0,

  init = function(_ENV)
    entity.init(_ENV)
    time_offset = rnd()
    hover_distance = rnd(3)
    hover_direction = rnd({-1,1})
    hover_speed = .3 + rnd() * .2
    follow_distance = 6 + rnd(3)
  end,

  draw = function(_ENV)
    if state == "attack" then
      local angle = atan2(target.x - x, target.y - y)
      local distance = dist(_ENV, target)
      local percent = sin(.5 + (attack_timer / attack_frames) * .5)
      elevation = 4 - percent * 4

      ox = cos(angle) * distance * percent
      oy = sin(angle) * distance * percent
    end

    sspr(40,0,5,4,x - width/2 + ox, y - height - elevation + oy, 5,4,rnd() > 0.5)
  end,

  throw_at = function(_ENV, t)
    del(player.bots,_ENV)
    state = "throw"
    target = { x=t.x, y=t.y }
    animation_frames = 30
    animation_frame = 0
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
    ox = cos(period * hover_direction) * hover_distance
    oy = sin(period * hover_direction) * hover_distance
  end,

  -- states

  states = {
    idle = function(_ENV)
      _ENV:hover()
    end,

    follow = function(_ENV)
      _ENV:follow(player)
      _ENV:hover()
    end,

    aiming = function(_ENV)
      -- move towards player
      elevation = lerp(elevation,2,.1)
      x = lerp(x, player.x - 3, .1)
      y = lerp(y, player.y + 4, .1)
    end,

    throw = function(_ENV)
      ox = 0
      oy = 0

      -- move towards ground target
      elevation = 2.5 + arc(animation_frames,8,animation_frame)

      local nx = lerp(player.x, target.x, animation_frame / animation_frames)
      local ny = lerp(player.y, target.y, animation_frame / animation_frames)

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

        -- TODO: on screen check
        -- TODO: check collision layers
        -- TODO: move to entity class
        if e.type == objective
        and ccol({ x=x, y=y, r=target_radius }, e)
        then
          local entity_dist = dist(_ENV, e)
          if entity_dist < new_target_dist then
            new_target_dist = entity_dist
            new_target = e
          end
        end
      end

      if (new_target) _ENV:carry(new_target)

      if not target then
        state = "idle"
      end
    end,

    carry = function(_ENV, new_target)
      _ENV:follow(target)
    end,

    attack = function(_ENV, target)
      _ENV:follow(target)

      attack_timer -= 1

      if attack_timer == attack_frames \ 2 then
        target:hit()
      end

      if attack_timer <= 0 then
        attack_timer = attack_frames
      end

      if target.health <= 0 then
        target = nil
        state = "idle"
      end
    end
  }
})
