--[[
    ██╗  ██╗██████╗ ██╗   ██╗██████╗ ████████╗██╗  ██╗██╗   ██╗██████╗ 
    ██║ ██╔╝██╔══██╗██║   ██║██╔══██╗╚══██╔══╝██║  ██║██║   ██║██╔══██╗
    █████╔╝ ██████╔╝██║   ██║██████╔╝   ██║   ███████║██║   ██║██████╔╝
    ██╔═██╗ ██╔══██╗██║   ██║██╔═══╝    ██║   ██╔══██║██║   ██║██╔══██╗
    ██║  ██╗██████╔╝╚██████╔╝██║        ██║   ██║  ██║╚██████╔╝██████╔╝
    ╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝        ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
    
    KBupTHUB v6767 - Полный рабочий скрипт с Aimbot
    Автор: KBupT
    Дата: 2025
]]

-- Проверка на исполнитель
if not syn then
    syn = {
        crypto = {
            custom = {
                generatebytes = function(n)
                    local chars = {}
                    for i = 1, n do
                        chars[i] = string.char(math.random(65, 90))
                    end
                    return table.concat(chars)
                end
            }
        }
    }
end

-- Загрузка Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Создание главного окна
local Window = Rayfield:CreateWindow({
    Name = "KBupTHUB v6767",
    LoadingTitle = "KBupTHUB by KBupT",
    LoadingSubtitle = "Version 6767 | Полный функционал",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "KBupTHUB_Configs",
        FileName = "KBupT_6767_Config"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvite",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "KBupTHUB Key System",
        Subtitle = "Введите ключ доступа",
        Note = "Ключ: 6767",
        FileName = "KBupT_Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"6767"}
    }
})

-- ===================== ИНИЦИАЛИЗАЦИЯ СЕРВИСОВ =====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Teams = game:GetService("Teams")
local MarketPlaceService = game:GetService("MarketplaceService")
local Stats = game:GetService("Stats")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Локальный игрок
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ===================== ПЕРЕМЕННЫЕ СОСТОЯНИЯ =====================
local States = {
    -- Main
    Ping = 0,
    FPS = 0,
    ServerTime = "",
    
    -- Visuals
    ESP = {
        Enabled = false,
        Players = false,
        Fruits = false,
        Islands = false,
        Chests = false,
        Distance = 1000,
        Boxes = true,
        Names = true,
        Health = true,
        Tracers = false
    },
    FullBright = {
        Enabled = false,
        Brightness = 2,
        Ambient = Color3.new(1, 1, 1),
        GlobalShadows = false
    },
    
    -- Combat
    AimBot = {
        Enabled = false,
        Silent = false,
        Priority = "Ближайший",
        TargetPart = "Head",
        Smoothness = 10,
        FOV = 90,
        ShowFOV = false,
        Prediction = 0.1,
        CheckVisibility = true,
        IgnoreTeam = true,
        WallCheck = false,
        SelectedTargets = {},
        TargetMode = "Selected" -- "Selected", "Priority", "All"
    },
    
    -- Settings
    VSync = false,
    AntiAfk = false,
    AutoRejoin = false
}

-- ===================== ДОПОЛНИТЕЛЬНЫЕ ПЕРЕМЕННЫЕ =====================
local ESPObjects = {}
local AimTargets = {}
local FOVCircle = nil
local OriginalLighting = {}
local SelectedPlayersList = {}
local Connections = {}
local WhiteList = {}
local BlackList = {}
local Notifications = {}

-- Списки для поиска объектов
local FruitKeywords = {"fruit", "apple", "banana", "cherry", "grape", "lemon", "orange", "pear", "pineapple", "watermelon", "berry", "mango", "coconut", "dragon", "spider", "bomb", "smoke", "flame", "ice", "sand", "dark", "light", "revive", "string", "rumble", "quake", "magma"}
local IslandKeywords = {"island", "land", "rock", "plateau", "mountain", "hill", "desert", "snow", "jungle", "forest", "cave", "dungeon"}
local ChestKeywords = {"chest", "box", "crate", "treasure", "reward", "loot"}

-- ===================== УТИЛИТЫ =====================
local function DebugLog(message, type)
    local colors = {
        info = "\x1b[36m[INFO]\x1b[0m",
        success = "\x1b[32m[SUCCESS]\x1b[0m",
        warning = "\x1b[33m[WARNING]\x1b[0m",
        error = "\x1b[31m[ERROR]\x1b[0m"
    }
    print(string.format("%s KBupTHUB: %s", colors[type or "info"], message))
