function astar(start, goal)
  local start_node = node:new({ x = start[1], y = start[2] })
  local goal_node = node:new({ x = goal[1], y = goal[2] })

  local open_list = {start_node}
  local closed_list = {}

  -- loop until we find the end
  while #open_list > 0 do
    -- sort(open_list,"f")

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
    for i,new_position in ipairs(adjacent_positions) do
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
      local tile = mget(adjacent_node.x, adjacent_node.y)
      if fget(tile, flags.block_path) then
        goto continue
      end

      add(children, adjacent_node)
      ::continue::
    end

    -- loop through children
    for _,child in ipairs(children) do
      for _,closed_child in ipairs(closed_list) do
        if child == closed_child then
          goto continue
        end
      end

      child.g = current_node.g + 1
      child.h = ((child.x - goal_node.x) ^ 2) + ((child.y - goal_node.y) ^ 2)
      child.f = child.g + child.h

      for _,open_node in ipairs(open_list) do
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
  {0,-1},
  {0,1},
  {-1,0},
  {1,0},
  -- disable corner pathing
  -- {-1,-1},
  -- {-1,1},
  -- {1,-1},
  -- {1,1}
  --]]
}
