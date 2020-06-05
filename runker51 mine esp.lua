local minesFOLDER = game:GetService("Workspace").CRITICAL.Mines

for i, v in pairs(minesFOLDER:GetChildren()) do
    local p = Instance.new("Part", v)
    p.Position = v.Position
    p.Transparency = 0
    p.Color = Color3.new(1, 1, 1)
    p.Material = Enum.Material.Neon
end

while wait(.5) do
    game.Workspace.ChildAdded:Connet(function(v)
        if v.Name == "Mine" then
            local p = Instance.new("Part", v)
            p.Position = v.Position
            p.Transparency = 0
            p.Color = Color3.new(1, 1, 1)
            p.Material = Enum.Material.Neon
        end
    end)
end
