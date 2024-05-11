machine = entity:extend({
  draw = function(_ENV)
    for wx=x+4,x+20 do
      pset(wx,y+1 + sin(wx/8), 1)
    end

    spr(11,x-8,y-1)
    spr(11,x,y-1,1,1,true)
    spr(12,x+16,y-11,2,2)
  end
})
