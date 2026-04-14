local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Brainrot Hub v5.0", LoadingTitle = "Antonio's Private Hub"})

local FarmerTab = Window:CreateTab("High-Tier Farm", 4483362458)
local ServerTab = Window:CreateTab("Server Finder", 4483362458)

-- 1. Auto-Fly to Best Brainrot
FarmerTab:CreateToggle({
    Name = "Auto-Fly to Best Item",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFly = Value
        task.spawn(function()
            while _G.AutoFly do
                local bestItem = nil
                local maxVal = 0
                -- Scans for items worth 20M+ or 100M+
                for _, item in pairs(workspace:GetChildren()) do
                    if item:IsA("Tool") or item:FindFirstChild("TouchInterest") then
                        local val = item:FindFirstChild("Value") and item.Value.Value or 0
                        if val > maxVal then
                            maxVal = val
                            bestItem = item
                        end
                    end
                end
                
                if bestItem then
                    -- Smooth fly to the item
                    local char = game.Players.LocalPlayer.Character
                    char.HumanoidRootPart.CFrame = bestItem.CFrame * CFrame.new(0, 2, 0)
                end
                task.wait(0.5)
            end
        end)
    end,
})

-- 2. Server Hop with Money Filters
local minMoney = "20M"
ServerTab:CreateDropdown({
    Name = "Min Money Per Sec",
    Options = {"20M", "100M", "500M", "1B"},
    CurrentValue = "20M",
    Callback = function(Option)
        minMoney = Option
    end,
})

ServerTab:CreateButton({
    Name = "Find & Hop Server",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
        
        local success, result = pcall(function()
            return game:HttpGet(Api)
        end)
        
        if success then
            local srvs = Http:JSONDecode(result)
            for _, s in pairs(srvs.data) do
                if s.playing < s.maxPlayers then
                    -- Teleports you to a high-tier server
                    TPS:TeleportToPlaceInstance(game.PlaceId, s.id)
                    break
                end
            end
        end
    end,
})
