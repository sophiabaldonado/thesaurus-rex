local button = {}

local config = require 'config'

function button:new(word, position)
  o = {}
  o.width = config[position].width
  o.height = config[position].height
  o.word = word

  o.x, o.y = self:buttonCoords(position)
  setmetatable(o, self)
  self.__index = self
  return o
end

function button:buttonCoords(position)
  local x = (screenWidth * config[position].xMult) - config[position].width / 2
  local y = config[position].y

  return x, y
end

return button
