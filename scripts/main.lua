if (debug) enable_debug()

function _init()
  log("initializing...", true)
  scene:load(game)
end

function _update60()
  -- set visible
  entity.visible = {}

  for e in all(entity.objects) do
    local sprite = { x = e.x - e.width / 2, y = e.y - e.height + 1, width = e.width, height = e.height }
    local view = { x = peek2(0x5f28), y = peek2(0x5f2a), width = 128, height = 128 }
    if (aabb(sprite, view)) add(entity.visible, e)
  end

  -- sort visible entities
  sort(entity.visible, "sort")

  async:update()
  scene.current:update()
  handle_input()
end

function _draw()
  scene.current:draw()
end
