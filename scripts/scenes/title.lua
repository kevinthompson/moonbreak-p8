title = scene:extend({
  init = function(_ENV)
    for i = 1, 30 do
      star:new({
        x = rnd(128),
        y = rnd(78),
        c = rnd({ 5, 6, 7 })
      })
    end

    pod_with_door:new({
      x = 32,
      y = 96
    })

    supply:new({ x = 92, y = 94 })
    supply:new({ x = 87, y = 87 })
    supply:new({ x = 82, y = 92 })

    _g.player = person:new({
      x = 64,
      y = 84,
      player_control = false
    })
  end,

  update = function(_ENV)
    if btnp(5) then
      _g.load("intro.p8")
    end
  end,

  draw = function(_ENV)
    cls(1)
    circfill(64, 176, 96, 13)

    for e in all(entity.visible) do
      e:draw()
    end

    ovalfill(24, 22, 104, 52, 1)

    tprint(function()
      printsc("moonbreak", 24, 7, 8)
    end)

    printc("-JAM EDITION-", 36, 6)
    printc("press    to play", 112, 7)
    prints("❎", 56, 112, 9, 5)
  end
})
