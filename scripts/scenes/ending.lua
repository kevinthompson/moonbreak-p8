ending = scene:extend({
  init = function(_ENV)
    camera()
    async:call(function(_ENV)
      -- ending animation
    end)
  end,

  update = function(_ENV)
    if btnp(5) then
      scene:load(title)
    end
  end,

  draw = function(_ENV)
    cls(1)

    tprint(function()
      printsc("you win!",34,7,8)
    end)

    printc("press ❎ to start over",96,7)
  end
})
