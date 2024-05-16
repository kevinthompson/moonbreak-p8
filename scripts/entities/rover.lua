rover = entity:extend({
  solid = true,
  hitbox = {-11,12,-12,0},
  width = 24,
  height = 16, -- offsets: left, right, up, down from origin

  draw = function(_ENV)
    spr(8,x-12,y-15)
    spr(24,x-12,y-7)
    spr(9,x-4,y-15)
    spr(25,x-4,y-7)
    spr(8,x+4,y-15,1,1,true)
    spr(24,x+4,y-7,1,1,true)
  end
})
