-- GAVIN STORE: Anime Dice (Test Auto Roll)
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "GavinStoreAnimeDice"
gui.Parent = player:WaitForChild("PlayerGui")

local btn = Instance.new("TextButton")
btn.Parent = gui
btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0, 20, 0, 100)
btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 16
btn.Text = "Auto Roll: OFF"

local autoRoll = false
local VirtualUser = game:GetService("VirtualUser")

btn.MouseButton1Click:Connect(function()
    autoRoll = not autoRoll
    if autoRoll then
        btn.Text = "Auto Roll: ON"
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    else
        btn.Text = "Auto Roll: OFF"
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if autoRoll then
        -- Simulasi pencetan tombol Space/Roll
        VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera)
        VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera)
        task.wait(0.5) 
    end
end)
