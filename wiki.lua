local wiki,ygo,food,song = {},{},{},{} -- this is so shit
local HS = game:GetService("HttpService")
local function get(URL)  return HS:JSONDecode(game:HttpGet(URL))  end

--[[

    WIKIPEDIA
    `` 
        dont remember where i got the wikipedia api
        but you could pretty much find the same thing in wikiPY
    ``
]]
function wiki:random()
    local req = get("https://en.wikipedia.org/w/api.php?action=query&list=random&rnnamespace=0&rnlimit=1&format=json")

    return req['query']['random'][1]['title']
end
function wiki:search(Q)
    local req = get(('https://en.wikipedia.org/w/api.php?list=search&srprop=&srlimit=1&srsearch='..Q..'&srinfo=suggestion&action=query&format=json'))

    return req['query']['search'][1]
end
function wiki:summary(Q, N) 
    N = N or 1 
    local sent = {}
    local info = wiki:search(Q)
    local title = info['title']
    title = title:gsub('%s+','+') -- makes it so "title" is easier to search up, not sure if i even need to do this tbh
                                  -- "Barack Obama" -> "Barack+Obama"
    local ID = info['pageid']
    ID = tostring(ID)
    local req = get('https://en.wikipedia.org/w/api.php?prop=extracts&explaintext=&titles='..title..'&exsentences='..N..'&action=query&format=json')
    req = req['query']['pages'][ID]['extract']; 
    req = req:gsub('%b()',''); req = req:gsub('%s%s',' ') -- removes anything in parentheses 
                                                          -- this is personal preference and can easily be removed/commented out
    
    return req
end
--[[

    YU-GI-OH
    ``
        thank you ygoprodeck
        find the website here:
            https://db.ygoprodeck.com/api-guide/
    ``

]]
function ygo:random() -- random card
    local DATA = {}
    local req = get('https://db.ygoprodeck.com/api/v7/randomcard.php')

    DATA["name"] = req["name"]
    DATA["type"] = req["type"]
    DATA["desc"] = req["desc"]
    return DATA
end

function ygo:card(NAME) -- only returns the FIRST result of what you typed in, full name or not
    NAME = NAME:gsub('%s+','+') -- remove spaces just in case
    local DATA = {}
    local req = get(("https://db.ygoprodeck.com/api/v7/cardinfo.php?fname="..NAME))

    DATA["name"] = req['data'][1]["name"]
    DATA["type"] = req['data'][1]["type"]
    DATA["desc"] = req['data'][1]["desc"]
    return DATA
end
--[[

FOOD
``
    thanks TheMealDB
    find them here:
        https://www.themealdb.com/
``

]]
function food:random() 
    local DATA = {}
    local req = get('https://www.themealdb.com/api/json/v1/1/random.php')
    local t = req['meals'][1]

    DATA["name"] = t['strMeal']
    DATA["instructions"] = t['strInstructions']
    return DATA
end --that was fast

--[[ 

SONG

]]
function song(NUM) -- i HATE YOU
	local random = Random.new()
	local id = NUM or math.floor(random:NextNumber(100000,1000000)); tostring(id);
	local url = "https://api.genius.com/songs/"..id.."?access_token="..auth_token
	local success, err = pcall(function() get(url) end)

    return get(url) 
end


--[[

FINALIZE

]]
getgenv()["wiki"] = wiki
getgenv()["ygo"] = ygo
getgenv()["food"] = food
getgenv()["song"] = song
