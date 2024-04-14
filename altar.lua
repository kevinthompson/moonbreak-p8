altar = entity:new({
  r = 4,
  type = "altar",
  energy = 0,
  sounds = {2,3,4,5,6},

  update = function(_ENV)
    if energy >= 5 then
      create_minion()
      energy -= 5
    end
  end,

  draw = function(_ENV)
    spr(6,x-3,y-3)

    if energy > 0 then
      rect(x-4,y+6,x+4,y+8,7)
      line(x-3,y+7,x-3+(energy/5)*6,y+7,12)
    end
  end,

  add_energy = function(_ENV, amt)
    energy += amt
    sfx(sounds[ceil((energy/5)*5)])
  end
})
