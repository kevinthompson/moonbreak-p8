ending = scene:extend({
  init = function(_ENV)
    music(-1, 10000)

    for i = 1,30 do
      star:new({
        x = rnd(128),
        y = rnd(78),
        c = rnd({5,6,7})
      })
    end

    ship_x = 84
    ship_y = 72
  end,

  update = function(_ENV)
    if btnp(5) then
      scene:load(title)
    end
  end,

  draw = function(_ENV)
    cls(1)
    circfill(64,176,96,13)

    for e in all(entity.visible) do
      e:draw()
    end

    ovalfill(24,22,104,52,1)

    tprint(function()
      printsc("you escaped!",34,7,8)
    end)

    ship_x = lerp(ship_x, 256, .005)
    ship_y = lerp(ship_y, 32, .005)
    spr(116, ship_x, ship_y)

    printc("press    to start over",112,7)
    prints("❎", 44, 112, 9, 5)
  end
})
