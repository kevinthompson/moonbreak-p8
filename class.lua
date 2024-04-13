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

entity=class:new({
	x=0,
	y=0,
})
