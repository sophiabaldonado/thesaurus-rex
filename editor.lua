local editor     = {}
local button     = require 'button'
local Gamestate  = require 'lib.gamestate'
local saveToFile = require 'lib.saveTableToFile'

function editor:enter(current, prevState)
  self.config = table.load('buttonConfig.lua')
  self.newConfig = {}
  self.prevState = prevState
  self.dragging = {}
end

function editor:draw()
  g.setBackgroundColor(40, 30, 45)
  g.printf('Editor', 20, 20, screenWidth, 'left', 0, 1, 1)
end

function editor:update(dt)
  if self.dragging.active == true then self:showMoveButtons() end
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
  local buttonClicked = findClickedButton(x, y)
  if buttonClicked then
    self.dragging = {
      active = true,
      button = buttonClicked,
      startX = x,
      startY = y
    }
    self.dragging.diffX = self.dragging.startX - self.dragging.button.x
    self.dragging.diffY = self.dragging.startY - self.dragging.button.y
  end
end

function editor:mousereleased(x, y, button, isTouch)
  self:recordMoveButtons(x, y)
  self.dragging.active = false
end

function editor:showMoveButtons()
  local button = self.dragging.button
  button.x = love.mouse.getX() - self.dragging.diffX
  button.y = love.mouse.getY() - self.dragging.diffY
end

function editor:recordMoveButtons(x, y)
  local button = self.dragging.button

  -- Find the new x (corner) and adjust for positioning from button center
  local adjustedX = button.x + button.width / 2
  self.newConfig[button.id] = {}
  self.newConfig[button.id].xMult = adjustedX / screenWidth
  self.newConfig[button.id].y = button.y
end

function editor:exit()
  Gamestate.switch(self.prevState)
end

function editor:save()
  table.mergeTables(self.config, self.newConfig)
  table.save(self.config, 'buttonConfig.lua')
end

return editor
