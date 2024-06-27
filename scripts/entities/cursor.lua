cursor = entity:extend({
  label = "cursor",

  x = 66,
  y = 76,
  width = 1,
  height = 1,
  speed = .8,
  recall_radius = 0,
  layer = -1,
  enabled = true,

  update = function(_ENV)
    entity.update(_ENV)

    if (not enabled) return

    if player.player_control then
      _ENV:handle_recall()

      if btnr(5) and btnf(5) < 15 and #player.bots > 0 then
        local bot = player.bots[1]
        bot:throw_at(_ENV)
        async(function()
          player.sprite = 32
          wait(5)
          player.sprite = nil
        end)
      end
    end
  end,

  draw = function(_ENV)
    if (not enabled) return

    pset(x,y,7)
    spr(14,x-3,y-2)

    if recall_radius > 3 then
      local c=6
      local step=3/(2*3.14*recall_radius)
      local to = t() * .05
      for a=0+to,1+to,step do
        pset(x+cos(a)*recall_radius,y+sin(a)*recall_radius * .6,c)
        c=c==6 and 7 or 6
      end
    end
  end,

  handle_recall = function(_ENV)
    if btnf(5) > 15 then
      if (btnf(5) == 20) sfx(3)
      recall_radius = lerp(recall_radius, 16, .1)

      if recall_radius >= 8 then
        for e in all(bot.objects) do
          if e.target != player
          and ccol({x=x,y=y,r=recall_radius},{x=e.x,y=e.y,r=1})
          and count(player.bots,e) <= 0
          then
            e:recall()
          end
        end
      end
    else
      recall_radius = lerp(recall_radius, 0, .25)
    end
  end,
})
