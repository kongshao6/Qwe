-- 自定义卡密验证系统
local correctKey = string.char(107, 115, 110, 98)  -- 简单混淆 "ksnb"
local maxAttempts = 3
local attempts = 0

local function kickPlayer(msg)
    local LocalPlayer = game:GetService("Players").LocalPlayer
    if LocalPlayer then LocalPlayer:Kick(msg) end
end

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
        if autoKick then kickPlayer(msg) end
    end)
end

local function verifyKey(input)
    if input == correctKey then return true
    else
        attempts = attempts + 1
        if attempts >= maxAttempts then showErrorPopup("卡密错误次数过多！即将踢出...", true)
        else showErrorPopup("卡密错误！还剩 " .. (maxAttempts - attempts) .. " 次机会", false) end
        return false
    end
end

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "KeySystem"
keyGui.ResetOnSpawn = false
keyGui.Parent = playerGui

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

local tweenIn = TweenService:Create(keyFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 380, 0, 230)})
tweenIn:Play()

local verified = false
keyButton.MouseButton1Click:Connect(function()
    if verifyKey(keyInput.Text) then verified = true keyGui:Destroy() end
end)
keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then if verifyKey(keyInput.Text) then verified = true keyGui:Destroy() end end
end)
repeat task.wait() until verified

-- ============================================================
-- 加载 WindUI（锁定 1.6.66 版本）
-- ============================================================
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/1.6.66/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "KS SCRIPT",
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
    UniversalTab = Window:Tab({ Title = "通用功能",      Icon = "wrench",          Desc = "实用功能合集" }),
}

Window:SelectTab(1)

-- ============================================================
-- 给 WindUI 窗口加背景图片（使用你上传的图片）
-- ============================================================
task.spawn(function()
    local gui = nil
    for i = 1, 30 do
        gui = game:GetService("CoreGui"):FindFirstChild("WindUI") or 
              game.Players.LocalPlayer.PlayerGui:FindFirstChild("WindUI")
        if gui then break end
        task.wait(0.1)
    end
    
    if gui then
        local container = gui:FindFirstChild("Container") or gui:FindFirstChild("Frame") or gui
        
        -- ⭐ 你的背景图
        local bg = Instance.new("ImageLabel")
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.Image = "rbxassetid://1000032541"  -- ✅ 你上传的图片
        bg.ScaleType = Enum.ScaleType.Crop
        bg.ZIndex = 0
        bg.Parent = container
        
        -- 半透明遮罩
        local overlay = Instance.new("Frame")
        overlay.Size = UDim2.new(1, 0, 1, 0)
        overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        overlay.BackgroundTransparency = 0.45
        overlay.BorderSizePixel = 0
        overlay.ZIndex = 1
        overlay.Parent = container
    end
end)

-- 变量
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

-- 通知
Tabs.NoticeTab:Paragraph({ Title = "📢 脚本公告", Desc = "欢迎使用 ks script！", Image = "bell", ImageSize = 34, Color = Color3.fromRGB(255, 0, 0) })
Tabs.NoticeTab:Paragraph({ Title = "📝 脚本介绍", Desc = "此脚本为缝合各种脚本\n倒卖sm", Image = "info", ImageSize = 34, Color = Color3.fromRGB(255, 165, 0) })
Tabs.NoticeTab:Paragraph({ Title = "⚠️ 警告", Desc = "请勿倒卖本脚本！", Image = "triangle-alert", ImageSize = 34, Color = Color3.fromRGB(255, 255, 0) })
Tabs.NoticeTab:Button({ Title = "👤 作者QQ: 3236904498", Icon = "clipboard-copy", Callback = function() pcall(function() setclipboard("3236904498") end) WindUI:Notify({ Title = "已复制", Content = "3236904498", Duration = 3 }) end })

