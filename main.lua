
local util = require 'util'
local game = require 'game'
local menu = require 'menu'
local button = require 'button'
local editor = require 'editor'
local gameover = require 'gameover'
local Gamestate = require 'lib.gamestate'
local wordListFormatter = require 'wordListFormatter'

function love.load()
  Gamestate.registerEvents()
  setupButtonConfig()
  setupSynonyms()

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
  for k,v in pairs(buttons) do
    g.setColor(255, 255, 255)
    g.rectangle('fill', v.x, v.y, v.width, v.height)

    g.setColor(100, 140, 240)
    g.printf(v.word, v.x, v.y + v.height * .33, v.width / 2, 'center', 0, 2, 2)
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

  function setupSynonyms()
    if (wordList == {}) then
      local unformattedWords = table.load('lib/luaWords.lua')
      wordListFormatter:format(unformattedWords)
    end
  end
end
