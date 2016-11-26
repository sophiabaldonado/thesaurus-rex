local button = {}

local saveToFile = require 'lib.saveTableToFile'
local config = table.load('configTest.lua')

function button:new(word, position)
  o = {}
  o.id = position
  o.width = config[position].width
  o.height = config[position].height
  o.word = word

  o.x, o.y = self:buttonCoords(position)
  print("boops", o.id, o.y)
  setmetatable(o, self)
  self.__index = self
  return o
end

function button:buttonCoords(position)
  local x = (screenWidth * config[position].xMult) - config[position].width / 2
  local y = config[position].y
  -- print('coords',y)
  return x, y
end

return button
