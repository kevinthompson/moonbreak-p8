ending = scene:extend({
  init = function(_ENV)
    cls(1)

    for i = 1,30 do
      pset(rnd(128),rnd(96),rnd({5,6,7}))
    end
  end,

  update = function(_ENV)
    if btnp(5) then
      scene:load(title)
    end
  end,

  draw = function(_ENV)
    camera()
    circfill(64,176,96,13)
    ovalfill(24,22,104,52,1)

    tprint(function()
      printsc("you win!",34,7,8)
    end)

    printc("press ❎ to start over",104,7)
  end
})
