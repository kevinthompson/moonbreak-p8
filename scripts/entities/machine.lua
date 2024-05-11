machine = entity:extend({
  draw = function(_ENV)
    for wx=x+12,x+24 do
      pset(wx,y-4 + sin(wx/8), 1)
    end

    spr(11,x,y-6)
    spr(11,x+8,y-6,1,1,true)
    spr(12,x+24,y-16,2,2)
  end
})
