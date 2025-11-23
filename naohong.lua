-- 汉化脚本
-- 江砚辰破解北海

local Translations = {["Nameless Hub"] = "空少汉化",
    ["Main"] = "主要",
    ["Iinfinite Jump"] = "无限跳(可能有回弹)",
    ["Dsync (respawn)"] = "防击打(重生)",
    ["Desync (unstable)"] = "防击打(易变的)",
    ["Dsync No Cloner"] = "防击打(无克隆)",
    ["Desync 2"] = "防击打2",
    ["Auto Lock Base after Steal"] = "偷窃后自动锁定底座",
    ["Hide under base"] = "藏在底座下",
    ["Base Protector"] = "基地保护(需要激光斗篷)",
    ["Auto Cloner"] = "自动克隆",
    ["Auto Fly to best brainrot"] = "自动飞往最好的脑红",
    ["Auto  Steal from above"] = "从上面自动偷窃(新版本无效)",
    ["Performance Boost"] = "降低画质",
    ["Auto Grab"] = "自动抓取(好像没用了)",
    ["NH"] = "脑红",
    ["settings"] = "设置",
    ["Auto Kick after Steal"] = "抢到后自动退出",
    ["Anti Ragdoll"] = "反布娃娃",
    ["Xray"] = "X光",
    ["FLY V2"] = "飞行",
    ["Float/Steal from above"] = "从上面漂浮/偷窃",
    ["Server Hopper"] = "服务器漏斗",
    ["Disable negative effects"] = "禁用负面效果",
    ["Steam speed & jump boost"] = "蒸汽速度和跳跃推进",
    ["Auto Destroy Turret"] = "自动摧毁炮塔",
    ["ESP"] = "追踪",
    ["Web & Laser Auto Aim"] = "网络和激光自动瞄准",
    ["Highest Value ESP"] = "最高值追踪",
    ["Timer ESP"] = "计时器倒计时",
    ["Info"] = "信息",
    ["Copy Discord"] = "作者qq2077812452",
    ["Rejoin Server"] = "重新加入服务器",
    ["Fix Server Hopper"] = "修复服务器漏斗",
    ["Job ID Joiner"] = "服务器ID",
    ["Auto Load"] = "自动加载",
    ["Configure"] = "安装ˌ使成形",
    ["Highest ESP Color"] = "追踪器颜色",
    }

local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    
    if Translations[text] then
        return Translations[text]
    end
    
    for en, cn in pairs(Translations) do
        if text:find(en) then
            return text:gsub(en, cn)
        end
    end
    
    return text
end

local function setupTranslationEngine()
    local success, err = pcall(function()
        local oldIndex = getrawmetatable(game).__newindex
        setreadonly(getrawmetatable(game), false)
        
        getrawmetatable(game).__newindex = newcclosure(function(t, k, v)
            if (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) and k == "Text" then
                v = translateText(tostring(v))
            end
            return oldIndex(t, k, v)
        end)
        
        setreadonly(getrawmetatable(game), true)
    end)
    
    if not success then
        warn("元表劫持失败:", err)
       
        local translated = {}
        local function scanAndTranslate()
            for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                    pcall(function()
                        local text = gui.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                gui.Text = translatedText
                                translated[gui] = true
                            end
                        end
                    end)
                end
            end
            
            local player = game:GetService("Players").LocalPlayer
            if player and player:FindFirstChild("PlayerGui") then
                for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
                    if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                        pcall(function()
                            local text = gui.Text
                            if text and text ~= "" then
                                local translatedText = translateText(text)
                                if translatedText ~= text then
                                    gui.Text = translatedText
                                    translated[gui] = true
                                end
                            end
                        end)
                    end
                end
            end
        end
        
        local function setupDescendantListener(parent)
            parent.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
                    task.wait(0.1)
                    pcall(function()
                        local text = descendant.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                descendant.Text = translatedText
                            end
                        end
                    end)
                end
            end)
        end
        
        pcall(setupDescendantListener, game:GetService("CoreGui"))
        local player = game:GetService("Players").LocalPlayer
        if player and player:FindFirstChild("PlayerGui") then
            pcall(setupDescendantListener, player.PlayerGui)
        end
        
        while true do
            scanAndTranslate()
            task.wait(3)
        end
    end
end

task.wait(2)

setupTranslationEngine()

local success, err = pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr"))()
end)

if not success then
    warn("加载失败:", err)
end
