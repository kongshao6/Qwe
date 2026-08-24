local correctKey = "ksnb"
local maxAttempts = 3
local attempts = 0
local isVerified = false

local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function getRainbowColor(speed)
    return Color3.fromHSV((tick() * speed) % 1, 1, 1)
end

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
end

local function createStroke(parent, thickness, color)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Color = color or Color3.fromRGB(255, 255, 255)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

local function showErrorPopup(msg, autoKick)
    local errorGui = Instance.new("ScreenGui")
    errorGui.Name = "ErrorPopup"
    errorGui.ResetOnSpawn = false
    errorGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    errorGui.Parent = playerGui
    
    local bgOverlay = Instance.new("Frame")
    bgOverlay.Size = UDim2.new(1, 0, 1, 0)
    bgOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bgOverlay.BackgroundTransparency = 0.6
    bgOverlay.BorderSizePixel = 0
    bgOverlay.Parent = errorGui
    
    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    frame.BorderSizePixel = 0
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.Size = UDim2.new(0, 0, 0, 0)
    frame.ClipsDescendants = true
    frame.Parent = errorGui
    createCorner(frame, 20)
    
    local frameStroke = createStroke(frame, 3, Color3.fromRGB(255, 0, 0))
    task.spawn(function()
        while errorGui and errorGui.Parent and frameStroke and frameStroke.Parent do
            frameStroke.Color = getRainbowColor(0.3)
            task.wait()
        end
    end)
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(1, 0, 0, 45)
    iconLabel.Position = UDim2.new(0, 0, 0, 15)
    iconLabel.Text = autoKick and "🚫" or "⚠️"
    iconLabel.TextSize = 35
    iconLabel.BackgroundTransparency = 1
    iconLabel.Parent = frame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 25)
    titleLabel.Position = UDim2.new(0, 0, 0, 60)
    titleLabel.Text = autoKick and "验证失败" or "卡密错误"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 20
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.BackgroundTransparency = 1
    titleLabel.Parent = frame
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -30, 0, 40)
    descLabel.Position = UDim2.new(0, 15, 0, 88)
    descLabel.Text = msg
    descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    descLabel.TextSize = 14
    descLabel.Font = Enum.Font.SourceSans
    descLabel.BackgroundTransparency = 1
    descLabel.TextWrapped = true
    descLabel.Parent = frame
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 220, 0, 38)
    closeBtn.Position = UDim2.new(0.5, -110, 0, 130)
    closeBtn.Text = "确 定"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 15
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = frame
    createCorner(closeBtn, 10)
    
    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}):Play()
    end)
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}):Play()
    end)
    
    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 320, 0, 180)})
    tweenIn:Play()
    
    closeBtn.MouseButton1Click:Connect(function()
        local tweenOut = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            errorGui:Destroy()
        end)
        if autoKick then
            task.wait(0.3)
            game.Players.LocalPlayer:Kick("验证失败次数过多")
        end
    end)
end

local function verifyKey(input)
    if input == correctKey then
        isVerified = true
        return true
    else
        attempts += 1
        local remaining = maxAttempts - attempts
        if remaining <= 0 then
            showErrorPopup("验证失败次数过多\n即将被踢出游戏", true)
        else
            showErrorPopup("卡密错误！\n剩余尝试次数: " .. remaining .. " 次", false)
        end
        return false
    end
end

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "KeySystem"
keyGui.ResetOnSpawn = false
keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
keyGui.Parent = playerGui

local particles = {}
for i = 1, 30 do
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, math.random(3, 8), 0, math.random(3, 8))
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    particle.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1)
    particle.BorderSizePixel = 0
    particle.BackgroundTransparency = 0.5
    particle.Parent = keyGui
    createCorner(particle, 999)
    table.insert(particles, particle)
    
    task.spawn(function()
        while keyGui and keyGui.Parent and particle and particle.Parent do
            local tween = TweenService:Create(particle, TweenInfo.new(math.random(4, 8)), {
                Position = UDim2.new(math.random(), 0, math.random(), 0),
                BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1),
                BackgroundTransparency = math.random(3, 6) / 10,
            })
            tween:Play()
            tween.Completed:Wait()
        end
    end)
end

local keyFrame = Instance.new("Frame")
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
keyFrame.BorderSizePixel = 0
keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
keyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
keyFrame.Size = UDim2.new(0, 0, 0, 0)
keyFrame.ClipsDescendants = true
keyFrame.Active = true
keyFrame.Parent = keyGui
createCorner(keyFrame, 20)

local frameStroke = createStroke(keyFrame, 3, Color3.fromRGB(255, 0, 0))
task.spawn(function()
    while keyGui and keyGui.Parent and frameStroke and frameStroke.Parent do
        frameStroke.Color = getRainbowColor(0.2)
        task.wait()
    end
end)

local dragArea = Instance.new("Frame")
dragArea.Size = UDim2.new(1, 0, 0, 60)
dragArea.Position = UDim2.new(0, 0, 0, 0)
dragArea.BackgroundTransparency = 1
dragArea.BorderSizePixel = 0
dragArea.Parent = keyFrame

local dragging = false
local dragOffset = Vector2.new(0, 0)

