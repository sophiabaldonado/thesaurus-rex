local saveToFile = require 'lib.saveTableToFile'
local wordListFormatter = {}
local words = {}
local syns = {}

function wordListFormatter:format(unformattedWords)
  for i,v in ipairs(unformattedWords) do
    for word,v in pairs(v) do
      words[word] = {}
      for key,val in pairs(v) do
        for kk,vv in pairs(val) do
          if (kk == 'syn') then
            for i,syn in ipairs(vv) do
              if (self:isSingleWord(syn)) then
                syns[syn] = 1
              end
            end
          end
        end
      end
      words[word]["synonyms"] = syns
      syns = {}
    end
  end
  self:saveWordList()
end

function wordListFormatter:saveWordList()
  wordList = words
end

function wordListFormatter:isSingleWord(str)
  for c in str:gmatch('%W') do
    return false
  end
  return true
end

return wordListFormatter
