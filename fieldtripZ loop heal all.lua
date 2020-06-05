while wait() do
    for i,v in pairs(game.Players:GetPlayers()) do
    local args = {
            [1]="HEAL_PLAYER",[2]=v,[3]=999999} 
        game:GetService("ReplicatedStorage").NetworkEvents.RemoteFunction:InvokeServer(unpack(args))
    end    
end
