local wiki = {}

local HS = game:GetService("HttpService")
function wiki:random()
    local URL = "https://en.wikipedia.org/w/api.php?action=query&list=random&rnnamespace=0&rnlimit=1&format=json"
    local req = HS:JSONDecode(game:HttpGet(URL))

    return req['query']['random'][1]['title']
end
function wiki:search(Q)
    local S = ('https://en.wikipedia.org/w/api.php?list=search&srprop=&srlimit=1&srsearch='..Q..'&srinfo=suggestion&action=query&format=json')
    local req = HS:JSONDecode(game:HttpGet(S))

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
    local S = 'https://en.wikipedia.org/w/api.php?prop=extracts&explaintext=&titles='..title..'&exsentences='..N..'&action=query&format=json'
    local req = HS:JSONDecode(game:HttpGet(S))
    req = req['query']['pages'][ID]['extract']; 
    req = req:gsub('%b()',''); req = req:gsub('%s%s',' ') -- removes anything in parentheses 
                                                          -- this is personal preference and can easily be removed/commented out
    
    return req
end
getgenv()["wiki"] = wiki
