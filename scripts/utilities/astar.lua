function astar(start, goal)
  local start_node = node:new({ x = start[1], y = start[2] })
  local goal_node = node:new({ x = goal[1], y = goal[2] })
  local open = {start_node}
  local nodes = {}
  local iteration = 1
  local max_iterations_per_frame = 16

  -- loop until we find the end
  while #open > 0 do
    sort(open, "f")

    local current_node = open[1]
    deli(open, 1)
    current_node.closed = true
    nodes[current_node.index] = current_node

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

    -- generate adjacent nodes
    for new_position in all(adjacent_positions) do
      local nx = current_node.x + new_position[1]
      local ny = current_node.y + new_position[2]
      local adjacent_node = node:new({ x = nx, y = ny })

      -- skip if...
      -- node is blocking path
      local tile = mget(adjacent_node.x, adjacent_node.y)
      if fget(tile, flags.solid)

      -- or node is out of bounds
      or adjacent_node.x > 127
      or adjacent_node.x < 0
      or adjacent_node.y > 63
      or adjacent_node.y < 0 then
        goto continue
      end

      local existing_node = nodes[adjacent_node.index]
      if existing_node and existing_node.closed then
        goto continue
      end

      adjacent_node.parent = current_node
      adjacent_node.g = current_node.g + 1
      adjacent_node.h = dist(adjacent_node, goal_node)
      adjacent_node.f = adjacent_node.g + adjacent_node.h

      if not existing_node then
        add(open,adjacent_node)
        nodes[adjacent_node.index] = adjacent_node
      else
        if adjacent_node.g < existing_node.g then
          existing_node.parent = current_node
          existing_node.g = adjacent_node.g
          existing_node.f = existing_node.g + existing_node.h
        end
      end

      ::continue::
    end

    iteration += 1
    if iteration >= max_iterations_per_frame then
      iteration = 0
      yield()
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

  new = function(_ENV, tbl)
    tbl = class.new(_ENV, tbl)
    tbl.index = tbl.x + tbl.y * 128
    return tbl
  end,

  __eq = function(t1,t2)
    return t1.x == t2.x and t1.y == t2.y
  end
})

adjacent_positions = {
  {0,-1},
  {0,1},
  {-1,0},
  {1,0},
  -- [[ disable corner pathing
  {-1,-1},
  {-1,1},
  {1,-1},
  {1,1}
  -- ]]
}
