-- 自定义卡密验证系统
local correctKey = "ksnb"
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
-- 加载 Orion UI
-- ============================================================
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "KS SCRIPT",
    HidePremium = false,
    SaveConfig = false,
    ConfigFolder = "ks script",
    IntroEnabled = false,
})

-- ============================================================
-- 变量
-- ============================================================
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

-- ============================================================
-- 通知
-- ============================================================
local NoticeTab = Window:MakeTab({ Name = "通知", Icon = "rbxassetid://123456" })
NoticeTab:AddParagraph("📢 脚本公告", "欢迎使用 ks script！")
NoticeTab:AddParagraph("📝 脚本介绍", "此脚本为缝合各种脚本\n倒卖sm")
NoticeTab:AddParagraph("⚠️ 警告", "请勿倒卖本脚本！")
NoticeTab:AddButton({ Name = "👤 作者QQ: 3236904498 (点击复制)", Callback = function() pcall(function() setclipboard("3236904498") end) OrionLib:MakeNotification({ Name = "已复制", Content = "3236904498", Time = 3 }) end })

-- ============================================================
-- 柠檬
-- ============================================================
local LemonTab = Window:MakeTab({ Name = "柠檬", Icon = "rbxassetid://123456" })
LemonTab:AddParagraph("🍋 柠檬脚本", "需解卡密，不会加原作者dc群")
LemonTab:AddButton({ Name = "加载柠檬脚本", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Fluxyyy333/HoshiOnTop/main/loader.lua"))() OrionLib:MakeNotification({ Name = "柠檬脚本", Content = "HoshiOnTop 已执行！", Time = 3 }) end })

-- ============================================================
-- 多种脚本整合
-- ============================================================
local ScriptsTab = Window:MakeTab({ Name = "多种脚本整合", Icon = "rbxassetid://123456" })
ScriptsTab:AddParagraph("多种脚本整合", "各类脚本合集")
ScriptsTab:AddButton({ Name = "加载 YI 脚本", Callback = function() getgenv().YI_HUB = "YI_HUB群979312897" loadstring(game:HttpGet('https://raw.githubusercontent.com/YI-HUB-TEAM/YIscript/refs/heads/main/YI_HUB'))("") end })
ScriptsTab:AddButton({ Name = "加载 PI 脚本", Callback = function() getgenv().XiaoPi = "皮脚本QQ群1002100032" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))() end })
ScriptsTab:AddButton({ Name = "加载 BS 脚本", Callback = function() loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\103\105\116\101\101\46\99\111\109\47\66\83\95\115\99\114\105\112\116\47\115\99\114\105\112\116\47\114\97\119\47\109\97\115\116\101\114\47\66\83\95\83\99\114\105\112\116\46\76\117\97\117"))() end })
ScriptsTab:AddButton({ Name = "加载 沙 脚本", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/114514lzkill/ShaHUB/refs/heads/main/ShaHUB"))() end })
ScriptsTab:AddButton({ Name = "加载 Kanl 破解版", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/eksan966/Federal/refs/heads/main/Kanl"))() end })
ScriptsTab:AddButton({ Name = "加载 For 脚本中心", Callback = function() getgenv().SCRIPT_KEY = "" loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/28f05f20579742b8db3901d189ca93ddecb4ff36815cee23d34bdff05ad7ae33/download"))() end })

-- ============================================================
-- TX翻译
-- ============================================================
local TXTab = Window:MakeTab({ Name = "TX翻译", Icon = "rbxassetid://123456" })
TXTab:AddParagraph("🌐 TX 翻译", "全自动翻译脚本")
TXTab:AddButton({ Name = "加载翻译", Callback = function() TX = "TX Script" Script = "全自动翻译" loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-language"))() end })

-- ============================================================
-- Run Race
-- ============================================================
local RunRaceTab = Window:MakeTab({ Name = "Run Race", Icon = "rbxassetid://123456" })
RunRaceTab:AddParagraph("🏃 Run Race", "Ruby Hub Run Race")
RunRaceTab:AddButton({ Name = "加载脚本", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Deni210/raceclicker/main/Ruby%20Hub%20v1.0", true))() end })

-- ============================================================
-- 自瞄一类
-- ============================================================
local AimbotTab = Window:MakeTab({ Name = "自瞄一类", Icon = "rbxassetid://123456" })
AimbotTab:AddParagraph("🔍 ESP 透视", "Roblox ESP V3.0 手机版")
AimbotTab:AddButton({ Name = "加载 ESP", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/1215203698741/Roblox-ESP-Antibot-V3/refs/heads/main/V3.0phone.lua"))() end })

-- ============================================================
-- 通用功能
-- ============================================================
local UniversalTab = Window:MakeTab({ Name = "通用功能", Icon = "rbxassetid://123456" })
UniversalTab:AddParagraph("🛠️ 通用功能", "开关控制+滑动调节")

UniversalTab:AddButton({ Name = "飞行V3汉化", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kongshao6/Qwe/main/Ksfly.lua"))() OrionLib:MakeNotification({ Name = "飞行V3", Content = "已加载！", Time = 3 }) end })

UniversalTab:AddToggle({ Name = "自定义速度", Default = false, Callback = function(v) walkEnabled = v applyAll() end })
UniversalTab:AddSlider({ Name = "速度值", Min = 16, Max = 200, Default = 50, Color = Color3.fromRGB(255,0,0), Callback = function(v) walkSpeed = v applyAll() end })

UniversalTab:AddToggle({ Name = "自定义跳跃", Default = false, Callback = function(v) jumpEnabled = v applyAll() end })
UniversalTab:AddSlider({ Name = "跳跃值", Min = 50, Max = 300, Default = 100, Color = Color3.fromRGB(255,0,0), Callback = function(v) jumpPower = v applyAll() end })

UniversalTab:AddToggle({ Name = "自定义重力", Default = false, Callback = function(v) gravityEnabled = v applyAll() end })
UniversalTab:AddSlider({ Name = "重力值", Min = 10, Max = 500, Default = 50, Color = Color3.fromRGB(255,0,0), Callback = function(v) gravityValue = v applyAll() end })

UniversalTab:AddToggle({ Name = "自定义视野", Default = false, Callback = function(v) fovEnabled = v applyAll() end })
UniversalTab:AddSlider({ Name = "FOV值", Min = 30, Max = 150, Default = 120, Color = Color3.fromRGB(255,0,0), Callback = function(v) fovValue = v applyAll() end })

UniversalTab:AddToggle({ Name = "穿墙模式", Default = false, Callback = function(v)
    noclipEnabled = v
    if v then
        noclipConn = game:GetService("RunService").Stepped:Connect(function()
            local char = game.Players.LocalPlayer.Character
            if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
        end)
    else
        if noclipConn then noclipConn:Disconnect() end
    end
end })

UniversalTab:AddToggle({ Name = "夜视模式", Default = false, Callback = function(v)
    local l = game:GetService("Lighting")
    if v then l.Brightness = 5 l.ClockTime = 14 l.FogEnd = 100000 l.GlobalShadows = false
    else l.Brightness = 1 l.FogEnd = 10000 l.GlobalShadows = true end
end })

UniversalTab:AddSlider({ Name = "时间调节", Min = 0, Max = 24, Default = 14, Color = Color3.fromRGB(255,0,0), Callback = function(v) game:GetService("Lighting").ClockTime = v end })

UniversalTab:AddButton({ Name = "重新加入服务器", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer) end })
UniversalTab:AddButton({ Name = "复制服务器ID", Callback = function() pcall(function() setclipboard(game.JobId) end) OrionLib:MakeNotification({ Name = "已复制", Content = game.JobId, Time = 3 }) end })

OrionLib:Init()
