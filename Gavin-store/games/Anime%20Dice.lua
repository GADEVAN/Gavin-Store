-- GAVIN STORE | Anime Dice Auto Farm
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Config = {
    AutoRoll = false,
    AutoCollect = false,
    AutoRebirth = false,
    AutoUpgrade = false,
    RollDelay = 0.5
}

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GavinStore_AnimeDice"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 280)
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
CreateToggle("AutoRebirth", 3)
CreateToggle("AutoUpgrade", 4)

-- Logic / Simulasi Klik
local VirtualUser = game:GetService("VirtualUser")

local function FireClick()
    VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera)
    VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera)
end

-- Loop Script
task.spawn(function()
    while task.wait(Config.RollDelay) do
        if Config.AutoRoll then
            -- Cari tombol Roll (biasanya di UI atau trigger via keyboard)
            -- Simulasi pencetan tombol 'R' atau spasi
            local RollBtn = LocalPlayer.PlayerGui:FindFirstChild("Roll", true)
            if RollBtn and RollBtn:IsA("TextButton") then
                RollBtn:Click()
            else
                -- Fallback: pake VirtualUser klik tengah layar
                FireClick()
            end
        end
        
        if Config.AutoCollect then
            -- Logic auto collect (mencari drop item)
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("Model") and (v.Name:find("Drop") or v.Name:find("Gem") or v.Name:find("Coin")) then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = v:GetPivot()
                    task.wait(0.1)
                end
            end
        end

        if Config.AutoRebirth then
            local RebirthBtn = LocalPlayer.PlayerGui:FindFirstChild("Rebirth", true)
            if RebirthBtn and RebirthBtn:IsA("TextButton") then
                RebirthBtn:Click()
            end
        end
        
        if Config.AutoUpgrade then
            local UpgradeBtn = LocalPlayer.PlayerGui:FindFirstChild("Upgrades", true)
            if UpgradeBtn and UpgradeBtn:IsA("TextButton") then
                UpgradeBtn:Click()
            end
        end
    end
end)

print("[GAVIN STORE] Anime Dice Loaded Successfully.")
