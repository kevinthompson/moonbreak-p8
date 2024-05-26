collector = entity:extend({
  label = "collector",
  layer = -1,
  width = 16,
  height = 8,

  init = function(_ENV)
    entity.init(_ENV)
    spawner_instance = spawner:new({
      x = x + 20,
      y = y
    })

    y = y - 4
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
      local collect_frames = 30

      for i = 1, collect_frames do
        local percent = i/collect_frames
        supply_instance.yclip = supply_instance.height * percent

        if i % 2 == 0 then
          particle:new({
            x = x - 3 + rnd(6),
            y = y - 4 + rnd(3),
            dy = .3 + rnd(.2),
            frames = 3 + rnd(4),
            radius = 0,
            color = {9,7},
            layer = 2
          })
        end

        yield()
      end

      supply_instance:destroy()
      spawner_instance:spawn_bot()
    end)
  end
})
