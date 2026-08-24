-- ============================================================
-- 自制UI系统
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

local function createStroke(parent, thickness, color)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Color = color or Color3.fromRGB(255, 255, 255)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

local function getRainbowColor(speed)
    return Color3.fromHSV((tick() * speed) % 1, 1, 1)
end

-- ============================================================
-- 主UI创建
-- ============================================================
local uiGui = Instance.new("ScreenGui")
uiGui.Name = "CustomUI"
uiGui.ResetOnSpawn = false
uiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
uiGui.Parent = playerGui

-- 打开按钮
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 60, 0, 60)
openBtn.Position = UDim2.new(0, 20, 0.5, -30)
openBtn.Text = "📱"
openBtn.TextSize = 28
openBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
openBtn.BorderSizePixel = 0
openBtn.Parent = uiGui
createCorner(openBtn, 999)

local openBtnStroke = createStroke(openBtn, 3, Color3.fromRGB(255, 0, 0))
task.spawn(function()
    while uiGui and uiGui.Parent and openBtnStroke and openBtnStroke.Parent do
        openBtnStroke.Color = getRainbowColor(0.3)
        task.wait()
    end
end)

openBtn.MouseEnter:Connect(function()
    TweenService:Create(openBtn, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 70, 0, 70)}):Play()
end)
openBtn.MouseLeave:Connect(function()
    TweenService:Create(openBtn, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 60, 0, 60)}):Play()
end)

-- 主窗口
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.ClipsDescendants = true
mainFrame.Parent = uiGui
createCorner(mainFrame, 15)

local mainFrameStroke = createStroke(mainFrame, 3, Color3.fromRGB(255, 0, 0))
task.spawn(function()
    while uiGui and uiGui.Parent and mainFrameStroke and mainFrameStroke.Parent do
        mainFrameStroke.Color = getRainbowColor(0.2)
        task.wait()
    end
end)

-- 顶部栏
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarGradient = Instance.new("UIGradient")
topBarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 165, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0)),
})
topBarGradient.Rotation = 90
topBarGradient.Parent = topBar

-- 标题
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 200, 0, 50)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.Text = "KS SCRIPT"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 20
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.BackgroundTransparency = 1
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

-- 关闭按钮
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 10)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.BorderSizePixel = 0
closeBtn.Parent = topBar
createCorner(closeBtn, 999)

closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
    }):Play()
    task.wait(0.3)
    mainFrame.Visible = false
end)

-- 标签页容器
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, 0, 0, 40)
tabContainer.Position = UDim2.new(0, 0, 0, 50)
tabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 37)
tabContainer.BorderSizePixel = 0
tabContainer.Parent = mainFrame

-- 内容容器
local contentContainer = Instance.new("ScrollingFrame")
contentContainer.Size = UDim2.new(1, 0, 1, -90)
contentContainer.Position = UDim2.new(0, 0, 0, 90)
contentContainer.BackgroundTransparency = 1
contentContainer.BorderSizePixel = 0
contentContainer.ScrollBarThickness = 4
contentContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
contentContainer.CanvasSize = UDim2.new(0, 0, 0, 450)
contentContainer.Parent = mainFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0, 10)
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Parent = contentContainer

local uiPadding = Instance.new("UIPadding")
uiPadding.PaddingTop = UDim.new(0, 10)
uiPadding.PaddingBottom = UDim.new(0, 10)
uiPadding.Parent = contentContainer

-- ============================================================
-- UI元素创建函数
-- ============================================================
local function createButton(parent, title, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Text = title
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 15
    btn.Font = Enum.Font.SourceSansBold
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.BorderSizePixel = 0
    btn.Parent = parent
    createCorner(btn, 8)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 55)}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    return btn
end

local function createToggle(parent, title, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -20, 0, 40)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = parent
    createCorner(toggleFrame, 8)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.Text = title
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 15
    label.Font = Enum.Font.SourceSansBold
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 50, 0, 25)
    toggleBtn.Position = UDim2.new(1, -65, 0.5, -12)
    toggleBtn.Text = ""
    toggleBtn.BackgroundColor3 = default and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = toggleFrame
    createCorner(toggleBtn, 999)
    
    local toggleDot = Instance.new("Frame")
    toggleDot.Size = UDim2.new(0, 15, 0, 15)
    toggleDot.Position = default and UDim2.new(1, -20, 0.5, -7) or UDim2.new(0, 5, 0.5, -7)
    toggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleDot.BorderSizePixel = 0
    toggleDot.Parent = toggleBtn
    createCorner(toggleDot, 999)
    
    local isOn = default or false
    
    toggleBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = isOn and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)}):Play()
        TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = isOn and UDim2.new(1, -20, 0.5, -7) or UDim2.new(0, 5, 0.5, -7)}):Play()
        if callback then callback(isOn) end
    end)
    
    return toggleFrame
end

