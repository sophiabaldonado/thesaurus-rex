local editor = {}
local config = require 'config'

local Gamestate = require 'lib.gamestate'
local button = require 'button'

function editor:enter(current, prevState)
  self.config = config
  self.prevState = prevState
end

function editor:exit()
  Gamestate.switch(self.prevState)
end

function editor:save()
  -- Write to config.lua
end

return editor
