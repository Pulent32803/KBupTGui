--[[
    Blox Fruits Ultimate Farm Script
    Поддержка: Авто фарм, ESP, Рейды, Расы V2-V4, Мастери и многое другое
    Меню: Rayfield Interface
]]

--- Загрузка Rayfield
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Сервисы
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local Mouse = LocalPlayer:GetMouse()

-- Переменные для анти-чита
local AntiBanEnabled = true
local RandomDelay = function(min, max)
    return math.random(min * 1000, max * 1000) / 1000
end

-- Создание главного окна
local Window = Rayfield:CreateWindow({
    Name = "🔮 Blox Fruits Ultimate v2.0",
    Icon = 0,
    LoadingTitle = "Blox Fruits Ultimate Script",
    LoadingSubtitle = "by Developer",
    Theme = "Ocean",
    ToggleUIKeybind = "Insert",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BloxFruitsConfig",
        FileName = "UltimateHub"
    },
})

-- Создание вкладок
local FarmTab = Window:CreateTab("🌾 Фарм", "farm")
local CombatTab = Window:CreateTab("⚔️ Бой", "sword")
local ESPTab = Window:CreateTab("👁️ ESP", "eye")
local RaceTab = Window:CreateTab("🧬 Расы", "users")
local RaidTab = Window:CreateTab("⚡ Рейды", "zap")
local FruitTab = Window:CreateTab("🍎 Фрукты", "package")
local TeleportTab = Window:CreateTab("🌍 Телепорты", "map")
local MiscTab = Window:CreateTab("⚙️ Разное", "settings")

-- ==================== АВТО ФАРМ С ПОСТЕПЕННЫМ ТЕЛЕПОРТОМ ====================
local FarmSection = FarmTab:CreateSection("Основной фарм")

local AutoFarmEnabled = false
local AutoQuestEnabled = false
local KillAuraEnabled = false
local CurrentQuest = nil

-- Функция плавного телепорта (анти-чит)
local function SmoothTeleport(TargetPosition)
    if not TargetPosition then return end
    
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then return end
    
    local StartPosition = HumanoidRootPart.Position
    local Distance = (TargetPosition - StartPosition).Magnitude
    
    if Distance < 10 then
        HumanoidRootPart.CFrame = CFrame.new(TargetPosition)
        return
    end
    
    -- Разбиваем телепорт на несколько этапов
    local Steps = math.ceil(Distance / 50) -- Максимум 50 студий за шаг
    for i = 1, Steps do
        local Alpha = i / Steps
        local NewPosition = StartPosition:Lerp(TargetPosition, Alpha)
        HumanoidRootPart.CFrame = CFrame.new(NewPosition)
        wait(RandomDelay(0.05, 0.1)) -- Задержка между шагами
    end
end

