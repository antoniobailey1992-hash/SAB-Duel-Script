local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Brainrot Hub v9.0", LoadingTitle = "OG Visuals Active"})

local BaseTab = Window:CreateTab("Base Skins", 4483362458)
local RareTab = Window:CreateTab("Rare Visuals", 4483362458)

-- Function to find YOUR base parts
local function getMyBaseParts()
    for _, base in pairs(workspace.Bases:GetChildren()) do
        if base:FindFirstChild("Owner") and base.Owner.Value == game.Players.LocalPlayer.Name then
            return base:GetDescendants()
        end
    end
    return {}
end

-- 1. Base Skin Changer (Visual Only)
BaseTab:CreateDropdown({
    Name = "Select Base Theme",
    Options = {"Lava", "Galaxy", "Yin Yang", "Radioactive", "Gold", "Diamond", "Cursed Candy", "Aquatic"},
    CurrentValue = "Gold",
    Callback = function(Option)
        local parts = getMyBaseParts()
        for _, v in pairs(parts) do
            if v:IsA("BasePart") then
                if Option == "Lava" then v.Material = Enum.Material.Neon v.Color = Color3.fromRGB(255, 60, 0)
                elseif Option == "Galaxy" then v.Material = Enum.Material.ForceField v.Color = Color3.fromRGB(100, 0, 255)
                elseif Option == "Radioactive" then v.Material = Enum.Material.Neon v.Color = Color3.fromRGB(50, 255, 50)
                elseif Option == "Gold" then v.Material = Enum.Material.Metal v.Color = Color3.fromRGB(255, 215, 0)
                elseif Option == "Diamond" then v.Material = Enum.Material.Glass v.Color = Color3.fromRGB(0, 255, 255)
                elseif Option == "Yin Yang" then v.Material = Enum.Material.SmoothPlastic v.Color = Color3.fromRGB(255, 255, 255)
                end
            end
        end
    end,
})

-- 2. Spawn Visual Rare Item on Carpet
RareTab:CreateButton({
    Name = "Spawn OG Secret (Visual Only)",
    Callback = function()
        local carpet = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, -5)
        local visual = Instance.new("Part", workspace)
        visual.Name = "Visual_OG"
        visual.Size = Vector3.new(3, 3, 3)
        visual.CFrame = carpet
        visual.Material = Enum.Material.Neon
        visual.Color = Color3.fromRGB(255, 0, 255)
        
        -- Add Secret Sparkles
        local p = Instance.new("ParticleEmitter", visual)
        p.Texture = "rbxassetid://2430536442"
        p.LightEmission = 1
        p.Rate = 100
    end,
})
