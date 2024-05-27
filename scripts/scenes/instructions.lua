instructions = scene:extend({
  slide = 1,

  init = function(_ENV)
    scene.init(_ENV)
    async:call(function()
      wait(60)
    end)

    person_instance = person:new({
      player_control = false,
      x = 48,
      y = 67
    })

    collector_instance = collector:new({
      x = 56,
      y = 64
    })

    cursor_instance = cursor:new({
      x = 72,
      y = 64
    })

    ship_instance = ship:new({
      x = 64,
      y = 52
    })

    spawner_instance = spawner.objects[1]
  end,

  update = function(_ENV)
    if btnp(5) then
      if slide == #slides then
        scene:load(game)
      else
        slide += 1
      end
    end
  end,

  draw = function(_ENV)
    cls(1)
    circfill(64,164,132,13)

    printc("instructions",12,7)
    line(32,20,96,20,5)
    slides[slide](_ENV)

    if slide == #slides then
      printc("   start game", 112, 7)
      prints("❎", 38, 112, 9, 5)
    else
      printc("   next", 112, 7)
      prints("❎", 50, 112, 9, 5)
    end
  end,

  slides = {
    function(_ENV)
      person_instance:draw()
      cursor_instance:draw()
      for b in all(person_instance.bots) do
        b:follow(person_instance)
        b:draw()
      end

      printc("use arrow keys/d-pad", 84, 7)
      printc("to walk and aim", 92, 7)
    end,

    function(_ENV)
      person_instance.sprite = 32
      person_instance.x = lerp(person_instance.x, 40, .1)
      person_instance:draw()
      cursor_instance.x = lerp(cursor_instance.x, 80, .1)
      cursor_instance:draw()
      for b in all(person_instance.bots) do
        b.x = lerp(b.x, 64, .1)
        b.y = lerp(b.y, 50, .1)
        b:draw()
      end
      spr(19,80,56)
      spr(67,84,64)
      printc("tap ❎ to throw bots", 84, 7)
      printc("at supplies and obstacles", 92, 7)
    end,

    function(_ENV)
      spr(16,40,60)
      cursor_instance.x = lerp(cursor_instance.x, 75, .1)
      cursor_instance.recall_radius = 16
      cursor_instance:draw()

      sspr(40,0,5,4,64,64,5,4)
      sspr(47,0,1,3,66,60,1,3)

      sspr(40,0,5,4,80,58,5,4)
      sspr(47,0,1,3,82,54,1,3)

      sspr(40,0,5,4,64,50,5,4)
      sspr(47,0,1,3,66,46,1,3)

      printc("recall your bots", 84, 7)
      printc("by holding ❎", 92, 7)
    end,

    function(_ENV)
      collector_instance:draw()
      spr(19,53,52)
      sspr(40,0,5,4,54,44,5,4)
      sspr(40,0,5,4,74,42,5,4)

      spawner_instance.open_percent = 100
      spawner_instance:draw()

      printc("collecting supplies", 84, 7)
      printc("creates more bots", 92, 7)
    end,

    function(_ENV)
      ship_instance:draw()

      spr(55, 40, 64)
      spr(54, 60, 64)
      spr(37, 80, 64)

      printc("use bots to collect parts", 84, 7)
      printc("and leave the moon", 92, 7)
    end
  }
})
