
local util = require "util"
local button = require "button"
local wordSet = require "wordSet"

function love.load()

  g = love.graphics
  screenWidth, screenHeight = g.getDimensions()
  circle = g.newImage("/art/circle.png")
  circleWidth, circleHeight = circle:getDimensions()

  startRound()
end

function startRound()
  resetTime()
  resetWords()
end

function resetTime()
  time = 10
end

function resetWords()
  wordSet:init()
  b1 = button:new(wordSet.wordOptions[1], 'left')
  b2 = button:new(wordSet.wordOptions[2], 'right')
  b3 = button:new(wordSet.wordOptions[3], 'bottom')
  buttons = { b1, b2, b3 }
end

function love.draw()
  g.setColor(255, 255, 255, 150)
  g.draw(circle, g.getWidth() / 2, 200, 0, 1, 1, circleWidth / 2, circleHeight / 2)
  drawCurrentWord()
  drawButtons()

  g.printf(string.format("%.1f", time), 50, 50, screenWidth, 'left', 0, 2, 2)
end

function love.update(dt)
  time = time - dt
end

function love.mousepressed(x, y, button, istouch)
  -- check if a button was pressed and if so check if it was the correct word
  print('mouse pressed at ('..x..','..y..')')
  clickedButton = findClickedButton(x, y)
  if clickedButton then
    if clickedButton.word == wordSet.synonym then
      print("correct!")
    else
      print("incorrect!")
    end
    startRound()
  end
end

function findClickedButton(x, y)
  for i, v in ipairs(buttons) do
    if x >= v.x and x <= v.x + v.width and y >= v.y and y <= v.y + v.height then
      return v
    end
  end
  return false
end

function love.keypressed(key)
   if key == 'r' then
      startRound()
   end
end

-- TODO: make a button class?
function drawButtons()
  g.setColor(255, 255, 255)
  g.rectangle('fill', b1.x, b1.y, b1.width, b1.height)
  g.rectangle('fill', b2.x, b2.y, b2.width, b2.height)
  g.rectangle('fill', b3.x, b3.y, b3.width, b3.height)

  g.setColor(100, 140, 240)
  g.printf(b1.word, b1.x, b1.y + b1.height * .33, b1.width / 2, 'center', 0, 2, 2)
  g.printf(b2.word, b2.x, b2.y + b2.height * .33, b2.width / 2, 'center', 0, 2, 2)
  g.printf(b3.word, b3.x, b3.y + b3.height * .33, b3.width / 2, 'center', 0, 2, 2)
end

function drawCurrentWord()
  g.setColor(100, 140, 240)
  g.printf(wordSet.currentWord, (screenWidth / 2) - 30, screenHeight / 4, screenWidth, 'left', 0, 2, 2)
end
