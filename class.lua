class=setmetatable({
	new=function(_ENV,tbl)
		tbl=tbl or {}

		setmetatable(tbl or {},{
			__index=_ENV
		})

		return tbl
	end,

	init=function()end
},{__index=_ENV})

noop = function()end

gameobject = class:new({
  init=noop,
  update=noop,
  draw=noop
})

entity=gameobject:new({
	x=0,
	y=0,
})

scene=gameobject:new()
