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
  local dx = c1.x - c2.x
  local dy = c1.y - c2.y
  return sqrt(dx * dx + dy * dy)
end
