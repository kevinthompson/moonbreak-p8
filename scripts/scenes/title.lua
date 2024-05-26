title = scene:extend({
  init = function(_ENV)
    cls(1)
    music(0,1000)

    for e in all(entity.objects) do
      e:destroy()
    end

    for i = 1,30 do
      pset(rnd(128),rnd(96),rnd({5,6,7}))
    end
  end,

  update = function(_ENV)
    if btnp(5) then
      scene:load(instructions)
    end
  end,

  draw = function(_ENV)
    circfill(64,176,96,13)
    ovalfill(24,22,104,52,1)

    tprint(function()
      printsc("moonbreak",34,7,8)
    end)

    printc("-JAM EDITION-",46,6)
    printc("press ❎ to start",104,7)
  end
})
