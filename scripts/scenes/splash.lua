splash = scene:extend({
  init = function(_ENV)
    -- setup camera and background
    if (peek(0x5f2c)==3) camera(31,28)
    pal(split("129,128,131,132,134,6,7,139,9,135,3,12,137,143,15,0"),1)
    cls(9)

    -- call name drawing function
    async:call(function()
      local weight = 1
      local points = split("49,66;45,74;41,80,1;44,77;53,71,1;44,77;50,75;51,75,0;52,76,1;55,76;56,74;55,76;59,76,0;60,75;61,74,1;62,76,0;64,76,0;65,74,1;65,76;68,75;72,74;73,76;79,76,0;82,75;84,73",";")
      local current = split(points[1])

      -- draw avatar
      local avatar="994429999999999994222229449999999222222422229999992244222222299992242222422229999222222422229999992222222224299999fffffff2422999942fff42ff2229992fffffff2f2299999f0fff0fff2ff9999f0fef0fff5ee9999fffefffff5ef9999ffeefff555f9999955f5f5555599999955555f555bbb999995fee555e3bbb9999955555ef13bbb999931eeeff13bbb9999bbfffffbbbb3999933bbfbbbb3399988bb37b7b33bbb98bbbb7737bbbbbbbbbbbb6bb6bbbbbbb"
      for i = 1, #avatar do
        pset(57+(i-1)%16,36+(i-1)\16, tonum(avatar[i],0x1))
      end

      -- draw by line
      line(51,60,77,60,10)
      ? "made",52,62,7
      ? "by",70,62,7
      line(51,68,77,68,10)

      wait(30)

      -- play jingle
      sfx(63)

      for pi = 2, #points do
        local	point = split(points[pi])
        local steps = 45

        for i=1,steps do
          local x = lerp(current[1], point[1], i/steps)
          local y = lerp(current[2], point[2], i/steps)
          weight = current[3] or weight
          rectfill(x, y, x + weight, y + weight, 7)

          if (i%20==0) yield()
        end

        current = point
      end

      wait(30)

      pal()
      scene:load(title)
    end)
  end,

  update = function(_ENV)
    if btnp(5) then
      async:reset()
      scene:load(title)
      sfx(-1)
    end
  end,
})
