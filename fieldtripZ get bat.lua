local lp = game.Players.LocalPlayer
local Bat = game.Workspace.Interactions.Weapons.Bat
if fireclickdetector then
    fireclickdetector(Bat.ClickDetector)
else
    lp.Character.HumanoidRootPart.CFrame = Bat.CFrame
end