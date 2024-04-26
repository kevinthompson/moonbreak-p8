function _init()
  log("Initializing...", true)
  scene:load(game)
end

function _update60()
  async:update()
  scene.current:update()
end

function _draw()
  scene.current:draw()
end
