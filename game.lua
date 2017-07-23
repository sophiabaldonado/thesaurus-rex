local game = {}

local button = require 'button'
local currentRoundWords = require 'currentRoundWords'
local Gamestate = require 'lib.gamestate'

function game:init()
  totalScore = 0
  timeToAdd = 5
  timeToSubtract = -4
  playedWords = {}
  self.circle = g.newImage('/art/circle.png')
  self.circleWidth, self.circleHeight = self.circle:getDimensions()
  self.round = 0
  self.time = 0
end

function game:enter()
  self:startRound()
end

function game:draw()
  g.setColor(255, 255, 255, 150)
  g.draw(self.circle, g.getWidth() / 2, 200, 0, 1, 1, self.circleWidth / 2, self.circleHeight / 2)
  self:drawCurrentWord()

  g.printf(string.format('%.1f', self.time), 50, 50, screenWidth, 'left', 0, 2, 2)
  g.printf(totalScore, 50, 100, screenWidth, 'left', 0, 2, 2)
end

function game:update(dt)
  self:updateTimer(dt)
end

function game:mousepressed(x, y, button, istouch)
  local buttonClicked = findClickedButton(x, y)
  local time = timeToSubtract
  if buttonClicked then
  	if buttonClicked and buttonClicked.word == currentRoundWords.synonym then
    	self:addPoints()
    	-- time = timeToAdd
		self:resetWords()
	else
    	-- self:adjustTime(time)
		buttonClicked:strike()
	end
	self.round = self.round + 1
	self:addToPlayedWords(buttonClicked.word)
  end
end

function game:startRound()
  self:resetTime()
  self:resetWords()
  self:resetStats()
end

function game:resetStats()
  totalScore = 0
  self.round = 1
  playedWords = {}
end

function game:resetTime()
  self.time = 15
end

function game:resetWords()
  currentRoundWords:new()
  self:assignNewWordsToButtons()
end

function game:assignNewWordsToButtons()
  local b1 = button:new(currentRoundWords.wordOptions[1], 'firstWord')
  local b2 = button:new(currentRoundWords.wordOptions[2], 'secondWord')
  local b3 = button:new(currentRoundWords.wordOptions[3], 'thirdWord')
  -- print(b1)
  buttons = { b1, b2, b3 }
end

function game:updateTimer(dt)
  if self.time > 0 then
    self.time = self.time - dt
  else
    Gamestate.switch(states.gameover)
  end
end

function game:drawCurrentWord()
  g.setColor(100, 140, 240)
  g.printf(currentRoundWords.currentWord, (screenWidth / 2) - 30, screenHeight / 4, screenWidth, 'left', 0, 2, 2)
end

function game:keypressed(key)
  if key == 'e' then
    startEditor(self)
  end
end

function game:adjustTime(amount)
  self.time = self.time + amount
end

function game:addPoints()
  totalScore = totalScore + 20
end

function game:addToPlayedWords(word)
    playedWords[self.round] = {
      current = currentRoundWords.currentWord,
      selected = word,
      match = word == currentRoundWords.synonym
    }
end

return game
