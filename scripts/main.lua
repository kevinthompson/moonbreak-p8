function _init()
  scene:load(game)
end

function _update60()
  async:update()
  scene.current:update()
  pbtn=btn()
end

function _draw()
  scene.current:draw()
end
