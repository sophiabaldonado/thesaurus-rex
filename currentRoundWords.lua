local words = require 'wordList'
local currentRoundWords = {}

function currentRoundWords:new()
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

function currentRoundWords:currentSynonym()
  local currentWord = words[self.currentWord]
  local syns = keys(currentWord.synonyms)
  local randomSynonym = table.rando(syns)

  return randomSynonym
end

function currentRoundWords:populateIncorrectWords(amount)
  for i = 1, amount do
    self:incorrectWord()
  end
end

function currentRoundWords:incorrectWord()
  local word = randomWord()
  local currentWord = words[self.currentWord]
  while self.currentWord == word or currentWord.synonyms[word] or table.includes(self.incorrectWords, word) do
    word = randomWord()
  end
  table.insert(self.incorrectWords, word)

  return word
end

function currentRoundWords:shuffleOptions()
  options = { self.synonym, self.incorrectWords[1], self.incorrectWords[2] }
  return shuffle(options)
end

return currentRoundWords
