particle = entity:extend({
  frames = 30,
  opacity = 1,
  radius = 1,
  color = 7,
  shadow = false,
  layer = -2,
  dx = 0,
  dy = 0,

  init = function(_ENV)
    entity.init(_ENV)
    max_frames = frames
  end,

  update = function(_ENV)
    frames -= 1
    if (frames <= 0) _ENV:destroy()
    x += dx
    y += dy
  end,

  draw = function(_ENV)
    -- TODO: figure out why color is referencing global
    local c = _ENV.color

    if type(c) == "table" then
      local frames_per_color = max_frames / #c
      local remaining_frames = max_frames - frames
      local i = 1 + remaining_frames \ frames_per_color
      c = c[i]
    end

    circfill(x,y,radius,c)
  end
})
