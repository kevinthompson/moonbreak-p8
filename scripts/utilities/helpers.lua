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
  return rect1.x < rect2.x + rect2.w and
    rect1.x + rect1.w > rect2.x and
    rect1.y < rect2.y + rect2.h and
    rect1.y + rect1.h > rect2.y
end

function lerp(a,b,t)
  return a+(b-a)*t
end
