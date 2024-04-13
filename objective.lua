objective = entity:new({
  x = 64,
  y = 64,
  r = 4,

  name = "target",

  health = 4,
  energy_count = 5,
  minions_required = 1,

  update = function(_ENV)
    _ENV:destroy()
  end,

  draw = function(_ENV)
    circfill(x,y,r,4)
  end,

  destroy = function(_ENV)
    if health <= 0 then
      del(objectives,_ENV)
      del(entities,_ENV)

      for i=1,energy_count do
        add(entities, energy:new({
          x=x,
          y=y,
          a=rnd()
        }))
      end
    end
  end
})
