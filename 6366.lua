-- ============================================================
-- 优化版卡密验证系统
-- ============================================================
local correctKey = "ksnb"
local isVerified = false
local attempts = 0
local maxAttempts = 3

local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function getRainbowColor(speed)
    return Color3.fromHSV((tick() * speed) % 1, 1, 1)
end

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
end

local function createStroke(parent, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Color = Color3.fromRGB(255, 0, 0)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

-- ============================================================
-- 卡密验证界面
-- ============================================================
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "KeySystem"
keyGui.ResetOnSpawn = false
keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
keyGui.Parent = playerGui

local bgOverlay = Instance.new("Frame")
bgOverlay.Size = UDim2.new(1, 0, 1, 0)
bgOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bgOverlay.BackgroundTransparency = 0.7
bgOverlay.BorderSizePixel = 0
bgOverlay.Parent = keyGui

-- 背景粒子
for i = 1, 25 do
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, math.random(3, 7), 0, math.random(3, 7))
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    particle.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1)
    particle.BorderSizePixel = 0
    particle.BackgroundTransparency = 0.5
    particle.Parent = bgOverlay
    createCorner(particle, 999)
    
    task.spawn(function()
        while keyGui and keyGui.Parent and particle and particle.Parent do
            local tween = TweenService:Create(particle, TweenInfo.new(math.random(4, 8)), {
                Position = UDim2.new(math.random(), 0, math.random(), 0),
                BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1),
            })
            tween:Play()
            tween.Completed:Wait()
        end
    end)
end

local keyFrame = Instance.new("Frame")
keyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
keyFrame.BorderSizePixel = 0
keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
keyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
keyFrame.Size = UDim2.new(0, 380, 0, 250)
keyFrame.ClipsDescendants = true
keyFrame.Parent = keyGui
createCorner(keyFrame, 18)

local frameGradient = Instance.new("UIGradient")
frameGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 25)),
})
frameGradient.Rotation = 135
frameGradient.Parent = keyFrame

local frameStroke = createStroke(keyFrame, 3)
task.spawn(function()
    while keyGui and keyGui.Parent and frameStroke and frameStroke.Parent do
        frameStroke.Color = getRainbowColor(0.25)
        task.wait()
    end
end)

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 4)
topBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
topBar.BorderSizePixel = 0
topBar.Parent = keyFrame

local topGradient = Instance.new("UIGradient")
topGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 165, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(148, 0, 211)),
})
topGradient.Parent = topBar

local lockIcon = Instance.new("TextLabel")
lockIcon.Size = UDim2.new(1, 0, 0, 40)
lockIcon.Position = UDim2.new(0, 0, 0, 12)
lockIcon.Text = "🔐"
lockIcon.TextSize = 30
lockIcon.BackgroundTransparency = 1
lockIcon.Parent = keyFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 28)
titleLabel.Position = UDim2.new(0, 0, 0, 52)
titleLabel.Text = "KS SCRIPT"
titleLabel.TextSize = 26
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = keyFrame

task.spawn(function()
    while keyGui and keyGui.Parent and titleLabel and titleLabel.Parent do
        titleLabel.TextColor3 = getRainbowColor(0.3)
        task.wait()
    end
end)

local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Size = UDim2.new(1, 0, 0, 18)
subtitleLabel.Position = UDim2.new(0, 0, 0, 80)
subtitleLabel.Text = "输入卡密以继续使用"
subtitleLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
subtitleLabel.TextSize = 13
subtitleLabel.Font = Enum.Font.SourceSans
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Parent = keyFrame

local inputContainer = Instance.new("Frame")
inputContainer.Size = UDim2.new(0, 300, 0, 42)
inputContainer.Position = UDim2.new(0.5, -150, 0, 105)
inputContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
inputContainer.BorderSizePixel = 0
inputContainer.Parent = keyFrame
createCorner(inputContainer, 10)

