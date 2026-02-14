--[[
    Название: Delta Universal GUI v2.0
    Платформа: Delta Executor (Android)
    Стиль: Rayfield Library (Адаптирован под сенсорное управление)
    Автор: Assistant
    Описание: Многофункциональное меню с поддержкой тем и игровых сервисов.
]]

-- Проверка на наличие библиотеки Rayfield (загружаем, если нет)
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Window = Rayfield:CreateWindow({
    Name = "Delta Universal v2.0 | Mobile",
    LoadingTitle = "Delta Executor",
    LoadingSubtitle = "by Assistant",
    ConfigurationSaving = { Enabled = true, FolderName = "DeltaConfigs", FileName = "DeltaHub" },
    Discord = { Enabled = false },
    KeySystem = false,
    KeySettings = { Title = "Delta Key", Subtitle = "Введите ключ", Note = "Ключ: 1234", Key = "1234" }
})

-- Глобальные переменные для состояний
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local VirtualUser = game:GetService("VirtualUser")

-- Текущие настройки
local Settings = {
    Theme = "Dark",
    FlySpeed = 50,
    WalkSpeed = 16,
    JumpPower = 50,
    ESPEnabled = false,
    AimbotEnabled = false
}

-- Переменные для функций
local FlyConnection = nil
local NoclipConnection = nil
local ESPConnections = {}
local AimbotConnection = nil

-- =============================================
-- Функции для работы интерфейса
-- =============================================

-- Функция для смены темы
local function ChangeTheme(theme)
    Settings.Theme = theme
    if theme == "Dark" then
        Rayfield:SetTheme("Dark")
    elseif theme == "Light" then
        Rayfield:SetTheme("Light")
    elseif theme == "RGB" then
        -- Для RGB просто используем темную тему с радужными элементами
        Rayfield:SetTheme("Dark")
        -- Дополнительная RGB подсветка будет в отдельных элементах
    end
end

-- =============================================
-- Основные функции (Main)
-- =============================================

-- Функция полета (Mobile version)
local function ToggleFly(state)
    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end
    
    if state then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0,0,0)
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Parent = Character.HumanoidRootPart
        
        FlyConnection = RunService.RenderStepped:Connect(function()
            if not Character or not Character:FindFirstChild("HumanoidRootPart") then
                ToggleFly(false)
                return
            end
            
            local moveDirection = Vector3.new(0,0,0)
            local cameraDirection = Camera.CFrame.LookVector
            
            -- Управление: кнопки на экране будут в интерфейсе, здесь эмуляция
            if UIS:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + cameraDirection
            end
            if UIS:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - cameraDirection
            end
            if UIS:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - cameraDirection:Cross(Vector3.new(0,1,0))
            end
            if UIS:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + cameraDirection:Cross(Vector3.new(0,1,0))
            end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0,1,0)
            end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
                moveDirection = moveDirection - Vector3.new(0,1,0)
            end
            
            if moveDirection.Magnitude > 0 then
                bodyVelocity.Velocity = moveDirection.Unit * Settings.FlySpeed
            else
                bodyVelocity.Velocity = Vector3.new(0,0,0)
            end
        end)
    else
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            Character.HumanoidRootPart:FindFirstChildOfClass("BodyVelocity"):Destroy()
        end
    end
end

-- Функция Noclip
local function ToggleNoclip(state)
    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end
    
    if state then
        NoclipConnection = RunService.Stepped:Connect(function()
            if Character then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end

-- Функция Infinity Jump
local function ToggleInfinityJump(state)
    if state then
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid:ChangeState("Jumping")
            end
        end)
    end
end

-- Функция Float
local function ToggleFloat(state)
    if state then
        local float = Instance.new("BodyPosition")
        float.MaxForce = Vector3.new(4000, 4000, 4000)
        float.Position = Character.HumanoidRootPart.Position
        float.Parent = Character.HumanoidRootPart
        
        RunService.Heartbeat:Connect(function()
            if not state then return end
            float.Position = Character.HumanoidRootPart.Position
        end)
    else
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            Character.HumanoidRootPart:FindFirstChildOfClass("BodyPosition"):Destroy()
        end
    end
end

