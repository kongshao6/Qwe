local correctKey = "ksnb"
local maxAttempts = 3
local attempts = 0
local isVerified = false

local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

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

local function createGradient(parent)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 165, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(148, 0, 211)),
    })
    gradient.Rotation = 90
    gradient.Parent = parent
    return gradient
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
    
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 5)
    topBar.Position = UDim2.new(0, 0, 0, 0)
    topBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    topBar.BorderSizePixel = 0
    topBar.Parent = frame
    createGradient(topBar)
    
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
keyFrame.Parent = keyGui
createCorner(keyFrame, 20)

local frameStroke = createStroke(keyFrame, 3, Color3.fromRGB(255, 0, 0))
task.spawn(function()
    while keyGui and keyGui.Parent and frameStroke and frameStroke.Parent do
        frameStroke.Color = getRainbowColor(0.2)
        task.wait()
    end
end)

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 5)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
topBar.BorderSizePixel = 0
topBar.Parent = keyFrame
createGradient(topBar)

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
titleLabel.Position = UDim2.new(0, 0, 0, 20)
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
subtitleLabel.Position = UDim2.new(0, 0, 0, 58)
subtitleLabel.Text = "🔐 请输入卡密以继续使用"
subtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
subtitleLabel.TextSize = 14
subtitleLabel.Font = Enum.Font.SourceSans
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Parent = keyFrame

local inputBg = Instance.new("Frame")
inputBg.Size = UDim2.new(0, 300, 0, 45)
inputBg.Position = UDim2.new(0.5, -150, 0, 85)
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
verifyBtn.Position = UDim2.new(0.5, -150, 0, 145)
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
footerLabel.Position = UDim2.new(0, 0, 0, 200)
footerLabel.Text = "KS Script © 2024 | 卡密验证系统"
footerLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
footerLabel.TextSize = 10
footerLabel.Font = Enum.Font.SourceSans
footerLabel.BackgroundTransparency = 1
footerLabel.Parent = keyFrame

local tweenIn = TweenService:Create(keyFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 380, 0, 225)})
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

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "ks script",
    Icon = "door-open",
    Author = "ks script",
    Folder = "ks script",
    Size = UDim2.fromOffset(580, 520),
    Transparent = true,
    Theme = "Light",
    SideBarWidth = 200,
    HasOutline = true,
    AccentColor = Color3.fromRGB(255, 0, 0),
})

Window:EditOpenButton({
    Title = "打开 ks script",
    Icon = "monitor",
    CornerRadius = UDim.new(0, 16),
    StrokeThickness = 3,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 165, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(148, 0, 211)),
    }),
    Draggable = true,
})

local Tabs = {
    NoticeTab    = Window:Tab({ Title = "通知",         Icon = "bell",            Desc = "脚本说明与公告" }),
    UniversalTab = Window:Tab({ Title = "通用功能",      Icon = "wrench",          Desc = "实用功能合集" }),
    ShenDiTab    = Window:Tab({ Title = "圣地rp",       Icon = "map",             Desc = "圣地rp脚本" }),
    MineTab      = Window:Tab({ Title = "矿山",         Icon = "pickaxe",         Desc = "矿山脚本加载器" }),
    LemonTab     = Window:Tab({ Title = "柠檬",         Icon = "citrus",          Desc = "HoshiOnTop 脚本加载器" }),
    TXTab        = Window:Tab({ Title = "TX翻译",       Icon = "languages",       Desc = "全自动翻译脚本" }),
    RunRaceTab   = Window:Tab({ Title = "Run Race",     Icon = "flag",            Desc = "Run Race 脚本加载器" }),
    AimbotTab    = Window:Tab({ Title = "自瞄一类",      Icon = "crosshair",       Desc = "ESP 透视脚本" }),
    ScriptsTab   = Window:Tab({ Title = "多种脚本整合",  Icon = "folder-code",     Desc = "各类脚本合集" }),
}

Window:SelectTab(1)

local walkEnabled = false; local walkSpeed = 50
local jumpEnabled = false; local jumpPower = 100
local gravityEnabled = false; local gravityValue = 50
local fovEnabled = false; local fovValue = 120
local noclipEnabled = false; local noclipConn
local spinEnabled = false; local spinConn; local spinSpeed = 10
local autoPickEnabled = false; local autoPickConn
local savedPos = nil

