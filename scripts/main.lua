function _init()
  log("Initializing...", true)
  scene:load(splash)
end

function _update60()
  scene.current:update()
end

function _draw()
  scene.current:draw()
end
