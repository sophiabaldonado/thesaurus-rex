local json = require 'json'
words = {[[
[
{
"laugh" : {"noun":{"syn":["laughter","joke","gag","jest","jape","facial expression","facial gesture","humor","humour","utterance","vocalization","wit","witticism","wittiness"]},"verb":{"syn":["express joy","express mirth","express emotion","express feelings"],"ant":["cry"],"rel":["laugh at","laugh away","laugh off"]}}
},
{
"giggle" : {"noun":{"syn":["laugh","laughter"]},"verb":{"syn":["titter","express joy","express mirth","laugh"]}}
},
{
"chuckle" : {"noun":{"syn":["chortle","laugh","laughter"]},"verb":{"syn":["chortle","laugh softly","express joy","express mirth","laugh"]}}
},
{
"sing" : {"verb":{"syn":["sing","whistle","spill the beans","let the cat out of the bag","talk","tattle","blab","peach","babble","babble out","blab out","break","bring out","disclose","discover","divulge","emit","expose","give away","go","impart","interpret","let loose","let on","let out","mouth","render","reveal","sound","speak","unwrap","utter","verbalise","verbalize"],"ant":["keep quiet"]}}
},
{
"croon" : {"verb":{"syn":["sing"],"usr":["hum"]}}
},
{
"serenade" : {"noun":{"syn":["divertimento","composition","musical composition","opus","piece","piece of music","song","vocal"]},"verb":{"syn":["do","execute","perform"]}}
},
{
"kind" : {"adjective":{"syn":["genial","tolerant"],"ant":["unkind"],"rel":["benign","benignant","considerate","good-natured","merciful","soft"],"sim":["benevolent","benign","benignant","charitable","forgiving","gentle","good-hearted","gracious","hospitable","kind-hearted","kindhearted","kindly","large-hearted","openhearted","sympathetic"]},"noun":{"syn":["sort","form","variety","category"]}}
},
{
"amiable" : {"adjective":{"syn":["good-humored","good-humoured","affable","cordial","genial"],"sim":["friendly","good-natured"]}}
},
{
"considerate" : {"adjective":{"ant":["inconsiderate"],"rel":["kind","tactful","unselfish"],"sim":["thoughtful"]}}
},
{
"tolerant" : {"adjective":{"syn":["kind","broad","large-minded","liberal","resistant","patient of"],"ant":["intolerant"],"rel":["charitable","patient"],"sim":["broad-minded","forgiving","patient","tolerable","unbigoted"]}}
}
]
]]}
luaWords = json.decode(words[1])
print (luaWords[1])
