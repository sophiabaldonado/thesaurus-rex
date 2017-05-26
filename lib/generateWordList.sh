## declare an array variable
declare -a words=("laugh" "giggle" "chuckle" "sing" "croon" "serenade" "kind" "amiable" "considerate" "tolerant")

echo "words = {[[" > jsonWordList.lua
echo "[" >> jsonWordList.lua
for word in "${words[@]}"
do
  echo "{" >> jsonWordList.lua
  key="$word"
  value=$(curl http://words.bighugelabs.com/api/2/fcbea6affd593d12d0ef06f6f80da3b7/${word}/json)
  kvpair="\"${key}\""" : ""${value}"
  echo "${kvpair}" >> jsonWordList.lua
  echo "}," >> jsonWordList.lua
done

sleep 4s
sed '$ s/.$//' jsonWordList.lua > tempfile.lua
rm jsonWordList.lua; mv tempfile.lua jsonWordList.lua

sleep 1s
echo "]" >> jsonWordList.lua
echo "]]}" >> jsonWordList.lua

echo "local json = require 'json'" > convertJsonToLua.lua

cat jsonWordList.lua >> convertJsonToLua.lua
sleep 1s

echo "luaWords = json.decode(words[1])" >> convertJsonToLua.lua
echo "return luaWords" >> convertJsonToLua.lua

sleep 2s
lua convertJsonToLua.lua
