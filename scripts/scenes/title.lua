title = scene:extend({
  init = function(_ENV)
    reset_palette()
    cls(1)

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
      printc("moonbreak",34,0,8)
      printc("moonbreak",32,7,8)
    end)

    printc("-JAM EDITION-",46,6)
    printc("press ❎ to start",104,7)
  end
})