local function createSlider(parent, title, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -20, 0, 60)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = parent
    createCorner(sliderFrame, 8)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -30, 0, 25)
    label.Position = UDim2.new(0, 15, 0, 5)
    label.Text = title .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.SourceSansBold
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -30, 0, 6)
    sliderBg.Position = UDim2.new(0, 15, 0, 35)
    sliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
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
    sliderBtn.Size = UDim2.new(0, 20, 0, 20)
    sliderBtn.Position = UDim2.new((default - min) / (max - min), -10, 0.5, -10)
    sliderBtn.Text = ""
    sliderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderBtn.BorderSizePixel = 0
    sliderBtn.Parent = sliderBg
    createCorner(sliderBtn, 999)
    
    local isDragging = false
    
    local function updateSlider(input)
        local mousePos = input.Position.X
        local sliderPos = sliderBg.AbsolutePosition.X
        local sliderSize = sliderBg.AbsoluteSize.X
        local percent = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
        local value = math.floor(min + (max - min) * percent)
        
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
        sliderBtn.Position = UDim2.new(percent, -10, 0.5, -10)
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
    sectionLabel.Size = UDim2.new(1, -20, 0, 30)
    sectionLabel.Text = title
    sectionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    sectionLabel.TextSize = 16
    sectionLabel.Font = Enum.Font.SourceSansBold
    sectionLabel.BackgroundTransparency = 1
    sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    sectionLabel.Parent = parent
    
    return sectionLabel
end

-- ============================================================
-- 标签页系统
-- ============================================================
local tabs = {}
local currentTab = nil

local function createTab(name, icon)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0, 80, 0, 40)
    tabBtn.Position = UDim2.new(0, #tabs * 80, 0, 0)
    tabBtn.Text = icon .. " " .. name
    tabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    tabBtn.TextSize = 13
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 37)
    tabBtn.BorderSizePixel = 0
    tabBtn.Parent = tabContainer
    
    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.BorderSizePixel = 0
    tabContent.Visible = false
    tabContent.Parent = contentContainer
    
    local tabListLayout = Instance.new("UIListLayout")
    tabListLayout.Padding = UDim.new(0, 8)
    tabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabListLayout.Parent = tabContent
    
    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingTop = UDim.new(0, 5)
    tabPadding.PaddingBottom = UDim.new(0, 5)
    tabPadding.Parent = tabContent
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, tab in ipairs(tabs) do
            tab.btn.TextColor3 = Color3.fromRGB(180, 180, 180)
            tab.btn.BackgroundColor3 = Color3.fromRGB(30, 30, 37)
            tab.content.Visible = false
        end
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        tabContent.Visible = true
        currentTab = tabContent
    end)
    
    table.insert(tabs, {btn = tabBtn, content = tabContent})
    return tabContent
end

-- ============================================================
-- 打开/关闭动画
-- ============================================================
openBtn.MouseButton1Click:Connect(function()
    if mainFrame.Visible then
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
        }):Play()
        task.wait(0.3)
        mainFrame.Visible = false
    else
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 400, 0, 500),
            Position = UDim2.new(0.5, -200, 0.5, -250),
        }):Play()
    end
end)

-- 拖动功能
local dragging = false
local dragOffset = Vector2.new(0, 0)

topBar.MouseButton1Down:Connect(function()
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

-- ============================================================
-- 创建标签页和内容
-- ============================================================
local homeTab = createTab("主页", "🏠")
createSection(homeTab, "📢 公告")
createButton(homeTab, "欢迎使用 KS Script", nil)
createButton(homeTab, "作者QQ: 3236904498", function()
    pcall(function() setclipboard("3236904498") end)
end)

local functionTab = createTab("功能", "⚡")
createSection(functionTab, "🏃 人物功能")
createToggle(functionTab, "自定义速度", false, function(v) print("速度:", v) end)
createSlider(functionTab, "速度值", 16, 200, 50, function(v) print("速度:", v) end)
createToggle(functionTab, "穿墙模式", false, function(v) print("穿墙:", v) end)
createSection(functionTab, "👁️ 视觉功能")
createToggle(functionTab, "夜视模式", false, function(v) print("夜视:", v) end)
createToggle(functionTab, "ESP透视", false, function(v) print("ESP:", v) end)

local scriptTab = createTab("脚本", "📜")
createSection(scriptTab, "📜 脚本列表")
createButton(scriptTab, "加载脚本1", function()
    loadstring(game:HttpGet("URL_HERE"))()
end)
createButton(scriptTab, "加载脚本2", function()
    loadstring(game:HttpGet("URL_HERE"))()
end)

local settingTab = createTab("设置", "⚙️")
createSection(settingTab, "⚙️ 设置")
createToggle(settingTab, "彩虹边框", true, function(v) print("彩虹:", v) end)
createSlider(settingTab, "透明度", 0, 100, 100, function(v) print("透明度:", v) end)

-- 默认选中第一个标签页
if tabs[1] then
    tabs[1].btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabs[1].btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    tabs[1].content.Visible = true
end
