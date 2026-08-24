-- ============================================================
-- WindUI风格UI系统 + 卡密验证
-- ============================================================
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- 工具函数
local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
end

local function createStroke(parent, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Color = Color3.fromRGB(255, 0, 0)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

local function getRainbowColor(speed)
    return Color3.fromHSV((tick() * speed) % 1, 1, 1)
end

-- ============================================================
-- 卡密验证系统
-- ============================================================
local correctKey = "ksnb"
local isVerified = false

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "KeySystem"
keyGui.ResetOnSpawn = false
keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
keyGui.Parent = playerGui

local bgOverlay = Instance.new("Frame")
bgOverlay.Size = UDim2.new(1, 0, 1, 0)
bgOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bgOverlay.BackgroundTransparency = 0.7
bgOverlay.BorderSizePixel = 0
bgOverlay.Parent = keyGui

local keyFrame = Instance.new("Frame")
keyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
keyFrame.BorderSizePixel = 0
keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
keyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
keyFrame.Size = UDim2.new(0, 350, 0, 230)
keyFrame.ClipsDescendants = true
keyFrame.Parent = keyGui
createCorner(keyFrame, 16)

local keyFrameStroke = createStroke(keyFrame, 3)
task.spawn(function()
    while keyGui and keyGui.Parent and keyFrameStroke and keyFrameStroke.Parent do
        keyFrameStroke.Color = getRainbowColor(0.3)
        task.wait()
    end
end)

local keyTopBar = Instance.new("Frame")
keyTopBar.Size = UDim2.new(1, 0, 0, 5)
keyTopBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
keyTopBar.BorderSizePixel = 0
keyTopBar.Parent = keyFrame

local keyTopGradient = Instance.new("UIGradient")
keyTopGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 165, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255)),
})
keyTopGradient.Parent = keyTopBar

local keyIcon = Instance.new("TextLabel")
keyIcon.Size = UDim2.new(1, 0, 0, 35)
keyIcon.Position = UDim2.new(0, 0, 0, 15)
keyIcon.Text = "🔐"
keyIcon.TextSize = 28
keyIcon.BackgroundTransparency = 1
keyIcon.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 25)
keyTitle.Position = UDim2.new(0, 0, 0, 50)
keyTitle.Text = "KS SCRIPT 验证"
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.TextSize = 22
keyTitle.Font = Enum.Font.SourceSansBold
keyTitle.BackgroundTransparency = 1
keyTitle.Parent = keyFrame

task.spawn(function()
    while keyGui and keyGui.Parent and keyTitle and keyTitle.Parent do
        keyTitle.TextColor3 = getRainbowColor(0.3)
        task.wait()
    end
end)

local keySubtitle = Instance.new("TextLabel")
keySubtitle.Size = UDim2.new(1, 0, 0, 18)
keySubtitle.Position = UDim2.new(0, 0, 0, 75)
keySubtitle.Text = "请输入卡密以继续使用"
keySubtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
keySubtitle.TextSize = 13
keySubtitle.Font = Enum.Font.SourceSans
keySubtitle.BackgroundTransparency = 1
keySubtitle.Parent = keyFrame

local inputBg = Instance.new("Frame")
inputBg.Size = UDim2.new(0, 280, 0, 40)
inputBg.Position = UDim2.new(0.5, -140, 0, 100)
inputBg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
inputBg.BorderSizePixel = 0
inputBg.Parent = keyFrame
createCorner(inputBg, 8)

local inputStroke = createStroke(inputBg, 2)
task.spawn(function()
    while keyGui and keyGui.Parent and inputStroke and inputStroke.Parent do
        inputStroke.Color = getRainbowColor(0.3)
        task.wait()
    end
end)

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -20, 1, 0)
keyInput.Position = UDim2.new(0, 10, 0, 0)
keyInput.PlaceholderText = "请输入卡密..."
keyInput.Text = ""
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
keyInput.BackgroundTransparency = 1
keyInput.BorderSizePixel = 0
keyInput.Font = Enum.Font.SourceSans
keyInput.TextSize = 15
keyInput.Parent = inputBg

