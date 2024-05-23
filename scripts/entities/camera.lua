_camera = camera
camera = entity:new({
  layer = -10,
  x = 64,
  y = 64,

  reset = function(_ENV)
    x = 64
    y = 64
  end,

  draw = function(_ENV)
    _camera(x - 64, y - 64)
  end
})
