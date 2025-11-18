local Start = tick() -- 启动计时

-- 加载UI库（添加错误处理）
local success, ui = pcall(function()
    return loadstring(game:HttpGet("https://pastebin.com/raw/3vQdAJn"))()
end)

if not success or not ui then
    warn("UI库加载失败！")
    return
end

local win = ui:new("空⼤hub")
local UiTab1 = win:Tab("公告", "7734068321") -- 左侧边栏分类
local UiTab2 = win:Tab("通⽤", "7734068321") -- 左侧边栏分类
local UiTab3 = win:Tab("race cliker有汉化", "7734068321") -- 左侧边栏分类

-- 公告部分
local about = UiTab1:section("公告", true)
about:Label("奥你啊")
about:Label("作者qq2077812452")
about:Label("私人脚本")
about:Label("倒卖死全家")

-- 脚本部分（修复了变量名）
local scriptSection = UiTab3:section("脚本", true) -- 改为 UiTab3
scriptSection:Button("race", function() -- 修复了括号
    loadstring(game:HttpGet("https://raw.githubusercontent.com/kongsha06/~Qwe/326aa86b39b6e1db5b1d6caa3dae65c84661e025/Wsks.lua"))()
end) -- 修复了这里，应该是 end) 不是 end

-- 可以添加通用功能部分
local generalSection = UiTab2:section("通用功能", true)
generalSection:Button("飞行模式", function()
    -- 这里可以添加飞行功能
    print("飞行功能开启")
end)

generalSection:Button("无限跳跃", function()
    -- 这里可以添加无限跳跃功能
    print("无限跳跃开启")
end)

print(string.format("脚本加载完成，耗时: %.2f秒", tick() - Start))
