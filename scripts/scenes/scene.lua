scene=gameobject:extend({
  load = function(_ENV,new_scene)
    if current != new_scene then
      if (current) current:destroy()
      current = new_scene
      current:init()
    end
  end,
})
