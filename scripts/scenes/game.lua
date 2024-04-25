entities = {}
global_bots = {}
objectives = {}
targets = {}

game = scene:extend({
  init=function(_ENV)
    time_limit = 601
    time_start = time()

    create_terminal()

    for i=1,3 do
      create_objective()
    end

    for i=1,5 do
      create_energy(player.x,player.y,rnd())
    end

    for i=1,100 do
      create_bot()
    end
  end,

  update=function(_ENV)
    player:update()
    update_camera()
  end,

  draw=function(_ENV)
    cls(13)
    map()

    for e in all(entities) do
      e:update()
      e:draw()
    end

    player:draw()
    _ENV:draw_ui()
  end,

  draw_ui = function(_ENV)
    -- draw ui background
    rectfill(cx,cy,cx+128,cy+10,0)
    rectfill(cx+45,cy,cx+80,cy+13,0)

    -- print time
    local time_left = (time_limit - time() - time_start) \ 1
    local m = pad(time_left \ 60,2,"0")
    local s = pad(time_left % 60,2,"0")

    poke(0x5f58,0x81)
    printc(m .. ":" .. s,4,7,6)
    poke(0x5f58,0x80)

    -- show bot count
    local mcy=2
    spr(2,cx+4,cy+mcy)
    spr(0,cx+12,cy+mcy+1)
    print(#player.bots,cx+20,cy+mcy+2,7)

    -- show energy count
    spr(4,cx+104,cy+mcy+1)
    spr(0,cx+112,cy+mcy+1)
    print(player.energy,cx+120,cy+mcy+2,7)
  end
})

function update_camera()
  cx = mid(0, player.x - 64, 896)
  cy = mid(-16, player.y - 71, 384)
  camera(cx,cy)
end

function create_bot()
  local m = bot:new({
    x = player.x,
    y = player.y
  })

  add(global_bots,m)
  add(player.bots,m)
  add(entities,m)
end

function create_objective()
  local o = objective:new({
    x=rnd(128),
    y=rnd(128)
  })

  add(targets, o)
  add(objectives, o)
  add(entities, o)
end

function create_terminal()
  local t = terminal:new({
    x=32,
    y=32
  })

  add(targets, t)
  add(terminals, t)
  add(entities, t)
end

function create_energy(x,y,a)
  add(entities, energy:new({
    x=x,
    y=y,
    a=a
  }))
end
