pod = entity:extend({
  door = false,
  solid = true,
  hitbox = {-12,12,-15,1},
  width = 24,
  height = 24,

  draw = function(_ENV)
    spr(69,x-12,y-7)
    spr(69,x+5,y-7,1,1,true)
    circfill(x,y-12,12,7)

    if door then
      spr(22,x-4,y-6)
      spr(38,x-4,y)
    end
  end
})