-- Функция X-Ray (прозрачные стены)
local function ToggleXRay(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Transparency < 0.5 then
                v.Transparency = 0.5
            end
        end
    else
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Transparency == 0.5 then
                v.Transparency = 0
            end
        end
    end
end

-- Функция FullBright
local function ToggleFullBright(state)
    if state then
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").Ambient = Color3.new(1,1,1)
        game:GetService("Lighting").GlobalShadows = false
    else
        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").Ambient = Color3.new(0,0,0)
        game:GetService("Lighting").GlobalShadows = true
    end
end

-- =============================================
-- Combat/Visuals функции
-- =============================================

-- ESP функция
local function CreateESP(player)
    if player == Player then return end
    
    local esp = {}
    local highlight = Instance.new("Highlight")
    highlight.Parent = player.Character
    highlight.FillColor = Color3.new(1,0,0)
    highlight.OutlineColor = Color3.new(1,1,1)
    
    esp.Highlight = highlight
    
    local function onCharacterAdded(character)
        highlight.Parent = character
    end
    
    player.CharacterAdded:Connect(onCharacterAdded)
    
    return esp
end

local function ToggleESP(state)
    if state then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= Player then
                ESPConnections[player] = CreateESP(player)
            end
        end
        
        game.Players.PlayerAdded:Connect(function(player)
            ESPConnections[player] = CreateESP(player)
        end)
    else
        for _, esp in pairs(ESPConnections) do
            if esp.Highlight then
                esp.Highlight:Destroy()
            end
        end
        ESPConnections = {}
    end
end

-- Aimbot функция
local function ToggleAimbot(state)
    if AimbotConnection then
        AimbotConnection:Disconnect()
        AimbotConnection = nil
    end
    
    if state then
        AimbotConnection = RunService.RenderStepped:Connect(function()
            local closestPlayer = nil
            local shortestDistance = math.huge
            
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= Player and player.Character and player.Character:FindFirstChild("Head") then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    
                    if onScreen and distance < shortestDistance then
                        -- Проверка на видимость (Raycast)
                        local ray = Ray.new(Camera.CFrame.Position, (player.Character.Head.Position - Camera.CFrame.Position).Unit * 1000)
                        local hit, pos = Workspace:FindPartOnRay(ray, Player.Character)
                        
                        if hit and (hit:IsDescendantOf(player.Character) or hit == player.Character.Head) then
                            closestPlayer = player
                            shortestDistance = distance
                        end
                    end
                end
            end
            
            if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestPlayer.Character.Head.Position)
            end
        end)
    end
end

-- =============================================
-- Trolling функции
-- =============================================

-- Fling функция (кидает игроков)
local function FlingPlayer(targetPlayer)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local flingPart = Instance.new("Part")
        flingPart.Size = Vector3.new(5,5,5)
        flingPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-5)
        flingPart.Anchored = true
        flingPart.CanCollide = true
        flingPart.Parent = Workspace
        
        local weld = Instance.new("Weld")
        weld.Part0 = flingPart
        weld.Part1 = targetPlayer.Character.HumanoidRootPart
        weld.C0 = CFrame.new(0,0,0)
        weld.C1 = CFrame.new(0,0,0)
        weld.Parent = flingPart
        
        -- Создаем вращение
        local bodyAngular = Instance.new("BodyAngularVelocity")
        bodyAngular.AngularVelocity = Vector3.new(50,50,50)
        bodyAngular.MaxTorque = Vector3.new(4000,4000,4000)
        bodyAngular.Parent = flingPart
        
        wait(2)
        flingPart:Destroy()
    end
end

-- Функция Headless
local function ToggleHeadless(state)
    if state then
        if Character and Character:FindFirstChild("Head") then
            Character.Head.Transparency = 1
        end
    else
        if Character and Character:FindFirstChild("Head") then
            Character.Head.Transparency = 0
        end
    end
end

-- =============================================
-- Games Hub функции
-- =============================================

