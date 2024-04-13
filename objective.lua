objective = entity:new({
  x = 64,
  y = 64,
  r = 4,

  name = "target",

  health = 4,
  minions_required = 1,

  update = function()

  end,

  draw = function(_ENV)
    circfill(x,y,r,4)
  end
})
