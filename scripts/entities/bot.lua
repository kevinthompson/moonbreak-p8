bot = entity:extend({
  width = 5,
  height = 4,

  r = 3,
  speed = .25,
  state = "follow",
  target = player,
  attack_timer = 0,
  attack_speed = 60,
  elevation = 4,
  ox = 0,
  oy = 0,

  update = function(_ENV)
    states[state](_ENV)
  end,

  draw = function(_ENV)
    sspr(40,0,5,4,x - width/2, y - height - elevation)
  end,

  throw_at = function(_ENV,t)
    state = "throw"
    target = t
    animation_frames = 30
    animation_frame = 0
  end,

  -- private

  states = {
    follow = function(_ENV)
      if dist(_ENV,target) > 32 then
        speed = min(.5,speed + .05)
      else
        speed = max(.25,speed - .05)
      end

      local px = x
      local py = y

      local a = atan2(target.x-x,target.y-y)
      local dx = cos(a) * speed
      local dy = sin(a) * speed

      if (dx < 0) flip = true
      if (dx > 0) flip = false

      x = x + dx
      y = y + dy

      if ccol(target,_ENV) then
        x = px
        y = py
      end
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
    end,

    aiming = function(_ENV)
      -- move towards player
      x = lerp(x, player.x, .1)
      y = lerp(y, player.y, .1)
    end,

    throw = function(_ENV)
      -- move towards ground target
      elevation = point(animation_frames,8,animation_frame)

      x = lerp(player.x, target.x, animation_frame / animation_frames)
      y = lerp(player.y, target.y, animation_frame / animation_frames)
      animation_frame = min(animation_frame + 1, animation_frames)
      -- find target
      -- attack target or return to player
    end
  }
})