dragArea.MouseButton1Down:Connect(function()
    dragging = true
    local mousePos = UserInputService:GetMouseLocation()
    dragOffset = mousePos - keyFrame.AbsolutePosition
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        keyFrame.Position = UDim2.new(0, mousePos.X - dragOffset.X, 0, mousePos.Y - dragOffset.Y)
    end
end)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -38, 0, 8)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.BorderSizePixel = 0
closeBtn.Parent = keyFrame
createCorner(closeBtn, 999)

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}):Play()
end)
closeBtn.MouseButton1Click:Connect(function()
    local tweenOut = TweenService:Create(keyFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        keyGui:Destroy()
    end)
end)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 15)
titleLabel.Text = "KS SCRIPT"
titleLabel.TextSize = 32
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
subtitleLabel.Size = UDim2.new(1, 0, 0, 20)
subtitleLabel.Position = UDim2.new(0, 0, 0, 53)
subtitleLabel.Text = "🔐 请输入卡密以继续使用"
subtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
subtitleLabel.TextSize = 14
subtitleLabel.Font = Enum.Font.SourceSans
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Parent = keyFrame

local inputBg = Instance.new("Frame")
inputBg.Size = UDim2.new(0, 300, 0, 45)
inputBg.Position = UDim2.new(0.5, -150, 0, 80)
inputBg.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
inputBg.BorderSizePixel = 0
inputBg.Parent = keyFrame
createCorner(inputBg, 10)

local inputStroke = createStroke(inputBg, 2, Color3.fromRGB(255, 0, 0))
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
keyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
keyInput.BackgroundTransparency = 1
keyInput.BorderSizePixel = 0
keyInput.Font = Enum.Font.SourceSans
keyInput.TextSize = 16
keyInput.ClearTextOnFocus = false
keyInput.Parent = inputBg

local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0, 300, 0, 45)
verifyBtn.Position = UDim2.new(0.5, -150, 0, 140)
verifyBtn.Text = "⚡ 验 证"
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.TextSize = 18
verifyBtn.Font = Enum.Font.SourceSansBold
verifyBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
verifyBtn.BorderSizePixel = 0
verifyBtn.Parent = keyFrame
createCorner(verifyBtn, 10)

local btnStroke = createStroke(verifyBtn, 2, Color3.fromRGB(255, 0, 0))
task.spawn(function()
    while keyGui and keyGui.Parent and btnStroke and btnStroke.Parent do
        btnStroke.Color = getRainbowColor(0.3)
        verifyBtn.BackgroundColor3 = Color3.fromHSV((tick() * 0.3) % 1, 0.8, 0.6)
        task.wait()
    end
end)

verifyBtn.MouseEnter:Connect(function()
    TweenService:Create(btnStroke, TweenInfo.new(0.2), {Thickness = 4}):Play()
end)
verifyBtn.MouseLeave:Connect(function()
    TweenService:Create(btnStroke, TweenInfo.new(0.2), {Thickness = 2}):Play()
end)

local footerLabel = Instance.new("TextLabel")
footerLabel.Size = UDim2.new(1, 0, 0, 15)
footerLabel.Position = UDim2.new(0, 0, 0, 195)
footerLabel.Text = "KS Script © 2024 | 卡密验证系统"
footerLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
footerLabel.TextSize = 10
footerLabel.Font = Enum.Font.SourceSans
footerLabel.BackgroundTransparency = 1
footerLabel.Parent = keyFrame

local tweenIn = TweenService:Create(keyFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 380, 0, 220)})
tweenIn:Play()

local function onVerify()
    if verifyKey(keyInput.Text) then
        verifyBtn.Text = "✅ 验证成功！"
        verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        task.wait(0.5)
        local tweenOut = TweenService:Create(keyFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            keyGui:Destroy()
        end)
    else
        keyInput.Text = ""
        local originalPos = inputBg.Position
        for i = 1, 5 do
            inputBg.Position = originalPos + UDim2.new(0, 5, 0, 0)
            task.wait(0.03)
            inputBg.Position = originalPos - UDim2.new(0, 5, 0, 0)
            task.wait(0.03)
        end
        inputBg.Position = originalPos
    end
end

verifyBtn.MouseButton1Click:Connect(onVerify)
keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then onVerify() end
end)

repeat task.wait() until isVerified

local repo = 'https://raw.githubusercontent.com/KingScriptAE/No-sirve-nada./refs/heads/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Options = Library.Options
local Toggles = Library.Toggles

local Window = Library:CreateWindow({
    Title = "KS Script",
    Footer = "By ks script",
    Icon = 131153193945220,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

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

local flyGroup = Tabs.Universal:AddLeftGroupbox("飞行")
flyGroup:AddButton({
    Text = '飞行V3汉化',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kongshao6/Qwe/main/Ksfly.lua"))()
        Library:Notify("飞行V3已加载！", 3)
    end,
})

local moveGroup = Tabs.Universal:AddLeftGroupbox("人物功能")
local visualGroup = Tabs.Universal:AddRightGroupbox("视觉功能")
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

local function safeSpeedChange(hum, speed)
    pcall(function()
        hum.WalkSpeed = speed
        if hum.SetStateEnabled then
            hum:SetStateEnabled(Enum.HumanoidStateType.Running, true)
        end
    end)
end

local function applyAll()
    local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        safeSpeedChange(hum, walkEnabled and walkSpeed or 16)
        hum.JumpPower = jumpEnabled and jumpPower or 50
        hum.Gravity = gravityEnabled and gravityValue or 196.2
    end
    workspace.CurrentCamera.FieldOfView = fovEnabled and fovValue or 70
end

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
