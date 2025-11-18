local Start = tick()

local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()

local win = ui:CreateWindow("空少hub")

local UITab1 = win:CreateTab("公告", "rbxassetid://7734068321")
local UITab2 = win:CreateTab("通用", "rbxassetid://7734068321")
local UITab3 = win:CreateTab("race cliker有汉化", "rbxassetid://7734068321")

local noticeFrame = UITab1:CreateFrame("公告内容")
noticeFrame:CreateLabel("奥你啊")
noticeFrame:CreateLabel("作者qq2077812452")
noticeFrame:CreateLabel("私人脚本")
noticeFrame:CreateLabel("倒卖死全家")

local commonFrame = UITab2:CreateFrame("通用功能")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local speedValue = 16
commonFrame:CreateSlider("移动速度调节", 16, 100, 16, function(value)
    speedValue = value
    humanoid.WalkSpeed = speedValue
    print("[通用功能] 移动速度已更新：" .. speedValue)
end)

local autoJumpState = false
commonFrame:CreateToggle("自动跳跃", false, function(state)
    autoJumpState = state
    humanoid.AutoJumpEnabled = autoJumpState
    print("[通用功能] 自动跳跃已" .. (autoJumpState and "开启" or "关闭"))
end)

commonFrame:CreateButton("恢复默认设置", function()
    humanoid.WalkSpeed = 16
    humanoid.AutoJumpEnabled = false
    speedValue = 16
    autoJumpState = false
    print("[通用功能] 已恢复所有默认设置")
end)

local raceFrame = UITab3:CreateFrame("汉化脚本")
raceFrame:CreateButton("启动race汉化脚本", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kongshao6/Qwe/69326b5b80d1427022d9be2f617294e4606d4ed4/Wsks.lua"))()
    end)
    if success then
        print("[汉化脚本] 启动成功！")
    else
        print("[汉化脚本] 启动失败：" .. err)
    end
end)

ui:Init()
