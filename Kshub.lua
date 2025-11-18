local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local MainWindow = Rayfield:CreateWindow({
    Name = "空少hub",
    Icon = "rbxassetid://7734068321",
    LoadingTitle = "空少hub",
    LoadingSubtitle = "加载中...",
    Theme = "Default",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
    ConfigurationSaving = {
        Enabled = false,
        FileName = "KongShaoHub"
    },
    ToggleUIKeybind = "K"
})

local NoticeTab = MainWindow:CreateTab("公告", "rbxassetid://7734068321")
NoticeTab:CreateSection("公告内容")
NoticeTab:CreateLabel("奥你啊")
NoticeTab:CreateLabel("作者qq2077812452")
NoticeTab:CreateLabel("私人脚本")
NoticeTab:CreateLabel("倒卖死全家", "warning", Color3.fromRGB(255, 100, 100), true)

local CommonTab = MainWindow:CreateTab("通用", "rbxassetid://7734068321")
CommonTab:CreateSection("角色控制")

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local SpeedSlider = CommonTab:CreateSlider({
    Name = "移动速度调节",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Suffix = "单位",
    Callback = function(Value)
        Humanoid.WalkSpeed = Value
        Rayfield:Notify({
            Title = "速度更新",
            Content = "移动速度已设为：" .. Value,
            Duration = 2,
            Image = "speedometer"
        })
    end
})

local AutoJumpToggle = CommonTab:CreateToggle({
    Name = "自动跳跃",
    CurrentValue = false,
    Callback = function(State)
        Humanoid.AutoJumpEnabled = State
        Rayfield:Notify({
            Title = "自动跳跃",
            Content = State and "已开启" or "已关闭",
            Duration = 2,
            Image = State and "check" or "x"
        })
    end
})

CommonTab:CreateButton({
    Name = "恢复默认设置",
    Callback = function()
        Humanoid.WalkSpeed = 16
        Humanoid.AutoJumpEnabled = false
        SpeedSlider:Set(16)
        AutoJumpToggle:Set(false)
        Rayfield:Notify({
            Title = "恢复完成",
            Content = "所有通用功能已恢复默认",
            Duration = 2,
            Image = "refresh"
        })
    end
})

local RaceTab = MainWindow:CreateTab("race cliker有汉化", "rbxassetid://7734068321")
RaceTab:CreateSection("汉化脚本控制")

RaceTab:CreateButton({
    Name = "启动race汉化脚本",
    Callback = function()
        local Success, Err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/kongshao6/Qwe/69326b5b80d1427022d9be2f617294e4606d4ed4/Wsks.lua"))()
        end)
        if Success then
            Rayfield:Notify({
                Title = "启动成功",
                Content = "race汉化脚本已运行",
                Duration = 3,
                Image = "check-circle"
            })
        else
            Rayfield:Notify({
                Title = "启动失败",
                Content = "错误信息：" .. Err,
                Duration = 5,
                Image = "alert-circle"
            })
        end
    end
})

Rayfield:LoadConfiguration()
