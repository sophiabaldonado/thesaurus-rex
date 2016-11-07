
local wordSet = require "wordSet"
local util = require "util"

function love.load()
  g = love.graphics
  screenWidth, screenHeight = g.getDimensions()
  circle = g.newImage("/art/circle.png")
  circleWidth, circleHeight = circle:getDimensions()

  wordSet:init()
end

function love.draw()
  g.setColor(255, 255, 255, 150)
  g.draw(circle, g.getWidth() / 2, 200, 0, 1, 1, circleWidth / 2, circleHeight / 2)
  drawCurrentWord()
  drawButtons()
  -- g.circle('line', 200, 200, 100, 50)
end

function love.update(dt)
  --
end

function love.mousepressed(x, y, button, istouch)
   if button == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
      printx = x
      printy = y
   end
end

function love.keypressed(key)
   if key == 'r' then
      wordSet:init()
   end
end

-- TODO: make a button class?
function drawButtons()
  word1 = wordSet.wordOptions[1]
  word2 = wordSet.wordOptions[2]
  word3 = wordSet.wordOptions[3]
  bWidth = 170
  bHeight = 75
  g.setColor(255, 255, 255)
  g.rectangle('fill', (screenWidth * 0.33) - bWidth / 2, 400, bWidth, bHeight)
  g.rectangle('fill', (screenWidth * 0.66) - bWidth / 2, 400, bWidth, bHeight)
  g.rectangle('fill', (screenWidth * 0.5) - bWidth / 2, 500, bWidth, bHeight)
  g.setColor(100, 140, 240)
  g.printf(word1, (screenWidth * 0.33) - bWidth / 2, 400 + bHeight * .33, bWidth / 2, 'center', 0, 2, 2)
  g.printf(word2, (screenWidth * 0.66) - bWidth / 2, 400 + bHeight * .33, bWidth / 2, 'center', 0, 2, 2)
  g.printf(word3, (screenWidth * 0.5) - bWidth / 2, 500 + bHeight * .33, bWidth / 2, 'center', 0, 2, 2)
end

function drawCurrentWord()
  g.setColor(100, 140, 240)
  g.printf(wordSet.currentWord, (screenWidth / 2) - 30, screenHeight / 4, screenWidth, 'left', 0, 2, 2)
end