local function SetupGamesHub()
    local placeId = game.PlaceId
    
    if placeId == 1234567890 then -- Sail Down A River (пример)
        local GamesTab = Window:CreateTab("Game Features", "⚡")
        local GameSection = GamesTab:CreateSection("Sail Down A River")
        
        GamesTab:CreateToggle({
            Name = "Auto Farm",
            CurrentValue = false,
            Flag = "RiverAutoFarm",
            Callback = function(value)
                -- Логика автофарма
            end
        })
        
        GamesTab:CreateSlider({
            Name = "Boat Speed",
            Range = {10, 200},
            Increment = 5,
            CurrentValue = 50,
            Flag = "RiverSpeed",
            Callback = function(value)
                -- Изменение скорости лодки
            end
        })
        
    elseif placeId == 1234567891 then -- Blox Fruits
        local GamesTab = Window:CreateTab("Game Features", "⚡")
        local GameSection = GamesTab:CreateSection("Blox Fruits")
        
        GamesTab:CreateToggle({
            Name = "Auto Farm Level",
            CurrentValue = false,
            Flag = "BloxAutoFarm",
            Callback = function(value)
                -- Логика автофарма
            end
        })
        
        GamesTab:CreateToggle({
            Name = "Auto Chest",
            CurrentValue = false,
            Flag = "BloxAutoChest",
            Callback = function(value)
                -- Поиск и сбор сундуков
            end
        })
        
        GamesTab:CreateToggle({
            Name = "Fruit Notifier",
            CurrentValue = false,
            Flag = "BloxFruitNotif",
            Callback = function(value)
                -- Уведомления о фруктах
            end
        })
        
    elseif placeId == 1234567892 then -- Escape Tsunami
        local GamesTab = Window:CreateTab("Game Features", "⚡")
        local GameSection = GamesTab:CreateSection("Escape Tsunami")
        
        GamesTab:CreateToggle({
            Name = "Auto Win",
            CurrentValue = false,
            Flag = "TsunamiAutoWin",
            Callback = function(value)
                -- Автоматическое завершение
            end
        })
        
        GamesTab:CreateSlider({
            Name = "Speed",
            Range = {16, 100},
            Increment = 1,
            CurrentValue = 30,
            Flag = "TsunamiSpeed",
            Callback = function(value)
                if Character and Character:FindFirstChild("Humanoid") then
                    Character.Humanoid.WalkSpeed = value
                end
            end
        })
        
    elseif placeId == 1234567893 then -- Pet Simulator 99
        local GamesTab = Window:CreateTab("Game Features", "⚡")
        local GameSection = GamesTab:CreateSection("Pet Simulator 99")
        
        GamesTab:CreateToggle({
            Name = "Auto Farm Coins",
            CurrentValue = false,
            Flag = "PetAutoFarm",
            Callback = function(value)
                -- Фарм монет
            end
        })
        
    elseif placeId == 1234567894 then -- Brookhaven
        local GamesTab = Window:CreateTab("Game Features", "⚡")
        local GameSection = GamesTab:CreateSection("Brookhaven")
        
        GamesTab:CreateButton({
            Name = "Teleport to Luxury House",
            Callback = function()
                -- Телепорт
            end
        })
        
    elseif placeId == 1234567895 then -- Doors
        local GamesTab = Window:CreateTab("Game Features", "⚡")
        local GameSection = GamesTab:CreateSection("Doors")
        
        GamesTab:CreateToggle({
            Name = "See Through Doors",
            CurrentValue = false,
            Flag = "DoorsXRay",
            Callback = function(value)
                ToggleXRay(value)
            end
        })
        
    elseif placeId == 1234567896 then -- BedWars
        local GamesTab = Window:CreateTab("Game Features", "⚡")
        local GameSection = GamesTab:CreateSection("BedWars")
        
        GamesTab:CreateToggle({
            Name = "Aimbot",
            CurrentValue = false,
            Flag = "BedWarsAimbot",
            Callback = function(value)
                ToggleAimbot(value)
            end
        })
        
        GamesTab:CreateToggle({
            Name = "ESP",
            CurrentValue = false,
            Flag = "BedWarsESP",
            Callback = function(value)
                ToggleESP(value)
            end
        })
    end
end

-- =============================================
-- Misc функции
-- =============================================

-- Anti-AFK
local function ToggleAntiAFK(state)
    if state then
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end

-- Bypass Anti-Cheat
local function ToggleBypass(state)
    if state then
        -- Базовый обход проверок
        local oldIndex
        oldIndex = hookmetamethod(game, "__index", function(self, key)
            if self == Character.Humanoid and (key == "WalkSpeed" or key == "JumpPower") then
                return rawget(self, key)
            end
            return oldIndex(self, key)
        end)
    end
end

-- =============================================
-- Создание интерфейса
-- =============================================

-- Вкладка Main
local MainTab = Window:CreateTab("Main", "🏠")
local MainSection = MainTab:CreateSection("Основные функции")

MainTab:CreateToggle({
    Name = "Fly (Mobile)",
    CurrentValue = false,
    Flag = "ToggleFly",
    Callback = ToggleFly
})

MainTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "ToggleNoclip",
    Callback = ToggleNoclip
})

MainTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = Settings.WalkSpeed,
    Flag = "WalkSpeed",
    Callback = function(value)
        Settings.WalkSpeed = value
        if Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.WalkSpeed = value
        end
    end
})

MainTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200},
    Increment = 5,
    CurrentValue = Settings.JumpPower,
    Flag = "JumpPower",
    Callback = function(value)
        Settings.JumpPower = value
        if Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.JumpPower = value
        end
    end
})

MainTab:CreateToggle({
    Name = "Infinity Jump",
    CurrentValue = false,
    Flag = "InfinityJump",
    Callback = ToggleInfinityJump
})

MainTab:CreateToggle({
    Name = "Float",
    CurrentValue = false,
    Flag = "Float",
    Callback = ToggleFloat
})