local function applyAll()
    local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = walkEnabled and walkSpeed or 16
        hum.JumpPower = jumpEnabled and jumpPower or 50
        hum.Gravity = gravityEnabled and gravityValue or 196.2
    end
    workspace.CurrentCamera.FieldOfView = fovEnabled and fovValue or 70
end
game.Players.LocalPlayer.CharacterAdded:Connect(function(char) task.wait(0.1) applyAll() end)

Tabs.NoticeTab:Paragraph({ Title = "📢 脚本公告", Desc = "欢迎使用 ks script！", Image = "bell", ImageSize = 34, Color = Color3.fromRGB(255, 0, 0) })
Tabs.NoticeTab:Paragraph({ Title = "📝 脚本介绍", Desc = "此脚本为缝合各种脚本\n倒卖sm", Image = "info", ImageSize = 34, Color = Color3.fromRGB(255, 165, 0) })
Tabs.NoticeTab:Paragraph({ Title = "⚠️ 警告", Desc = "请勿倒卖本脚本！", Image = "triangle-alert", ImageSize = 34, Color = Color3.fromRGB(255, 255, 0) })
Tabs.NoticeTab:Button({ Title = "👤 作者QQ: 3236904498", Icon = "clipboard-copy", Callback = function() pcall(function() setclipboard("3236904498") end) WindUI:Notify({ Title = "已复制", Content = "3236904498", Duration = 3 }) end })

Tabs.UniversalTab:Paragraph({ Title = "🛠️ 通用功能", Desc = "开关控制+滑动调节", Image = "wrench", ImageSize = 34, Color = Color3.fromRGB(0, 255, 200) })