local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0, 280, 0, 40)
verifyBtn.Position = UDim2.new(0.5, -140, 0, 150)
verifyBtn.Text = "⚡ 验 证"
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.TextSize = 16
verifyBtn.Font = Enum.Font.SourceSansBold
verifyBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
verifyBtn.BorderSizePixel = 0
verifyBtn.Parent = keyFrame
createCorner(verifyBtn, 8)

local verifyBtnStroke = createStroke(verifyBtn, 2)
task.spawn(function()
    while keyGui and keyGui.Parent and verifyBtnStroke and verifyBtnStroke.Parent do
        verifyBtnStroke.Color = getRainbowColor(0.3)
        verifyBtn.BackgroundColor3 = Color3.fromHSV((tick() * 0.3) % 1, 0.8, 0.6)
        task.wait()
    end
end)

local errorLabel = Instance.new("TextLabel")
errorLabel.Size = UDim2.new(1, 0, 0, 20)
errorLabel.Position = UDim2.new(0, 0, 0, 195)
errorLabel.Text = ""
errorLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
errorLabel.TextSize = 12
errorLabel.Font = Enum.Font.SourceSans
errorLabel.BackgroundTransparency = 1
errorLabel.Parent = keyFrame

local attempts = 0
local maxAttempts = 3

local function onVerify()
    if keyInput.Text == correctKey then
        verifyBtn.Text = "✅ 验证成功！"
        verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        task.wait(0.5)
        isVerified = true
        keyGui:Destroy()
    else
        attempts += 1
        local remaining = maxAttempts - attempts
        if remaining <= 0 then
            errorLabel.Text = "❌ 验证失败，即将踢出..."
            task.wait(1)
            game.Players.LocalPlayer:Kick("验证失败次数过多")
        else
            errorLabel.Text = "❌ 卡密错误！剩余 " .. remaining .. " 次机会"
            keyInput.Text = ""
            local originalPos = inputBg.Position
            for i = 1, 5 do
                inputBg.Position = originalPos + UDim2.new(0, 5, 0, 0)
                task.wait(0.03)
                inputBg.Position = originalPos - UDim2.new(0, 5, 0, 0)
                task.wait(0.03)
            end
            inputBg.Position = originalPos
        end
    end
end

verifyBtn.MouseButton1Click:Connect(onVerify)
keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then onVerify() end
end)

repeat task.wait() until isVerified

-- ============================================================
-- WindUI风格主界面
-- ============================================================
local uiGui = Instance.new("ScreenGui")
uiGui.Name = "MainUI"
uiGui.ResetOnSpawn = false
uiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
uiGui.Parent = playerGui

