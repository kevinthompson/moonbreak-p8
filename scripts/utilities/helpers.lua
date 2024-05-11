-- print centered
function printc(str,y,clr,w)
  w=w or 4
	local x=64-(#str*w)/2
	print(str,cx+x,cy+y,clr)
end

-- print shadow
function prints(str,x,y,clr)
	print(str,x,y+1,0)
	print(str,x,y,clr)
end

-- left pad
function pad(str,len,char)
	str=tostr(str)
	char=char or "0"
	if (#str==len) return str
	return char..pad(str, len-1)
end

-- circle collision
function ccol(c1,c2)
  return dist(c1,c2) < c1.r + c2.r
end

function dist(c1,c2)
  --[[
  Numbers larger than 32767.99999 will overflow
  and cause invalid distance values
  ]]
  local dx = c2.x - c1.x
  local dy = c2.y - c1.y
  return sqrt(dx * dx + dy * dy)
end

function aabb(rect1,rect2)
  return rect1.x < rect2.x + rect2.width and
    rect1.x + rect1.width > rect2.x and
    rect1.y < rect2.y + rect2.height and
    rect1.y + rect1.height > rect2.y
end

function lerp(a,b,t)
  return a+(b-a)*t
end

function wait(frames)
  for i=1,frames do
    yield()
  end
end

function arc(max_x, max_y, x)
  return sin(.5 + (x/max_x) * .5) * max_y
end

function sort(tbl,key,lo,hi)
  key,lo,hi=key or "y",lo or 1,hi or #tbl
  if lo<hi then
    local p,i,j=tbl[(lo+hi)\2][key],lo-1,hi+1
    while true do
      repeat i+=1 until tbl[i][key]>=p
      repeat j-=1 until tbl[j][key]<=p
      if (i>=j) break
      tbl[i],tbl[j]=tbl[j],tbl[i]
    end
    sort(tbl,key,lo,j)
    sort(tbl,key,j+1,hi)
  end
end

-- button methods
-- ====================
pbtn = 0
bfr = {}

-- button released
function btnr(b)
  local bit=shl(1,b)
  return band(bit,pbtn)==bit and btn()==band(bnot(bit),btn())
end

-- return button frame count
function btnf(b)
  return bfr[b+1] or 0
end

-- increment button frames
function bframes()
  for b=0,5 do bfr[b+1] = btn(b) and bfr[b+1]+1 or 0 end
end

function handle_input()
  bframes()
  pbtn=btn()
end

function astar(start, goal)
  local start_node = node:new({ x = start[1], y = start[2] })
  local goal_node = node:new({ x = goal[1], y = goal[2] })

  local open_list = {start_node}
  local closed_list = {}
  local max_iterations = 1000
  local iteration = 1

  -- loop until we find the end
  while #open_list > 0 and iteration < max_iterations do
    sort(open_list,"f")
    iteration += 1

    local current_node = open_list[1]
    local current_index = 1

    -- get the current node
    for index, other_node in ipairs(open_list) do
      if other_node.f < current_node.f then
        current_node = other_node
        current_index = index
      end
    end

    -- move the current node to the closed list
    deli(open_list, current_index)
    add(closed_list, current_node)

    -- found the goal
    if current_node == goal_node then
      local path = {}
      local current = current_node

      while current do
        add(path, { x = current.x, y = current.y }, 1)
        current = current.parent
      end

      return path
    end

    -- generate children
    local children = {}
    for new_position in all(adjacent_positions) do
      local adjacent_node = node:new({
        parent = current_node,
        x = current_node.x + new_position[1],
        y = current_node.y + new_position[2]
      })

      -- check that position is in map
      if adjacent_node.x > 127
      or adjacent_node.x < 0
      or adjacent_node.y > 63
      or adjacent_node.y < 0 then
        goto continue
      end

      -- skip solid tiles
      if fget(mget(adjacent_node.x, adjacent_node.y), flags.solid) then
        goto continue
      end

      add(children, adjacent_node)
      ::continue::
    end

    -- loop through children
    for child in all(children) do
      for closed_child in all(closed_list) do
        if child == closed_child then
          goto continue
        end
      end

      child.g = current_node.g + 1
      child.h = ((child.x - goal_node.x) ^ 2) + ((child.y - goal_node.y) ^ 2)
      child.f = child.g + child.h

      for open_node in all(open_list) do
        if child == open_node and child.g > open_node.g then
          goto continue
        end
      end

      add(open_list, child)
      ::continue::
    end
  end
end

node = class:extend({
  parent = nil,
  x = 0,
  y = 0,
  g = 0,
  h = 0,
  f = 0,

  __eq = function(t1,t2)
    return t1.x == t2.x and t1.y == t2.y
  end
})

adjacent_positions = {
  {0,-1},{0,1},{-1,0},
  {1,0}, {-1,-1}, {-1,1},
  {1,-1}, {1,1}
}
