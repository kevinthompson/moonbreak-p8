class=setmetatable({
  extend=function(_ENV,tbl)
    tbl=tbl or {}
    tbl.__index = tbl

    setmetatable(tbl or {},{
      __index=_ENV
    })

    return tbl
  end,

  new=function(_ENV,tbl)
    tbl=tbl or {}
    setmetatable(tbl,_ENV)
    tbl.type = _ENV
    tbl:init()
    return tbl
  end,

  init = _noop
},{__index=_ENV})
class.__index = class