Tabs.UniversalTab:Section({ Title = "✈️ 飞行" })
Tabs.UniversalTab:Button({ Title = "飞行V3汉化", Icon = "plane", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kongshao6/Qwe/main/Ksfly.lua"))() WindUI:Notify({ Title = "飞行V3", Content = "已加载！", Duration = 3 }) end })

Tabs.UniversalTab:Section({ Title = "🏃 人物功能" })
Tabs.UniversalTab:Toggle({ Title = "自定义速度", Default = false, Callback = function(v) task.spawn(function() walkEnabled = v applyAll() end) end })
Tabs.UniversalTab:Slider({ Title = "速度值", Default = 50, Min = 16, Max = 200, Rounding = 0, Callback = function(v) walkSpeed = v applyAll() end })
Tabs.UniversalTab:Toggle({ Title = "自定义跳跃", Default = false, Callback = function(v) task.spawn(function() jumpEnabled = v applyAll() end) end })
Tabs.UniversalTab:Slider({ Title = "跳跃值", Default = 100, Min = 50, Max = 300, Rounding = 0, Callback = function(v) jumpPower = v applyAll() end })
Tabs.UniversalTab:Toggle({ Title = "自定义重力", Default = false, Callback = function(v) task.spawn(function() gravityEnabled = v applyAll() end) end })
Tabs.UniversalTab:Slider({ Title = "重力值", Default = 50, Min = 10, Max = 500, Rounding = 1, Callback = function(v) gravityValue = v applyAll() end })
Tabs.UniversalTab:Toggle({ Title = "自定义视野", Default = false, Callback = function(v) task.spawn(function() fovEnabled = v applyAll() end) end })
Tabs.UniversalTab:Slider({ Title = "FOV值", Default = 120, Min = 30, Max = 150, Rounding = 0, Callback = function(v) fovValue = v applyAll() end })
Tabs.UniversalTab:Toggle({ Title = "穿墙模式", Default = false, Callback = function(v) task.spawn(function()
    noclipEnabled = v
    if v then
        noclipConn = game:GetService("RunService").Stepped:Connect(function()
            local char = game.Players.LocalPlayer.Character
            if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
        end)
    else if noclipConn then noclipConn:Disconnect() end end
end) end })
Tabs.UniversalTab:Toggle({ Title = "旋转人物", Default = false, Callback = function(v) task.spawn(function()
    spinEnabled = v
    if v then
        spinConn = game:GetService("RunService").Heartbeat:Connect(function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
            end
        end)
    else if spinConn then spinConn:Disconnect() end end
end) end })
Tabs.UniversalTab:Slider({ Title = "旋转速度", Default = 10, Min = 1, Max = 100, Rounding = 0, Callback = function(v) spinSpeed = v end })
Tabs.UniversalTab:Toggle({ Title = "无敌模式", Default = false, Callback = function(v) task.spawn(function()
    local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if v then hum.MaxHealth = 9e9 hum.Health = 9e9
        else hum.MaxHealth = 100 hum.Health = 100 end
    end
end) end })

Tabs.UniversalTab:Section({ Title = "🦘 跳跃增强" })
Tabs.UniversalTab:Toggle({ Title = "无限跳", Default = false, Callback = function(v)
    getgenv().InfiniteJump = v
    if v then
        getgenv().JumpConn = game:GetService("UserInputService").JumpRequest:Connect(function()
            local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.Jump = true end
        end)
    else
        if getgenv().JumpConn then getgenv().JumpConn:Disconnect() end
    end
end })

Tabs.UniversalTab:Section({ Title = "👁️ 视觉功能" })
Tabs.UniversalTab:Toggle({ Title = "夜视模式", Default = false, Callback = function(v) task.spawn(function()
    local l = game:GetService("Lighting")
    if v then l.Brightness = 5 l.ClockTime = 14 l.FogEnd = 100000 l.GlobalShadows = false
    else l.Brightness = 1 l.FogEnd = 10000 l.GlobalShadows = true end
end) end })
Tabs.UniversalTab:Slider({ Title = "时间调节", Default = 14, Min = 0, Max = 24, Rounding = 0, Callback = function(v) game:GetService("Lighting").ClockTime = v end })
Tabs.UniversalTab:Toggle({ Title = "全亮模式", Default = false, Callback = function(v)
    local lighting = game:GetService("Lighting")
    if v then
        lighting.Brightness = 10
        lighting.Ambient = Color3.fromRGB(255, 255, 255)
    else
        lighting.Brightness = 1
        lighting.Ambient = Color3.fromRGB(0, 0, 0)
    end
end })
Tabs.UniversalTab:Toggle({ Title = "ESP透视", Default = false, Callback = function(v)
    getgenv().ESP = v
    if v then
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
end })

Tabs.UniversalTab:Section({ Title = "🎯 传送" })
Tabs.UniversalTab:Button({ Title = "💾 保存位置", Icon = "save", Callback = function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then savedPos = char.HumanoidRootPart.CFrame end
end })
Tabs.UniversalTab:Button({ Title = "📌 传送到保存点", Icon = "map-pin", Callback = function()
    if savedPos then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then char.HumanoidRootPart.CFrame = savedPos end
    end
end })
Tabs.UniversalTab:Button({ Title = "👤 传送到随机玩家", Icon = "user", Callback = function()
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
end })

Tabs.UniversalTab:Section({ Title = "🎮 实用功能" })
Tabs.UniversalTab:Toggle({ Title = "反挂机防踢", Default = false, Callback = function(v) task.spawn(function()
    if v then
        getgenv().AntiAfkConn = game:GetService("Players").LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end)
    else if getgenv().AntiAfkConn then getgenv().AntiAfkConn:Disconnect() end end
end) end })
Tabs.UniversalTab:Toggle({ Title = "自动拾取", Default = false, Callback = function(v) task.spawn(function()
    autoPickEnabled = v
    if v then
        autoPickConn = game:GetService("RunService").Heartbeat:Connect(function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local root = char.HumanoidRootPart
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Tool") and (obj.Position - root.Position).Magnitude < 10 then
                        firetouchinterest(root, obj, 0)
                        firetouchinterest(root, obj, 1)
                    end
                end
            end
        end)
    else if autoPickConn then autoPickConn:Disconnect() end end
end) end })
Tabs.UniversalTab:Toggle({ Title = "自动攻击", Default = false, Callback = function(v)
    getgenv().AutoClick = v
    if v then
        getgenv().ClickConn = game:GetService("RunService").Heartbeat:Connect(function()
            local mouse = game.Players.LocalPlayer:GetMouse()
            mouse.Button1Down:Fire()
            task.wait(0.05)
            mouse.Button1Up:Fire()
        end)
    else
        if getgenv().ClickConn then getgenv().ClickConn:Disconnect() end
    end
end })
Tabs.UniversalTab:Toggle({ Title = "自瞄", Default = false, Callback = function(v)
    getgenv().Aimbot = v
    if v then
        getgenv().AimbotConn = game:GetService("RunService").Heartbeat:Connect(function()
            local char = game.Players.LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local root = char.HumanoidRootPart
            local target = nil
            local closest = math.huge
            
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local targetRoot = player.Character.HumanoidRootPart
                    local dist = (targetRoot.Position - root.Position).Magnitude
                    if dist < closest and dist < 100 then
                        closest = dist
                        target = targetRoot
                    end
                end
            end
            
            if target then
                local cam = workspace.CurrentCamera
                local screenPos, onScreen = cam:WorldToScreenPoint(target.Position + Vector3.new(0, 3, 0))
                if onScreen then
                    local mouse = game.Players.LocalPlayer:GetMouse()
                    mousemoverel((screenPos.X - mouse.X) * 0.4, (screenPos.Y - mouse.Y) * 0.4)
                end
            end
        end)
    else
        if getgenv().AimbotConn then getgenv().AimbotConn:Disconnect() end
    end
end })
Tabs.UniversalTab:Toggle({ Title = "防摔落", Default = false, Callback = function(v)
    getgenv().AntiFall = v
    if v then
        getgenv().FallConn = game:GetService("RunService").Heartbeat:Connect(function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local root = char.HumanoidRootPart
                if root.Position.Y < -20 then
                    root.CFrame = CFrame.new(0, 50, 0)
                end
            end
        end)
    else
        if getgenv().FallConn then getgenv().FallConn:Disconnect() end
    end
end })
Tabs.UniversalTab:Button({ Title = "🖱️ 点击传送", Icon = "mouse-pointer", Callback = function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        mouse.Button1Down:Connect(function()
            if mouse.Hit then
                char.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 5, 0))
            end
        end)
    end
end })

