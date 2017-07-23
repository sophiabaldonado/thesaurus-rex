local wordListFormatter = {}
local words = {}
local syns = {}
local inspect = require ('inspect')

function wordListFormatter:format(unformattedWords)
  for i,v in ipairs(unformattedWords) do
    for word,v in pairs(v) do
      for key,val in pairs(v) do
        for kk,vv in pairs(val) do
		  if kk == 'syn' and #vv > 0 then
            for i,syn in ipairs(vv) do
              if (self:isSingleWord(syn)) then
                words[word] = {}
                syns[self:validWord(syn)] = 1
              end
            end
          end
        end
      end
      if (words[word]) then
        words[word]["synonyms"] = syns
      end
      syns = {}
    end
  end
  return words
end

function wordListFormatter:isSingleWord(str)
  for c in str:gmatch('%W') do
    return false
  end
  return true
end

function wordListFormatter:validWord(word)
  local keywords = {'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for', 'function', 'if', 'in', 'local', 'nil', 'not', 'or', 'repeat', 'return', 'then', 'true', 'until', 'while'}

  result = self:isKeyword(keywords, word) and '['.. word ..']' or word
  print(result)

  return result
end

function wordListFormatter:isKeyword(table, word)
  for i,v in ipairs(table) do
    if word == v then
      print(word)
      return true
    end
  end
  return false
end

return wordListFormatter
