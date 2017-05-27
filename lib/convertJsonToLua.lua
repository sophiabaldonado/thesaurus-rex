local json = require 'json'
local saveToFile = require 'saveTableToFile'
local jsonWords = require 'jsonWordList'

luaWords = json.decode(jsonWords[1])

table.save(luaWords, 'luaWords.lua')