local inputStroke = createStroke(inputContainer, 2)
task.spawn(function()
    while keyGui and keyGui.Parent and inputStroke and inputStroke.Parent do
        inputStroke.Color = getRainbowColor(0.3)
        task.wait()
    end
end)

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -30, 1, 0)
keyInput.Position = UDim2.new(0, 15, 0, 0)
keyInput.PlaceholderText = "请输入卡密..."
keyInput.Text = ""
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
keyInput.BackgroundTransparency = 1
keyInput.BorderSizePixel = 0
keyInput.Font = Enum.Font.SourceSans
keyInput.TextSize = 15
keyInput.Parent = inputContainer

local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0, 300, 0, 42)
verifyBtn.Position = UDim2.new(0.5, -150, 0, 155)
verifyBtn.Text = "⚡ 验 证"
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.TextSize = 16
verifyBtn.Font = Enum.Font.SourceSansBold
verifyBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
verifyBtn.BorderSizePixel = 0
verifyBtn.Parent = keyFrame
createCorner(verifyBtn, 10)

local btnGradient = Instance.new("UIGradient")
btnGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 30, 30)),
})
btnGradient.Parent = verifyBtn

local btnStroke = createStroke(verifyBtn, 2)
task.spawn(function()
    while keyGui and keyGui.Parent and btnStroke and btnStroke.Parent do
        btnStroke.Color = getRainbowColor(0.3)
        task.wait()
    end
end)

verifyBtn.MouseEnter:Connect(function()
    TweenService:Create(btnStroke, TweenInfo.new(0.2), {Thickness = 4}):Play()
    TweenService:Create(verifyBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 310, 0, 44)}):Play()
end)
verifyBtn.MouseLeave:Connect(function()
    TweenService:Create(btnStroke, TweenInfo.new(0.2), {Thickness = 2}):Play()
    TweenService:Create(verifyBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 300, 0, 42)}):Play()
end)

local errorLabel = Instance.new("TextLabel")
errorLabel.Size = UDim2.new(1, 0, 0, 20)
errorLabel.Position = UDim2.new(0, 0, 0, 205)
errorLabel.Text = ""
errorLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
errorLabel.TextSize = 12
errorLabel.Font = Enum.Font.SourceSans
errorLabel.BackgroundTransparency = 1
errorLabel.Parent = keyFrame

local footerLabel = Instance.new("TextLabel")
footerLabel.Size = UDim2.new(1, 0, 0, 15)
footerLabel.Position = UDim2.new(0, 0, 0, 228)
footerLabel.Text = "KS Script © 2024"
footerLabel.TextColor3 = Color3.fromRGB(80, 80, 80)
footerLabel.TextSize = 10
footerLabel.Font = Enum.Font.SourceSans
footerLabel.BackgroundTransparency = 1
footerLabel.Parent = keyFrame

keyFrame.Size = UDim2.new(0, 0, 0, 0)
local tweenIn = TweenService:Create(keyFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 380, 0, 250)
})
tweenIn:Play()

local function onVerify()
    if keyInput.Text == correctKey then
        verifyBtn.Text = "✅ 验证成功！"
        verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        btnGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 0)),
        })
        task.wait(0.4)
        
        local tweenOut = TweenService:Create(keyFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        })
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            isVerified = true
            keyGui:Destroy()
        end)
    else
        attempts += 1
        local remaining = maxAttempts - attempts
        
        if remaining <= 0 then
            errorLabel.Text = "❌ 验证失败，即将踢出..."
            task.wait(1)
            game.Players.LocalPlayer:Kick("验证失败次数过多")
        else
            errorLabel.Text = "❌ 卡密错误！剩余 " .. remaining .. " 次机会"
            keyInput.Text = ""
            
            local originalPos = inputContainer.Position
            for i = 1, 6 do
                inputContainer.Position = originalPos + UDim2.new(0, 6, 0, 0)
                task.wait(0.03)
                inputContainer.Position = originalPos - UDim2.new(0, 6, 0, 0)
                task.wait(0.03)
            end
            inputContainer.Position = originalPos
            
            inputContainer.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
            task.wait(0.2)
            inputContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        end
    end
end

