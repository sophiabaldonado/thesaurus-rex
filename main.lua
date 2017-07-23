
local util = require 'util'
local game = require 'game'
local menu = require 'menu'
local button = require 'button'
local editor = require 'editor'
local gameover = require 'gameover'
local Gamestate = require 'lib.gamestate'
local wordList = require 'wordList'

function love.load()
  Gamestate.registerEvents()
  setupButtonConfig()

  g = love.graphics
  screenWidth, screenHeight = g.getDimensions()
  buttons = {}
  states = { game = game, gameover = gameover, menu = menu, editor = editor }

  Gamestate.switch(states.menu)
end

function love.draw()
  g.setBackgroundColor(20, 20, 20)
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
  for k,button in pairs(buttons) do
    g.setColor(unpack(button.color))
    g.rectangle('fill', button.x, button.y, button.width, button.height)

    g.setColor(200, 140, 240)
    g.printf(button.word, button.x, button.y + button.height * .33, button.width / 2, 'center', 0, 2, 2)
  end
end

function setupButtonConfig()
  if not love.filesystem.exists('buttonConfig.lua') then
    local defaultButtonConfig = {
      firstWord = {
        width = 170,
        height = 75,
        xMult = 0.33,
        y = 400
      },
      secondWord = {
        width = 170,
        height = 75,
        xMult = 0.66,
        y = 400
      },
      thirdWord = {
        width = 170,
        height = 75,
        xMult = 0.5,
        y = 500
      },
      gameOverReplay = {
        width = 170,
        height = 75,
        xMult = 0.33,
        y = 400
      },
      gameOverReview = {
        width = 170,
        height = 75,
        xMult = 0.66,
        y = 400
      },
      menuPlay = {
        width = 170,
        height = 75,
        xMult = 0.5,
        y = 500
      },
      reviewReplay = {
        width = 170,
        height = 75,
        xMult = 0.5,
        y = 500
      }
    }
    table.save(defaultButtonConfig, 'buttonConfig.lua')
  end
end
