-- GAVIN STORE | Anime Dice Premium Edition
-- Extracted & Rebuilt for Maximum Performance

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

local Config = {
    AutoRoll = false,
    AutoCollect = false,
    AutoPlace = false,
    AutoUpgrade = false,
    AutoRebirth = false,
    AutoFuse = false,
    AntiAFK = true,
    RollDelay = 0.1
}

-- 1. ANTI-AFK (Biar ga kick)
LocalPlayer.Idled:Connect(function()
    if Config.AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- 2. UI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GavinStore_Premium"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 380)
MainFrame.Position = UDim2.new(0, 20, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Title.BorderSizePixel = 0
Title.Text = "GAVIN STORE | Anime Dice"
Title.TextColor3 = Color3.fromRGB(255, 105, 180)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Parent = MainFrame

-- Helper: Bikin Toggle Button
local function CreateToggle(name, displayName, order)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Btn.BorderSizePixel = 0
    Btn.Text = displayName .. " [OFF]"
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13
    Btn.LayoutOrder = order
    Btn.Parent = MainFrame
    
    local BtnCorner = Instance.new("UICorner", Btn)
    BtnCorner.CornerRadius = UDim.new(0, 6)

    Btn.MouseButton1Click:Connect(function()
        Config[name] = not Config[name]
        Btn.Text = displayName .. (Config[name] and " [ON]" or " [OFF]")
        Btn.BackgroundColor3 = Config[name] and Color3.fromRGB(255, 105, 180) or Color3.fromRGB(35, 35, 45)
        Btn.TextColor3 = Config[name] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    end)
end

CreateToggle("AutoRoll", "Auto Roll", 1)
CreateToggle("AutoCollect", "Auto Collect", 2)
CreateToggle("AutoPlace", "Auto Place Best", 3)
CreateToggle("AutoUpgrade", "Auto Upgrade", 4)
CreateToggle("AutoRebirth", "Auto Rebirth", 5)
CreateToggle("AutoFuse", "Auto Fuse", 6)

-- Helper: Cari dan Klik tombol berdasarkan nama
local function ClickButton(name)
    local gui = LocalPlayer.PlayerGui
    local btn = gui:FindFirstChild(name, true)
    if btn and (btn:IsA("TextButton") or btn:IsA("ImageButton")) then
        btn:Activate()
        return true
    end
    return false
end

-- 3. LOGIKA UTAMA (GABUNGAN SEMUA FITUR)
task.spawn(function()
    while task.wait(Config.RollDelay) do
        local char = LocalPlayer.Character
        if not char then continue end

        if Config.AutoRoll then
            if not ClickButton("ROLL") then
                -- Fallback simulasi pencetan keyboard
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(workspace.CurrentCamera.ViewportSize / 2)
            end
        end

        if Config.AutoCollect then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:find("Gem") or v.Name:find("Coin") or v.Name:find("Drop") or v.Name:find("Cash")) then
                    if char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = v.CFrame
                        task.wait(0.05)
                    end
                end
            end
        end

        if Config.AutoUpgrade then
            ClickButton("Upgrades")
            ClickButton("Upgrade")
        end

        if Config.AutoRebirth then
            ClickButton("Rebirth")
        end
        
        if Config.AutoPlace then
            ClickButton("Place")
            ClickButton("Auto Place")
        end
        
        if Config.AutoFuse then
            ClickButton("Fuse")
        end
    end
end)

print("[GAVIN STORE] Premium Anime Dice Script Loaded Successfully!")