-- 柠檬
Tabs.LemonTab:Paragraph({ Title = "🍋 柠檬脚本", Desc = "需解卡密，不会加原作者dc", Image = "citrus", ImageSize = 34, Color = Color3.fromRGB(0, 255, 0) })
Tabs.LemonTab:Button({ Title = "加载柠檬", Icon = "play", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Fluxyyy333/HoshiOnTop/main/loader.lua"))() end })

-- 脚本整合
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

-- TX翻译
Tabs.TXTab:Paragraph({ Title = "🌐 TX 翻译", Desc = "全自动翻译脚本", Image = "languages", ImageSize = 34, Color = Color3.fromRGB(75, 0, 130) })
Tabs.TXTab:Button({ Title = "加载翻译", Icon = "play", Callback = function() TX = "TX Script" Script = "全自动翻译" loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-language"))() end })

-- Run Race
Tabs.RunRaceTab:Paragraph({ Title = "🏃 Run Race", Desc = "Ruby Hub", Image = "flag", ImageSize = 34, Color = Color3.fromRGB(255, 0, 0) })
Tabs.RunRaceTab:Button({ Title = "加载脚本", Icon = "play", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Deni210/raceclicker/main/Ruby%20Hub%20v1.0", true))() end })

-- 自瞄
Tabs.AimbotTab:Paragraph({ Title = "🔍 ESP 透视", Desc = "V3.0 手机版", Image = "eye", ImageSize = 34, Color = Color3.fromRGB(255, 0, 0) })
Tabs.AimbotTab:Button({ Title = "加载 ESP", Icon = "play", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/1215203698741/Roblox-ESP-Antibot-V3/refs/heads/main/V3.0phone.lua"))() end })

-- 通用功能
Tabs.UniversalTab:Paragraph({ Title = "🛠️ 通用功能", Desc = "开关控制+滑动调节", Image = "wrench", ImageSize = 34, Color = Color3.fromRGB(0, 255, 200) })

Tabs.UniversalTab:Section({ Title = "✈️ 飞行" })
Tabs.UniversalTab:Button({ Title = "飞行V3汉化", Icon = "plane", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kongshao6/Qwe/main/Ksfly.lua"))() WindUI:Notify({ Title = "飞行V3", Content = "已加载！", Duration = 3 }) end })

Tabs.UniversalTab:Section({ Title = "🏃 人物功能" })
Tabs.UniversalTab:Toggle({ Title = "自定义速度", Default = false, Callback = function(v) walkEnabled = v applyAll() end })
Tabs.UniversalTab:Slider({ Title = "速度值", Default = 50, Min = 16, Max = 200, Rounding = 0, Callback = function(v) walkSpeed = v applyAll() end })
Tabs.UniversalTab:Toggle({ Title = "自定义跳跃", Default = false, Callback = function(v) jumpEnabled = v applyAll() end })
Tabs.UniversalTab:Slider({ Title = "跳跃值", Default = 100, Min = 50, Max = 300, Rounding = 0, Callback = function(v) jumpPower = v applyAll() end })
Tabs.UniversalTab:Toggle({ Title = "自定义重力", Default = false, Callback = function(v) gravityEnabled = v applyAll() end })
Tabs.UniversalTab:Slider({ Title = "重力值", Default = 50, Min = 10, Max = 500, Rounding = 1, Callback = function(v) gravityValue = v applyAll() end })
Tabs.UniversalTab:Toggle({ Title = "自定义视野", Default = false, Callback = function(v) fovEnabled = v applyAll() end })
Tabs.UniversalTab:Slider({ Title = "FOV值", Default = 120, Min = 30, Max = 150, Rounding = 0, Callback = function(v) fovValue = v applyAll() end })
Tabs.UniversalTab:Toggle({ Title = "穿墙模式", Default = false, Callback = function(v)
    noclipEnabled = v
    if v then
        noclipConn = game:GetService("RunService").Stepped:Connect(function()
            local char = game.Players.LocalPlayer.Character
            if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
        end)
    else if noclipConn then noclipConn:Disconnect() end end
end })

Tabs.UniversalTab:Section({ Title = "👁️ 视觉功能" })
Tabs.UniversalTab:Toggle({ Title = "夜视模式", Default = false, Callback = function(v)
    local l = game:GetService("Lighting")
    if v then l.Brightness = 5 l.ClockTime = 14 l.FogEnd = 100000 l.GlobalShadows = false
    else l.Brightness = 1 l.FogEnd = 10000 l.GlobalShadows = true end
end })
Tabs.UniversalTab:Slider({ Title = "时间调节", Default = 14, Min = 0, Max = 24, Rounding = 0, Callback = function(v) game:GetService("Lighting").ClockTime = v end })

Tabs.UniversalTab:Section({ Title = "🌐 服务器" })
Tabs.UniversalTab:Button({ Title = "重新加入", Icon = "refresh-cw", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer) end })
Tabs.UniversalTab:Button({ Title = "复制服务器ID", Icon = "clipboard-copy", Callback = function() pcall(function() setclipboard(game.JobId) end) WindUI:Notify({ Title = "已复制", Content = game.JobId, Duration = 3 }) end })

Tabs.NoticeTab:Button({ Title = "🌈 彩虹主题", Icon = "palette", Callback = function() WindUI:Notify({ Title = "🌈 彩虹", Content = "UI已变彩虹色！", Duration = 3 }) end })
