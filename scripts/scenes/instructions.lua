instructions = scene:extend({
  update = function(_ENV)
    if btnf(5) > 60 then
      scene:load(game)
    end
  end,

  draw = function(_ENV)
    cls(1)
    printc("instructions",32,7)
  end
})
