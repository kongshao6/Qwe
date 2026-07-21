-- 自定义卡密验证系统
local correctKey = "ksnb"
local maxAttempts = 3
local attempts = 0

-- 用户名白名单
local allowedUsers = {
    "youkhuoo",
}

local function kickPlayer(msg)
    local LocalPlayer = game:GetService("Players").LocalPlayer
    if LocalPlayer then
        LocalPlayer:Kick(msg)
    end
end

local function verifyUser()
    local playerName = game:GetService("Players").LocalPlayer.Name
    for _, name in ipairs(allowedUsers) do
        if playerName:lower() == name:lower() then
            return true
        end
    end
    return false
end

-- 创建卡密验证界面
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

local function showErrorPopup(msg, autoKick)
    local errorGui = Instance.new("ScreenGui")
    errorGui.Name = "ErrorPopup"
    errorGui.ResetOnSpawn = false
    errorGui.Parent = playerGui
    
    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.Size = UDim2.new(0, 0, 0, 0)
    frame.Parent = errorGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = frame
    
    local rainbowBorder = Instance.new("Frame")
    rainbowBorder.Size = UDim2.new(1, 4, 1, 4)
    rainbowBorder.Position = UDim2.new(0, -2, 0, -2)
    rainbowBorder.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    rainbowBorder.BorderSizePixel = 0
    rainbowBorder.Parent = frame
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 14)
    borderCorner.Parent = rainbowBorder
    
    task.spawn(function()
        local hue = 0
        while errorGui and errorGui.Parent and rainbowBorder and rainbowBorder.Parent do
            rainbowBorder.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
            hue = (hue + 0.008) % 1
            task.wait()
        end
    end)
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(1, 0, 0, 30)
    iconLabel.Position = UDim2.new(0, 0, 0, 10)
    iconLabel.Text = "🚫"
    iconLabel.TextSize = 28
    iconLabel.BackgroundTransparency = 1
    iconLabel.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 22)
    title.Position = UDim2.new(0, 0, 0, 38)
    title.Text = "ks(??)"
    title.TextSize = 20
    title.Font = Enum.Font.SourceSansBold
    title.BackgroundTransparency = 1
    title.Parent = frame
    
    task.spawn(function()
        local hue = 0
        while errorGui and errorGui.Parent and title and title.Parent do
            title.TextColor3 = Color3.fromHSV(hue, 1, 1)
            hue = (hue + 0.01) % 1
            task.wait()
        end
    end)
    
    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -20, 0, 35)
    desc.Position = UDim2.new(0, 10, 0, 62)
    desc.Text = msg
    desc.TextColor3 = Color3.fromRGB(60, 60, 60)
    desc.TextSize = 13
    desc.Font = Enum.Font.SourceSans
    desc.BackgroundTransparency = 1
    desc.TextWrapped = true
    desc.Parent = frame
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 240, 0, 32)
    closeBtn.Position = UDim2.new(0.5, -120, 0, 100)
    closeBtn.Text = "确定"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 15
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    closeBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = closeBtn
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Thickness = 2
    btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    btnStroke.Parent = closeBtn
    
    task.spawn(function()
        local hue = 0
        while errorGui and errorGui.Parent and btnStroke and btnStroke.Parent do
            btnStroke.Color = Color3.fromHSV(hue, 1, 1)
            closeBtn.BackgroundColor3 = Color3.fromHSV(hue, 0.8, 0.6)
            hue = (hue + 0.015) % 1
            task.wait()
        end
    end)
    
    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 300, 0, 140)})
    tweenIn:Play()
    
    closeBtn.MouseButton1Click:Connect(function()
        errorGui:Destroy()
        if autoKick then
            kickPlayer(msg)
        end
    end)
end

local function verifyKey(input)
    if input == correctKey then
        return true
    else
        attempts = attempts + 1
        if attempts >= maxAttempts then
            showErrorPopup("卡密错误次数过多！即将踢出...", true)
        else
            showErrorPopup("卡密错误！还剩 " .. (maxAttempts - attempts) .. " 次机会", false)
        end
        return false
    end
end

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "KeySystem"
keyGui.ResetOnSpawn = false
keyGui.Parent = playerGui

