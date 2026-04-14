local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Brainrot Hub v6.0", LoadingTitle = "TikTok Edition Active"})

local StealTab = Window:CreateTab("Void Stealer", 4483362458)

-- 1. Void Stealer (Vacuum All Items)
StealTab:CreateToggle({
    Name = "Vacuum All Brainrots",
    CurrentValue = false,
    Callback = function(Value)
        _G.Vacuum = Value
        task.spawn(function()
            while _G.Vacuum do
                for _, item in pairs(workspace:GetChildren()) do
                    if item.Name == "Brainrot" or item:FindFirstChild("TouchInterest") then
                        -- Snaps item to you instead of you to item (harder to catch)
                        local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if root and item:IsA("BasePart") then
                            item.CFrame = root.CFrame
                        elseif item:IsA("Tool") and item:FindFirstChild("Handle") then
                            item.Handle.CFrame = root.CFrame
                        end
                    end
                end
                task.wait(0.3)
            end
        end)
    end,
})

-- 2. Anti-Void (Fly back if you fall)
StealTab:CreateToggle({
    Name = "Anti-Void Fall",
    CurrentValue = false,
    Callback = function(Value)
        _G.AntiVoid = Value
        task.spawn(function()
            while _G.AntiVoid do
                local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root and root.Position.Y < -10 then
                    root.Velocity = Vector3.new(0, 100, 0)
                    root.CFrame = root.CFrame * CFrame.new(0, 50, 0)
                end
                task.wait(0.5)
            end
        end)
    end,
})

-- 3. Instant Cash Collect (From the video)
StealTab:CreateButton({
    Name = "Collect All Cash Zones",
    Callback = function()
        for _, zone in pairs(workspace:GetDescendants()) do
            if zone.Name == "Collect" or zone.Name == "CashZone" then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, zone, 0)
                task.wait(0.05)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, zone, 1)
            end
        end
    end,
})
