local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "XWARE Spawner v2.0", LoadingTitle = "Premium Visuals Active"})

local SpawnerTab = Window:CreateTab("Spawner", 4483362458)
local BaseTab = Window:CreateTab("Base Skins", 4483362458)

-- 1. XWARE Brainrot Spawner (Visual Only)
SpawnerTab:CreateDropdown({
    Name = "Select Secret Brainrot",
    Options = {"Strawberry Elephant", "Sammy ni Fattini", "Nacho Spyder", "Rosetti Tualetti", "OG Secret"},
    CurrentValue = "Strawberry Elephant",
    Callback = function(Option)
        _G.SelectedBrainrot = Option
    end,
})

SpawnerTab:CreateButton({
    Name = "Spawn on Carpet",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        -- Spawns the visual item exactly where the "carpet" usually is
        local visual = Instance.new("Part", workspace)
        visual.Name = "Visual_Secret"
        visual.Size = Vector3.new(4, 4, 4)
        visual.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, -2, -6)
        visual.Material = Enum.Material.Neon
        
        -- Color coding based on the rare item
        if _G.SelectedBrainrot == "Strawberry Elephant" then
            visual.Color = Color3.fromRGB(255, 50, 50)
        elseif _G.SelectedBrainrot == "Sammy ni Fattini" then
            visual.Color = Color3.fromRGB(255, 215, 0)
        else
            visual.Color = Color3.fromRGB(200, 0, 255)
        end
        
        -- Secret sparkle effect
        local p = Instance.new("ParticleEmitter", visual)
        p.Texture = "rbxassetid://2430536442"
        p.Rate = 120
    end,
})

-- 2. Base Material Overrides
BaseTab:CreateDropdown({
    Name = "Skin Your Base",
    Options = {"Lava", "Galaxy", "Yin Yang", "Radioactive", "Gold", "Diamond", "Cursed Candy", "Aquatic", "Halloween"},
    CurrentValue = "Galaxy",
    Callback = function(Option)
        -- Finds your specific base to apply the visual skin
        for _, base in pairs(workspace.Bases:GetChildren()) do
            if base:FindFirstChild("Owner") and base.Owner.Value == game.Players.LocalPlayer.Name then
                for _, part in pairs(base:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if Option == "Lava" then part.Material = "Neon" part.Color = Color3.fromRGB(255, 50, 0)
                        elseif Option == "Galaxy" then part.Material = "ForceField" part.Color = Color3.fromRGB(120, 0, 255)
                        elseif Option == "Radioactive" then part.Material = "Neon" part.Color = Color3.fromRGB(100, 255, 100)
                        elseif Option == "Cursed Candy" then part.Material = "Glitch" part.Color = Color3.fromRGB(255, 0, 150)
                        elseif Option == "Halloween" then part.Material = "Wood" part.Color = Color3.fromRGB(255, 120, 0)
                        end
                    end
                end
            end
        end
    end,
})