-- 粒子
local particles = {}
for i = 1, 40 do
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, math.random(4, 10), 0, math.random(4, 10))
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    particle.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1)
    particle.BorderSizePixel = 0
    particle.BackgroundTransparency = 0.4
    particle.Parent = keyGui
    
    local pCorner = Instance.new("UICorner")
    pCorner.CornerRadius = UDim.new(1, 0)
    pCorner.Parent = particle
    
    table.insert(particles, particle)
end

task.spawn(function()
    while keyGui and keyGui.Parent do
        for _, particle in ipairs(particles) do
            local tween = TweenService:Create(particle, TweenInfo.new(math.random(3, 6)), {
                Position = UDim2.new(math.random(), 0, math.random(), 0),
                BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1),
                BackgroundTransparency = math.random(3, 7) / 10,
            })
            tween:Play()
        end
        task.wait(math.random(1, 3))
    end
end)

-- 主框架
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 380, 0, 230)
keyFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
keyFrame.BackgroundTransparency = 0.15
keyFrame.BorderSizePixel = 0
keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
keyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
keyFrame.Size = UDim2.new(0, 0, 0, 0)
keyFrame.Parent = keyGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = keyFrame

-- 彩虹边框
local rainbowBorder = Instance.new("Frame")
rainbowBorder.Size = UDim2.new(1, 4, 1, 4)
rainbowBorder.Position = UDim2.new(0, -2, 0, -2)
rainbowBorder.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
rainbowBorder.BorderSizePixel = 0
rainbowBorder.Parent = keyFrame

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 16)
borderCorner.Parent = rainbowBorder

task.spawn(function()
    local hue = 0
    while keyGui and keyGui.Parent and rainbowBorder and rainbowBorder.Parent do
        rainbowBorder.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
        hue = (hue + 0.005) % 1
        task.wait()
    end
end)

-- 标题
local ksTitle = Instance.new("TextLabel")
ksTitle.Size = UDim2.new(1, 0, 0, 40)
ksTitle.Position = UDim2.new(0, 0, 0, 18)
ksTitle.Text = "KS SCRIPT"
ksTitle.TextSize = 28
ksTitle.Font = Enum.Font.SourceSansBold
ksTitle.BackgroundTransparency = 1
ksTitle.Parent = keyFrame

task.spawn(function()
    local hue = 0
    while keyGui and keyGui.Parent and ksTitle and ksTitle.Parent do
        ksTitle.TextColor3 = Color3.fromHSV(hue, 1, 1)
        hue = (hue + 0.008) % 1
        task.wait()
    end
end)

local subLabel = Instance.new("TextLabel")
subLabel.Size = UDim2.new(1, 0, 0, 18)
subLabel.Position = UDim2.new(0, 0, 0, 55)
subLabel.Text = "🔐 请输入卡密以继续"
subLabel.TextColor3 = Color3.fromRGB(80, 80, 80)
subLabel.TextSize = 13
subLabel.Font = Enum.Font.SourceSans
subLabel.BackgroundTransparency = 1
subLabel.Parent = keyFrame

-- 输入框
local inputBg = Instance.new("Frame")
inputBg.Size = UDim2.new(0, 300, 0, 45)
inputBg.Position = UDim2.new(0.5, -150, 0, 85)
inputBg.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
inputBg.BorderSizePixel = 0
inputBg.Parent = keyFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 10)
inputCorner.Parent = inputBg

local inputRainbowStroke = Instance.new("UIStroke")
inputRainbowStroke.Thickness = 2
inputRainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
inputRainbowStroke.Parent = inputBg

task.spawn(function()
    local hue = 0
    while keyGui and keyGui.Parent and inputRainbowStroke and inputRainbowStroke.Parent do
        inputRainbowStroke.Color = Color3.fromHSV(hue, 1, 1)
        hue = (hue + 0.01) % 1
        task.wait()
    end
end)

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -16, 1, 0)
keyInput.Position = UDim2.new(0, 8, 0, 0)
keyInput.PlaceholderText = "请输入卡密..."
keyInput.Text = ""
keyInput.TextColor3 = Color3.fromRGB(40, 40, 40)
keyInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
keyInput.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
keyInput.BorderSizePixel = 0
keyInput.Font = Enum.Font.SourceSans
keyInput.TextSize = 16
keyInput.ClearTextOnFocus = false
keyInput.Parent = inputBg