verifyBtn.MouseButton1Click:Connect(onVerify)
keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then onVerify() end
end)

repeat task.wait() until isVerified

-- ============================================================
-- 加载UI库
-- ============================================================
local repo = 'https://raw.githubusercontent.com/KingScriptAE/No-sirve-nada./refs/heads/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Options = Library.Options
local Toggles = Library.Toggles

-- ============================================================
-- 创建主窗口
-- ============================================================
local Window = Library:CreateWindow({
    Title = "KS Script",
    Footer = "By ks script",
    Icon = 131153193945220,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

-- ============================================================
-- 创建标签页
-- ============================================================
local Tabs = {
    Notice = Window:AddTab("通知", "info"),
    Universal = Window:AddTab("通用功能", "settings"),
    ShenDi = Window:AddTab("圣地rp", "map"),
    Mine = Window:AddTab("矿山", "pickaxe"),
    Lemon = Window:AddTab("柠檬", "citrus"),
    TX = Window:AddTab("TX翻译", "languages"),
    RunRace = Window:AddTab("Run Race", "flag"),
    Aimbot = Window:AddTab("自瞄一类", "crosshair"),
    Scripts = Window:AddTab("脚本整合", "folder-code"),
}

-- ============================================================
-- 绕过检测的速度修改
-- ============================================================
local function safeSpeedChange(hum, speed)
    pcall(function()
        -- 方法1：直接修改
        hum.WalkSpeed = speed
        
        -- 方法2：使用SetState绕过检测
        if hum.SetStateEnabled then
            hum:SetStateEnabled(Enum.HumanoidStateType.Running, true)
        end
        
        -- 方法3：修改PhysicalProperties
        local root = hum.Parent and hum.Parent:FindFirstChild("HumanoidRootPart")
        if root then
            -- 不修改PhysicalProperties避免被检测
        end
    end)
end

-- ============================================================
-- 通知标签页
-- ============================================================
local noticeGroup = Tabs.Notice:AddLeftGroupbox("脚本信息")
noticeGroup:AddLabel('欢迎使用 KS Script！')
noticeGroup:AddLabel('此脚本为缝合各种脚本', true)
noticeGroup:AddLabel('请勿倒卖本脚本！')
noticeGroup:AddButton({
    Text = '👤 作者QQ: 3236904498',
    Func = function()
        pcall(function() setclipboard("3236904498") end)
        Library:Notify("已复制QQ号", 3)
    end,
})

-- ============================================================
-- 通用功能标签页
-- ============================================================
local leftGroup = Tabs.Universal:AddLeftGroupbox("人物功能")
local rightGroup = Tabs.Universal:AddRightGroupbox("视觉功能")
local teleportGroup = Tabs.Universal:AddLeftGroupbox("传送功能")

local walkEnabled = false
local walkSpeed = 50
local jumpEnabled = false
local jumpPower = 100
local gravityEnabled = false
local gravityValue = 50
local fovEnabled = false
local fovValue = 120
local noclipEnabled = false
local noclipConn
local spinEnabled = false
local spinConn
local spinSpeed = 10
local savedPos = nil

local function applyAll()
    local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        -- 使用安全修改方式
        safeSpeedChange(hum, walkEnabled and walkSpeed or 16)
        hum.JumpPower = jumpEnabled and jumpPower or 50
        hum.Gravity = gravityEnabled and gravityValue or 196.2
    end
    workspace.CurrentCamera.FieldOfView = fovEnabled and fovValue or 70
end

-- 心跳循环持续应用速度（绕过检测）
task.spawn(function()
    while task.wait(0.5) do
        if walkEnabled then
            local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                safeSpeedChange(hum, walkSpeed)
            end
        end
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.1)
    applyAll()
end)

-- 人物功能
leftGroup:AddToggle('MyWalkToggle', {
    Text = '自定义速度',
    Default = false,
    Tooltip = '开启后可以调整走路速度',
    Callback = function(Value)
        walkEnabled = Value
        applyAll()
    end
})

leftGroup:AddSlider('MyWalkSpeed', {
    Text = '速度值',
    Default = 50,
    Min = 16,
    Max = 200,
    Rounding = 0,
    Suffix = "",
    Compact = false,
    Callback = function(Value)
        walkSpeed = Value
        applyAll()
    end
})

leftGroup:AddToggle('MyJumpToggle', {
    Text = '自定义跳跃',
    Default = false,
    Tooltip = '开启后可以调整跳跃高度',
    Callback = function(Value)
        jumpEnabled = Value
        applyAll()
    end
})

leftGroup:AddSlider('MyJumpPower', {
    Text = '跳跃值',
    Default = 100,
    Min = 50,
    Max = 300,
    Rounding = 0,
    Callback = function(Value)
        jumpPower = Value
        applyAll()
    end
})

leftGroup:AddToggle('MyGravityToggle', {
    Text = '自定义重力',
    Default = false,
    Callback = function(Value)
        gravityEnabled = Value
        applyAll()
    end
})

leftGroup:AddSlider('MyGravity', {
    Text = '重力值',
    Default = 50,
    Min = 10,
    Max = 500,
    Rounding = 1,
    Callback = function(Value)
        gravityValue = Value
        applyAll()
    end
})

leftGroup:AddToggle('MyNoclip', {
    Text = '穿墙模式',
    Default = false,
    Tooltip = '穿墙',
    Callback = function(Value)
        noclipEnabled = Value
        if Value then
            noclipConn = game:GetService("RunService").Stepped:Connect(function()
                local char = game.Players.LocalPlayer.Character
                if char then
                    for _, p in ipairs(char:GetDescendants()) do
                        if p:IsA("BasePart") then
                            p.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConn then noclipConn:Disconnect() end
        end
    end
})

leftGroup:AddToggle('MySpin', {
    Text = '旋转人物',
    Default = false,
    Callback = function(Value)
        spinEnabled = Value
        if Value then
            spinConn = game:GetService("RunService").Heartbeat:Connect(function()
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
                end
            end)
        else
            if spinConn then spinConn:Disconnect() end
        end
    end
})

leftGroup:AddSlider('MySpinSpeed', {
    Text = '旋转速度',
    Default = 10,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        spinSpeed = Value
    end
})

leftGroup:AddToggle('MyGodMode', {
    Text = '无敌模式',
    Default = false,
    Callback = function(Value)
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            if Value then
                hum.MaxHealth = 9e9
                hum.Health = 9e9
            else
                hum.MaxHealth = 100
                hum.Health = 100
            end
        end
    end
})

leftGroup:AddToggle('MyInfiniteJump', {
    Text = '无限跳',
    Default = false,
    Callback = function(Value)
        getgenv().InfiniteJump = Value
        if Value then
            getgenv().JumpConn = game:GetService("UserInputService").JumpRequest:Connect(function()
                local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.Jump = true end
            end)
        else
            if getgenv().JumpConn then getgenv().JumpConn:Disconnect() end
        end
    end
})

-- 视觉功能
rightGroup:AddToggle('MyFovToggle', {
    Text = '自定义视野',
    Default = false,
    Callback = function(Value)
        fovEnabled = Value
        applyAll()
    end
})

rightGroup:AddSlider('MyFov', {
    Text = 'FOV值',
    Default = 120,
    Min = 30,
    Max = 150,
    Rounding = 0,
    Callback = function(Value)
        fovValue = Value
        applyAll()
    end
})

rightGroup:AddToggle('MyNightVision', {
    Text = '夜视模式',
    Default = false,
    Callback = function(Value)
        local l = game:GetService("Lighting")
        if Value then
            l.Brightness = 5
            l.ClockTime = 14
            l.FogEnd = 100000
            l.GlobalShadows = false
        else
            l.Brightness = 1
            l.FogEnd = 10000
            l.GlobalShadows = true
        end
    end
})

rightGroup:AddSlider('MyTime', {
    Text = '时间调节',
    Default = 14,
    Min = 0,
    Max = 24,
    Rounding = 0,
    Callback = function(Value)
        game:GetService("Lighting").ClockTime = Value
    end
})

rightGroup:AddToggle('MyFullBright', {
    Text = '全亮模式',
    Default = false,
    Callback = function(Value)
        local lighting = game:GetService("Lighting")
        if Value then
            lighting.Brightness = 10
            lighting.Ambient = Color3.fromRGB(255, 255, 255)
        else
            lighting.Brightness = 1
            lighting.Ambient = Color3.fromRGB(0, 0, 0)
        end
    end
})

rightGroup:AddToggle('MyESP', {
    Text = 'ESP透视',
    Default = false,
    Callback = function(Value)
        getgenv().ESP = Value
        if Value then
            local espGui = Instance.new("ScreenGui")
            espGui.Name = "ESP"
            espGui.ResetOnSpawn = false
            espGui.Parent = game.Players.LocalPlayer.PlayerGui
            
            getgenv().ESPConn = game:GetService("RunService").Heartbeat:Connect(function()
                for _, child in ipairs(espGui:GetChildren()) do child:Destroy() end
                local cam = workspace.CurrentCamera
                local char = game.Players.LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local root = char.HumanoidRootPart
                
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local targetRoot = player.Character.HumanoidRootPart
                        local screenPos, onScreen = cam:WorldToScreenPoint(targetRoot.Position + Vector3.new(0, 3, 0))
                        if onScreen then
                            local label = Instance.new("TextLabel")
                            label.Size = UDim2.new(0, 150, 0, 20)
                            label.Position = UDim2.new(0, screenPos.X - 75, 0, screenPos.Y - 30)
                            label.Text = player.Name .. " | " .. math.floor((targetRoot.Position - root.Position).Magnitude) .. "m"
                            label.TextColor3 = Color3.fromRGB(255, 0, 0)
                            label.TextSize = 14
                            label.Font = Enum.Font.SourceSansBold
                            label.BackgroundTransparency = 1
                            label.TextStrokeTransparency = 0.3
                            label.Parent = espGui
                        end
                    end
                end
            end)
        else
            if getgenv().ESPConn then getgenv().ESPConn:Disconnect() end
            if game.Players.LocalPlayer.PlayerGui:FindFirstChild("ESP") then
                game.Players.LocalPlayer.PlayerGui.ESP:Destroy()
            end
        end
    end
})

-- 传送功能
teleportGroup:AddButton({
    Text = '💾 保存位置',
    Func = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            savedPos = char.HumanoidRootPart.CFrame
            Library:Notify("位置已保存", 2)
        end
    end,
})

teleportGroup:AddButton({
    Text = '📌 传送到保存点',
    Func = function()
        if savedPos then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = savedPos
            end
        end
    end,
})

teleportGroup:AddButton({
    Text = '👤 传送到随机玩家',
    Func = function()
        local players = {}
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then table.insert(players, p) end
        end
        if #players > 0 then
            local target = players[math.random(1, #players)]
            if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                end
            end
        end
    end,
})

-- ============================================================
-- 圣地rp标签页
-- ============================================================
local shengdiGroup = Tabs.ShenDi:AddLeftGroupbox("脚本列表")
shengdiGroup:AddLabel('圣地rp专用脚本', true)
shengdiGroup:AddButton({
    Text = 'Ax脚本',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Tarmaster/AverlikHub/refs/heads/main/Loader"))()
        Library:Notify("Ax脚本已加载，卡密: NEW_EVENTgag2", 5)
    end,
})
shengdiGroup:AddButton({
    Text = 'hux脚本',
    Func = function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/adff9b33e46197721a37f4d1ad509d418db5cfb1f4899c166f10781be92b5389/download"))()
        Library:Notify("hux脚本已加载，需要卡密", 5)
    end,
})
shengdiGroup:AddButton({
    Text = 'huxhub',
    Func = function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/4f070b7ced7a195b57ea0a533cd8831f6a29f42810254f7b931a670e03f39228/download"))()
        Library:Notify("huxhub已加载，需要卡密", 5)
    end,
})

-- ============================================================
-- 矿山标签页
-- ============================================================
local mineGroup = Tabs.Mine:AddLeftGroupbox("矿山脚本")
mineGroup:AddLabel('Mine-a-mountain 相关脚本', true)
mineGroup:AddButton({
    Text = '加载脚本1',
    Func = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/z8KgbT9H"))()
        Library:Notify("矿山脚本1已加载", 3)
    end,
})
mineGroup:AddButton({
    Text = '加载脚本2',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/WoiiKau/Mine-a-mountain/refs/heads/main/MaM"))()
        Library:Notify("矿山脚本2已加载", 3)
    end,
})

-- ============================================================
-- 柠檬标签页
-- ============================================================
local lemonGroup = Tabs.Lemon:AddLeftGroupbox("柠檬脚本")
lemonGroup:AddLabel('需解卡密，不会加原作者dc', true)
lemonGroup:AddButton({
    Text = '加载柠檬',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Fluxyyy333/HoshiOnTop/main/loader.lua"))()
    end,
})

-- ============================================================
-- TX翻译标签页
-- ============================================================
local txGroup = Tabs.TX:AddLeftGroupbox("TX翻译")
txGroup:AddLabel('全自动翻译脚本', true)
txGroup:AddButton({
    Text = '加载翻译',
    Func = function()
        TX = "TX Script"
        Script = "全自动翻译"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-language"))()
    end,
})

-- ============================================================
-- Run Race标签页
-- ============================================================
local runraceGroup = Tabs.RunRace:AddLeftGroupbox("Run Race")
runraceGroup:AddLabel('Ruby Hub', true)
runraceGroup:AddButton({
    Text = '加载脚本',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Deni210/raceclicker/main/Ruby%20Hub%20v1.0", true))()
    end,
})

-- ============================================================
-- 自瞄标签页
-- ============================================================
local aimbotGroup = Tabs.Aimbot:AddLeftGroupbox("ESP透视")
aimbotGroup:AddLabel('V3.0 手机版', true)
aimbotGroup:AddButton({
    Text = '加载 ESP',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/1215203698741/Roblox-ESP-Antibot-V3/refs/heads/main/V3.0phone.lua"))()
    end,
})

-- ============================================================
-- 脚本整合标签页
-- ============================================================
local scriptsGroup = Tabs.Scripts:AddLeftGroupbox("脚本列表")
scriptsGroup:AddLabel('YI 脚本', true)
scriptsGroup:AddButton({
    Text = '加载 YI',
    Func = function()
        getgenv().YI_HUB = "YI_HUB群979312897"
        loadstring(game:HttpGet('https://raw.githubusercontent.com/YI-HUB-TEAM/YIscript/refs/heads/main/YI_HUB'))("")
    end,
})
scriptsGroup:AddLabel('PI 脚本', true)
scriptsGroup:AddButton({
    Text = '加载 PI',
    Func = function()
        getgenv().XiaoPi = "皮脚本QQ群1002100032"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
    end,
})
scriptsGroup:AddLabel('BS 脚本', true)
scriptsGroup:AddButton({
    Text = '加载 BS',
    Func = function()
        loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\103\105\116\101\101\46\99\111\109\47\66\83\95\115\99\114\105\112\116\47\115\99\114\105\112\116\47\114\97\119\47\109\97\115\116\101\114\47\66\83\95\83\99\114\105\112\116\46\76\117\97\117"))()
    end,
})

-- ============================================================
-- 设置
-- ============================================================
local MenuGroup = Tabs.Notice:AddRightGroupbox('菜单')
MenuGroup:AddButton('卸载脚本', function() Library:Unload() end)
MenuGroup:AddLabel('菜单快捷键'):AddKeyPicker('MenuKeybind', { Default = 'RightShift', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
ThemeManager:SetFolder("KSScriptTheme")
SaveManager:SetFolder("KSScriptConfig")
SaveManager:BuildConfigSection(Tabs.Notice)
ThemeManager:ApplyToTab(Tabs.Notice)
