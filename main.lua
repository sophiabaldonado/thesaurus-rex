
local util = require 'util'
local button = require 'button'
local game = require 'game'
local menu = require 'menu'
local gameover = require 'gameover'
local editor = require 'editor'
local Gamestate = require 'lib.gamestate'

function love.load()
  Gamestate.registerEvents()

  g = love.graphics
  screenWidth, screenHeight = g.getDimensions()
  buttons = {}
  states = { game = game, gameover = gameover, menu = menu, editor = editor }

  Gamestate.switch(states.menu)
end

function love.draw()
  drawButtons()
end

function love.update(dt)
  --
end

function startEditor(prevState)
  Gamestate.switch(states.editor, prevState)
end

function findClickedButton(x, y)
  for i, v in ipairs(buttons) do
    if x >= v.x and x <= v.x + v.width and y >= v.y and y <= v.y + v.height then
      return v
    end
  end
  return false
end

function drawButtons()
  for k,v in pairs(buttons) do
    g.setColor(255, 255, 255)
    g.rectangle('fill', v.x, v.y, v.width, v.height)

    g.setColor(100, 140, 240)
    g.printf(v.word, v.x, v.y + v.height * .33, v.width / 2, 'center', 0, 2, 2)
  end
end
