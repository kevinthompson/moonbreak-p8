altar = entity:new({
  r = 8,
  type = "altar",
  energy = 0,

  update = function(_ENV)
    if energy >= 5 then
      create_minion()
      energy = energy - 5
    end
  end,

  draw = function(_ENV)
    rectfill(x-4,y-4,x+4,y+4,5)
  end
})