-- 验证按钮
local keyButton = Instance.new("TextButton")
keyButton.Size = UDim2.new(0, 300, 0, 45)
keyButton.Position = UDim2.new(0.5, -150, 0, 145)
keyButton.Text = "⚡ 验 证"
keyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
keyButton.TextSize = 18
keyButton.Font = Enum.Font.SourceSansBold
keyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
keyButton.Parent = keyFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = keyButton

local btnGlowStroke = Instance.new("UIStroke")
btnGlowStroke.Thickness = 2
btnGlowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
btnGlowStroke.Parent = keyButton

task.spawn(function()
    local hue = 0
    while keyGui and keyGui.Parent and btnGlowStroke and btnGlowStroke.Parent do
        btnGlowStroke.Color = Color3.fromHSV(hue, 1, 1)
        keyButton.BackgroundColor3 = Color3.fromHSV(hue, 0.8, 0.6)
        hue = (hue + 0.01) % 1
        task.wait()
    end
end)

keyButton.MouseEnter:Connect(function()
    TweenService:Create(btnGlowStroke, TweenInfo.new(0.2), {Thickness = 4}):Play()
end)

keyButton.MouseLeave:Connect(function()
    TweenService:Create(btnGlowStroke, TweenInfo.new(0.2), {Thickness = 2}):Play()
end)

-- 底部版权
local footerLabel = Instance.new("TextLabel")
footerLabel.Size = UDim2.new(1, 0, 0, 18)
footerLabel.Position = UDim2.new(0, 0, 0, 200)
footerLabel.Text = "KS Script © 2024"
footerLabel.TextSize = 11
footerLabel.Font = Enum.Font.SourceSans
footerLabel.BackgroundTransparency = 1
footerLabel.Parent = keyFrame

task.spawn(function()
    local hue = 0
    while keyGui and keyGui.Parent and footerLabel and footerLabel.Parent do
        footerLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
        hue = (hue + 0.008) % 1
        task.wait()
    end
end)

-- 入场动画
local tweenIn = TweenService:Create(keyFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 380, 0, 230)})
tweenIn:Play()

-- 确认
local verified = false

keyButton.MouseButton1Click:Connect(function()
    if verifyKey(keyInput.Text) then
        verified = true
        keyGui:Destroy()
    end
end)

keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        if verifyKey(keyInput.Text) then
            verified = true
            keyGui:Destroy()
        end
    end
end)

repeat task.wait() until verified

