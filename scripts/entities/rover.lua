rover = entity:extend({
  label = "rover",

  solid = true,
  hitbox = {-11,12,-7,0},
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

crashed_rover = rover:extend({
  particle_timer = 30,

  update = function(_ENV)
    rover.update(_ENV)
    particle_timer -= 1
    if particle_timer <= 0 then
      particle:new({
        radius=rnd(2),
        color = {6,5},
        frames = 30 + rnd(30),
        dy = -.25,
        x = x + 4 + rnd(8),
        y = y - 8,
        layer = 2
      })
      particle_timer = 20
    end
  end
})
