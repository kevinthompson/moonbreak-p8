async = class:extend({
  __call = function(_ENV, func)
    add(coroutines, cocreate(func))
  end,

  coroutines = {},

  reset = function(_ENV)
    coroutines = {}
  end,

  update = function(_ENV)
    for routine in all(coroutines) do
      if costatus(routine) != "dead" then
        assert(coresume(routine))
      else
        del(coroutines, routine)
      end
    end
  end
})

function wait(frames)
  for i = 1, frames do
    yield()
  end
end
