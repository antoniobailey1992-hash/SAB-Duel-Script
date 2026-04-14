local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Brainrot Hub v4.0", LoadingTitle = "Antonio's Private Hub"})

local Tab = Window:CreateTab("Main Ops", 4483362458)

-- 1. Server Hopper (Money Filter)
Tab:CreateButton({
    Name = "Server Hop (High Money Servers)",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
        local _srv = Http:JSONDecode(game:HttpGet(Api))
        for _, s in pairs(_srv.data) do
            if s.playing < s.maxPlayers then
                TPS:TeleportToPlaceInstance(game.PlaceId, s.id)
            end
        end
    end,
})

-- 2. Two-Point Teleport (Set your own Base Point)
local PointA = nil
Tab:CreateButton({
    Name = "Set Return Point (Base)",
    Callback = function()
        PointA = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        Rayfield:Notify({Title = "Point Set!", Content = "Return point saved."})
    end,
})

Tab:CreateButton({
    Name = "TP to Return Point",
    Callback = function()
        if PointA then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = PointA
        end
    end,
})

-- 3. Desync Lag Mode (Visual Jumps)
Tab:CreateToggle({
    Name = "Desync Lag Mode",
    CurrentValue = false,
    Callback = function(Value)
        _G.Desync = Value
        task.spawn(function()
            while _G.Desync do
                local root = game.Players.LocalPlayer.Character.HumanoidRootPart
                -- Rapidly shifts position to look laggy to others
                local oldCF = root.CFrame
                root.CFrame = oldCF * CFrame.new(math.random(-10,10), 0, math.random(-10,10))
                task.wait(0.1)
                root.CFrame = oldCF
                task.wait(4.9) -- Jumps every 5 seconds as requested
            end
        end)
    end,
})

-- 4. Phase Through Lasers (Noclip)
Tab:CreateToggle({
    Name = "Phase (Noclip Lasers)",
    CurrentValue = false,
    Callback = function(Value)
        _G.Noclip = Value
        game:GetService("RunService").Stepped:Connect(function()
            if _G.Noclip then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end
        end)
    end,
})

-- 5. Enhanced Carrying Speed
Tab:CreateToggle({
    Name = "Infinite Carry Speed",
    CurrentValue = false,
    Callback = function(Value)
        _G.FastCarry = Value
        task.spawn(function()
            while _G.FastCarry do
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 60
                task.wait(0.1)
            end
        end)
    end,
})
