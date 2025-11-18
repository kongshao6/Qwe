local Start = tick()

-- 使用你提供的WindUI链接
local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/main_example.lua'))()

-- 创建主窗口（使用卡密ks666）
local mainWindow = WindUI:Create("空大hub", "ks666")

-- 创建标签页
local tab1 = mainWindow:Tab("公告")
local tab2 = mainWindow:Tab("通用功能")
local tab3 = mainWindow:Tab("Race Clicker")

-- 公告部分
local section1 = tab1:Section("公告信息")
section1:Label("私人脚本")
section1:Label("作者QQ: 2077812452")
section1:Label("倒卖死全家")
section1:Label("卡密: ks666")

-- 通用功能部分
local section2 = tab2:Section("移动功能")

-- 飞行功能变量
local flyEnabled = false
local flySpeed = 50
local bodyVelocity, bodyGyro, flyConnection

-- 无限跳变量
local infJumpEnabled = false
local jumpConnection

-- 飞行功能
section2:Toggle("飞行模式", false, function(state)
    flyEnabled = state
    if flyEnabled then
        EnableFlying()
    else
        DisableFlying()
    end
end)

-- 飞行速度调节
section2:Slider("飞行速度", 10, 200, 50, function(value)
    flySpeed = value
end)

-- 无限跳跃
section2:Toggle("无限跳跃", false, function(state)
    infJumpEnabled = state
    if infJumpEnabled then
        EnableInfJump()
    else
        DisableInfJump()
    end
end)

-- 移动速度调节
section2:Slider("移动速度", 16, 150, 16, function(value)
    local humanoid = GetHumanoid()
    if humanoid then
        humanoid.WalkSpeed = value
    end
end)

-- 跳跃高度调节
section2:Slider("跳跃高度", 50, 200, 50, function(value)
    local humanoid = GetHumanoid()
    if humanoid then
        humanoid.JumpPower = value
    end
end)

-- 一键功能
section2:Button("重置所有设置", function()
    flyEnabled = false
    infJumpEnabled = false
    DisableFlying()
    DisableInfJump()
    
    local humanoid = GetHumanoid()
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
    
    WindUI:Notify("重置完成", "所有设置已恢复默认")
end)

-- 快速功能按钮
section2:Button("快速飞行(按F)", function()
    flyEnabled = not flyEnabled
    if flyEnabled then
        EnableFlying()
    else
        DisableFlying()
    end
end)

section2:Button("快速无限跳", function()
    infJumpEnabled = not infJumpEnabled
    if infJumpEnabled then
        EnableInfJump()
    else
        DisableInfJump()
    end
end)

-- Race Clicker 部分
local section3 = tab3:Section("脚本功能")
section3:Button("加载Race脚本", function()
    WindUI:Notify("加载中", "正在加载Race脚本...")
    
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kongshao6/Qwe/87b1523f33d06b29f270d8de97fc08921c9a02f3/www.lua";))()
    end)
    
    if success then
        WindUI:Notify("成功", "Race脚本加载完成")
    else
        WindUI:Notify("错误", "加载失败: " .. tostring(err))
    end
end)

section3:Button("测试通知", function()
    WindUI:Notify("测试", "这是通知测试消息")
end)

-- 功能实现函数
function GetHumanoid()
    local player = game.Players.LocalPlayer
    if player.Character then
        return player.Character:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

function GetRootPart()
    local player = game.Players.LocalPlayer
    if player.Character then
        return player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Torso")
    end
    return nil
end

-- 飞行功能
function EnableFlying()
    local rootPart = GetRootPart()
    local humanoid = GetHumanoid()
    
    if not rootPart or not humanoid then
        WindUI:Notify("错误", "找不到角色部件，请等待角色加载")
        return
    end
    
    -- 清除旧的连接
    if flyConnection then
        flyConnection:Disconnect()
    end
    
    -- 创建飞行控制
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
    
    -- 飞行控制循环
    flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not flyEnabled or not bodyVelocity or not bodyGyro then
            return
        end
        
        local direction = Vector3.new(0, 0, 0)
        
        -- 移动控制
        local UIS = game:GetService("UserInputService")
        if UIS:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + rootPart.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - rootPart.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - rootPart.CFrame.RightVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + rootPart.CFrame.RightVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            direction = direction + Vector3.new(0, 1, 0)
        end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
            direction = direction + Vector3.new(0, -1, 0)
        end
        
        -- 应用速度
        if direction.Magnitude > 0 then
            direction = direction.Unit * flySpeed
        end
        
        bodyVelocity.Velocity = direction
        bodyGyro.CFrame = rootPart.CFrame
    end)
    
    WindUI:Notify("飞行模式", "已开启 - 使用WASD移动, Space上升, Shift下降")
end

function DisableFlying()
    local humanoid = GetHumanoid()
    if humanoid then
        humanoid.PlatformStand = false
    end
    
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
    
    WindUI:Notify("飞行模式", "已关闭")
end

-- 无限跳跃功能
function EnableInfJump()
    local humanoid = GetHumanoid()
    if not humanoid then 
        WindUI:Notify("错误", "找不到Humanoid")
        return 
    end
    
    -- 清除旧的连接
    if jumpConnection then
        jumpConnection:Disconnect()
    end
    
    -- 跳跃请求连接
    jumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
        if infJumpEnabled and humanoid and humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
    
    WindUI:Notify("无限跳跃", "已开启")
end

function DisableInfJump()
    if jumpConnection then
        jumpConnection:Disconnect()
        jumpConnection = nil
    end
    WindUI:Notify("无限跳跃", "已关闭")
end

-- 键盘快捷键
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        flyEnabled = not flyEnabled
        if flyEnabled then
            EnableFlying()
        else
            DisableFlying()
        end
    end
    
    if input.KeyCode == Enum.KeyCode.G then
        infJumpEnabled = not infJumpEnabled
        if infJumpEnabled then
            EnableInfJump()
        else
            DisableInfJump()
        end
    end
end)

-- 角色重生处理
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
    wait(1) -- 等待角色完全加载
    
    -- 重新应用设置
    if flyEnabled then
        DisableFlying()
        wait(0.5)
        EnableFlying()
    end
    
    if infJumpEnabled then
        DisableInfJump()
        wait(0.5)
        EnableInfJump()
    end
end)

-- 加载完成提示
WindUI:Notify("欢迎", "空大hub加载完成!")
print(string.format("脚本加载完成，耗时: %.2f秒", tick() - Start))
print("快捷键: F键切换飞行, G键切换无限跳")
