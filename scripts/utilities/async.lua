async = class:extend({
  coroutines = {},

  call = function(_ENV,func)
    add(coroutines,cocreate(func))
  end,

  update = function(_ENV)
    for routine in all(coroutines) do
      if costatus(routine) != "dead" then
        assert(coresume(routine))
      else
        del(coroutines,routine)
      end
    end
  end
})