local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "⭐空少脚本⭐",
    HidePremium = false,
    SaveConfig = false,
    IntroText = "欢迎使用",
    ConfigFolder = "欢迎使用"
})

local NoticeTab = Window:MakeTab({
    Name = "📢脚本公告📢",
    Icon = "rbxassetid://7734068321",
    PremiumOnly = false
})
NoticeTab:AddParagraph("作者", "⭐空少⭐")
NoticeTab:AddLabel("作者QQ：2506887018")
NoticeTab:AddLabel("QQ群：864060476")
NoticeTab:AddLabel("此脚本完全免费")

local CommonTab = Window:MakeTab({
    Name = "✨通用功能✨",
    Icon = "rbxassetid://7734068321",
    PremiumOnly = false
})

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
CommonTab:AddSlider({
    Name = "移动速度调节",
    Min = 16,
    Max = 100,
    Default = 16,
    Callback = function(v)
        Humanoid.WalkSpeed = v
    end
})

CommonTab:AddToggle({
    Name = "自动跳跃",
    Default = false,
    Callback = function(s)
        Humanoid.AutoJumpEnabled = s
    end
})

CommonTab:AddButton({
    Name = "HUA 光影",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/arzRCGws"))()
    end
})

CommonTab:AddButton({
    Name = "恢复默认设置",
    Callback = function()
        Humanoid.WalkSpeed = 16
        Humanoid.AutoJumpEnabled = false
    end
})

local RaceTab = Window:MakeTab({
    Name = "race cliker有汉化",
    Icon = "rbxassetid://7734068321",
    PremiumOnly = false
})
RaceTab:AddButton({
    Name = "启动race汉化脚本",
    Callback = function()
        local S, E = pcall(function()
            loadstring(game:HttpGet("https://ghproxy.com/https://raw.githubusercontent.com/kongshao6/Qwe/69326b5b80d1427022d9be2f617294e4606d4ed4/Wsks.lua"))()
        end)
        if S then
            OrionLib:MakeNotification({
                Title = "启动成功",
                Content = "汉化脚本已运行",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Title = "启动失败",
                Content = "错误：" .. E,
                Time = 5
            })
        end
    end
})

local CoreGui = game:GetService("StarterGui")
CoreGui:SetCore("SendNotification", {
    Title = "⭐空少⭐",
    Text = "耐心等待（反挂机已开启）",
    Duration = 5
})
print("反挂机开启")

local vu = game:GetService("Players").LocalPlayer
vu.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

OrionLib:Init()
