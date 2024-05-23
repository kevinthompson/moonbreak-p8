-- print centered with shadow
function printsc(str,y,clr,w)
  printc(str,y+2,0,w)
  printc(str,y,clr,w)
end

-- print centered
function printc(str,y,clr,w)
  w=w or 4
	local x=64-(#str*w)/2
	print(str,x,y,clr)
end

-- print shadow
function prints(str,x,y,clr)
	print(str,x,y+1,0)
	print(str,x,y,clr)
end

function tprint(func)
  poke(0x5f58,0x81)
  func()
  poke(0x5f58,0x01)
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
  local dx = abs(c2.x - c1.x)
  local dy = abs(c2.y - c1.y)
  if dy < dx then
    dx,dy=dy,dx
  end
  return dy/sin(atan2(dx,dy))
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
bfr = {0,0,0,0,0,0}

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
  for b=0,5 do
    bfr[b+1] = btn(b) and bfr[b+1]+1 or 0
  end
end

function handle_input()
  bframes()
  pbtn=btn()
end
