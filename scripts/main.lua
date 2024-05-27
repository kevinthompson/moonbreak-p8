if (debug) enable_debug()

function _init()
  log("initializing...", true)
  scene:load(splash)
end

function _update60()
  -- clear visible entities
  entity.visible = {}

  -- build table of visible entities
  for e in all(entity.objects) do
    local sprite = { x = e.x - e.width / 2, y = e.y - e.height + 1, width = e.width, height = e.height }
    local view = { x = peek2(0x5f28), y = peek2(0x5f2a), width = 128, height = 128 }
    if (aabb(sprite, view)) add(entity.visible, e)
    e:update()
  end

  -- sort visible entities
  sort(entity.visible, "sort")

  async:update()
  scene.current:update()
  apply_button_extensions()
end

function _draw()
  scene.current:draw()
end
