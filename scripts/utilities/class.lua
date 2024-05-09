class=setmetatable({
	new=function(_ENV,tbl)
		tbl=tbl or {}
		setmetatable(tbl,_ENV)
    tbl.type = _ENV
    tbl:init()
		return tbl
	end,

	extend=function(_ENV,tbl)
		tbl=tbl or {}
    tbl.__index = tbl

		setmetatable(tbl or {},{
			__index=_ENV
		})

		return tbl
  end
},{__index=_ENV})
