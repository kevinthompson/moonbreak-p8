function log(any, overwrite)
  printh(tostr(any), logfile or "log", overwrite)
end

_tostr = tostr

function tostr(any, prefix)
  prefix = prefix or ""

  if type(any) == "table" then
    local str="{"
    local add_comma=false
    local use_keys=false

    for k,_ in pairs(any) do
      if type(k) == "string" then
        use_keys = true
        break
      end
    end

    for k,v in pairs(any) do
      str=str..(add_comma and "," or "")

      if use_keys then
        str=str.."\n  "..prefix..k.." = "
      end

      str=str..tostr(v, "  ")
      add_comma=true
    end

    if use_keys then
      str=str.."\n"..prefix
    end

    return str.."}"
  else
    return _tostr(any)
  end
end

function enable_debug()
  entity.draw_hitbox = function(_ENV)
    local hb = _ENV:get_hitbox()
    local wo = hb.width > 0 and -1 or 0
    local ho = hb.height > 0 and -1 or 0
    rect(hb.x, hb.y, hb.x + hb.width + wo, hb.y + hb.height + ho, 11)
  end

  _game_draw = game.draw
  game.draw = function(_ENV)
    _game_draw(_ENV)

    if debug then
      for e in all(entity.objects) do
        e:draw_hitbox()
      end
    end
  end
end

function profile(label, func)
  local before = stat(1)
  func()
  log(label .. ": " .. stat(1) - before)
end