-- 主窗口
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 550, 0, 500)
mainFrame.Position = UDim2.new(0.5, -275, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = uiGui
createCorner(mainFrame, 12)

-- 阴影效果
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.BorderSizePixel = 0
shadow.ZIndex = 0
shadow.Parent = uiGui
createCorner(shadow, 16)

-- 侧边栏
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 180, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

-- 侧边栏顶部
local sidebarTop = Instance.new("Frame")
sidebarTop.Size = UDim2.new(1, 0, 0, 70)
sidebarTop.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
sidebarTop.BorderSizePixel = 0
sidebarTop.Parent = sidebar

local sidebarTitle = Instance.new("TextLabel")
sidebarTitle.Size = UDim2.new(1, 0, 1, 0)
sidebarTitle.Text = "KS SCRIPT"
sidebarTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
sidebarTitle.TextSize = 20
sidebarTitle.Font = Enum.Font.SourceSansBold
sidebarTitle.BackgroundTransparency = 1
sidebarTitle.Parent = sidebarTop

task.spawn(function()
    while uiGui and uiGui.Parent and sidebarTitle and sidebarTitle.Parent do
        sidebarTitle.TextColor3 = getRainbowColor(0.3)
        task.wait()
    end
end)

-- 侧边栏标签按钮容器
local sidebarTabs = Instance.new("Frame")
sidebarTabs.Size = UDim2.new(1, 0, 1, -70)
sidebarTabs.Position = UDim2.new(0, 0, 0, 70)
sidebarTabs.BackgroundTransparency = 1
sidebarTabs.BorderSizePixel = 0
sidebarTabs.Parent = sidebar

local sidebarListLayout = Instance.new("UIListLayout")
sidebarListLayout.Padding = UDim.new(0, 5)
sidebarListLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarListLayout.Parent = sidebarTabs

local sidebarPadding = Instance.new("UIPadding")
sidebarPadding.PaddingTop = UDim.new(0, 10)
sidebarPadding.PaddingLeft = UDim.new(0, 8)
sidebarPadding.PaddingRight = UDim.new(0, 8)
sidebarPadding.Parent = sidebarTabs

-- 内容区域
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -180, 1, 0)
contentArea.Position = UDim2.new(0, 180, 0, 0)
contentArea.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
contentArea.BorderSizePixel = 0
contentArea.Parent = mainFrame

-- 内容顶部栏
local contentTopBar = Instance.new("Frame")
contentTopBar.Size = UDim2.new(1, 0, 0, 55)
contentTopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
contentTopBar.BorderSizePixel = 0
contentTopBar.Parent = contentArea

local contentTitle = Instance.new("TextLabel")
contentTitle.Size = UDim2.new(0, 200, 1, 0)
contentTitle.Position = UDim2.new(0, 20, 0, 0)
contentTitle.Text = "主页"
contentTitle.TextColor3 = Color3.fromRGB(40, 40, 40)
contentTitle.TextSize = 18
contentTitle.Font = Enum.Font.SourceSansBold
contentTitle.BackgroundTransparency = 1
contentTitle.TextXAlignment = Enum.TextXAlignment.Left
contentTitle.Parent = contentTopBar

-- 关闭按钮
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 12)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(100, 100, 100)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.BackgroundColor3 = Color3.fromRGB(230, 230, 235)
closeBtn.BorderSizePixel = 0
closeBtn.Parent = contentTopBar
createCorner(closeBtn, 999)

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 80), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(230, 230, 235), TextColor3 = Color3.fromRGB(100, 100, 100)}):Play()
end)
closeBtn.MouseButton1Click:Connect(function()
    uiGui:Destroy()
end)

-- 拖动功能
local dragging = false
local dragOffset = Vector2.new(0, 0)

contentTopBar.MouseButton1Down:Connect(function()
    dragging = true
    local mousePos = UserInputService:GetMouseLocation()
    dragOffset = mousePos - mainFrame.AbsolutePosition
end)

sidebarTop.MouseButton1Down:Connect(function()
    dragging = true
    local mousePos = UserInputService:GetMouseLocation()
    dragOffset = mousePos - mainFrame.AbsolutePosition
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        mainFrame.Position = UDim2.new(0, mousePos.X - dragOffset.X, 0, mousePos.Y - dragOffset.Y)
    end
end)

-- 内容滚动区域
local contentScroll = Instance.new("ScrollingFrame")
contentScroll.Size = UDim2.new(1, 0, 1, -55)
contentScroll.Position = UDim2.new(0, 0, 0, 55)
contentScroll.BackgroundTransparency = 1
contentScroll.BorderSizePixel = 0
contentScroll.ScrollBarThickness = 4
contentScroll.ScrollBarImageColor3 = Color3.fromRGB(180, 180, 180)
contentScroll.CanvasSize = UDim2.new(0, 0, 0, 500)
contentScroll.Parent = contentArea

