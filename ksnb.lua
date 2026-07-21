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
    KeySystem = {
        Key = { "ksnb" },
        Note = "请输入密钥",
        SaveKey = false,
    },
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
