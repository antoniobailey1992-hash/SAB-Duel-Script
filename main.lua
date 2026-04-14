local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Brainrot Hub v3.1", LoadingTitle = "Antonio's Private Hub"})

local Tab = Window:CreateTab("Auto-Steal", 4483362458)

-- Function to find YOUR specific base
local function getMyBase()
    -- Check common names like "Bases" or "PlayerBases"
    local basesFolder = workspace:FindFirstChild("Bases") or workspace:FindFirstChild("PlayerBases")
    if basesFolder then
        for _, base in pairs(basesFolder:GetChildren()) do
            -- Look for your name on the base sign or owner value
            if base:FindFirstChild("Owner") and (base.Owner.Value == game.Players.LocalPlayer.Name or base.Owner.Value == game.Players.LocalPlayer.UserId) then
                return base:GetModelCFrame()
            end
        end
    end
    return nil
end

-- Improved TP Logic
Tab:CreateToggle({
    Name = "Instant Base TP on Grab",
    CurrentValue = false,
    Callback = function(Value)
        _G.BaseTP = Value
        
        -- Check Character for the item (in case it doesn't go to backpack)
        game.Players.LocalPlayer.Character.ChildAdded:Connect(function(child)
            if _G.BaseTP and child:IsA("Tool") then
                local baseCF = getMyBase()
                if baseCF then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = baseCF
                    print("Grabbed item! TPing to Base...")
                end
            end
        end)
    end,
})
