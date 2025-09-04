--// NoxLera Hack Menu - Birleştirilmiş ve Güvenli Infinity Jump
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NoxLeraGui"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Frame (Ana Menü)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 180, 0, 220)
Frame.Position = UDim2.new(1, -190, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Active = true
Frame.ClipsDescendants = true
Frame.BorderSizePixel = 0
Frame.Name = "MainFrame"
local corner = Instance.new("UICorner", Frame)
corner.CornerRadius = UDim.new(0, 10)
local hiddenPosition = UDim2.new(1, 0, 0.2, 0)
local shownPosition = UDim2.new(1, -190, 0.2, 0)
Frame.Position = hiddenPosition

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "NoxLeraX"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold

-- Layout
local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Buton oluşturma
local function createButton(name, callback)
    local btn = Instance.new("Frame", Frame)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.BorderSizePixel = 0
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 6)
    local label = Instance.new("TextLabel", btn)
    label.Size = UDim2.new(1, -35, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    local box = Instance.new("Frame", btn)
    box.Size = UDim2.new(0, 20, 0, 20)
    box.Position = UDim2.new(1, -25, 0.5, -10)
    box.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    local border = Instance.new("UIStroke", box)
    border.Color = Color3.fromRGB(0, 0, 0)
    border.Thickness = 2
    local boxCorner = Instance.new("UICorner", box)
    boxCorner.CornerRadius = UDim.new(0, 4)
    local state = false
    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            state = not state
            box.BackgroundColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            callback(state)
        end
    end)
end

----------------------------------------------------------------
-- Hile Fonksiyonları
----------------------------------------------------------------

-- Player ESP (Pelerin gözükmezlik koruması)
local function toggleESP(state)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if state then
                if not plr.Character:FindFirstChild("NoxLera_HL") then
                    local highlight = Instance.new("Highlight", plr.Character)
                    highlight.Name = "NoxLera_HL"
                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    highlight.FillTransparency = 0.7
                    highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
                    highlight.OutlineTransparency = 0
                    highlight.Adornee = plr.Character
                end
                -- İsim etiketi
                local head = plr.Character:FindFirstChild("Head")
                if head and not head:FindFirstChild("NoxLera_BB") then
                    local billboard = Instance.new("BillboardGui", head)
                    billboard.Name = "NoxLera_BB"
                    billboard.Size = UDim2.new(0, 200, 0, 30)
                    billboard.AlwaysOnTop = true
                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                    local label = Instance.new("TextLabel", billboard)
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    label.TextStrokeTransparency = 0
                    label.TextScaled = true
                    label.Text = plr.Name
                end
            else
                if plr.Character:FindFirstChild("NoxLera_HL") then plr.Character.NoxLera_HL:Destroy() end
                local head = plr.Character:FindFirstChild("Head")
                if head and head:FindFirstChild("NoxLera_BB") then head.NoxLera_BB:Destroy() end
            end
        end
    end
end

-- Infinity Jump (Geliştirilmiş ve Güvenli)
local infJumpEnabled = false
local jumpCooldown = false
local function toggleInfJump(state)
    infJumpEnabled = state
end
UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and not jumpCooldown then
            jumpCooldown = true
            humanoid.Health = math.max(humanoid.Health, 20)
            humanoid:ChangeState("Jumping")
            task.delay(0.2, function()
                jumpCooldown = false
            end)
        end
    end
end)

-- Speed Hack
local speedEnabled = false
local speedValue = 41
local speedConn
local function toggleSpeed(state)
    speedEnabled = state
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if state then
        if humanoid then humanoid.WalkSpeed = speedValue end
        speedConn = RunService.RenderStepped:Connect(function()
            if speedEnabled and humanoid and humanoid.WalkSpeed ~= speedValue then
                humanoid.WalkSpeed = speedValue
            end
        end)
    else
        if humanoid then humanoid.WalkSpeed = 16 end
        if speedConn then speedConn:Disconnect() end
    end
end

----------------------------------------------------------------
-- Butonlar
----------------------------------------------------------------
createButton("Player ESP", toggleESP)
createButton("Speed Hack", toggleSpeed)
createButton("Infinity Jump", toggleInfJump)

-- Menü aç/kapa (sağ Ctrl)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        local target = (Frame.Position == hiddenPosition) and shownPosition or hiddenPosition
        TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = target}):Play()
    end
end)