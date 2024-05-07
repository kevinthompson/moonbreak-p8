pod = entity:extend({
  door = false,

  draw = function(_ENV)
    spr(69,x-12,y-8)
    spr(69,x+5,y-8,1,1,true)
    circfill(x,y-13,12,7)

    if door then
      spr(22,x-4,y-7)
      spr(38,x-4,y+1)
    end
  end
})
