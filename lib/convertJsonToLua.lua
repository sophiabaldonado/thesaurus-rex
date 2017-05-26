local json = require 'json'
local jsonWords = require 'jsonWordList'

luaWords = json.decode(jsonWords[1])

return luaWords
