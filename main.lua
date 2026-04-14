local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Brainrot Hub v3.0", LoadingTitle = "Antonio's Private Hub"})

local Tab = Window:CreateTab("Auto-Steal", 4483362458)

-- 1. Find Your Base
local function getMyBase()
    for _, base in pairs(workspace.Bases:GetChildren()) do
        if base:FindFirstChild("Owner") and base.Owner.Value == game.Players.LocalPlayer.Name then
            return base.PrimaryPart.CFrame
        end
    end
    return nil
end

-- 2. TP Back to Base Logic (Nothing stops you)
Tab:CreateToggle({
    Name = "Instant Base TP on Grab",
    CurrentValue = false,
    Callback = function(Value)
        _G.BaseTP = Value
        game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(child)
            if _G.BaseTP and child:IsA("Tool") then
                local baseCF = getMyBase()
                if baseCF then
                    -- Forces teleport regardless of speed or weight
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = baseCF
                end
            end
        end)
    end,
})

-- 3. Anti-Hit / Desync (From the video)
Tab:CreateToggle({
    Name = "Anti-Hit (Desync)",
    CurrentValue = false,
    Callback = function(Value)
        _G.Desync = Value
        task.spawn(function()
            while _G.Desync do
                local char = game.Players.LocalPlayer.Character
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    -- Rapidly shifts your hitbox locally so players can't hit you
                    root.CFrame = root.CFrame * CFrame.new(0, 0.05, 0)
                    task.wait()
                    root.CFrame = root.CFrame * CFrame.new(0, -0.05, 0)
                end
                task.wait(0.1)
            end
        end)
    end,
})

-- 4. Speed & Flight (Enhanced)
Tab:CreateToggle({
    Name = "God Speed & Fly",
    CurrentValue = false,
    Callback = function(Value)
        _G.FlySpeed = Value
        local hum = game.Players.LocalPlayer.Character.Humanoid
        if Value then
            hum.WalkSpeed = 100
            -- Adds a platform below you for flying
            local p = Instance.new("Part", workspace)
            p.Size = Vector3.new(8, 1, 8)
            p.Anchored = true
            p.Transparency = 0.8
            game:GetService("RunService").RenderStepped:Connect(function()
                if _G.FlySpeed then
                    p.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
                else
                    p:Destroy()
                end
            end)
        else
            hum.WalkSpeed = 16
        end
    end,
})
