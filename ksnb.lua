-- 自定义卡密验证系统
local correctKey = "ksnb"
local maxAttempts = 3
local attempts = 0

local function kickPlayer()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    if LocalPlayer then
        LocalPlayer:Kick("sb ksnb都不知道你用啥我的脚本")
    end
end

local function showErrorPopup()
    local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    
    local errorGui = Instance.new("ScreenGui")
    errorGui.Name = "ErrorPopup"
    errorGui.ResetOnSpawn = false
    errorGui.Parent = playerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = errorGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.Text = "ks(??)"
    title.TextColor3 = Color3.fromRGB(255, 50, 50)
    title.TextSize = 28
    title.Font = Enum.Font.SourceSansBold
    title.BackgroundTransparency = 1
    title.Parent = frame
    
    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -20, 0, 30)
    desc.Position = UDim2.new(0, 10, 0, 55)
    desc.Text = "卡密错误！还剩 " .. (maxAttempts - attempts) .. " 次机会"
    desc.TextColor3 = Color3.fromRGB(255, 255, 255)
    desc.TextSize = 16
    desc.Font = Enum.Font.SourceSans
    desc.BackgroundTransparency = 1
    desc.Parent = frame
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 80, 0, 35)
    closeBtn.Position = UDim2.new(0.5, -40, 0, 100)
    closeBtn.Text = "确定"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 18
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(function()
        errorGui:Destroy()
        if attempts >= maxAttempts then
            kickPlayer()
        end
    end)
end

local function verifyKey(input)
    if input == correctKey then
        return true
    else
        attempts = attempts + 1
        showErrorPopup()
        return false
    end
end

-- 创建验证界面
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "KeySystem"
keyGui.ResetOnSpawn = false
keyGui.Parent = playerGui

-- 背景模糊遮罩
local blurBg = Instance.new("Frame")
blurBg.Size = UDim2.new(1, 0, 1, 0)
blurBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blurBg.BackgroundTransparency = 0.5
blurBg.BorderSizePixel = 0
blurBg.Parent = keyGui

-- 粒子效果
local particles = {}
for i = 1, 25 do
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, math.random(3, 8), 0, math.random(3, 8))
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    particle.BackgroundColor3 = Color3.fromRGB(255, math.random(50, 150), math.random(50, 150))
    particle.BorderSizePixel = 0
    particle.BackgroundTransparency = 0.7
    particle.Parent = keyGui
    
    local pCorner = Instance.new("UICorner")
    pCorner.CornerRadius = UDim.new(1, 0)
    pCorner.Parent = particle
    
    table.insert(particles, particle)
end

-- 粒子动画
task.spawn(function()
    while keyGui and keyGui.Parent do
        for _, particle in ipairs(particles) do
            local newX = math.random() 
            local newY = math.random()
            local tween = TweenService:Create(particle, TweenInfo.new(math.random(3, 6)), {Position = UDim2.new(newX, 0, newY, 0)})
            tween:Play()
        end
        task.wait(math.random(2, 4))
    end
end)

-- 主框架
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 420, 0, 300)
keyFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
keyFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui

-- 红色边框光晕
local glowFrame = Instance.new("Frame")
glowFrame.Size = UDim2.new(1, 20, 1, 20)
glowFrame.Position = UDim2.new(0, -10, 0, -10)
glowFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
glowFrame.BackgroundTransparency = 0.6
glowFrame.BorderSizePixel = 0
glowFrame.Parent = keyFrame

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 16)
glowCorner.Parent = glowFrame

-- 主框架圆角
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = keyFrame

-- 顶部红色标题栏
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 60)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 15, 15)
titleBar.BorderSizePixel = 0
titleBar.Parent = keyFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- KS SCRIPT 大标题
local ksTitle = Instance.new("TextLabel")
ksTitle.Size = UDim2.new(1, 0, 0, 35)
ksTitle.Position = UDim2.new(0, 0, 0, 5)
ksTitle.Text = "KS SCRIPT"
ksTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ksTitle.TextSize = 26
ksTitle.Font = Enum.Font.SourceSansBold
ksTitle.BackgroundTransparency = 1
ksTitle.Parent = titleBar

-- 副标题
local subTitleBar = Instance.new("TextLabel")
subTitleBar.Size = UDim2.new(1, 0, 0, 18)
subTitleBar.Position = UDim2.new(0, 0, 0, 36)
subTitleBar.Text = "🔐 身份验证系统"
subTitleBar.TextColor3 = Color3.fromRGB(255, 200, 200)
subTitleBar.TextSize = 13
subTitleBar.Font = Enum.Font.SourceSans
subTitleBar.BackgroundTransparency = 1
subTitleBar.Parent = titleBar

-- 欢迎文字
local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(1, -40, 0, 25)
welcomeLabel.Position = UDim2.new(0, 20, 0, 75)
welcomeLabel.Text = "👋 欢迎使用 KS Script"
welcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
welcomeLabel.TextSize = 16
welcomeLabel.Font = Enum.Font.SourceSansBold
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
welcomeLabel.Parent = keyFrame

