-- Highlight Configuration
local TeamFillColor = Color3.fromRGB(0, 0, 255)  -- Blue for your team
local EnemyFillColor = Color3.fromRGB(255, 0, 0) -- Red for enemies
local DepthMode = "AlwaysOnTop"
local FillTransparency = 0.9
local OutlineColor = Color3.fromRGB(255, 255, 255)
local OutlineTransparency = 0.5

-- Essential Services
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local connections = {}

-- Storage for Highlights
local Storage = Instance.new("Folder")
Storage.Parent = CoreGui
Storage.Name = "Highlight_Storage"

-- Function to Update Highlight
local function updateHighlight(plr)
    local highlight = Storage:FindFirstChild(plr.Name)
    if highlight then
        if plr.Team == LocalPlayer.Team then
            highlight.FillColor = TeamFillColor
        else
            highlight.FillColor = EnemyFillColor
        end
    end
end

-- Function to Highlight Players
local function HighlightPlayer(plr)
    local highlight = Instance.new("Highlight")
    highlight.Name = plr.Name
    highlight.DepthMode = DepthMode
    highlight.FillTransparency = FillTransparency
    highlight.OutlineColor = OutlineColor
    highlight.OutlineTransparency = OutlineTransparency
    highlight.Parent = Storage

    local plrchar = plr.Character
    if plrchar then
        highlight.Adornee = plrchar
    end

    connections[plr] = plr.CharacterAdded:Connect(function(char)
        highlight.Adornee = char
        updateHighlight(plr)
    end)

    plr:GetPropertyChangedSignal("Team"):Connect(function()
        updateHighlight(plr)
    end)

    updateHighlight(plr)
end

-- Connect Player Adding Event
Players.PlayerAdded:Connect(HighlightPlayer)

-- Initial Highlight for Existing Players
for _, player in ipairs(Players:GetPlayers()) do
    HighlightPlayer(player)
end

-- Connect Player Removing Event
Players.PlayerRemoving:Connect(function(plr)
    local plrname = plr.Name
    if Storage:FindFirstChild(plrname) then
        Storage[plrname]:Destroy()
    end
    if connections[plr] then
        connections[plr]:Disconnect()
    end
end)
