title = scene:extend({
  init = function(_ENV)
    reset_palette()
  end,

  update = function(_ENV)
    if btnp(5) then
      scene:load(game)
    end
  end,

  draw = function(_ENV)
    cls(1)
    tprint(function()
      printc("moonbreak",32,7,6)
    end)

    printc("press ❎ to start",96,6)
  end
})
