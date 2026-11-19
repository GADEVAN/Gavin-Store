-- GAVIN STORE | Anime Dice (Safe UI Mode)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Fungsi biar GUI ga kehapus sama Anti-Cheat
local function getGui()
    local a = pcall(function() return game:GetService("CoreGui") end)
    if a then return game:GetService("CoreGui") end
    local b = pcall(function() return gethui() end)
    if b then return gethui() end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local Config = {
    AutoRoll = false,
    AutoCollect = false,
    RollDelay = 0.5
}

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GavinStore_AnimeDice"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = getGui()

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 200)
MainFrame.Position = UDim2.new(0, 20, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
Title.BorderSizePixel = 0
Title.Text = "GAVIN STORE | Anime Dice"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Parent = MainFrame

local function CreateToggle(name, layoutOrder)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Btn.BorderSizePixel = 0
    Btn.Text = name .. ": OFF"
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13
    Btn.LayoutOrder = layoutOrder
    Btn.Parent = MainFrame
    
    Btn.MouseButton1Click:Connect(function()
        Config[name] = not Config[name]
        Btn.Text = name .. ": " .. (Config[name] and "ON" or "OFF")
        Btn.BackgroundColor3 = Config[name] and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 60)
    end)
    return Btn
end

CreateToggle("AutoRoll", 1)
CreateToggle("AutoCollect", 2)

-- Loop Script
task.spawn(function()
    while task.wait(Config.RollDelay) do
        if Config.AutoRoll then
            local RollBtn = LocalPlayer.PlayerGui:FindFirstChild("ROLL", true) 
            if RollBtn and (RollBtn:IsA("TextButton") or RollBtn:IsA("ImageButton")) then
                RollBtn:Activate()
            end
        end
        
        if Config.AutoCollect then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:find("Drop") or v.Name:find("Gem") or v.Name:find("Coin")) then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        task.wait(0.05)
                    end
                end
            end
        end
    end
end)
