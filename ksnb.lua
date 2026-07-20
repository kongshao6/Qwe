-- 加载 WindUI 库（从 GitHub 最新版本下载并执行）
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- 创建主窗口（彩虹色主题）
local Window = WindUI:CreateWindow({
    Title = "ks script",                  -- 窗口标题
    Icon = "door-open",                   -- 窗口图标
    Author = "ks script",                 -- 作者名称
    Folder = "ks script",                 -- 本地存储的文件夹名
    Size = UDim2.fromOffset(580, 460),    -- 窗口尺寸（宽580，高460）
    Transparent = true,                   -- 是否启用透明背景
    Theme = "Dark",                       -- 主题：Dark（深色）
    SideBarWidth = 200,                   -- 左侧标签栏宽度
    HasOutline = true,                    -- 是否显示窗口外边框
    AccentColor = Color3.fromRGB(255, 0, 0), -- 基础强调色（红色，会被彩虹覆盖）
    -- 密钥系统配置
    KeySystem = {
        Key = { "ksnb" },                 -- 有效密钥
        Note = "请输入密钥",               -- 提示说明
        SaveKey = false,                  -- 不保存密钥，每次都需要重新输入
    },
})

-- 自定义"打开界面"按钮的样式（彩虹色）
Window:EditOpenButton({
    Title = "打开 ks script",
    Icon = "monitor",
    CornerRadius = UDim.new(0, 16),      -- 圆角半径
    StrokeThickness = 3,                 -- 边框厚度
    Color = ColorSequence.new({          -- 彩虹渐变
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),     -- 红
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 165, 0)), -- 橙
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)), -- 黄
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),    -- 绿
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),   -- 蓝
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),  -- 靛
        ColorSequenceKeypoint.new(1, Color3.fromRGB(148, 0, 211)),    -- 紫
    }),
    Draggable = true,                    -- 是否可拖动
})

-- 创建标签页（每个标签页使用不同颜色）
local Tabs = {
    NoticeTab   = Window:Tab({ Title = "通知",         Icon = "bell",            Desc = "脚本说明与公告" }),
    LemonTab    = Window:Tab({ Title = "柠檬",         Icon = "citrus",          Desc = "HoshiOnTop 脚本加载器" }),
    ScriptsTab  = Window:Tab({ Title = "多种脚本整合",  Icon = "folder-code",     Desc = "各类脚本合集" }),
    TXTab       = Window:Tab({ Title = "TX翻译",       Icon = "languages",       Desc = "全自动翻译脚本" }),
    RunRaceTab  = Window:Tab({ Title = "Run Race",     Icon = "flag",            Desc = "Run Race 脚本加载器" }),
}

-- 默认选中通知标签页（第一个）
Window:SelectTab(1)

-- ============================================================
-- 通知标签页（彩虹色段落）
-- ============================================================

Tabs.NoticeTab:Paragraph({
    Title = "📢 脚本公告",
    Desc = "欢迎使用 ks script！",
    Image = "bell",
    ImageSize = 34,
    Color = Color3.fromRGB(255, 0, 0), -- 红色
})

Tabs.NoticeTab:Paragraph({
    Title = "📝 脚本介绍",
    Desc = "此脚本为缝合各种脚本\n倒卖sm",
    Image = "info",
    ImageSize = 34,
    Color = Color3.fromRGB(255, 165, 0), -- 橙色
})

Tabs.NoticeTab:Paragraph({
    Title = "⚠️ 警告",
    Desc = "请勿倒卖本脚本，尊重原作者劳动成果！",
    Image = "triangle-alert",
    ImageSize = 34,
    Color = Color3.fromRGB(255, 255, 0), -- 黄色
})

-- ============================================================
-- 柠檬标签页（已更新介绍）
-- ============================================================

-- 新的介绍段落
Tabs.LemonTab:Paragraph({
    Title = "🍋 Sell Lemon 脚本",
    Desc = "这个是我亲身试用 sell lemon 最好用的一个脚本",
    Image = "citrus",
    ImageSize = 34,
    Color = Color3.fromRGB(0, 255, 0), -- 绿色
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
    Color = Color3.fromRGB(0, 0, 255), -- 蓝色
})

-- YI脚本
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

-- PI脚本
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

-- BS脚本
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

-- 沙脚本
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

-- Kanl破解版
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

-- For脚本中心
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
-- TX翻译标签页（彩虹色）
-- ============================================================

Tabs.TXTab:Paragraph({
    Title = "🌐 TX 翻译脚本",
    Desc = "全自动翻译脚本，助您畅玩全球游戏",
    Image = "languages",
    ImageSize = 34,
    Color = Color3.fromRGB(75, 0, 130), -- 靛色
})

Tabs.TXTab:Paragraph({
    Title = "📖 脚本说明",
    Desc = "TX Script - 全自动翻译\n点击下方按钮即可加载",
    Image = "info",
    ImageSize = 34,
    Color = Color3.fromRGB(148, 0, 211), -- 紫色
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

Tabs.TXTab:Button({
    Title = "打开翻译设置",
    Desc = "如果脚本支持，可打开设置面板",
    Icon = "settings",
    Callback = function()
        WindUI:Notify({
            Title = "提示",
            Content = "请先加载TX翻译脚本！",
            Icon = "info",
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
    Color = Color3.fromRGB(255, 0, 0), -- 红色
})

Tabs.RunRaceTab:Paragraph({
    Title = "📖 脚本说明",
    Desc = "Run Race 游戏专用脚本\n点击下方按钮即可加载",
    Image = "info",
    ImageSize = 34,
    Color = Color3.fromRGB(255, 165, 0), -- 橙色
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
-- 额外的彩虹色美化
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