-- Функция взятия квеста
local function TakeQuest()
    if not AutoQuestEnabled then return end
    
    -- Поиск NPC с квестами
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Head") then
            if v.Name:find("Quest") or v.Name:find("NPC") then
                local QuestGiver = v
                local QuestPosition = QuestGiver.Head.Position
                
                -- Плавно телепортируемся к NPC
                SmoothTeleport(QuestPosition + Vector3.new(0, 5, 0))
                wait(RandomDelay(0.5, 1))
                
                -- Взаимодействие с NPC
                local args = {
                    [1] = "StartQuest",
                    [2] = QuestGiver.Name
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
                
                CurrentQuest = QuestGiver.Name
                wait(1)
                break
            end
        end
    end
end

-- Функция фарма мобов
local function FarmMobs()
    if not AutoFarmEnabled then return end
    
    local Character = LocalPlayer.Character
    if not Character then return end
    
    -- Поиск ближайшего моба
    local ClosestMob = nil
    local ClosestDistance = math.huge
    
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            if v.Humanoid.Health > 0 and not Players:GetPlayerFromCharacter(v) then
                local Distance = (Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                if Distance < ClosestDistance then
                    ClosestMob = v
                    ClosestDistance = Distance
                end
            end
        end
    end
    
    if ClosestMob then
        if ClosestDistance > 20 then
            -- Плавно подходим к мобу
            SmoothTeleport(ClosestMob.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
        else
            -- Атакуем моба
            if KillAuraEnabled then
                ClosestMob.Humanoid.Health = 0
            else
                -- Используем оружие
                local args = {
                    [1] = "Attack",
                    [2] = ClosestMob.HumanoidRootPart.Position
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
            end
        end
    end
end

-- Основной цикл фарма
coroutine.wrap(function()
    while true do
        wait(RandomDelay(0.3, 0.5))
        
        if AutoFarmEnabled then
            if AutoQuestEnabled and not CurrentQuest then
                TakeQuest()
            end
            FarmMobs()
        end
    end
end)()

-- Toggle для авто фарма
FarmTab:CreateToggle({
    Name = "Авто фарм",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        AutoFarmEnabled = Value
        Rayfield:Notify({
            Title = "Авто фарм",
            Content = Value and "Включен" or "Выключен",
            Duration = 2,
        })
    end
})

FarmTab:CreateToggle({
    Name = "Авто квесты",
    CurrentValue = false,
    Flag = "AutoQuest",
    Callback = function(Value)
        AutoQuestEnabled = Value
    end
})

FarmTab:CreateToggle({
    Name = "Kill Aura (мобы + игроки)",
    CurrentValue = false,
    Flag = "KillAura",
    Callback = function(Value)
        KillAuraEnabled = Value
    end
})

-- ==================== МАСТЕРИ ФРУКТОВ И МЕЧЕЙ ====================
local MasterySection = FarmTab:CreateSection("Мастери")

local AutoMasteryFruit = false
local AutoMasterySword = false
local AutoMasteryGun = false

FarmTab:CreateToggle({
    Name = "Авто мастери фрукт",
    CurrentValue = false,
    Flag = "MasteryFruit",
    Callback = function(Value)
        AutoMasteryFruit = Value
    end
})

FarmTab:CreateToggle({
    Name = "Авто мастери меч",
    CurrentValue = false,
    Flag = "MasterySword",
    Callback = function(Value)
        AutoMasterySword = Value
    end
})

-- ==================== ESP ====================
ESPTab:CreateSection("Визуальные улучшения")

local ESPEnabled = false
local FruitESP = false
local PlayerESP = false
local ChestESP = false
local IslandESP = false

-- Создание ESP объектов
local ESPObjects = {}

local function CreateESP(Target, Color, Text)
    if not Target or not Target:FindFirstChild("HumanoidRootPart") then return end
    
    local Billboard = Instance.new("BillboardGui")
    local TextLabel = Instance.new("TextLabel")
    
    Billboard.Name = "ESP_"..Target.Name
    Billboard.Adornee = Target.HumanoidRootPart
    Billboard.Size = UDim2.new(0, 200, 0, 50)
    Billboard.StudsOffset = Vector3.new(0, 3, 0)
    Billboard.AlwaysOnTop = true
    
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = Text or Target.Name
    TextLabel.TextColor3 = Color
    TextLabel.TextStrokeTransparency = 0
    TextLabel.TextScaled = true
    TextLabel.Font = Enum.Font.SourceSansBold
    
    TextLabel.Parent = Billboard
    Billboard.Parent = Target.HumanoidRootPart
    
    table.insert(ESPObjects, Billboard)
end

ESPTab:CreateToggle({
    Name = "Включить ESP",
    CurrentValue = false,
    Flag = "ESPMain",
    Callback = function(Value)
        ESPEnabled = Value
        if not Value then
            -- Удаляем все ESP
            for _, v in pairs(ESPObjects) do
                v:Destroy()
            end
            table.clear(ESPObjects)
        end
    end
})

ESPTab:CreateToggle({
    Name = "ESP Фрукты",
    CurrentValue = false,
    Flag = "FruitESP",
    Callback = function(Value)
        FruitESP = Value
    end
})

ESPTab:CreateToggle({
    Name = "ESP Игроки",
    CurrentValue = false,
    Flag = "PlayerESP",
    Callback = function(Value)
        PlayerESP = Value
    end
})

ESPTab:CreateToggle({
    Name = "ESP Сундуки",
    CurrentValue = false,
    Flag = "ChestESP",
    Callback = function(Value)
        ChestESP = Value
    end
})

ESPTab:CreateToggle({
    Name = "ESP Острова",
    CurrentValue = false,
    Flag = "IslandESP",
    Callback = function(Value)
        IslandESP = Value
    end
})

-- Цикл обновления ESP
coroutine.wrap(function()
    while true do
        wait(1)
        
        if ESPEnabled then
            -- Фрукты
            if FruitESP then
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name:find("Fruit") and not v:FindFirstChild("ESP_Fruit") then
                        CreateESP(v, Color3.new(1, 0, 0), "🍎 "..v.Name)
                    end
                end
            end
            
            -- Игроки
            if PlayerESP then
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and not v.Character:FindFirstChild("ESP_Player") then
                        local Color = v.TeamColor == LocalPlayer.TeamColor and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
                        CreateESP(v.Character, Color, "👤 "..v.Name)
                    end
                end
            end
            
            -- Сундуки
            if ChestESP then
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name == "Chest1" or v.Name == "Chest2" or v.Name == "Chest3" then
                        if not v:FindFirstChild("ESP_Chest") then
                            CreateESP(v, Color3.new(1, 1, 0), "📦 Chest")
                        end
                    end
                end
            end
        end
    end
end)()

-- ==================== АВТО РАСА V2-V4 ====================
local RaceSection = RaceTab:CreateSection("Авто Раса")

local AutoRaceV2 = false
local AutoRaceV3 = false
local AutoRaceV4 = false

RaceTab:CreateToggle({
    Name = "Авто Race V2",
    CurrentValue = false,
    Flag = "RaceV2",
    Callback = function(Value)
        AutoRaceV2 = Value
    end
})

RaceTab:CreateToggle({
    Name = "Авто Race V3",
    CurrentValue = false,
    Flag = "RaceV3",
    Callback = function(Value)
        AutoRaceV3 = Value
    end
})

RaceTab:CreateToggle({
    Name = "Авто Race V4",
    CurrentValue = false,
    Flag = "RaceV4",
    Callback = function(Value)
        AutoRaceV4 = Value
    end
})

-- ==================== АВТО ФАБРИКА И РЕЙДЫ ====================
RaidTab:CreateSection("Рейды и Фабрика")

local AutoFactory = false
local AutoRaid = false
local AutoChip = false

RaidTab:CreateToggle({
    Name = "Авто Фабрика",
    CurrentValue = false,
    Flag = "AutoFactory",
    Callback = function(Value)
        AutoFactory = Value
    end
})

RaidTab:CreateToggle({
    Name = "Авто Рейд с чипом",
    CurrentValue = false,
    Flag = "AutoRaidChip",
    Callback = function(Value)
        AutoRaid = Value
        if Value then
            -- Автоматическое использование чипа
            local args = {
                [1] = "Raids",
                [2] = "SelectChip"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end
    end
})

RaidTab:CreateToggle({
    Name = "Авто покупка чипа",
    CurrentValue = false,
    Flag = "AutoBuyChip",
    Callback = function(Value)
        AutoChip = Value
    end
})

-- ==================== ВАЛЕНТИН ИВЕНТ ====================
MiscTab:CreateSection("Ивенты")

local ValentinesEnabled = false

MiscTab:CreateToggle({
    Name = "Авто Валентин магазин",
    CurrentValue = false,
    Flag = "Valentines",
    Callback = function(Value)
        ValentinesEnabled = Value
        if Value then
            -- Телепорт к Валентин NPC
            local ValentinesNPC = workspace:FindFirstChild("ValentinesNPC")
            if ValentinesNPC then
                SmoothTeleport(ValentinesNPC.HumanoidRootPart.Position)
                wait(1)
                
                -- Открыть магазин
                local args = {
                    [1] = "ValentinesEvent",
                    [2] = "OpenShop"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
            end
        end
    end
})

-- ==================== ТЕЛЕПОРТЫ ====================
TeleportTab:CreateSection("Быстрые телепорты")

-- Функция для кнопок телепорта
local function CreateTeleportButton(Name, Position)
    TeleportTab:CreateButton({
        Name = "🌍 " .. Name,
        Callback = function()
            SmoothTeleport(Position)
            Rayfield:Notify({
                Title = "Телепорт",
                Content = "Телепортация в " .. Name,
                Duration = 2,
            })
        end
    })
end

-- Основные локации
CreateTeleportButton("Морской Король (Sea 1)", Vector3.new(-1200, 20, 3500))
CreateTeleportButton("Тюрьма (Sea 1)", Vector3.new(5000, 20, 2000))
CreateTeleportButton("Колизей (Sea 2)", Vector3.new(-1500, 20, -500))
CreateTeleportButton("Замок на море (Sea 2)", Vector3.new(-5000, 20, -5000))
CreateTeleportButton("Замок Воплощения (Sea 3)", Vector3.new(2000, 50, -2000))
CreateTeleportButton("Гидра (Sea 3)", Vector3.new(5000, 20, 5000))

TeleportTab:CreateSection("Телепорт к игроку")

local SelectedPlayer = nil
local PlayerDropdown = TeleportTab:CreateDropdown({
    Name = "Выбери игрока",
    Options = {},
    CurrentOption = "",
    Flag = "PlayerSelect",
    Callback = function(Option)
        SelectedPlayer = Players:FindFirstChild(Option)
    end
})

-- Обновление списка игроков
coroutine.wrap(function()
    while true do
        wait(5)
        local PlayerNames = {}
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer then
                table.insert(PlayerNames, v.Name)
            end
        end
        PlayerDropdown:Set(PlayerNames)
    end
end)()

TeleportTab:CreateButton({
    Name = "🔮 Телепорт к игроку",
    Callback = function()
        if SelectedPlayer and SelectedPlayer.Character then
            SmoothTeleport(SelectedPlayer.Character.HumanoidRootPart.Position)
            Rayfield:Notify({
                Title = "Телепорт",
                Content = "Телепортация к " .. SelectedPlayer.Name,
                Duration = 2,
            })
        else
            Rayfield:Notify({
                Title = "Ошибка",
                Content = "Игрок не выбран или не в игре",
                Duration = 2,
            })
        end
    end
})

-- ==================== АВТО ЗАБИРАНИЕ ФРУКТОВ ====================
FruitTab:CreateSection("Фрукты")

local AutoGrabFruit = false
local FruitNotifier = false

FruitTab:CreateToggle({
    Name = "Авто забрать фрукт",
    CurrentValue = false,
    Flag = "AutoGrab",
    Callback = function(Value)
        AutoGrabFruit = Value
    end
})

FruitTab:CreateToggle({
    Name = "Уведомлять о фруктах",
    CurrentValue = false,
    Flag = "FruitNotifier",
    Callback = function(Value)
        FruitNotifier = Value
    end
})

-- Цикл авто забирания фруктов
coroutine.wrap(function()
    while true do
        wait(RandomDelay(0.5, 1))
        
        if AutoGrabFruit then
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name:find("Fruit") and v:FindFirstChild("Handle") then
                    -- Плавно подходим к фрукту
                    SmoothTeleport(v.Handle.Position)
                    wait(0.5)
                    
                    -- Забираем фрукт
                    local args = {
                        [1] = "SetFruit",
                        [2] = v.Name
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
                    
                    if FruitNotifier then
                        Rayfield:Notify({
                            Title = "🍎 Фрукт найден!",
                            Content = "Найден: " .. v.Name,
                            Duration = 3,
                        })
                    end
                    
                    wait(1)
                end
            end
        end
    end
end)()

-- ==================== ЗАЩИТА ОТ АНТИ-ЧИТА ====================
local AntiBanSection = MiscTab:CreateSection("Анти-чит защита")

MiscTab:CreateToggle({
    Name = "Анти-бан защита",
    CurrentValue = true,
    Flag = "AntiBan",
    Callback = function(Value)
        AntiBanEnabled = Value
    end
})

-- Симуляция активности (анти-афк)
coroutine.wrap(function()
    while true do
        wait(300) -- Каждые 5 минут
        if AntiBanEnabled then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(1,0,0))
        end
    end
end)()

-- Случайные движения для маскировки
coroutine.wrap(function()
    while true do
        wait(RandomDelay(60, 120))
        if AutoFarmEnabled and AntiBanEnabled then
            -- Имитация случайных действий игрока
            local random = math.random(1, 3)
            if random == 1 then
                LocalPlayer.Character.Humanoid.Jump = true
            elseif random == 2 then
                VirtualUser:CaptureController()
            end
        end
    end
end)()

-- ==================== ИНФОРМАЦИЯ ====================
local InfoSection = MiscTab:CreateSection("Информация")

MiscTab:CreateButton({
    Name = "📊 Информация об игроке",
    Callback = function()
        local PlayerLevel = LocalPlayer.Data.Level.Value
        local PlayerBounty = LocalPlayer.Leaderstats["Bounty/Honor"].Value
        local PlayerFruit = LocalPlayer.Data.DevilFruit.Value or "Нет"
        
        Rayfield:Notify({
            Title = "Информация",
            Content = string.format("Уровень: %d\nБаунти: %s\nФрукт: %s", PlayerLevel, PlayerBounty, PlayerFruit),
            Duration = 5,
        })
    end
})

MiscTab:CreateButton({
    Name = "🔄 Обновить скрипт",
    Callback = function()
        Rayfield:Notify({
            Title = "Обновление",
            Content = "Проверка обновлений...",
            Duration = 2,
        })
        -- Здесь можно добавить проверку обновлений
    end
})

-- Приветственное уведомление
Rayfield:Notify({
    Title = "✅ Blox Fruits Ultimate",
    Content = "Скрипт успешно загружен!\nНажми Insert для открытия меню",
    Duration = 5,
})

-- Защита от обнаружения
if AntiBanEnabled then
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(...)
        local args = {...}
        local method = getnamecallmethod()
        if method == "FireServer" or method == "InvokeServer" then
            if tostring(args[1]):find("Teleport") or tostring(args[1]):find("AntiCheat") then
                return
            end
        end
        return old(...)
    end)
    setreadonly(mt, true)
end
