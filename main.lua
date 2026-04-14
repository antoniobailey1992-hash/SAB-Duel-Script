local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Brainrot Hub v2.0", LoadingTitle = "Antonio's Private Hub"})

local Tab = Window:CreateTab("Auto-Farm", 4483362458)

-- 1. Improved Carrying Speed (Bypasses regular slow-down)
Tab:CreateToggle({
    Name = "Fast Carry (Always 35+ Speed)",
    CurrentValue = false,
    Callback = function(Value)
        _G.FastCarry = Value
        task.spawn(function()
            while _G.FastCarry do
                local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = 45 end -- Forces high speed even with items
                task.wait(0.1)
            end
        end)
    end,
})

-- 2. Auto-Play / Instant Steal (From the video)
Tab:CreateToggle({
    Name = "Instant Steal (Auto-Play)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoSteal = Value
        task.spawn(function()
            while _G.AutoSteal do
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name == "Brainrot" or v:FindFirstChild("TouchInterest") then
                        -- Teleports directly to item and back
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                        task.wait(0.1)
                    end
                end
                task.wait()
            end
        end)
    end,
})

-- 3. Base ESP & Timers
Tab:CreateToggle({
    Name = "Show Base Timers & ESP",
    CurrentValue = false,
    Callback = function(Value)
        -- Logic to find all Bases and put a visual timer over them
        for _, base in pairs(workspace.Bases:GetChildren()) do
            if Value then
                local bill = Instance.new("BillboardGui", base)
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.AlwaysOnTop = true
                local txt = Instance.new("TextLabel", bill)
                txt.Size = UDim2.new(1, 0, 1, 0)
                txt.Text = base.Name .. " Timer" -- Replace with actual base timer value
            end
        end
    end,
})

-- 4. Semi-Invisible Toggle
Tab:CreateToggle({
    Name = "Semi-Invisible (Ghost Mode)",
    CurrentValue = false,
    Callback = function(Value)
        for _, part in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then part.Transparency = Value and 0.5 or 0 end
        end
    end,
})
