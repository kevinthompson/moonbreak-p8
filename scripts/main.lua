if (debug) enable_debug()

cam_x = 0
cam_y = 0

function _init()
  log("initializing...", true)
  scene:load(game)
end

function _update60()
  async:update()
  scene.current:update()
  handle_input()
end

function _draw()
  scene.current:draw()
end
