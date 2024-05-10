bot = entity:extend({
  width = 5,
  height = 4,

  map_collision = true,
  follow_distance = 8,

  speed = .50,

  state = "follow",

  target_radius = 8,
  attack_timer = 0,
  attack_frames = 45,

  elevation = 4,
  shadow = true,

  init = function(_ENV)
    entity.init(_ENV)
    time_offset = rnd()
  end,

  update = function(_ENV)
    -- hover animiation
    elevation = 2.5 + sin((t() + time_offset) * .5)
    entity.update(_ENV)
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

    sspr(40,0,5,4,x - width/2 + ox, y - height - elevation + oy)
  end,

  throw_at = function(_ENV,t)
    del(player.bots,_ENV)
    state = "throw"
    target = { x=t.x, y=t.y }
    animation_frames = 30
    animation_frame = 0
  end,

  -- states

  states = {
    follow = function(_ENV)
      _ENV:follow(player)
    end,

    aiming = function(_ENV)
      -- move towards player
      elevation = lerp(elevation,2,.1)
      x = lerp(x, player.x - 3, .1)
      y = lerp(y, player.y + 4, .1)
    end,

    throw = function(_ENV)
      -- move towards ground target
      elevation = arc(animation_frames,8,animation_frame)

      local nx = lerp(player.x, target.x, animation_frame / animation_frames)
      local ny = lerp(player.y, target.y, animation_frame / animation_frames)

      _ENV:move(nx,ny)

      animation_frame = min(animation_frame + 1, animation_frames)

      if animation_frame == animation_frames then
        path = astar({ x\8, y\8 }, {8,8})
        state = "targeting"
      end
    end,

    targeting = function(_ENV)
      -- find target
      for e in all(entity.objects) do

        -- TODO: on screen check
        -- TODO: check collision layers
        -- TODO: move to entity class
        if e.type == objective
        and ccol({ x=x, y=y, r=target_radius }, e) then
          target = e
          state = "attack"
        end
      end

      -- carry or attack target
      -- else go idle
    end,

    attack = function(_ENV)
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
