instructions = scene:extend({
  init = function(_ENV)
    scene.init(_ENV)
    controls_enabled = false
    async:call(function()
      wait(60)
      controls_enabled = true
    end)
  end,

  update = function(_ENV)
    if controls_enabled and btnp(5) then
      scene:load(game)
    end
  end,

  draw = function(_ENV)
    cls(1)
    printc("instructions",12,7)
    line(32,20,96,20,5)


    ? "\f7- \f6use arrow keys to walk", 16, 28
    ? "  and aim", 16, 34

    ? "\f7- \f6tap ❎ to throw bots", 16, 44
    ? "  at supplies an obstacles", 16, 50

    ? "\f7- \f6recall your bots", 16, 60
    ? "  by holding \f7❎", 16, 66

    ? "\f7- \f6collecting supplies", 16, 76
    ? "  creates more bots", 16, 82

    ? "\f7- \f6use bots to collect", 16, 92
    ? "  ship parts and leave", 16, 98

    if controls_enabled then
      printc("     \f7press \f9❎ \f7to start",112)
    end
  end
})
