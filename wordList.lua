local json = require "lib.json"



list = {
  laugh = {
    synonyms = {
      giggle = 1,
      chuckle = 2
    }
  },

  giggle = {
    synonyms = {
      laugh = 1,
      chuckle = 2
    }
  },

  chuckle = {
    synonyms = {
      giggle = 1,
      laugh = 2
    }
  },

  sing = {
    synonyms = {
      croon = 1,
      serenade = 1
    }
  },

  croon = {
    synonyms = {
      sing = 1,
      serenade = 1
    }
  },

  serenade = {
    synonyms = {
      croon = 1,
      sing = 1
    }
  },

  kind = {
    synonyms = {
      amiable = 1,
      considerate = 1,
      tolerant = 3
    }
  },

  amiable = {
    synonyms = {
      kind = 1,
      considerate = 1,
      tolerant = 3
    }
  },

  considerate = {
    synonyms = {
      amiable = 1,
      kind = 1,
      tolerant = 3
    }
  },

  tolerant = {
    synonyms = {
      amiable = 1,
      considerate = 1,
      kind = 3
    }
  }
}

-- local words = {
--   {
--     word = 'one',
--     synonyms = {
--       'one1',
--       'one2',
--       'one3'
--     }
--   },
--   {
--     word = 'two',
--     synonyms = {
--       'two1',
--       'two2',
--       'two3'
--     }
--   },
--   {
--     word = 'three',
--     synonyms = {
--       'three1',
--       'three2',
--       'three3'
--     }
--   }
-- }
--
-- -- local j = get the json
--
-- -- local t = json.decode(j)
--
-- local function transformTable(t)
--   local l = {}
--   for i = 1, 3 do
--     local c = t[i]
--       l[c['word']] = { synonym = c['synonyms'] }
--   end
--   return l
-- end
--
-- local words = transformTable(t)
return list
