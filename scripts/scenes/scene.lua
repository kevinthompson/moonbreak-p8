scene=gameobject:extend({
  load = function(_ENV,scene_class)
    if (current) current:destroy()
    current = scene_class:new()
    if (scene_class != splash) reset_palette()
  end,
})