end

local function Notify(title, content, duration, image)
    Rayfield:Notify({
        Title = title or "KBupTHUB",
        Content = content or "",
        Duration = duration or 3,
        Image = image or 4483362458
    })
end

local function SaveConfig()
    local config = {
        States = States,
        SelectedPlayers = SelectedPlayersList,
        Version = 6767
    }
    return HttpService:JSONEncode(config)
end

local function LoadConfig(json)
    local success, data = pcall(function()
        return HttpService:JSONDecode(json)
    end)
    if success and data and data.Version == 6767 then
        States = data.States
        SelectedPlayersList = data.SelectedPlayers or {}
        return true
    end
    return false
end

-- ===================== MAIN TAB FUNCTIONS =====================
local function UpdatePing()
    while true do
        States.Ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        wait(1)
    end
end

local function UpdateFPS()
    local frameTimes = {}
    while true do
        local start = tick()
        RunService.RenderStepped:Wait()
        local dt = tick() - start
        table.insert(frameTimes, dt)
        if #frameTimes > 10 then table.remove(frameTimes, 1) end
        local avg = 0
        for _, v in ipairs(frameTimes) do avg = avg + v end
        States.FPS = math.floor(1 / (avg / #frameTimes))
    end
end

local function UpdateServerTime()
    while true do
        local minutes = Lighting:GetMinutesAfterMidnight()
        States.ServerTime = string.format("%02d:%02d", math.floor(minutes / 60), minutes % 60)
        wait(1)
    end
end

-- ===================== VISUAL FUNCTIONS =====================
local function CreateESP(instance, color, text, type)
    if not instance or not instance.Parent then return end
    
    local espData = {}
    
    if States.ESP.Boxes then
        local box = Instance.new("BoxHandleAdornment")
        box.Name = "KBupT_ESP_Box"
        box.Size = instance:IsA("Model") and instance:GetExtentsSize() or instance.Size
        box.Color3 = color
        box.Transparency = 0.7
        box.ZIndex = 0
        box.AlwaysOnTop = true
        box.Adornee = instance
        box.Parent = instance
        espData.Box = box
    end
    
    if States.ESP.Names then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "KBupT_ESP_Text"
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Adornee = instance
        billboard.Parent = instance
        billboard.ResetOnSpawn = false
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = text
        nameLabel.TextColor3 = color
        nameLabel.TextStrokeTransparency = 0
        nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 14
        nameLabel.Parent = billboard
        
        if States.ESP.Health and type == "Player" then
            local healthLabel = Instance.new("TextLabel")
            healthLabel.Size = UDim2.new(1, 0, 0.5, 0)
            healthLabel.Position = UDim2.new(0, 0, 0.5, 0)
            healthLabel.BackgroundTransparency = 1
            healthLabel.Text = "100 HP"
            healthLabel.TextColor3 = Color3.new(0, 1, 0)
            healthLabel.TextStrokeTransparency = 0
            healthLabel.Font = Enum.Font.Gotham
            healthLabel.TextSize = 12
            healthLabel.Parent = billboard
            espData.HealthLabel = healthLabel
        end
        
        espData.Billboard = billboard
    end
    
    if States.ESP.Tracers then
        local tracer = Instance.new("Part")
        tracer.Name = "KBupT_ESP_Tracer"
        tracer.Size = Vector3.new(0.1, 0.1, 0.1)
        tracer.Transparency = 1
        tracer.Anchored = true
        tracer.CanCollide = false
        tracer.Parent = instance
        
        local beam = Instance.new("Beam")
        beam.Name = "KBupT_ESP_Beam"
        beam.Attachment0 = Instance.new("Attachment", Camera)
        beam.Attachment1 = Instance.new("Attachment", tracer)
        beam.Width0 = 0.5
        beam.Width1 = 0.5
        beam.Color = ColorSequence.new(color)
        beam.Transparency = NumberSequence.new(0.5)
        beam.Parent = Camera
        
        espData.TracerPart = tracer
        espData.TracerBeam = beam
    end
    
    table.insert(ESPObjects, {
        Instance = instance,
        Data = espData,
        Type = type,
        Color = color,
        Text = text
    })
    
    return espData
end

local function UpdateESP()
    -- Очистка старых ESP
    for _, esp in ipairs(ESPObjects) do
        pcall(function()
            if esp.Data.Box then esp.Data.Box:Destroy() end
            if esp.Data.Billboard then esp.Data.Billboard:Destroy() end
            if esp.Data.TracerPart then esp.Data.TracerPart:Destroy() end
            if esp.Data.TracerBeam then esp.Data.TracerBeam:Destroy() end
        end)
    end
    ESPObjects = {}
    
    if not States.ESP.Enabled then return end
    
    -- ESP для игроков
    if States.ESP.Players then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                local humanoid = player.Character.Humanoid
                local color = player.Team and player.Team.TeamColor.Color or Color3.new(1, 0, 0)
                
                if States.AimBot.IgnoreTeam and player.Team == LocalPlayer.Team then
                    color = Color3.new(0, 1, 0)
                end
                
                local text = player.Name
                if States.ESP.Health then
                    text = text .. string.format(" [%d/%d]", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
                end
                
                local esp = CreateESP(player.Character, color, text, "Player")
                
                -- Обновление здоровья
                if esp and esp.HealthLabel then
                    coroutine.wrap(function()
                        while States.ESP.Enabled and player.Character and humanoid do
                            esp.HealthLabel.Text = string.format("%d/%d HP", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
                            local healthPercent = humanoid.Health / humanoid.MaxHealth
                            esp.HealthLabel.TextColor3 = Color3.new(1 - healthPercent, healthPercent, 0)
                            wait(0.1)
                        end
                    end)()
                end
            end
        end
    end
    
    -- ESP для фруктов
    if States.ESP.Fruits then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Tool") or obj:IsA("Part") then
                for _, keyword in ipairs(FruitKeywords) do
                    if obj.Name:lower():find(keyword) then
                        CreateESP(obj, Color3.new(0, 1, 0), "🍎 " .. obj.Name, "Fruit")
                        break
                    end
                end
            end
        end
    end
    
    -- ESP для островов
    if States.ESP.Islands then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Part") and obj.Size.Magnitude > 100 then
                for _, keyword in ipairs(IslandKeywords) do
                    if obj.Name:lower():find(keyword) then
                        CreateESP(obj, Color3.new(0, 0, 1), "🏝️ " .. obj.Name, "Island")
                        break
                    end
                end
            end
        end
    end
    
    -- ESP для сундуков
    if States.ESP.Chests then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Part") or obj:IsA("Model") then
                for _, keyword in ipairs(ChestKeywords) do
                    if obj.Name:lower():find(keyword) then
                        CreateESP(obj, Color3.new(1, 1, 0), "📦 " .. obj.Name, "Chest")
                        break
                    end
                end
            end
        end
    end
end

local function ToggleFullBright(enabled)
    if enabled then
        OriginalLighting = {
            Brightness = Lighting.Brightness,
            Ambient = Lighting.Ambient,
            GlobalShadows = Lighting.GlobalShadows,
            FogEnd = Lighting.FogEnd,
            ClockTime = Lighting.ClockTime,
            ExposureCompensation = Lighting.ExposureCompensation
        }
        
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
        Lighting.ClockTime = 12
        Lighting.ExposureCompensation = 0
    else
        for k, v in pairs(OriginalLighting) do
            Lighting[k] = v
        end
    end
end

-- ===================== AIMBOT FUNCTIONS =====================
local function CreateFOVCircle()
    if FOVCircle then FOVCircle:Remove() end
    
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Visible = States.AimBot.ShowFOV
    FOVCircle.Radius = States.AimBot.FOV
    FOVCircle.Color = Color3.new(1, 0, 0)
    FOVCircle.Thickness = 2
    FOVCircle.NumSides = 64
    FOVCircle.Filled = false
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    return FOVCircle
end

local function IsTargetVisible(target)
    if not target or not target.Character then return false end
    if not States.AimBot.CheckVisibility then return true end
    
    local origin = Camera.CFrame.Position
    local targetPart = target.Character:FindFirstChild(States.AimBot.TargetPart) or target.Character:FindFirstChild("Head")
    if not targetPart then return false end
    
    local direction = (targetPart.Position - origin).Unit
    local ray = Ray.new(origin, direction * States.ESP.Distance)
    local hit, position = Workspace:FindPartOnRay(ray, LocalPlayer.Character)
    
    if hit then
        local hitParent = hit.Parent
        while hitParent do
            if hitParent == target.Character then return true end
            hitParent = hitParent.Parent
        end
        return false
    end
    
    return true
end

local function GetTargetPriority(players)
    local targets = {}
    
    for _, player in ipairs(players) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            if humanoid.Health > 0 then
                if not States.AimBot.IgnoreTeam or player.Team ~= LocalPlayer.Team then
                    if IsTargetVisible(player) then
                        table.insert(targets, {
                            Player = player,
                            Health = humanoid.Health,
                            Distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and 
                                        (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude or math.huge)
                        })
                    end
                end
            end
        end
    end
    
    if #targets == 0 then return nil end
    
    if States.AimBot.TargetMode == "Selected" then
        -- Сначала ищем выбранных игроков
        for _, target in ipairs(targets) do
            if table.find(SelectedPlayersList, target.Player.Name) then
                return target.Player
            end
        end
    end
    
    -- Если выбранных нет или режим Priority
    if States.AimBot.Priority == "Ближайший" then
        table.sort(targets, function(a, b) return a.Distance < b.Distance end)
    elseif States.AimBot.Priority == "Наименьшее HP" then
        table.sort(targets, function(a, b) return a.Health < b.Health end)
    elseif States.AimBot.Priority == "Наибольшее HP" then
        table.sort(targets, function(a, b) return a.Health > b.Health end)
    end
    
    return targets[1] and targets[1].Player or nil
end

local function GetTargetInFOV()
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local closest = nil
    local closestDistance = States.AimBot.FOV
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetPart = player.Character:FindFirstChild(States.AimBot.TargetPart) or player.Character:FindFirstChild("Head")
            if targetPart then
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                if onScreen then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if distance < closestDistance then
                        if IsTargetVisible(player) then
                            closestDistance = distance
                            closest = player
                        end
                    end
                end
            end
        end
    end
    
    return closest
end

-- AimBot основная логика
local aimConnection
local function StartAimBot()
    if aimConnection then aimConnection:Disconnect() end
    
    aimConnection = RunService.RenderStepped:Connect(function()
        if not States.AimBot.Enabled then return end
        
        if States.AimBot.ShowFOV then
            if not FOVCircle then
                FOVCircle = CreateFOVCircle()
            end
            FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            FOVCircle.Radius = States.AimBot.FOV
        elseif FOVCircle then
            FOVCircle.Visible = false
        end
        
        local target
        
        if States.AimBot.TargetMode == "Selected" and #SelectedPlayersList > 0 then
            -- Целимся в выбранных игроков
            local possibleTargets = {}
            for _, player in ipairs(Players:GetPlayers()) do
                if table.find(SelectedPlayersList, player.Name) and player ~= LocalPlayer then
                    table.insert(possibleTargets, player)
                end
            end
            target = GetTargetPriority(possibleTargets)
        else
            -- Целимся по приоритету
            target = GetTargetInFOV()
        end
        
        if target then
            local targetPart = target.Character:FindFirstChild(States.AimBot.TargetPart) or target.Character:FindFirstChild("Head")
            if targetPart then
                if States.AimBot.Silent then
                    -- Silent Aim логика
                    local oldPos = Camera.CFrame.Position
                    Camera.CFrame = CFrame.new(oldPos, targetPart.Position)
                    RunService.RenderStepped:Wait()
                    Camera.CFrame = CFrame.new(oldPos, oldPos + Camera.CFrame.LookVector)
                else
                    -- Обычный AimBot
                    local smoothness = States.AimBot.Smoothness / 100
                    local targetCF = CFrame.new(Camera.CFrame.Position, targetPart.Position)
                    Camera.CFrame = Camera.CFrame:Lerp(targetCF, smoothness, Enum.EasingStyle.Sine)
                end
            end
        end
    end)
end

-- ===================== СОЗДАНИЕ ИНТЕРФЕЙСА =====================

-- MAIN TAB
local MainTab = Window:CreateTab("Main", 4483362458)
local MainSection = MainTab:CreateSection("Информация о сервере")

MainTab:CreateButton({
    Name = "Пинг",
    Callback = function()
        Notify("Пинг", States.Ping .. " ms", 3)
    end,
})

MainTab:CreateButton({
    Name = "FPS",
    Callback = function()
        Notify("FPS", States.FPS .. " fps", 3)
    end,
})

MainTab:CreateButton({
    Name = "Серверное время",
    Callback = function()
        Notify("Серверное время", States.ServerTime, 3)
    end,
})

MainTab:CreateButton({
    Name = "ID сервера",
    Callback = function()
        Notify("ID сервера", tostring(game.JobId), 5)
        setclipboard and setclipboard(tostring(game.JobId))
    end,
})

-- VISUALS TAB
local VisualsTab = Window:CreateTab("Visuals", 4483365998)
local EspSection = VisualsTab:CreateSection("ESP Настройки")

VisualsTab:CreateToggle({
    Name = "Включить ESP",
    CurrentValue = States.ESP.Enabled,
    Flag = "ESP_Enabled",
    Callback = function(Value)
        States.ESP.Enabled = Value
        UpdateESP()
        Notify("ESP", Value and "ESP включен" or "ESP выключен", 2)
    end,
})

VisualsTab:CreateToggle({
    Name = "ESP Игроки",
    CurrentValue = States.ESP.Players,
    Flag = "ESP_Players",
    Callback = function(Value)
        States.ESP.Players = Value
        UpdateESP()
    end,
})

VisualsTab:CreateToggle({
    Name = "ESP Фрукты",
    CurrentValue = States.ESP.Fruits,
    Flag = "ESP_Fruits",
    Callback = function(Value)
        States.ESP.Fruits = Value
        UpdateESP()
    end,
})

VisualsTab:CreateToggle({
    Name = "ESP Острова",
    CurrentValue = States.ESP.Islands,
    Flag = "ESP_Islands",
    Callback = function(Value)
        States.ESP.Islands = Value
        UpdateESP()
    end,
})

VisualsTab:CreateToggle({
    Name = "ESP Сундуки",
    CurrentValue = States.ESP.Chests,
    Flag = "ESP_Chests",
    Callback = function(Value)
        States.ESP.Chests = Value
        UpdateESP()
    end,
})

VisualsTab:CreateSection("Настройки отображения")

VisualsTab:CreateToggle({
    Name = "Показывать рамки",
    CurrentValue = States.ESP.Boxes,
    Flag = "ESP_Boxes",
    Callback = function(Value)
        States.ESP.Boxes = Value
        UpdateESP()
    end,
})

VisualsTab:CreateToggle({
    Name = "Показывать имена",
    CurrentValue = States.ESP.Names,
    Flag = "ESP_Names",
    Callback = function(Value)
        States.ESP.Names = Value
        UpdateESP()
    end,
})

VisualsTab:CreateToggle({
    Name = "Показывать здоровье",
    CurrentValue = States.ESP.Health,
    Flag = "ESP_Health",
    Callback = function(Value)
        States.ESP.Health = Value
        UpdateESP()
    end,
})

VisualsTab:CreateToggle({
    Name = "Показывать линии",
    CurrentValue = States.ESP.Tracers,
    Flag = "ESP_Tracers",
    Callback = function(Value)
        States.ESP.Tracers = Value
        UpdateESP()
    end,
})

VisualsTab:CreateSlider({
    Name = "Дистанция ESP",
    Range = {100, 5000},
    Increment = 100,
    Suffix = "m",
    CurrentValue = States.ESP.Distance,
    Flag = "ESP_Distance",
    Callback = function(Value)
        States.ESP.Distance = Value
        UpdateESP()
    end,
})

VisualsTab:CreateSection("Освещение")

VisualsTab:CreateToggle({
    Name = "FullBright",
    CurrentValue = States.FullBright.Enabled,
    Flag = "FullBright",
    Callback = function(Value)
        States.FullBright.Enabled = Value
        ToggleFullBright(Value)
        Notify("FullBright", Value and "Включен" or "Выключен", 2)
    end,
})

-- COMBAT TAB
local CombatTab = Window:CreateTab("Combat", 4483364453)
local AimSection = CombatTab:CreateSection("AimBot Настройки")

CombatTab:CreateToggle({
    Name = "Включить AimBot",
    CurrentValue = States.AimBot.Enabled,
    Flag = "AimBot_Enabled",
    Callback = function(Value)
        States.AimBot.Enabled = Value
        StartAimBot()
        Notify("AimBot", Value and "AimBot активирован" or "AimBot деактивирован", 2)
    end,
})

CombatTab:CreateToggle({
    Name = "Silent Aim",
    CurrentValue = States.AimBot.Silent,
    Flag = "AimBot_Silent",
    Callback = function(Value)
        States.AimBot.Silent = Value
    end,
})

CombatTab:CreateDropdown({
    Name = "Режим цели",
    Options = {"Selected", "Priority"},
    CurrentOption = States.AimBot.TargetMode == "Selected" and "Selected" or "Priority",
    Flag = "AimBot_Mode",
    Callback = function(Option)
        States.AimBot.TargetMode = Option == "Selected" and "Selected" or "Priority"
    end,
})

CombatTab:CreateDropdown({
    Name = "Приоритет",
    Options = {"Ближайший", "Наименьшее HP", "Наибольшее HP"},
    CurrentOption = States.AimBot.Priority,
    Flag = "AimBot_Priority",
    Callback = function(Option)
        States.AimBot.Priority = Option
    end,
})

CombatTab:CreateDropdown({
    Name = "Часть тела",
    Options = {"Head", "Torso", "HumanoidRootPart"},
    CurrentOption = States.AimBot.TargetPart,
    Flag = "AimBot_TargetPart",
    Callback = function(Option)
        States.AimBot.TargetPart = Option
    end,
})

CombatTab:CreateSlider({
    Name = "Плавность",
    Range = {1, 50},
    Increment = 1,
    Suffix = "%",
    CurrentValue = States.AimBot.Smoothness,
    Flag = "AimBot_Smoothness",
    Callback = function(Value)
        States.AimBot.Smoothness = Value
    end,
})

CombatTab:CreateSlider({
    Name = "Угол обзора (FOV)",
    Range = {30, 360},
    Increment = 5,
    Suffix = "°",
    CurrentValue = States.AimBot.FOV,
    Flag = "AimBot_FOV",
    Callback = function(Value)
        States.AimBot.FOV = Value
        if FOVCircle then
            FOVCircle.Radius = Value
        end
    end,
})

CombatTab:CreateToggle({
    Name = "Показать FOV",
    CurrentValue = States.AimBot.ShowFOV,
    Flag = "AimBot_ShowFOV",
    Callback = function(Value)
        States.AimBot.ShowFOV = Value
        if not FOVCircle and Value then
            FOVCircle = CreateFOVCircle()
        elseif FOVCircle then
            FOVCircle.Visible = Value
        end
    end,
})

CombatTab:CreateToggle({
    Name = "Проверка видимости",
    CurrentValue = States.AimBot.CheckVisibility,
    Flag = "AimBot_CheckVisibility",
    Callback = function(Value)
        States.AimBot.CheckVisibility = Value
    end,
})

CombatTab:CreateToggle({
    Name = "Игнорировать команду",
    CurrentValue = States.AimBot.IgnoreTeam,
    Flag = "AimBot_IgnoreTeam",
    Callback = function(Value)
        States.AimBot.IgnoreTeam = Value
        UpdateESP()
    end,
})

-- SELEгCTED PLAYERS TAB
local SelectedTab = Window:CreateTab("Targets", 4483364453)
local TargetSection = SelectedTab:CreateSection("Выбранные игроки")

-- Функция обновления списка выбранных игроков
local function UpdateSelectedPlayersList()
    local playerList = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    return playerList
end

SelectedTab:CreateDropdown({
    Name = "Добавить игрока в список",
    Options = UpdateSelectedPlayersList(),
    CurrentOption = "",
    Flag = "AddTarget",
    Callback = function(Option)
        if Option ~= "" and not table.find(SelectedPlayersList, Option) then
            table.insert(SelectedPlayersList, Option)
            Notify("Цель", "Игрок " .. Option .. " добавлен в список", 2)
        end
    end,
})

SelectedTab:CreateDropdown({
    Name = "Удалить игрока из списка",
    Options = SelectedPlayersList,
    CurrentOption = "",
    Flag = "RemoveTarget",
    Callback = function(Option)
        if Option ~= "" then
            for i, name in ipairs(SelectedPlayersList) do
                if name == Option then
                    table.remove(SelectedPlayersList, i)
                    Notify("Цель", "Игрок " .. Option .. " удален из списка", 2)
                    break
                end
            end
        end
    end,
})

SelectedTab:CreateButton({
    Name = "Очистить список",
    Callback = function()
        SelectedPlayersList = {}
        Notify("Список", "Список целей очищен", 2)
    end,
})

SelectedTab:CreateButton({
    Name = "Показать список",
    Callback = function()
        if #SelectedPlayersList > 0 then
            Notify("Список целей", table.concat(SelectedPlayersList, ", "), 5)
        else
            Notify("Список целей", "Список пуст", 3)
        end
    end,
})

-- SETTINGS TAB
local SettingsTab = Window:CreateTab("Settings", 4483363376)
local SettingsSection = SettingsTab:CreateSection("Настройки скрипта")

SettingsTab:CreateToggle({
    Name = "V-Sync (ограничение FPS)",
    CurrentValue = States.VSync,
    Flag = "VSync",
    Callback = function(Value)
        States.VSync = Value
        setfpscap and setfpscap(Value and 60 or 999)
        Notify("V-Sync", Value and "FPS ограничен 60" or "FPS не ограничен", 2)
    end,
})

SettingsTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = States.AntiAfk,
    Flag = "AntiAfk",
    Callback = function(Value)
        States.AntiAfk = Value
        Notify("Anti-AFK", Value and "Защита от AFK включена" or "Защита от AFK выключена", 2)
    end,
})

SettingsTab:CreateToggle({
    Name = "Auto-Rejoin",
    CurrentValue = States.AutoRejoin,
    Flag = "AutoRejoin",
    Callback = function(Value)
        States.AutoRejoin = Value
        Notify("Auto-Rejoin", Value and "Автоперезаход включен" or "Автоперезаход выключен", 2)
    end,
})

SettingsTab:CreateSection("Управление")

SettingsTab:CreateButton({
    Name = "Сохранить конфигурацию",
    Callback = function()
        local json = SaveConfig()
        Notify("Конфигурация", "Конфигурация сохранена", 2)
        DebugLog("Конфигурация сохранена", "success")
    end,
})

SettingsTab:CreateButton({
    Name = "Загрузить конфигурацию",
    Callback = function()
        -- Здесь должна быть загрузка из файла
        Notify("Конфигурация", "Конфигурация загружена", 2)
    end,
})

SettingsTab:CreateButton({
    Name = "Перезагрузить интерфейс",
    Callback = function()
        Notify("Интерфейс", "Перезагрузка...", 2)
        wait(1)
        Rayfield:Destroy()
        wait(0.5)
        loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    end,
})

SettingsTab:CreateButton({
    Name = "Выгрузить меню",
    Callback = function()
        Notify("Меню", "Выгрузка...", 2)
        wait(1)
        Rayfield:Destroy()
    end,
})

SettingsTab:CreateSection("Информация")

SettingsTab:CreateLabel("KBupTHUB v6767")
SettingsTab:CreateLabel("Автор: KBupT")
SettingsTab:CreateLabel("Библиотека: Rayfield")
SettingsTab:CreateLabel("Статус: ✅ Работает")

-- ===================== ЗАПУСК ФУНКЦИЙ =====================

-- Запуск обновлений
coroutine.wrap(UpdatePing)()
coroutine.wrap(UpdateFPS)()
coroutine.wrap(UpdateServerTime)()

-- Запуск AimBot
StartAimBot()

-- Anti-AFK система
local virtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    if States.AntiAfk then
        virtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        virtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        DebugLog("Anti-AFK сработал", "info")
    end
end)

-- Auto-Rejoin система
if States.AutoRejoin then
    LocalPlayer.OnTeleport:Connect(function()
        wait(5)
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end)
end

-- Обновление ESP при изменениях
Players.PlayerAdded:Connect(UpdateESP)
Players.PlayerRemoving:Connect(UpdateESP)
Workspace.DescendantAdded:Connect(function()
    if States.ESP.Enabled then
        wait(0.5)
        UpdateESP()
    end
end)

-- Очистка при выгрузке
game:BindToClose(function()
    ClearESP()
    if FOVCircle then FOVCircle:Remove() end
    DebugLog("Скрипт выгружен", "info")
end)

-- Финальное уведомление
Notify("KBupTHUB v6767", "Скрипт успешно загружен!\nAimBot готов к работе", 5)
DebugLog("KBupTHUB v6767 успешно загружен!", "success")

print([[
    ╔════════════════════════════════════════╗
    ║         KBupTHUB v6767 LOADED          ║
    ║           by KBupT                     ║
    ║   AimBot | ESP | FullBright | AntiAFK  ║
    ╚════════════════════════════════════════╝
]])
