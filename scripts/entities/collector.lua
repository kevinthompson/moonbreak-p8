collector = entity:extend({
  layer = 0,

  init = function(_ENV)
    entity.init(_ENV)
    spawner_instance = spawner:new({
      x = x + 24,
      y = y + 4
    })
  end,

  draw = function(_ENV)
    for wx=x+4,spawner_instance.x do
      pset(wx,y+1 + sin(wx/8), 1)
    end
    spr(11,x-8,y-1)
    spr(11,x,y-1,1,1,true)
  end,

  collect_supply = function(_ENV, supply_instance)
    -- TODO collect animation
    supply_instance:destroy()
    spawner_instance:spawn_bot()
  end
})
