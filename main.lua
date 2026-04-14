local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "XWARE Premium v5.0", LoadingTitle = "Combined Elite Hub"})

local ESPTab = Window:CreateTab("ESP & Timers", 4483362458)
local StealTab = Window:CreateTab("Stealer & Trade", 4483362458)
local MoveTab = Window:CreateTab("Movement", 4483362458)

-- 1. Large Base Timers (ESP)
ESPTab:CreateToggle({
    Name = "Show All Base Timers",
    CurrentValue = false,
    Callback = function(Value)
        _G.BaseESP = Value
        task.spawn(function()
            while _G.BaseESP do
                for _, base in pairs(workspace.Bases:GetChildren()) do
                    local timer = base:FindFirstChild("Timer", true) or base:FindFirstChild("Time", true)
                    if timer and not base:FindFirstChild("ESP_Tag") then
                        local bg = Instance.new("BillboardGui", base)
                        bg.Name = "ESP_Tag"
                        bg.AlwaysOnTop = true
                        bg.Size = UDim2.new(0, 200, 0, 50)
                        bg.ExtentsOffset = Vector3.new(0, 10, 0)
                        
                        local txt = Instance.new("TextLabel", bg)
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.Text = "BASE: " .. (timer.Text or "00:00")
                        txt.TextScaled = true
                        txt.TextColor3 = Color3.new(1, 0, 0)
                        txt.BackgroundTransparency = 1
                    end
                end
                task.wait(1)
            end
        end)
    end,
})

-- 2. Freeze Trade Timer
StealTab:CreateToggle({
    Name = "Freeze Trade Timer",
    CurrentValue = false,
    Callback = function(Value)
        _G.FreezeTrade = Value
        game:GetService("RunService").Stepped:Connect(function()
            if _G.FreezeTrade then
                local tradeUI = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TradeUI")
                if tradeUI then
                    local timer = tradeUI:FindFirstChild("Timer", true)
                    if timer then timer.Text = "10" end
                end
            end
        end)
    end,
})

-- 3. Meowl Stealer with ESP & Unlock
StealTab:CreateButton({
    Name = "Steal Meowl + Highlight",
    Callback = function()
        for _, base in pairs(workspace.Bases:GetChildren()) do
            local meowl = base:FindFirstChild("Meowl", true)
            if meowl then
                local hl = Instance.new("Highlight", meowl)
                hl.FillColor = Color3.fromRGB(255, 255, 0)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = meowl.CFrame
            end
        end
    end,
})

-- 4. TP Forward (Blink)
MoveTab:CreateButton({
    Name = "TP Forward (Blink Through Walls)",
    Callback = function()
        local root = game.Players.LocalPlayer.Character.HumanoidRootPart
        root.CFrame = root.CFrame * CFrame.new(0, 0, -15)
    end,
})

-- 5. Unlock All Base Gates
StealTab:CreateButton({
    Name = "Unlock All Base Gates",
    Callback = function()
        for _, base in pairs(workspace.Bases:GetChildren()) do
            local gate = base:FindFirstChild("Gate", true) or base:FindFirstChild("Door", true)
            if gate then
                gate.CanCollide = false
                gate.Transparency = 0.5
            end
        end
    end,
})
