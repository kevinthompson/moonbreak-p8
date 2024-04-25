class=setmetatable({
	new=function(_ENV,tbl)
		tbl=tbl or {}

		setmetatable(tbl or {},{
			__index=_ENV
		})

		return tbl
	end,

	extend=function(_ENV,tbl)
		tbl=tbl or {}

		setmetatable(tbl or {},{
			__index=_ENV
		})

		return tbl
  end
},{__index=_ENV})