-- 卡密通过后验证用户名
if not verifyUser() then
    pcall(function()
        setclipboard("3236904498")
    end)
    
    local whitelistGui = Instance.new("ScreenGui")
    whitelistGui.Name = "WhitelistPopup"
    whitelistGui.ResetOnSpawn = false
    whitelistGui.Parent = playerGui
    
    local wFrame = Instance.new("Frame")
    wFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    wFrame.BackgroundTransparency = 0.1
    wFrame.BorderSizePixel = 0
    wFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    wFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    wFrame.Size = UDim2.new(0, 0, 0, 0)
    wFrame.Parent = whitelistGui
    
    local wCorner = Instance.new("UICorner")
    wCorner.CornerRadius = UDim.new(0, 12)
    wCorner.Parent = wFrame
    
    local wBorder = Instance.new("Frame")
    wBorder.Size = UDim2.new(1, 4, 1, 4)
    wBorder.Position = UDim2.new(0, -2, 0, -2)
    wBorder.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    wBorder.BorderSizePixel = 0
    wBorder.Parent = wFrame
    
    local wBorderCorner = Instance.new("UICorner")
    wBorderCorner.CornerRadius = UDim.new(0, 14)
    wBorderCorner.Parent = wBorder
    
    task.spawn(function()
        local hue = 0
        while whitelistGui and whitelistGui.Parent do
            wBorder.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
            hue = (hue + 0.008) % 1
            task.wait()
        end
    end)
    
    local wIcon = Instance.new("TextLabel")
    wIcon.Size = UDim2.new(1, 0, 0, 30)
    wIcon.Position = UDim2.new(0, 0, 0, 12)
    wIcon.Text = "🚫"
    wIcon.TextSize = 28
    wIcon.BackgroundTransparency = 1
    wIcon.Parent = wFrame
    
    local wTitle = Instance.new("TextLabel")
    wTitle.Size = UDim2.new(1, 0, 0, 22)
    wTitle.Position = UDim2.new(0, 0, 0, 40)
    wTitle.Text = "用户名未授权"
    wTitle.TextSize = 20
    wTitle.Font = Enum.Font.SourceSansBold
    wTitle.BackgroundTransparency = 1
    wTitle.Parent = wFrame
    
    task.spawn(function()
        local hue = 0
        while whitelistGui and whitelistGui.Parent and wTitle and wTitle.Parent do
            wTitle.TextColor3 = Color3.fromHSV(hue, 1, 1)
            hue = (hue + 0.01) % 1
            task.wait()
        end
    end)
    
    local wDesc = Instance.new("TextLabel")
    wDesc.Size = UDim2.new(1, -20, 0, 50)
    wDesc.Position = UDim2.new(0, 10, 0, 65)
    wDesc.Text = "你的用户名: " .. game:GetService("Players").LocalPlayer.Name .. "\n\n作者QQ已复制: 3236904498\n请联系作者加入白名单\n\n3秒后自动踢出..."
    wDesc.TextColor3 = Color3.fromRGB(60, 60, 60)
    wDesc.TextSize = 13
    wDesc.Font = Enum.Font.SourceSans
    wDesc.BackgroundTransparency = 1
    wDesc.TextWrapped = true
    wDesc.Parent = wFrame
    
    local wCount = Instance.new("TextLabel")
    wCount.Size = UDim2.new(1, 0, 0, 20)
    wCount.Position = UDim2.new(0, 0, 0, 140)
    wCount.Text = "3"
    wCount.TextColor3 = Color3.fromRGB(255, 0, 0)
    wCount.TextSize = 18
    wCount.Font = Enum.Font.SourceSansBold
    wCount.BackgroundTransparency = 1
    wCount.Parent = wFrame
    
    local tweenIn2 = TweenService:Create(wFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 320, 0, 170)})
    tweenIn2:Play()
    
    -- 倒计时3秒踢出
    for i = 3, 1, -1 do
        wCount.Text = tostring(i)
        task.wait(1)
    end
    kickPlayer("用户名未授权，请联系作者QQ:3236904498")
    
    -- 死循环防止继续
    while true do task.wait(1) end
end

