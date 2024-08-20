-- Create the main screen GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local AimbotToggle = Instance.new("TextButton")
local IncreaseFOVButton = Instance.new("TextButton")
local DecreaseFOVButton = Instance.new("TextButton")
local IncreaseSmoothButton = Instance.new("TextButton")
local DecreaseSmoothButton = Instance.new("TextButton")
local SmoothnessLabel = Instance.new("TextLabel")
local FOVToggle = Instance.new("TextButton")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

-- Set up the ScreenGui
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "AimbotESPGui"

-- Set up the Frame
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Frame.Size = UDim2.new(0, 200, 0, 270)
Frame.Position = UDim2.new(0.5, -100, 0.5, -135)
Frame.Visible = true
Frame.Active = true
Frame.Draggable = true

-- Set up the Aimbot Toggle Button
AimbotToggle.Parent = Frame
AimbotToggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
AimbotToggle.Size = UDim2.new(0, 180, 0, 30)
AimbotToggle.Position = UDim2.new(0, 10, 0, 10)
AimbotToggle.Text = "Aimbot: Off"
AimbotToggle.TextColor3 = Color3.new(1, 1, 1)

-- Set up the Increase FOV Button
IncreaseFOVButton.Parent = Frame
IncreaseFOVButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
IncreaseFOVButton.Size = UDim2.new(0, 85, 0, 30)
IncreaseFOVButton.Position = UDim2.new(0, 10, 0, 80)
IncreaseFOVButton.Text = "+ FOV"
IncreaseFOVButton.TextColor3 = Color3.new(1, 1, 1)

-- Set up the Decrease FOV Button
DecreaseFOVButton.Parent = Frame
DecreaseFOVButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
DecreaseFOVButton.Size = UDim2.new(0, 85, 0, 30)
DecreaseFOVButton.Position = UDim2.new(0, 105, 0, 80)
DecreaseFOVButton.Text = "- FOV"
DecreaseFOVButton.TextColor3 = Color3.new(1, 1, 1)

-- Set up the Increase Smooth Button
IncreaseSmoothButton.Parent = Frame
IncreaseSmoothButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
IncreaseSmoothButton.Size = UDim2.new(0, 85, 0, 30)
IncreaseSmoothButton.Position = UDim2.new(0, 10, 0, 115)
IncreaseSmoothButton.Text = "+ Smooth"
IncreaseSmoothButton.TextColor3 = Color3.new(1, 1, 1)

-- Set up the Decrease Smooth Button
DecreaseSmoothButton.Parent = Frame
DecreaseSmoothButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
DecreaseSmoothButton.Size = UDim2.new(0, 85, 0, 30)
DecreaseSmoothButton.Position = UDim2.new(0, 105, 0, 115)
DecreaseSmoothButton.Text = "- Smooth"
DecreaseSmoothButton.TextColor3 = Color3.new(1, 1, 1)

-- Set up the Smoothness Label
SmoothnessLabel.Parent = Frame
SmoothnessLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
SmoothnessLabel.Size = UDim2.new(0, 180, 0, 30)
SmoothnessLabel.Position = UDim2.new(0, 10, 0, 150)
SmoothnessLabel.Text = "Smoothness: 1"
SmoothnessLabel.TextColor3 = Color3.new(1, 1, 1)
SmoothnessLabel.TextScaled = true
SmoothnessLabel.TextStrokeTransparency = 0.5

-- Set up the FOV Toggle Button
FOVToggle.Parent = Frame
FOVToggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
FOVToggle.Size = UDim2.new(0, 180, 0, 30)
FOVToggle.Position = UDim2.new(0, 10, 0, 185)
FOVToggle.Text = "FOV Circle: On"
FOVToggle.TextColor3 = Color3.new(1, 1, 1)

-- Function to toggle the Frame's visibility with the right shift key
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Frame.Visible = not Frame.Visible
    end
end)

-- Variables for the aimbot
local aimbotEnabled = false
local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Color = Color3.new(1, 0, 0)
fovCircle.Thickness = 2
fovCircle.NumSides = 32
fovCircle.Radius = 150
fovCircle.Filled = false

local smoothness = 1 -- Smoothing factor
local rightMouseDown = false

-- Function to get the closest player
local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Team ~= Players.LocalPlayer.Team and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local screenPos = Camera:WorldToViewportPoint(head.Position)
            local distanceFromMouse = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            local distanceFromPlayer = (head.Position - Players.LocalPlayer.Character.Head.Position).Magnitude

            if distanceFromMouse <= fovCircle.Radius and distanceFromPlayer < shortestDistance then
                shortestDistance = distanceFromPlayer
                closestPlayer = player
            end
        end
    end

    return closestPlayer
end

-- Function to aim at a target
local function AimAt(target)
    if target and target.Character and target.Character:FindFirstChild("Head") then
        local head = target.Character.Head
        local targetPosition = head.Position
        local cameraPosition = Camera.CFrame.Position

        -- Smoothly move the camera towards the target position
        local lookAtPosition = CFrame.new(cameraPosition, targetPosition)
        local newCFrame = Camera.CFrame:Lerp(lookAtPosition, 1 / smoothness)
        Camera.CFrame = newCFrame
    end
end

-- Aimbot toggle logic
AimbotToggle.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotToggle.Text = aimbotEnabled and "Aimbot: On" or "Aimbot: Off"
    fovCircle.Visible = aimbotEnabled and FOVToggle.Text == "FOV Circle: On"
end)

-- FOV circle toggle logic
FOVToggle.MouseButton1Click:Connect(function()
    fovCircle.Visible = not fovCircle.Visible
    FOVToggle.Text = fovCircle.Visible and "FOV Circle: On" or "FOV Circle: Off"
end)

-- Track right mouse button state
Mouse.Button2Down:Connect(function()
    rightMouseDown = true
end)

Mouse.Button2Up:Connect(function()
    rightMouseDown = false
end)

-- Update the aimbot logic
RunService.RenderStepped:Connect(function()
    if aimbotEnabled and rightMouseDown then
        local closestPlayer = GetClosestPlayer()
        if closestPlayer then
            AimAt(closestPlayer)
        end
    end

    if fovCircle.Visible then
        fovCircle.Position = Vector2.new(Mouse.X, Mouse.Y)
    end
end)

-- Adjust FOV circle radius
IncreaseFOVButton.MouseButton1Click:Connect(function()
    fovCircle.Radius = fovCircle.Radius + 10
end)

DecreaseFOVButton.MouseButton1Click:Connect(function()
    fovCircle.Radius = math.max(fovCircle.Radius - 10, 10)
end)

-- Adjust Smoothness
IncreaseSmoothButton.MouseButton1Click:Connect(function()
    smoothness = math.min(smoothness + 1, 10)
    SmoothnessLabel.Text = "Smoothness: " .. string.format("%.1f", smoothness)
end)

DecreaseSmoothButton.MouseButton1Click:Connect(function()
    smoothness = math.max(smoothness - 1, 1)
    SmoothnessLabel.Text = "Smoothness: " .. string.format("%.1f", smoothness)
end)
