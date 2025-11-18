local Start = tick() -- 启动计时

-- 加载UI库（添加错误处理）
local success, ui = pcall(function()
    return loadstring(game:HttpGet("https://pastebin.com/raw/3vQdAJn";))()
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

-- Race Clicker 脚本部分
local scriptSection = UiTab3:section("脚本", true)
scriptSection:Button("race", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/kongsha06/~Qwe/326aa86b39b6e1db5b1d6caa3dae65c84661e025/Wsks.lua";))()
end)

-- 通用功能部分 - 整合飞行和无限跳
local generalSection = UiTab2:section("移动功能", true)

-- 飞行脚本变量
local flyEnabled = false
local bodyVelocity, bodyGyro
local flySpeed = 50

-- 无限跳脚本变量
local infJumpEnabled = false

-- 飞行功能
generalSection:Toggle("飞行模式", false, function(state)
    flyEnabled = state
    if flyEnabled then
        enableFlying()
    else
        disableFlying()
    end
end)

-- 飞行速度调节
generalSection:Slider("飞行速度", 10, 100, 50, function(value)
    flySpeed = value
    if flyEnabled then
        disableFlying()
        enableFlying()
    end
end)

-- 无限跳跃功能
generalSection:Toggle("无限跳跃", false, function(state)
    infJumpEnabled = state
    if infJumpEnabled then
        enableInfiniteJump()
    else
        disableInfiniteJump()
    end
end)

-- 移动速度调节
generalSection:Slider("移动速度", 16, 100, 16, function(value)
    local humanoid = getHumanoid()
    if humanoid then
        humanoid.WalkSpeed = value
    end
end)

-- 跳跃高度调节
generalSection:Slider("跳跃高度", 50, 200, 50, function(value)
    local humanoid = getHumanoid()
    if humanoid then
        humanoid.JumpPower = value
    end
end)

-- 一键重置功能
generalSection:Button("重置所有能力", function()
    flyEnabled = false
    infJumpEnabled = false
    disableFlying()
    disableInfiniteJump()
    
    local humanoid = getHumanoid()
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
end)

-- 获取角色的函数
function getHumanoid()
    local player = game.Players.LocalPlayer
    if player.Character then
        return player.Character:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

function getRootPart()
    local player = game.Players.LocalPlayer
    if player.Character then
        return player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Torso")
    end
    return nil
end

-- 飞行功能实现
function enableFlying()
    local rootPart = getRootPart()
    local humanoid = getHumanoid()
    
    if not rootPart or not humanoid then return end
    
    -- 创建飞行物理控制
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVelocity.Parent = rootPart
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
    bodyGyro.P = 1000
    bodyGyro.D = 50
    bodyGyro.Parent = rootPart
    
    humanoid.PlatformStand = true
    
    -- 飞行控制连接
    local flyConnection
    flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not flyEnabled or not bodyVelocity or not bodyGyro then
            if flyConnection then
                flyConnection:Disconnect()
            end
            return
        end
        
        local direction = Vector3.new(0, 0, 0)
        
        -- 前后移动 (W/S)
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
            direction = direction + rootPart.CFrame.LookVector
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
            direction = direction - rootPart.CFrame.LookVector
        end
        
        -- 左右移动 (A/D)
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
            direction = direction - rootPart.CFrame.RightVector
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
            direction = direction + rootPart.CFrame.RightVector
        end
        
        -- 上升下降 (Space/Shift)
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
            direction = direction + Vector3.new(0, 1, 0)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
            direction = direction + Vector3.new(0, -1, 0)
        end
        
        -- 应用速度
        if direction.Magnitude > 0 then
            direction = direction.Unit * flySpeed
        end
        
        bodyVelocity.Velocity = direction
        bodyGyro.CFrame = rootPart.CFrame
    end)
    
    print("飞行模式已开启 - 使用 WASD 移动, Space 上升, Shift 下降")
end

function disableFlying()
    local humanoid = getHumanoid()
    if humanoid then
        humanoid.PlatformStand = false
    end
    
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
    
    print("飞行模式已关闭")
end

-- 无限跳跃功能实现
function enableInfiniteJump()
    local humanoid = getHumanoid()
    if not humanoid then return end
    
    -- 跳跃请求连接
    local jumpConnection
    jumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
        if infJumpEnabled and humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
    
    print("无限跳跃已开启")
end

function disableInfiniteJump()
    print("无限跳跃已关闭")
end

-- 角色重生时重置
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
    -- 短暂延迟后重新应用设置
    wait(1)
    
    local humanoid = getHumanoid()
    if humanoid then
        if flyEnabled then
            disableFlying()
            enableFlying()
        end
        
        if infJumpEnabled then
            disableInfiniteJump()
            enableInfiniteJump()
        end
    end
end)

print(string.format("脚本加载完成，耗时: %.2f秒", tick() - Start))
print("移动功能已加载：飞行模式、无限跳跃、速度调节")
