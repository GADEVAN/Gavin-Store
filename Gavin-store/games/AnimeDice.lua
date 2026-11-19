-- GAVIN STORE | Anime Dice (Auto Clicker & Farm)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

local Config = {
    AutoRoll = false,
    AutoCollect = false,
    RollDelay = 0.1
}

-- 1. BIKIN UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GavinStore_AnimeDice"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

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

-- 2. LOGIKA LOOPING
task.spawn(function()
    while task.wait(Config.RollDelay) do
        if Config.AutoRoll then
            -- Simulasi pencet tombol Space (biasanya buat roll)
            local RollBtn = LocalPlayer.PlayerGui:FindFirstChild("ROLL", true) 
            if RollBtn and (RollBtn:IsA("TextButton") or RollBtn:IsA("ImageButton")) then
                RollBtn:Activate() -- Coba pencet UI
            else
                -- Kalau UI gagal, klik tengah layar
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2))
            end
        end
        
        if Config.AutoCollect then
            -- Teleport ke item drop (Gem/Coin/Drop)
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
