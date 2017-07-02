local json = require 'json'
local inspect = require 'inspect'
local jsonWords = require 'jsonWordList'
local synonymsFormatter = require 'wordListFormatter'

local luaWords = json.decode(jsonWords[1])
local formattedWords = synonymsFormatter:format(luaWords)
print(inspect(formattedWords))
