local lp = game.Players.LocalPlayer
local vu = game:GetService("VirtualUser")
lp.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local char = lp.Character
local moves = {}
local client = game.ReplicatedStorage:WaitForChild(lp.UserId.."Client")
local StartMove = client.StartMove
local EndMove = client.EndMove
local NewMove = ""
local part = Instance.new("Part", workspace)
part.Anchored = true
part.Position = Vector3.new(700,200000,700)
part.Size = Vector3.new(200,1,200)
local function DoMove(move)
   StartMove:FireServer(move)
   wait()
   EndMove:FireServer(move)
end

for i, v in ipairs(lp.Backpack:GetChildren()) do
   table.insert(moves, v.Name)
end

while wait() do
   char.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0,2,0)
   for i, v in pairs(moves) do
       wait()
       DoMove(moves[i])
   end
   lp.Backpack.ChildAdded:Connect(function(new)
       if new.Name ~= NewMove then
           table.insert(moves, new.Name)
           NewMove = new.Name
       end
   end)
end

