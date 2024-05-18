_camera = camera
camera = entity:new({
  layer = -10,

  draw = function(_ENV)
    x = mid(64, player.x, 896)
    y = mid(64, player.y, 384)

    _camera(x - 64, y - 64)
  end
})
