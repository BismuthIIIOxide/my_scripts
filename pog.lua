local PlaceId = game.PlaceId
local URL = ("https://www.roblox.com/games/getgameinstancesjson?placeId=%s&startindex="):format(PlaceId)
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
function ServerHop(MaxQueries, MaxPlayers, MinPlayers)
	local List = {}
	MaxQueries = (MaxQueries or 10) * 10
	
	for page = 0, MaxQueries do
		local Query = HttpService:JSONDecode(game:HttpGet(URL..page))
		
		if page % 10 == 0 then -- ask roblox, not me.
			for i,v in next, Query.Collection do 
				List[v.Guid] = {
					PlayerCount = #v.CurrentPlayers,
					IsSlow = v.ShowShutdownAllButton,
					Capacity = v.Capacity,
				}
			end
		end
	end

	local ChosenServer = nil

	for i,v in pairs(List) do
		if i ~= game.JobId then
			local MaxCheck = (MaxPlayers and v.PlayerCount <= MaxPlayers) or (not MaxPlayers and true)
			local MinCheck = (MinPlayers and v.PlayerCount >= MinPlayers) or (not MinPlayers and true)
			local CapacityCheck = v.Capacity ~= v.PlayerCount
			local SlowCheck = not v.IsSlow
			
			if MaxCheck and MinCheck and CapacityCheck and SlowCheck then
				ChosenServer = i
				break
			end
		end
	end

	if ChosenServer then
		TeleportService:TeleportToPlaceInstance(game.PlaceId, ChosenServer, game.Players.LocalPlayer)
	else
		print("Server Hop Failure, Could not find a server!")
	end
end

loadstring(game:HttpGet(('https://pastebin.com/raw/bVKcb9Es'),true))()
ServerHop(10, 18, 10)
syn.queue_on_teleport("loadstring(game:HttpGet(('https://pastebin.com/raw/sLb8ahzr'),true))()")
