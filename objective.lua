objective = entity:new({
  x = 64,
  y = 64,
  r = 4,

  name = "target",
  type = "objective",

  health = 5,
  energy_count = 5,
  minions_required = 1,
  flash_timer = 0,

  update = function(_ENV)
    _ENV:destroy()
    flash_timer = max(0,flash_timer - 1)
  end,

  draw = function(_ENV)
    if (flash_timer > 0) pal({7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7})
    circfill(x,y,r,4)
    if (flash_timer > 0) pal()
    prints(minions_required,x-1,y+2,7)
  end,

  hit = function(_ENV)
    sfx(0)
    health -= 1
    flash_timer = 5
  end,

  destroy = function(_ENV)
    if health <= 0 then
      del(objectives,_ENV)
      del(entities,_ENV)

      for i=1,energy_count do
        create_energy(x,y,rnd())
      end
    end
  end
})
