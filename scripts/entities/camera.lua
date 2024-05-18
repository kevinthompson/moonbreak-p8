_camera = camera
camera = entity:new({
  x = player.x,
  y = player.y,

  hitbox = { -12, 12, -12, 12 },

  draw = function(_ENV)
    if not _ENV:entity_collide(x,y,player) then
      local a = atan2(player.x - x, player.y - y)
      x = mid(64, x + cos(a) * player.speed, 896)
      y = mid(64, y + sin(a) * player.speed, 384)
    end

    _camera(x - 64, y - 64)
  end
})
