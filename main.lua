
local util = require "util"
local button = require "button"
local wordSet = require "wordSet"

function love.load()
  g = love.graphics
  screenWidth, screenHeight = g.getDimensions()
  circle = g.newImage("/art/circle.png")
  circleWidth, circleHeight = circle:getDimensions()

  totalScore = 0
  gameOver = false
  replayButton = button:new("Replay", 'left')
  reviewButton = button:new("Review", 'right')

  startRound()
end

function startRound()
  resetTime()
  resetWords()
  totalScore = 0
  gameOver = false
end

function resetTime()
  time = 20
end

function resetWords()
  wordSet:init()
  b1 = button:new(wordSet.wordOptions[1], 'left')
  b2 = button:new(wordSet.wordOptions[2], 'right')
  b3 = button:new(wordSet.wordOptions[3], 'bottom')
  buttons = { b1, b2, b3 }
end

function love.draw()
  if gameOver then
    g.setColor(100, 140, 240)
    g.printf("GAME OVER", -screenWidth / 2, 200, screenWidth, 'center', 0, 2, 2)
    g.printf(totalScore, -screenWidth / 2, 250, screenWidth, 'center', 0, 2, 2)
    drawLostButtons()
  else
    g.setColor(255, 255, 255, 150)
    g.draw(circle, g.getWidth() / 2, 200, 0, 1, 1, circleWidth / 2, circleHeight / 2)
    drawCurrentWord()
    drawWordButtons()

    g.printf(string.format("%.1f", time), 50, 50, screenWidth, 'left', 0, 2, 2)
    g.printf(totalScore, 50, 100, screenWidth, 'left', 0, 2, 2)
  end
end

function love.update(dt)
  updateTimer(dt)
end

function love.mousepressed(x, y, button, istouch)
  -- check if a button was pressed and if so check if it was the correct word
  local clickedButton = findClickedButton(x, y)
  local timeToAdd = 5
  local timeToSubtract = -2
  if clickedButton then
    if clickedButton.word == wordSet.synonym then
      print("correct!")
      addPoints()
      adjustTime(timeToAdd)
    elseif clickedButton.word == 'Replay' then
      print('replay')
      startRound()
    elseif clickedButton.word == 'Review' then
      print('review')
    else
      print("incorrect!")
      adjustTime(timeToSubtract)
    end
    -- startRound()
    resetWords()
  end
end

function findClickedButton(x, y)
  if gameOver then
    buttons = { replayButton, reviewButton }
  end
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

function drawLostButtons()
  g.setColor(255, 255, 255)
  g.rectangle('fill', replayButton.x, replayButton.y, replayButton.width, replayButton.height)
  g.rectangle('fill', reviewButton.x, reviewButton.y, reviewButton.width, reviewButton.height)

  g.setColor(100, 140, 240)
  g.printf(replayButton.word, replayButton.x, replayButton.y + replayButton.height * .33, replayButton.width / 2, 'center', 0, 2, 2)
  g.printf(reviewButton.word, reviewButton.x, reviewButton.y + reviewButton.height * .33, reviewButton.width / 2, 'center', 0, 2, 2)
end

function updateTimer(dt)
  if time > 0 then
    time = time - dt
  else
    gameOver = true
  end
end

function adjustTime(amount)
  time = time + amount
end

function addPoints()
  totalScore = totalScore + 20
end
