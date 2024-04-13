player = entity:new({
  x=64,
  y=64,
  speed=1,

  update=function(_ENV)
    local dx=0
    local dy=0

    if (btn(0)) dx-=1
    if (btn(1)) dx+=1
    if (btn(2)) dy-=1
    if (btn(3)) dy+=1

    -- normalize movement speed
    if dx!=0 or dy != 0 then
      local angle = atan2(dx,dy)
      x+=cos(angle) * speed
      y+=sin(angle) * speed
    end
  end,

  draw=function(_ENV)
    circfill(x,y,3,3)
  end
})

time_limit = 601

function game_init()
  time_start = time()
end

function game_update()
  player:update()
  update_camera()
end

function game_draw()
  cls(0)
  map()
  player:draw()
  print_time()
end

function print_time()
  local time_left = (time_limit - time() - time_start) \ 1
  local m = pad(time_left \ 60,2,"0")
  local s = pad(time_left % 60,2,"0")
  printc(m .. ":" .. s,4,7,6)
end

function update_camera()
  cx = mid(0, player.x - 64, 896)
  cy = mid(0, player.y - 64, 384)
  camera(cx,cy)
end
