bot = entity:extend({
  width = 5,
  height = 4,

  map_collision = true,
  follow_distance = 8,

  speed = .25,

  state = "follow",
  attack_timer = 0,
  attack_speed = 60,
  elevation = 4,
  ox = 0,
  oy = 0,

  shadow = true,

  init = function(_ENV)
    entity.init(_ENV)
    target_offset = { x = rnd(8), y = rnd(8) }
    time_offset = rnd()
  end,

  update = function(_ENV)
    -- hover animiation
    elevation = 2.5 + sin((t() + time_offset) * .5)
    entity.update(_ENV)
  end,

  draw = function(_ENV)
    sspr(40,0,5,4,x - width/2, y - height - elevation)
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
      elevation = point(animation_frames,8,animation_frame)

      local nx = lerp(player.x, target.x, animation_frame / animation_frames)
      local ny = lerp(player.y, target.y, animation_frame / animation_frames)

      _ENV:move(nx,ny)

      animation_frame = min(animation_frame + 1, animation_frames)

      if animation_frame == animation_frames then
        state = "idle"
      end
      -- find target
      -- attack target or return to player
    end,

    attack = function(_ENV)
      if attack_timer <= 0 then
        target:hit()
        attack_timer = attack_speed
      else
        attack_timer -= 1
      end

      if target.health <= 0 then
        target = nil
        state = "follow"
        add(player.bots,_ENV)
      end
    end
  }
})
