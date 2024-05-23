if (debug) enable_debug()

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
