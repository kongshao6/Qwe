local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua"))()
WindUI:SetNotificationLower(true)

local Window = WindUI:CreateWindow({
    Title = "空少hub",
    Author = "空少",
    Folder = "kongshao_hub",
    Icon = "sfsymbols:star",
    OpenButton = { Enabled = true, Draggable = true },
    KeySystem = { Enabled = false } -- 强制关闭密钥验证
})

-- 公告标签页
local NoticeTab = Window:Tab({ Title = "公告", Icon = "info" })
NoticeTab:Section({ Title = "公告内容" })
NoticeTab:Label({ Title = "奥你啊" })
NoticeTab:Label({ Title = "作者qq2077812452" })
NoticeTab:Label({ Title = "私人脚本" })
NoticeTab:Label({ Title = "倒卖死全家" })

-- 通用功能标签页
local CommonTab = Window:Tab({ Title = "通用", Icon = "gear" })
CommonTab:Section({ Title = "通用功能" })

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

CommonTab:Slider({
    Title = "移动速度调节",
    Min = 16,
    Max = 100,
    Default = 16,
    Callback = function(value)
        Humanoid.WalkSpeed = value
        WindUI:Notify({ Title = "速度更新", Content = "当前速度：" .. value })
    end
})

CommonTab:Toggle({
    Title = "自动跳跃",
    Default = false,
    Callback = function(state)
        Humanoid.AutoJumpEnabled = state
        WindUI:Notify({ Title = "自动跳跃", Content = state and "已开启" or "已关闭" })
    end
})

CommonTab:Button({
    Title = "恢复默认设置",
    Callback = function()
        Humanoid.WalkSpeed = 16
        Humanoid.AutoJumpEnabled = false
        WindUI:Notify({ Title = "恢复完成", Content = "已重置所有默认设置" })
    end
})

-- 汉化脚本标签页
local RaceTab = Window:Tab({ Title = "race cliker有汉化", Icon = "language" })
RaceTab:Section({ Title = "汉化脚本" })
RaceTab:Button({
    Title = "启动race汉化脚本",
    Callback = function()
        local success = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/kongshao6/Qwe/69326b5b80d1427022d9be2f617294e4606d4ed4/Wsks.lua"))()
        end)
        WindUI:Notify({
            Title = success and "启动成功" or "启动失败",
            Content = success and "汉化脚本已运行" or "加载出错，请检查链接"
        })
    end
})

WindUI:Init()