local scrollListLayout = Instance.new("UIListLayout")
scrollListLayout.Padding = UDim.new(0, 10)
scrollListLayout.SortOrder = Enum.SortOrder.LayoutOrder
scrollListLayout.Parent = contentScroll

local scrollPadding = Instance.new("UIPadding")
scrollPadding.PaddingTop = UDim.new(0, 15)
scrollPadding.PaddingLeft = UDim.new(0, 15)
scrollPadding.PaddingRight = UDim.new(0, 15)
scrollPadding.PaddingBottom = UDim.new(0, 15)
scrollPadding.Parent = contentScroll

-- ============================================================
-- 标签页系统
-- ============================================================
local tabs = {}

local function createTab(name, icon, desc)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 40)
    tabBtn.Text = icon .. "  " .. name
    tabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    tabBtn.TextSize = 14
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    tabBtn.BorderSizePixel = 0
    tabBtn.Parent = sidebarTabs
    createCorner(tabBtn, 8)
    
    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.BorderSizePixel = 0
    tabContent.Visible = false
    tabContent.Parent = contentScroll
    
    local tabListLayout = Instance.new("UIListLayout")
    tabListLayout.Padding = UDim.new(0, 8)
    tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabListLayout.Parent = tabContent
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, tab in ipairs(tabs) do
            tab.btn.TextColor3 = Color3.fromRGB(180, 180, 180)
            tab.btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
            tab.content.Visible = false
        end
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        tabContent.Visible = true
        contentTitle.Text = name
    end)
    
    table.insert(tabs, {btn = tabBtn, content = tabContent})
    return tabContent
end

-- ============================================================
-- UI组件函数
-- ============================================================
local function createButton(parent, title, icon, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Text = (icon or "") .. "  " .. title
    btn.TextColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSansBold
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.Parent = parent
    createCorner(btn, 8)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 200, 200)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    return btn
end

local function createToggle(parent, title, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0, 40)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = parent
    createCorner(toggleFrame, 8)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.Text = title
    label.TextColor3 = Color3.fromRGB(40, 40, 40)
    label.TextSize = 14
    label.Font = Enum.Font.SourceSansBold
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 45, 0, 22)
    toggleBtn.Position = UDim2.new(1, -60, 0.5, -11)
    toggleBtn.Text = ""
    toggleBtn.BackgroundColor3 = default and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(180, 180, 180)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = toggleFrame
    createCorner(toggleBtn, 999)
    
    local toggleDot = Instance.new("Frame")
    toggleDot.Size = UDim2.new(0, 14, 0, 14)
    toggleDot.Position = default and UDim2.new(1, -18, 0.5, -7) or UDim2.new(0, 4, 0.5, -7)
    toggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleDot.BorderSizePixel = 0
    toggleDot.Parent = toggleBtn
    createCorner(toggleDot, 999)
    
    local isOn = default or false
    
    toggleBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = isOn and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(180, 180, 180)}):Play()
        TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = isOn and UDim2.new(1, -18, 0.5, -7) or UDim2.new(0, 4, 0.5, -7)}):Play()
        if callback then callback(isOn) end
    end)
    
    return toggleFrame
end

