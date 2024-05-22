ship = entity:extend({
  solid = true,
  hitbox = {-20,19,-7,1},

  draw = function(_ENV)
    spr(69,x-14,y-6)
    spr(69,x+5,y-6,1,1,true)
    spr(33,x-20,y-17,4,1)
    spr(49,x-20,y-9,5,1)
  end,

  draw_shadow = function(_ENV)
    rectfill(x-12,y,x+11,y+2,14)
  end
})
