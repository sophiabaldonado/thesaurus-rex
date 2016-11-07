local util = {}

function length(t)
  local count = 0
  for k in pairs(t) do
    count = count + 1
  end
  return count
end

function shuffle(t)
  local n = #t
  while n > 1 do
    local k = love.math.random(1, n)
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
  return t
end

function table.includes(t, val)
  for i, v in ipairs(t) do
    if v == val then return true end
  end
  return false
end

function table.rando(t)
  local randomValue = love.math.random(1, #t)
  return t[randomValue]
end

function keys(t)
  local keys = {}
  for k, v in pairs(t) do
    table.insert(keys, k)
  end
  return keys
end

return util
