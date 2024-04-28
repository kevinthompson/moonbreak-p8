particle = entity:extend({
  frames = 30,
  opacity = 1,
  radius = 1,
  color = 7,
  shadow = false,
  dx = 0,
  dy = 0,

  update = function(_ENV)
    frames -= 1
    if (frames <= 0) _ENV:destroy()
    x += dx
    y += dy
  end,

  draw = function(_ENV)
    -- TODO: figure out why color is referencing global
    circfill(x,y,radius,_ENV.color)
  end
})
