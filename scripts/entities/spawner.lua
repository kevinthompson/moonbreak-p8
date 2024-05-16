spawner = entity:extend({
  open_percent = 0,
  solid = true,
  hitbox = {-8,7,-12,0},

  update = function(_ENV)
    entity.update(_ENV)
  end,

  draw = function(_ENV)
    spr(12,x-8,y-15,2,2)
    if (open_percent == 50) sspr(112,8,8,2,x-3,y-14)
    if (open_percent == 100) sspr(112,10,8,2,x-3,y-14)
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
