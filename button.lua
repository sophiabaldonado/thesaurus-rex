local button = {}

local saveToFile = require 'lib.saveTableToFile'
local config = {}

function button:new(word, buttonId)
  config = table.load('buttonConfig.lua')
  o = {}
  o.id = buttonId
  o.width = config[buttonId].width
  o.height = config[buttonId].height
  o.word = word
  o.x, o.y = self:buttonCoords(buttonId)
  o.color = { 255, 255, 255 }

  setmetatable(o, self)
  self.__index = self
  return o
end

function button:buttonCoords(id)
  local x = (screenWidth * config[id].xMult) - config[id].width / 2
  local y = config[id].y
  return x, y
end

function button:strike()
  self.color = { 255, 100, 100 }
end

return button
