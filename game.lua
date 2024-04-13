time_limit = 601

function game_init()
  time_start = time()
  entities = {}
  minions = {}
  objectives = {}
  create_minion()
  create_objective()
end

function game_update()
  player:update()
  update_camera()
end

function game_draw()
  cls(0)
  map()

  for e in all(entities) do
    e:update()
    e:draw()
  end

  player:draw()
  draw_ui()
end

function update_camera()
  cx = mid(0, player.x - 64, 896)
  cy = mid(0, player.y - 71, 384)
  camera(cx,cy)
end

function draw_ui()
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

  -- show minion count
  local mcy=2
  spr(2,cx+4,cy+mcy)
  spr(0,cx+12,cy+mcy+1)
  print(#minions,cx+20,cy+mcy+2,7)
end

function create_minion()
  local m = minion:new({
    x = player.x,
    y = player.y
  })

  add(minions,m)
  add(entities,m)
end

function create_objective()
  local o = objective:new({
    x=72,
    y=72
  })

  add(objectives, o)
  add(entities, o)
end