-- 提示文字
local hintText = Instance.new("TextLabel")
hintText.Size = UDim2.new(1, -40, 0, 20)
hintText.Position = UDim2.new(0, 20, 0, 100)
hintText.Text = "请输入卡密以解锁全部功能"
hintText.TextColor3 = Color3.fromRGB(160, 160, 160)
hintText.TextSize = 13
hintText.Font = Enum.Font.SourceSans
hintText.BackgroundTransparency = 1
hintText.TextXAlignment = Enum.TextXAlignment.Left
hintText.Parent = keyFrame

-- 输入框背景
local inputBg = Instance.new("Frame")
inputBg.Size = UDim2.new(0, 340, 0, 48)
inputBg.Position = UDim2.new(0.5, -170, 0, 130)
inputBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
inputBg.BorderSizePixel = 0
inputBg.Parent = keyFrame

local inputBgCorner = Instance.new("UICorner")
inputBgCorner.CornerRadius = UDim.new(0, 10)
inputBgCorner.Parent = inputBg

-- 输入框边框
local inputStroke = Instance.new("UIStroke")
inputStroke.Color = Color3.fromRGB(255, 40, 40)
inputStroke.Thickness = 1.5
inputStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
inputStroke.Parent = inputBg

-- 锁图标
local lockIcon = Instance.new("TextLabel")
lockIcon.Size = UDim2.new(0, 40, 1, 0)
lockIcon.Text = "🔒"
lockIcon.TextSize = 20
lockIcon.BackgroundTransparency = 1
lockIcon.Parent = inputBg

-- 输入框
local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -50, 1, 0)
keyInput.Position = UDim2.new(0, 45, 0, 0)
keyInput.PlaceholderText = "请输入卡密..."
keyInput.Text = ""
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
keyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyInput.BorderSizePixel = 0
keyInput.Font = Enum.Font.SourceSans
keyInput.TextSize = 17
keyInput.ClearTextOnFocus = false
keyInput.Parent = inputBg

-- 验证按钮
local keyButton = Instance.new("TextButton")
keyButton.Size = UDim2.new(0, 340, 0, 48)
keyButton.Position = UDim2.new(0.5, -170, 0, 195)
keyButton.Text = "⚡ 点击验证"
keyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
keyButton.TextSize = 19
keyButton.Font = Enum.Font.SourceSansBold
keyButton.BackgroundColor3 = Color3.fromRGB(255, 20, 20)
keyButton.Parent = keyFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = keyButton

-- 按钮悬停效果
keyButton.MouseEnter:Connect(function()
    TweenService:Create(keyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}):Play()
    TweenService:Create(keyButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 345, 0, 50)}):Play()
end)

keyButton.MouseLeave:Connect(function()
    TweenService:Create(keyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 20, 20)}):Play()
    TweenService:Create(keyButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 340, 0, 48)}):Play()
end)

-- 底部信息
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -40, 0, 20)
infoLabel.Position = UDim2.new(0, 20, 0, 255)
infoLabel.Text = "💡 卡密由作者提供"
infoLabel.TextColor3 = Color3.fromRGB(110, 110, 110)
infoLabel.TextSize = 12
infoLabel.Font = Enum.Font.SourceSans
infoLabel.BackgroundTransparency = 1
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.Parent = keyFrame

-- 底部版权
local copyLabel = Instance.new("TextLabel")
copyLabel.Size = UDim2.new(1, -40, 0, 20)
copyLabel.Position = UDim2.new(0, 20, 0, 272)
copyLabel.Text = "By: KS Script © 2024"
copyLabel.TextColor3 = Color3.fromRGB(90, 90, 90)
copyLabel.TextSize = 11
copyLabel.Font = Enum.Font.SourceSans
copyLabel.BackgroundTransparency = 1
copyLabel.TextXAlignment = Enum.TextXAlignment.Right
copyLabel.Parent = keyFrame

-- 装饰线条
local decorLine = Instance.new("Frame")
decorLine.Size = UDim2.new(0, 60, 0, 2)
decorLine.Position = UDim2.new(0, 20, 0, 123)
decorLine.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
decorLine.BorderSizePixel = 0
decorLine.Parent = keyFrame

-- 入场动画
keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
keyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
keyFrame.Size = UDim2.new(0, 0, 0, 0)
keyFrame.BackgroundTransparency = 1
local tweenIn = TweenService:Create(keyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 420, 0, 300)})
local tweenAlpha = TweenService:Create(keyFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0})
tweenIn:Play()
tweenAlpha:Play()

-- 确认
local verified = false

keyButton.MouseButton1Click:Connect(function()
    if verifyKey(keyInput.Text) then
        verified = true
        keyGui:Destroy()
    end
end)

-- 回车确认
keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        if verifyKey(keyInput.Text) then
            verified = true
            keyGui:Destroy()
        end
    end
end)

-- 等待验证
repeat task.wait() until verified

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