MainTab:CreateToggle({
    Name = "X-Ray",
    CurrentValue = false,
    Flag = "XRay",
    Callback = ToggleXRay
})

MainTab:CreateToggle({
    Name = "FullBright",
    CurrentValue = false,
    Flag = "FullBright",
    Callback = ToggleFullBright
})

-- Вкладка Combat
local CombatTab = Window:CreateTab("Combat", "⚔️")
local CombatSection = CombatTab:CreateSection("Боевые функции")

CombatTab:CreateToggle({
    Name = "Aimbot (Visible Check)",
    CurrentValue = false,
    Flag = "Aimbot",
    Callback = ToggleAimbot
})

CombatTab:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Flag = "ESP",
    Callback = ToggleESP
})

-- Вкладка Games Hub
local GamesTab = Window:CreateTab("Games", "🎮")
local GamesSection = GamesTab:CreateSection("Игровые сервисы")

-- Запускаем настройку игровых функций
SetupGamesHub()

-- Вкладка Trolling
local TrollingTab = Window:CreateTab("Trolling", "🤡")
local TrollingSection = TrollingTab:CreateSection("Троллинг функции")

-- Создаем выпадающий список для выбора игрока
local playerNames = {}
for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= Player then
        table.insert(playerNames, player.Name)
    end
end

TrollingTab:CreateDropdown({
    Name = "Select Player",
    Options = playerNames,
    CurrentOption = "",
    Flag = "TargetPlayer",
    Callback = function(option)
        Settings.TargetPlayer = option
    end
})

TrollingTab:CreateButton({
    Name = "Fling Player",
    Callback = function()
        if Settings.TargetPlayer then
            FlingPlayer(game.Players[Settings.TargetPlayer])
        end
    end
})

TrollingTab:CreateToggle({
    Name = "Headless (Visual)",
    CurrentValue = false,
    Flag = "Headless",
    Callback = ToggleHeadless
})

TrollingTab:CreateButton({
    Name = "Annoy Player",
    Callback = function()
        if Settings.TargetPlayer then
            -- Отправка спам сообщений в чат
            for i = 1, 10 do
                game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer("LOL", "All")
                wait(0.1)
            end
        end
    end
})

TrollingTab:CreateToggle({
    Name = "Fake Lag",
    CurrentValue = false,
    Flag = "FakeLag",
    Callback = function(value)
        if value then
            -- Имитация лагов
            RunService.Heartbeat:Connect(function()
                wait(0.5)
            end)
        end
    end
})

TrollingTab:CreateToggle({
    Name = "Bring Unanchored",
    CurrentValue = false,
    Flag = "BringUnanchored",
    Callback = function(value)
        if value then
            RunService.Heartbeat:Connect(function()
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and not obj.Anchored then
                        obj.Position = Character.HumanoidRootPart.Position + Vector3.new(5,0,0)
                    end
                end
            end)
        end
    end
})

-- Вкладка Misc
local MiscTab = Window:CreateTab("Misc", "🔧")
local MiscSection = MiscTab:CreateSection("Дополнительно")

MiscTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = false,
    Flag = "AntiAFK",
    Callback = ToggleAntiAFK
})

MiscTab:CreateToggle({
    Name = "Bypass Anti-Cheat",
    CurrentValue = false,
    Flag = "Bypass",
    Callback = ToggleBypass
})

MiscTab:CreateButton({
    Name = "Unlock Emotes",
    Callback = function()
        -- Разблокировка эмоций
        for _, emote in pairs(Player.Character:GetDescendants()) do
            if emote:IsA("StringValue") and emote.Name == "Emote" then
                emote.Value = "All"
            end
        end
    end
})

-- Настройки темы
local SettingsTab = Window:CreateTab("Settings", "⚙️")
local ThemeSection = SettingsTab:CreateSection("Настройки темы")

SettingsTab:CreateDropdown({
    Name = "Theme",
    Options = {"Dark", "Light", "RGB"},
    CurrentOption = "Dark",
    Flag = "ThemeSelector",
    Callback = ChangeTheme
})

-- Загрузка конфигурации
Rayfield:LoadConfiguration()
Rayfield:Notify({
    Title = "Delta Universal",
    Content = "Меню успешно загружено!",
    Duration = 3
})

-- Автоматическое обновление списка игроков
game.Players.PlayerAdded:Connect(function()
    -- Обновляем список игроков в дропдаунах
    local newList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= Player then
            table.insert(newList, player.Name)
        end
    end
    Rayfield:UpdateDropdown("TargetPlayer", newList)
end)

game.Players.PlayerRemoving:Connect(function()
    local newList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= Player then
            table.insert(newList, player.Name)
        end
    end
    Rayfield:UpdateDropdown("TargetPlayer", newList)
end)
