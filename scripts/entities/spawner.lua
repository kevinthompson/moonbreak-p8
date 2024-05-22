spawner = entity:extend({
  open_percent = 0,
  solid = true,
  hitbox = {-8,7,-12,0},

  update = function(_ENV)
    entity.update(_ENV)
    if btnp(4) then
      _ENV:spawn_bot()
    end
  end,

  draw = function(_ENV)
    spr(69,x-9,y-7)
    spr(69,x+2,y-7,1,1,true)
    circfill(x,y-8,7,7)

    sspr(112,8,8,2,x-3,y-14)
    if (open_percent == 50) sspr(112,10,8,2,x-3,y-14)
    if (open_percent == 100) sspr(112,12,8,2,x-3,y-14)

    spr(10,x-2,y-8)
  end,

  spawn_bot = function(_ENV)
    async:call(function()
      open_percent = 50
      wait(6)
      open_percent = 100

      for i = 1,2 do
        local new_bot = bot:new({
          x = x + 1,
          y = y - 12
        })

        new_bot:throw_at({
          x = x + 12 * rnd({-1,1}),
          y = y - 16 + rnd(32)
        })
      end

      wait(30)

      open_percent = 50
      wait(6)
      open_percent = 0
    end)
  end
})
