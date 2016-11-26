local editor = {}
-- local config     = require 'config'
local button     = require 'button'
local Gamestate  = require 'lib.gamestate'
local saveToFile = require 'lib.saveTableToFile'

function editor:enter(current, prevState)
  self.config = table.load('configTest.lua')
  self.prevState = prevState
  self.err = nil
end

function editor:keypressed(key)
  if key == 'q' then
    self:exit()
  end
  if key == 's' then
    self:save()
  end
end

function editor:mousepressed(x, y, button, istouch)
  local clickedButton = findClickedButton(x, y)
  if clickedButton then
    clickedButton.y = clickedButton.y - 10
    self.config[clickedButton.id].y = clickedButton.y
  end
end

function editor:exit()
  Gamestate.switch(self.prevState)
end

function editor:save()
  -- Write to config.lua
  table.save(self.config, 'configTest.lua')
end

return editor
