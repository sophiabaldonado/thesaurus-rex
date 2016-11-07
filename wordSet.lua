local words = require "wordList"
local wordSet = {}

function wordSet:init()
  self.currentWord = randomWord()
  self.synonym = self:currentSynonym()
  self.incorrectWords = {}
  self:populateIncorrectWords(2)

  self.wordOptions = self:shuffleOptions()
end

function randomWord()
  local keys = keys(words)
  local rando = love.math.random(1, #keys)
  local randomWord = keys[rando]

  return randomWord
end

function wordSet:currentSynonym()
  local currentWord = words[self.currentWord]
  local syns = keys(currentWord.synonyms)
  local randomSynonym = table.rando(syns)

  return randomSynonym
end

function wordSet:populateIncorrectWords(amount)
  for i = 1, amount do
    self:incorrectWord()
  end
end

function wordSet:incorrectWord()
  local word = randomWord()
  local currentWord = words[self.currentWord]
  -- check against currentWord, currentWord synonyms, and incorrectWords
  while self.currentWord == word or currentWord.synonyms[word] or table.includes(self.incorrectWords, word) do
    word = randomWord()
  end
  -- add to incorrectWords
  table.insert(self.incorrectWords, word)

  return word
end

function wordSet:shuffleOptions()
  options = { self.synonym, self.incorrectWords[1], self.incorrectWords[2] }
  return shuffle(options)
end

-- util
function shuffle(t)
  local n = #t
  while n > 1 do
    local k = love.math.random(1, n)
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
  return t
end

function table.includes(t, val)
  for i, v in ipairs(t) do
    if v == val then return true end
  end
  return false
end

function table.rando(t)
  local randomValue = love.math.random(1, #t)
  return t[randomValue]
end

function keys(t)
  local keys = {}
  for k, v in pairs(t) do
    table.insert(keys, k)
  end
  return keys
end

return wordSet
