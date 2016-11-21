local gameover = {}

local button = require 'button'
local Gamestate = require 'lib.gamestate'

function gameover:init()
  self.reviewScreen = false
  self:setupButtons()
end

function gameover:enter()
  self:setupButtons()
end

function gameover:setupButtons()
  replay = button:new('Replay', 'right')
  review = button:new('Review', 'left')
  reviewReplay = button:new('Replay', 'bottom')

  self.lostButtons = { replay, review }
  self.reviewButtons = { reviewReplay }
end

function gameover:draw()
  if self.reviewScreen then
    if length(keys(playedWords)) <= 0 then
        g.printf('No Words to Review', 0, 100, screenWidth, 'center')
    end
    for k, v in pairs(playedWords) do
      local roundSummary = v.current..' ------ '..v.selected

      if v.match == true then
        g.setColor(200, 200, 200, 150)
      else
        g.setColor(100, 100, 100, 150)
      end
      g.printf(roundSummary, 0, 100 + (15 * k), screenWidth, 'center')
    end
  else
    g.setColor(100, 140, 240)
    g.printf('GAME OVER', -screenWidth / 2, 200, screenWidth, 'center', 0, 2, 2)
    g.printf(totalScore, -screenWidth / 2, 250, screenWidth, 'center', 0, 2, 2)
  end
end

function gameover:update()
  buttons = self.reviewScreen and self.reviewButtons or self.lostButtons
end

function gameover:mousepressed(x, y, button, istouch)
  local clickedButton = findClickedButton(x, y)
  if clickedButton then
    if clickedButton.word == 'Replay' then
      print('replay')
      self.reviewScreen = false
      Gamestate.switch(states.game)
    elseif clickedButton.word == 'Review' then
      print('review')
      self.reviewScreen = true
    end
  end
end

return gameover