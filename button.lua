local button = {}

function button:new(word, position)
  o = {}
  o.width = 170
  o.height = 75
  o.word = word

  o.x, o.y = buttonCoords(position)
  setmetatable(o, self)
  self.__index = self
  return o
end

function buttonCoords(position)
  if position == 'left' then
    x = (screenWidth * 0.33) - o.width / 2
    y = 400
  elseif position == 'right' then
    x = (screenWidth * 0.66) - o.width / 2
    y = 400
  elseif position == 'bottom' then
    x = (screenWidth * 0.5) - o.width / 2
    y = 500
  end
  return x, y
end

return button