local function createSlider(parent, title, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 55)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = parent
    createCorner(sliderFrame, 8)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -30, 0, 20)
    label.Position = UDim2.new(0, 15, 0, 5)
    label.Text = title .. ": " .. default
    label.TextColor3 = Color3.fromRGB(40, 40, 40)
    label.TextSize = 13
    label.Font = Enum.Font.SourceSansBold
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -30, 0, 5)
    sliderBg.Position = UDim2.new(0, 15, 0, 30)
    sliderBg.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = sliderFrame
    createCorner(sliderBg, 999)
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    createCorner(sliderFill, 999)
    
    local sliderBtn = Instance.new("TextButton")
    sliderBtn.Size = UDim2.new(0, 18, 0, 18)
    sliderBtn.Position = UDim2.new((default - min) / (max - min), -9, 0.5, -9)
    sliderBtn.Text = ""
    sliderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderBtn.BorderSizePixel = 0
    sliderBtn.Parent = sliderBg
    createCorner(sliderBtn, 999)
    createStroke(sliderBtn, 2)
    
    local isDragging = false
    
    local function updateSlider(input)
        local mousePos = input.Position.X
        local sliderPos = sliderBg.AbsolutePosition.X
        local sliderSize = sliderBg.AbsoluteSize.X
        local percent = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
        local value = math.floor(min + (max - min) * percent)
        
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
        sliderBtn.Position = UDim2.new(percent, -9, 0.5, -9)
        label.Text = title .. ": " .. value
        
        if callback then callback(value) end
    end
    
    sliderBtn.MouseButton1Down:Connect(function()
        isDragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    return sliderFrame
end

local function createSection(parent, title)
    local sectionLabel = Instance.new("TextLabel")
    sectionLabel.Size = UDim2.new(1, 0, 0, 25)
    sectionLabel.Text = title
    sectionLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
    sectionLabel.TextSize = 15
    sectionLabel.Font = Enum.Font.SourceSansBold
    sectionLabel.BackgroundTransparency = 1
    sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    sectionLabel.Parent = parent
    
    return sectionLabel
end

local function createParagraph(parent, title, desc)
    local paraFrame = Instance.new("Frame")
    paraFrame.Size = UDim2.new(1, 0, 0, 70)
    paraFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    paraFrame.BorderSizePixel = 0
    paraFrame.Parent = parent
    createCorner(paraFrame, 8)
    
    local paraTitle = Instance.new("TextLabel")
    paraTitle.Size = UDim2.new(1, -20, 0, 25)
    paraTitle.Position = UDim2.new(0, 10, 0, 5)
    paraTitle.Text = title
    paraTitle.TextColor3 = Color3.fromRGB(40, 40, 40)
    paraTitle.TextSize = 14
    paraTitle.Font = Enum.Font.SourceSansBold
    paraTitle.BackgroundTransparency = 1
    paraTitle.TextXAlignment = Enum.TextXAlignment.Left
    paraTitle.Parent = paraFrame
    
    local paraDesc = Instance.new("TextLabel")
    paraDesc.Size = UDim2.new(1, -20, 0, 35)
    paraDesc.Position = UDim2.new(0, 10, 0, 30)
    paraDesc.Text = desc
    paraDesc.TextColor3 = Color3.fromRGB(120, 120, 120)
    paraDesc.TextSize = 12
    paraDesc.Font = Enum.Font.SourceSans
    paraDesc.BackgroundTransparency = 1
    paraDesc.TextWrapped = true
    paraDesc.TextXAlignment = Enum.TextXAlignment.Left
    paraDesc.Parent = paraFrame
    
    return paraFrame
end

-- ============================================================
-- 创建标签页
-- ============================================================
local homeTab = createTab("主页", "🏠", "脚本说明与公告")
createParagraph(homeTab, "📢 脚本公告", "欢迎使用 KS Script！")
createParagraph(homeTab, "📝 脚本介绍", "此脚本为缝合各种脚本\n倒卖sm")
createParagraph(homeTab, "⚠️ 警告", "请勿倒卖本脚本！")
createButton(homeTab, "👤 作者QQ: 3236904498", nil, function()
    pcall(function() setclipboard("3236904498") end)
end)

local universalTab = createTab("通用功能", "🛠️", "实用功能合集")
createSection(universalTab, "🏃 人物功能")
createToggle(universalTab, "自定义速度", false, function(v) print("速度:", v) end)
createSlider(universalTab, "速度值", 16, 200, 50, function(v) print("速度:", v) end)
createToggle(universalTab, "穿墙模式", false, function(v) print("穿墙:", v) end)
createToggle(universalTab, "无敌模式", false, function(v) print("无敌:", v) end)

createSection(universalTab, "👁️ 视觉功能")
createToggle(universalTab, "夜视模式", false, function(v) print("夜视:", v) end)
createToggle(universalTab, "ESP透视", false, function(v) print("ESP:", v) end)

createSection(universalTab, "🎯 传送")
createButton(universalTab, "💾 保存位置", nil, function() print("保存位置") end)
createButton(universalTab, "📌 传送到保存点", nil, function() print("传送") end)

local shengdiTab = createTab("圣地rp", "🗺️", "圣地rp脚本")
createSection(shengdiTab, "📜 脚本列表")
createButton(shengdiTab, "Ax脚本", "📜", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tarmaster/AverlikHub/refs/heads/main/Loader"))()
end)
createButton(shengdiTab, "hux脚本", "📜", function()
    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/adff9b33e46197721a37f4d1ad509d418db5cfb1f4899c166f10781be92b5389/download"))()
end)
createButton(shengdiTab, "huxhub", "📜", function()
    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/4f070b7ced7a195b57ea0a533cd8831f6a29f42810254f7b931a670e03f39228/download"))()
end)

local mineTab = createTab("矿山", "⛏️", "矿山脚本加载器")
createSection(mineTab, "⛏️ 矿山脚本")
createButton(mineTab, "加载脚本1", "⛏️", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/z8KgbT9H"))()
end)
createButton(mineTab, "加载脚本2", "⛏️", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/WoiiKau/Mine-a-mountain/refs/heads/main/MaM"))()
end)

local lemonTab = createTab("柠檬", "🍋", "HoshiOnTop 脚本加载器")
createSection(lemonTab, "🍋 柠檬脚本")
createButton(lemonTab, "加载柠檬", "🍋", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Fluxyyy333/HoshiOnTop/main/loader.lua"))()
end)

local txTab = createTab("TX翻译", "🌐", "全自动翻译脚本")
createSection(txTab, "🌐 TX翻译")
createButton(txTab, "加载翻译", "🌐", function()
    TX = "TX Script" Script = "全自动翻译" loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-language"))()
end)

local runraceTab = createTab("Run Race", "🏃", "Run Race 脚本加载器")
createSection(runraceTab, "🏃 Run Race")
createButton(runraceTab, "加载脚本", "🏃", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Deni210/raceclicker/main/Ruby%20Hub%20v1.0", true))()
end)

local aimbotTab = createTab("自瞄一类", "🎯", "ESP 透视脚本")
createSection(aimbotTab, "🎯 ESP")
createButton(aimbotTab, "加载 ESP", "🎯", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/1215203698741/Roblox-ESP-Antibot-V3/refs/heads/main/V3.0phone.lua"))()
end)

local scriptsTab = createTab("脚本整合", "📁", "各类脚本合集")
createSection(scriptsTab, "YI 脚本")
createButton(scriptsTab, "加载 YI", "📁", function()
    getgenv().YI_HUB = "YI_HUB群979312897" loadstring(game:HttpGet('https://raw.githubusercontent.com/YI-HUB-TEAM/YIscript/refs/heads/main/YI_HUB'))("")
end)
createSection(scriptsTab, "PI 脚本")
createButton(scriptsTab, "加载 PI", "📁", function()
    getgenv().XiaoPi = "皮脚本QQ群1002100032" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end)
createSection(scriptsTab, "BS 脚本")
createButton(scriptsTab, "加载 BS", "📁", function()
    loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\103\105\116\101\101\46\99\111\109\47\66\83\95\115\99\114\105\112\116\47\115\99\114\105\112\116\47\114\97\119\47\109\97\115\116\101\114\47\66\83\95\83\99\114\105\112\116\46\76\117\97\117"))()
end)

-- 默认选中第一个标签页
if tabs[1] then
    tabs[1].btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabs[1].btn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    tabs[1].content.Visible = true
end
