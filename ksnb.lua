-- 自定义卡密验证系统
local correctKey = "ksnb"
local maxAttempts = 3
local attempts = 0

local function kickPlayer()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    if LocalPlayer then
        LocalPlayer:Kick("验证失败次数过多，已被踢出游戏")
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

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "KeySystem"
keyGui.ResetOnSpawn = false
keyGui.Parent = playerGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 350, 0, 200)
keyFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 12)
keyCorner.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 45)
keyTitle.Position = UDim2.new(0, 0, 0, 15)
keyTitle.Text = "🔐 请输入密钥"
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.TextSize = 24
keyTitle.Font = Enum.Font.SourceSansBold
keyTitle.BackgroundTransparency = 1
keyTitle.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0, 260, 0, 40)
keyInput.Position = UDim2.new(0.5, -130, 0, 70)
keyInput.PlaceholderText = "请输入卡密..."
keyInput.Text = ""
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyInput.BorderSizePixel = 0
keyInput.Font = Enum.Font.SourceSans
keyInput.TextSize = 18
keyInput.ClearTextOnFocus = false
keyInput.Parent = keyFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = keyInput

local keyButton = Instance.new("TextButton")
keyButton.Size = UDim2.new(0, 260, 0, 40)
keyButton.Position = UDim2.new(0.5, -130, 0, 125)
keyButton.Text = "验证"
keyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
keyButton.TextSize = 20
keyButton.Font = Enum.Font.SourceSansBold
keyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
keyButton.Parent = keyFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = keyButton

local verified = false

keyButton.MouseButton1Click:Connect(function()
    if verifyKey(keyInput.Text) then
        verified = true
        keyGui:Destroy()
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
