collector = entity:extend({
  hitbox = {-8, 7, 0, 5},

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
    async:call(function()
      local collect_frames = 120

      for i = 1, collect_frames do
        local percent = i/collect_frames
        supply_instance.yclip = supply_instance.height * percent

        particle:new({
          x = x - 4 + rnd(8),
          y = y - 1 + rnd(3),
          dy = rnd(.5) * -1,
          frames = 6 + rnd(4),
          radius = 0,
          color = {7,6,5}
        })

        yield()
      end

      supply_instance:destroy()
      spawner_instance:spawn_bot()
    end)
  end
})
