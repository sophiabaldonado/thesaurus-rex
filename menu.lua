local menu = {}

local button = require 'button'
local Gamestate = require 'lib.gamestate'

function menu:init()
  self.trex = g.newImage('/art/trex.png')
  self.trexWidth, self.trexHeight = self.trex:getDimensions()
end

function menu:enter()
  self.setupButtons()
end

function menu:draw()
  g.setColor(255,255,255)
  g.printf('THESAURUS REX', -screenWidth / 2, 80, screenWidth, 'center', 0, 2, 3)
  g.draw(self.trex, g.getWidth() / 2, 300, 0, .5, .5, self.trexWidth / 2, self.trexHeight / 2)
end

function menu:setupButtons()
  buttons = { button:new('Play', 'menuPlay') }
end

function menu:keypressed(key)
  if key == 'e' then
    startEditor(self)
  end
end

function menu:mousepressed(x, y, button, istouch)
  local clickedButton = findClickedButton(x, y)
  if clickedButton and clickedButton.word == 'Play' then
    Gamestate.switch(states.game)
  end
end

return menu