-- 加载 WindUI 库
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- 创建主窗口
local Window = WindUI:CreateWindow({
    Title = "ks script",
    Icon = "door-open",
    Author = "ks script",
    Folder = "ks script",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
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
    LemonTab     = Window:Tab({ Title = "柠檬",         Icon = "citrus",          Desc = "HoshiOnTop 脚本加载器" }),
    ScriptsTab   = Window:Tab({ Title = "多种脚本整合",  Icon = "folder-code",     Desc = "各类脚本合集" }),
    TXTab        = Window:Tab({ Title = "TX翻译",       Icon = "languages",       Desc = "全自动翻译脚本" }),
    RunRaceTab   = Window:Tab({ Title = "Run Race",     Icon = "flag",            Desc = "Run Race 脚本加载器" }),
    AimbotTab    = Window:Tab({ Title = "自瞄一类",      Icon = "crosshair",       Desc = "ESP 透视脚本" }),
    UniversalTab = Window:Tab({ Title = "通用功能",      Icon = "wrench",          Desc = "飞行功能" }),
}

Window:SelectTab(1)

-- ============================================================
-- 通知标签页
-- ============================================================

Tabs.NoticeTab:Paragraph({
    Title = "📢 脚本公告",
    Desc = "欢迎使用 ks script！",
    Image = "bell",
    ImageSize = 34,
    Color = Color3.fromRGB(255, 0, 0),
})

Tabs.NoticeTab:Paragraph({
    Title = "📝 脚本介绍",
    Desc = "此脚本为缝合各种脚本\n倒卖sm",
    Image = "info",
    ImageSize = 34,
    Color = Color3.fromRGB(255, 165, 0),
})

Tabs.NoticeTab:Paragraph({
    Title = "⚠️ 警告",
    Desc = "请勿倒卖本脚本，尊重原作者劳动成果！",
    Image = "triangle-alert",
    ImageSize = 34,
    Color = Color3.fromRGB(255, 255, 0),
})

Tabs.NoticeTab:Button({
    Title = "👤 作者QQ: 3236904498 (点击复制)",
    Desc = "点击复制QQ号到剪贴板",
    Icon = "clipboard-copy",
    Callback = function()
        pcall(function()
            setclipboard("3236904498")
        end)
        WindUI:Notify({
            Title = "已复制",
            Content = "QQ号 3236904498 已复制到剪贴板！",
            Icon = "check-circle",
            Duration = 3,
        })
    end
})

-- ============================================================
-- 柠檬标签页
-- ============================================================

Tabs.LemonTab:Paragraph({
    Title = "🍋 柠檬脚本",
    Desc = "此脚本需要解卡密\n不会的可以加原作者dc群去学哦",
    Image = "citrus",
    ImageSize = 34,
    Color = Color3.fromRGB(0, 255, 0),
})

Tabs.LemonTab:Button({
    Title = "加载柠檬脚本",
    Desc = "点击执行 HoshiOnTop 脚本",
    Icon = "play",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Fluxyyy333/HoshiOnTop/main/loader.lua"))()
        WindUI:Notify({
            Title = "柠檬脚本",
            Content = "HoshiOnTop 脚本已执行！",
            Icon = "check-circle",
            Duration = 3,
        })
    end
})

-- ============================================================
-- 多种脚本整合标签页
-- ============================================================

Tabs.ScriptsTab:Paragraph({
    Title = "多种脚本整合",
    Desc = "以下是各类脚本合集，点击对应按钮即可执行",
    Image = "folder-code",
    ImageSize = 34,
    Color = Color3.fromRGB(0, 0, 255),
})

Tabs.ScriptsTab:Section({ Title = "YI 脚本" })
Tabs.ScriptsTab:Button({
    Title = "加载 YI 脚本",
    Desc = "YI_HUB 脚本加载器",
    Icon = "play",
    Callback = function()
        getgenv().YI_HUB = "YI_HUB群979312897"
        loadstring(game:HttpGet('https://raw.githubusercontent.com/YI-HUB-TEAM/YIscript/refs/heads/main/YI_HUB'))("")
        WindUI:Notify({
            Title = "YI 脚本",
            Content = "YI_HUB 脚本已执行！",
            Icon = "check-circle",
            Duration = 3,
        })
    end
})

Tabs.ScriptsTab:Section({ Title = "PI 脚本" })
Tabs.ScriptsTab:Button({
    Title = "加载 PI 脚本",
    Desc = "皮脚本 - QQ群1002100032",
    Icon = "play",
    Callback = function()
        getgenv().XiaoPi = "皮脚本QQ群1002100032"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
        WindUI:Notify({
            Title = "PI 脚本",
            Content = "皮脚本已执行！",
            Icon = "check-circle",
            Duration = 3,
        })
    end
})

Tabs.ScriptsTab:Section({ Title = "BS 脚本" })
Tabs.ScriptsTab:Button({
    Title = "加载 BS 脚本",
    Desc = "BS_Script 加载器",
    Icon = "play",
    Callback = function()
        BS = "\104\116\116\112\115\58\47\47\103\105\116\101\101\46\99\111\109\47\66\83\95\115\99\114\105\112\116\47\115\99\114\105\112\116\47\114\97\119\47\109\97\115\116\101\114\47\66\83\95\83\99\114\105\112\116\46\76\117\97\117"
        loadstring(game:HttpGet(BS))()
        WindUI:Notify({
            Title = "BS 脚本",
            Content = "BS_Script 已执行！",
            Icon = "check-circle",
            Duration = 3,
        })
    end
})

Tabs.ScriptsTab:Section({ Title = "沙 脚本" })
Tabs.ScriptsTab:Button({
    Title = "加载 沙 脚本",
    Desc = "ShaHUB 加载器",
    Icon = "play",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/114514lzkill/ShaHUB/refs/heads/main/ShaHUB"))()
        WindUI:Notify({
            Title = "沙脚本",
            Content = "ShaHUB 已执行！",
            Icon = "check-circle",
            Duration = 3,
        })
    end
})

Tabs.ScriptsTab:Section({ Title = "Kanl 破解版" })
Tabs.ScriptsTab:Button({
    Title = "加载 Kanl 破解版",
    Desc = "Kanl 破解版加载器",
    Icon = "play",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/eksan966/Federal/refs/heads/main/Kanl"))()
        WindUI:Notify({
            Title = "Kanl 脚本",
            Content = "Kanl 破解版已执行！",
            Icon = "check-circle",
            Duration = 3,
        })
    end
})

Tabs.ScriptsTab:Section({ Title = "For 脚本中心" })
Tabs.ScriptsTab:Button({
    Title = "加载 For 脚本中心",
    Desc = "脚本中心加载器",
    Icon = "play",
    Callback = function()
        getgenv().SCRIPT_KEY = ""
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/28f05f20579742b8db3901d189ca93ddecb4ff36815cee23d34bdff05ad7ae33/download"))()
        WindUI:Notify({
            Title = "For 脚本中心",
            Content = "脚本中心已执行！",
            Icon = "check-circle",
            Duration = 3,
        })
    end
})

-- ============================================================
-- TX翻译标签页
-- ============================================================

Tabs.TXTab:Paragraph({
    Title = "🌐 TX 翻译脚本",
    Desc = "全自动翻译脚本，助您畅玩全球游戏",
    Image = "languages",
    ImageSize = 34,
    Color = Color3.fromRGB(75, 0, 130),
})

Tabs.TXTab:Button({
    Title = "加载 TX 翻译",
    Desc = "点击执行全自动翻译脚本",
    Icon = "play",
    Callback = function()
        TX = "TX Script"
        Script = "全自动翻译"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-language"))()
        WindUI:Notify({
            Title = "TX 翻译",
            Content = "全自动翻译脚本已执行！",
            Icon = "check-circle",
            Duration = 3,
        })
    end
})

-- ============================================================
-- Run Race 标签页
-- ============================================================

Tabs.RunRaceTab:Paragraph({
    Title = "🏃 Run Race 脚本",
    Desc = "Ruby Hub Run Race 脚本加载器",
    Image = "flag",
    ImageSize = 34,
    Color = Color3.fromRGB(255, 0, 0),
})

Tabs.RunRaceTab:Button({
    Title = "加载 Run Race 脚本",
    Desc = "点击执行 Ruby Hub v1.0",
    Icon = "play",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Deni210/raceclicker/main/Ruby%20Hub%20v1.0", true))()
        WindUI:Notify({
            Title = "Run Race",
            Content = "Ruby Hub v1.0 脚本已执行！",
            Icon = "check-circle",
            Duration = 3,
        })
    end
})

-- ============================================================
-- 自瞄一类标签页
-- ============================================================

Tabs.AimbotTab:Paragraph({
    Title = "🔍 ESP 透视脚本",
    Desc = "Roblox ESP 透视与反机器人 V3.0 手机版",
    Image = "eye",
    ImageSize = 34,
    Color = Color3.fromRGB(255, 0, 0),
})

Tabs.AimbotTab:Button({
    Title = "加载 ESP 透视脚本",
    Desc = "点击加载完整 ESP 透视系统",
    Icon = "play",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/1215203698741/Roblox-ESP-Antibot-V3/refs/heads/main/V3.0phone.lua"))()
        WindUI:Notify({
            Title = "ESP 透视",
            Content = "ESP 透视脚本已加载！",
            Icon = "check-circle",
            Duration = 3,
        })
    end
})

-- ============================================================
-- 通用功能标签页
-- ============================================================

Tabs.UniversalTab:Paragraph({
    Title = "✈️ 飞行功能",
    Desc = "空少汉化飞行脚本 V3 版本",
    Image = "plane",
    ImageSize = 34,
    Color = Color3.fromRGB(0, 255, 200),
})

Tabs.UniversalTab:Button({
    Title = "飞行V3汉化",
    Desc = "加载空少汉化飞行V3脚本",
    Icon = "plane",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kongshao6/Qwe/main/Ksfly.lua"))()
        WindUI:Notify({
            Title = "飞行V3汉化",
            Content = "飞行脚本已加载！",
            Icon = "check-circle",
            Duration = 3,
        })
    end
})

-- ============================================================
-- 彩虹主题按钮
-- ============================================================

Tabs.NoticeTab:Button({
    Title = "🌈 彩虹主题激活",
    Desc = "点击查看彩虹效果",
    Icon = "palette",
    Callback = function()
        WindUI:Notify({
            Title = "🌈 彩虹主题",
            Content = "您的UI已变成彩虹色！",
            Icon = "check-circle",
            Duration = 3,
        })
    end
})
