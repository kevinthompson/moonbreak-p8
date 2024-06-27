class = setmetatable({
  label = "class",
  ancestors = {},
  descendants = {},

  extend = function(_ENV, tbl)
    tbl = tbl or {}
    tbl.__index = tbl
    tbl.ancestors = {}
    tbl.super = _ENV

    for a in all(_ENV.ancestors) do
      add(tbl.ancestors, a)
    end

    add(tbl.ancestors, _ENV)

    setmetatable(tbl, {
      __index = _ENV,
      __call = tbl.__call
    })

    return tbl
  end,

  new = function(_ENV, tbl)
    tbl = tbl or {}
    setmetatable(tbl, _ENV)
    tbl.class = _ENV
    tbl:init()
    return tbl
  end,

  is = function(_ENV, klass)
    return _ENV.class == klass or count(ancestors, klass) > 0
  end,

  init = _noop
}, { __index = _ENV })

class.__index = class
