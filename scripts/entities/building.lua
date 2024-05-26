building = entity:extend({
  label = "building",

  solid = true,
  hitbox = {-12,20,-7,1},

  init = function(_ENV)
    entity.init(_ENV)
    rust = {}

    for i = 1,rnd(3) do
      add(rust, {
        s = rnd({{96,16},{100,16},{96,20},{100,20}}),
        x = x - 11 + rnd(26),
        y = y - 14,
        flipx = rnd() > 0.5
      })
    end
  end,

  draw = function(_ENV)
    spr(69,x-21,y-5)
    spr(69,x+5,y-5,1,1,true)
    spr(40,x-20,y-16,4,2)
    spr(38,x-4,y+1)

    for r in all(rust) do
      sspr(r.s[1],r.s[2],4,4,r.x,r.y,4,4,r.flipx,r.flipy)
    end
  end,

  draw_shadow = function(_ENV)
    rectfill(x-19,y,x+10,y+2,14)
  end,
})
