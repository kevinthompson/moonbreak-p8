-- print centered
function printc(str,y,clr,w)
  w=w or 4
	local x=64-(#str*w)/2
	print(str,x,y,clr)
end

-- print shadow
function prints(str,x,y,clr)
	print(str,x+1,y+1,0)
	print(str,x,y,clr)
end

-- left pad
function pad(str,len,char)
	str=tostr(str)
	char=char or "0"
	if (#str==len) return str
	return char..pad(str, len-1)
end