Tabs.UniversalTab:Section({ Title = "🌐 服务器" })
Tabs.UniversalTab:Button({ Title = "重新加入", Icon = "refresh-cw", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer) end })
Tabs.UniversalTab:Button({ Title = "复制服务器ID", Icon = "clipboard-copy", Callback = function() pcall(function() setclipboard(game.JobId) end) end })

Tabs.ShenDiTab:Paragraph({ Title = "🏰 圣地rp脚本", Desc = "圣地rp专用脚本", Image = "map", ImageSize = 34, Color = Color3.fromRGB(255, 215, 0) })
Tabs.ShenDiTab:Section({ Title = "📜 脚本列表" })
Tabs.ShenDiTab:Button({ Title = "Ax脚本", Icon = "play", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tarmaster/AverlikHub/refs/heads/main/Loader"))()
    WindUI:Notify({ Title = "Ax脚本", Content = "已加载！", Duration = 5 })
end })
Tabs.ShenDiTab:Button({ Title = "📋 Ax脚本卡密: NEW_EVENTgag2", Icon = "clipboard-copy", Callback = function()
    pcall(function() setclipboard("NEW_EVENTgag2") end)
    WindUI:Notify({ Title = "已复制", Content = "NEW_EVENTgag2", Duration = 3 })
end })
Tabs.ShenDiTab:Button({ Title = "auxhub", Icon = "play", Callback = function()
    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/adff9b33e46197721a37f4d1ad509d418db5cfb1f4899c166f10781be92b5389/download"))()
    WindUI:Notify({ Title = "auxhub", Content = "需要卡密，并且需要DC", Duration = 5 })
end })
Tabs.ShenDiTab:Paragraph({ Title = "💡 推荐", Desc = "作者亲测最好用的一个自动农场脚本，但是需要卡密", Image = "star", ImageSize = 34, Color = Color3.fromRGB(255, 215, 0) })
Tabs.ShenDiTab:Button({ Title = "huxhub", Icon = "play", Callback = function()
    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/4f070b7ced7a195b57ea0a533cd8831f6a29f42810254f7b931a670e03f39228/download"))()
    WindUI:Notify({ Title = "huxhub", Content = "需要卡密 (need key)", Duration = 5 })
end })

Tabs.MineTab:Paragraph({ Title = "⛏️ 矿山脚本", Desc = "Mine-a-mountain 相关脚本", Image = "pickaxe", ImageSize = 34, Color = Color3.fromRGB(255, 165, 0) })
Tabs.MineTab:Section({ Title = "⛏️ 矿山脚本加载" })
Tabs.MineTab:Button({ Title = "加载 Mine-a-mountain (脚本1)", Icon = "hammer", Callback = function() 
    loadstring(game:HttpGet("https://pastebin.com/raw/z8KgbT9H"))()
    WindUI:Notify({ Title = "矿山脚本1", Content = "已加载！", Duration = 3 })
end })
Tabs.MineTab:Button({ Title = "加载 Mine-a-mountain (脚本2)", Icon = "pickaxe", Callback = function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/WoiiKau/Mine-a-mountain/refs/heads/main/MaM"))()
    WindUI:Notify({ Title = "矿山脚本2", Content = "已加载！", Duration = 3 })
end })
Tabs.MineTab:Button({ Title = "🔄 加载全部矿山脚本", Icon = "refresh-cw", Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/z8KgbT9H"))()
    task.wait(0.3)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/WoiiKau/Mine-a-mountain/refs/heads/main/MaM"))()
    WindUI:Notify({ Title = "全部加载", Content = "两个矿山脚本已加载！", Duration = 3 })
end })

