-- Brainrot Hub v1.0
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Brainrot Hub",
   LoadingTitle = "Loading Duel System...",
   LoadingSubtitle = "by Antonio",
})

local MainTab = Window:CreateTab("Combat", 4483362458) -- Main Tab

-- 1. Fast Carrying & Speed
MainTab:CreateSlider({
   Name = "Carrying Speed",
   Range = {16, 100},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 35,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- 2. Semi-Invisible (Lagger Mode)
MainTab:CreateToggle({
   Name = "Semi-Invisible (Lag View)",
   CurrentValue = false,
   Callback = function(Value)
      local char = game.Players.LocalPlayer.Character
      for _, v in pairs(char:GetChildren()) do
         if v:IsA("BasePart") then
            v.Transparency = Value and 0.7 or 0
         end
      end
   end,
})

-- 3. Platform Fly
MainTab:CreateButton({
   Name = "Spawn Fly Platform",
   Callback = function()
      local p = Instance.new("Part", workspace)
      p.Size = Vector3.new(10, 1, 10)
      p.Anchored = true
      p.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
      -- Makes it follow player
      game:GetService("RunService").RenderStepped:Connect(function()
         p.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
      end)
   end,
})
