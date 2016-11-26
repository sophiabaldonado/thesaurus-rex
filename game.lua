local game = {}

local button = require 'button'
local wordSet = require 'wordset'
local Gamestate = require 'lib.gamestate'

function game:init()
  self.totalScore = 0
  self.playedWords = {}
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
  g.printf(self.totalScore, 50, 100, screenWidth, 'left', 0, 2, 2)
end

function game:update(dt)
  self:updateTimer(dt)
end

function game:mousepressed(x, y, button, istouch)
  -- check if a button was pressed and if so check if it was the correct word
  local clickedButton = findClickedButton(x, y)
  local timeToAdd = 5
  local timeToSubtract = -4
  if clickedButton then
    if clickedButton.word == wordSet.synonym then
      print('correct!')
      self:addPoints()
      self:adjustTime(timeToAdd)
      self:addToPlayedWords(clickedButton.word)
    else
      print('incorrect!')
      self:adjustTime(timeToSubtract)
      self:addToPlayedWords(clickedButton.word)
    end
    self.round = self.round + 1
    self:resetWords()
  end
end

function game:startRound()
  self:resetTime()
  self:resetWords()
  self:resetStats()
end

function game:resetStats()
  self.totalScore = 0
  self.round = 1
  self.playedWords = {}
end

function game:resetTime()
  self.time = 15
end

function game:resetWords()
  wordSet:new()
  local b1 = button:new(wordSet.wordOptions[1], 'firstWord')
  local b2 = button:new(wordSet.wordOptions[2], 'secondWord')
  local b3 = button:new(wordSet.wordOptions[3], 'thirdWord')
  buttons = { b1, b2, b3 }
end

function game:updateTimer(dt)
  if self.time > 0 then
    self.time = self.time - dt
  else
    Gamestate.switch(states.gameover, self.playedWords, self.totalScore)
  end
end

function game:drawCurrentWord()
  g.setColor(100, 140, 240)
  g.printf(wordSet.currentWord, (screenWidth / 2) - 30, screenHeight / 4, screenWidth, 'left', 0, 2, 2)
end

function game:adjustTime(amount)
  self.time = self.time + amount
end

function game:addPoints()
  self.totalScore = self.totalScore + 20
end

function game:addToPlayedWords(word)
  if word == wordSet.synonym then
    self.playedWords[self.round] = {
      current = wordSet.currentWord,
      selected = word,
      match = true
    }
  else -- should i display the correct synonym instead?
    self.playedWords[self.round] = {
      current = wordSet.currentWord,
      selected = word,
      match = false
    }
  end
end

return game
