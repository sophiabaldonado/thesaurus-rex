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

sed '$ s/.$//' jsonWordList.lua > tempfile.lua
rm jsonWordList.lua; mv tempfile.lua jsonWordList.lua

echo "]" >> jsonWordList.lua
echo "]]}" >> jsonWordList.lua
echo "return words" >> jsonWordList.lua

lua convertJsonToLua.lua