Tabs.LemonTab:Paragraph({ Title = "🍋 柠檬脚本", Desc = "需解卡密，不会加原作者dc", Image = "citrus", ImageSize = 34, Color = Color3.fromRGB(0, 255, 0) })
Tabs.LemonTab:Button({ Title = "加载柠檬", Icon = "play", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Fluxyyy333/HoshiOnTop/main/loader.lua"))() end })

Tabs.TXTab:Paragraph({ Title = "🌐 TX 翻译", Desc = "全自动翻译脚本", Image = "languages", ImageSize = 34, Color = Color3.fromRGB(75, 0, 130) })
Tabs.TXTab:Button({ Title = "加载翻译", Icon = "play", Callback = function() TX = "TX Script" Script = "全自动翻译" loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-language"))() end })

Tabs.RunRaceTab:Paragraph({ Title = "🏃 Run Race", Desc = "Ruby Hub", Image = "flag", ImageSize = 34, Color = Color3.fromRGB(255, 0, 0) })
Tabs.RunRaceTab:Button({ Title = "加载脚本", Icon = "play", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Deni210/raceclicker/main/Ruby%20Hub%20v1.0", true))() end })

Tabs.AimbotTab:Paragraph({ Title = "🔍 ESP 透视", Desc = "V3.0 手机版", Image = "eye", ImageSize = 34, Color = Color3.fromRGB(255, 0, 0) })
Tabs.AimbotTab:Button({ Title = "加载 ESP", Icon = "play", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/1215203698741/Roblox-ESP-Antibot-V3/refs/heads/main/V3.0phone.lua"))() end })

Tabs.ScriptsTab:Paragraph({ Title = "多种脚本整合", Desc = "各类脚本合集", Image = "folder-code", ImageSize = 34, Color = Color3.fromRGB(0, 0, 255) })
Tabs.ScriptsTab:Section({ Title = "YI 脚本" })
Tabs.ScriptsTab:Button({ Title = "加载 YI", Icon = "play", Callback = function() getgenv().YI_HUB = "YI_HUB群979312897" loadstring(game:HttpGet('https://raw.githubusercontent.com/YI-HUB-TEAM/YIscript/refs/heads/main/YI_HUB'))("") end })
Tabs.ScriptsTab:Section({ Title = "PI 脚本" })
Tabs.ScriptsTab:Button({ Title = "加载 PI", Icon = "play", Callback = function() getgenv().XiaoPi = "皮脚本QQ群1002100032" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))() end })
Tabs.ScriptsTab:Section({ Title = "BS 脚本" })
Tabs.ScriptsTab:Button({ Title = "加载 BS", Icon = "play", Callback = function() loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\103\105\116\101\101\46\99\111\109\47\66\83\95\115\99\114\105\112\116\47\115\99\114\105\112\116\47\114\97\119\47\109\97\115\116\101\114\47\66\83\95\83\99\114\105\112\116\46\76\117\97\117"))() end })
Tabs.ScriptsTab:Section({ Title = "沙 脚本" })
Tabs.ScriptsTab:Button({ Title = "加载 沙", Icon = "play", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/114514lzkill/ShaHUB/refs/heads/main/ShaHUB"))() end })
Tabs.ScriptsTab:Section({ Title = "Kanl 破解版" })
Tabs.ScriptsTab:Button({ Title = "加载 Kanl", Icon = "play", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/eksan966/Federal/refs/heads/main/Kanl"))() end })
Tabs.ScriptsTab:Section({ Title = "For 脚本中心" })
Tabs.ScriptsTab:Button({ Title = "加载 For", Icon = "play", Callback = function() getgenv().SCRIPT_KEY = "" loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/28f05f20579742b8db3901d189ca93ddecb4ff36815cee23d34bdff05ad7ae33/download"))() end })

Tabs.NoticeTab:Button({ Title = "🌈 彩虹主题", Icon = "palette", Callback = function() WindUI:Notify({ Title = "🌈 彩虹", Content = "UI已变彩虹色！", Duration = 3 }) end })
