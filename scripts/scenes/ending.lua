ending = scene:extend({
  init = function(_ENV)
    camera:reset()
  end,

  draw = function(_ENV)
    cls(1)

    tprint(function()
      printsc("you win!",34,7,8)
    end)
  end
})
