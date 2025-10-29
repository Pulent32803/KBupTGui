local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer

-- Основное меню
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KBupTMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Кружок утки для открытия/закрытия
local DuckButton = Instance.new("ImageButton")
DuckButton.Name = "DuckToggle"
DuckButton.Size = UDim2.new(0, 50, 0, 50)
DuckButton.Position = UDim2.new(0, 20, 0.5, -25)
DuckButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
DuckButton.BackgroundTransparency = 0.2
DuckButton.Image = "rbxassetid://13285615740"
DuckButton.Parent = ScreenGui

local DuckCorner = Instance.new("UICorner")
DuckCorner.CornerRadius = UDim.new(1, 0)
DuckCorner.Parent = DuckButton

local DuckStroke = Instance.new("UIStroke")
DuckStroke.Color = Color3.fromRGB(80, 80, 80)
DuckStroke.Thickness = 2
DuckStroke.Parent = DuckButton

-- Главное меню
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0, 80, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(50, 50, 50)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "KBupT Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Панель навигации между страницами
local NavigationFrame = Instance.new("Frame")
NavigationFrame.Size = UDim2.new(1, 0, 0, 40)
NavigationFrame.Position = UDim2.new(0, 0, 0, 40)
NavigationFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
NavigationFrame.BorderSizePixel = 0
NavigationFrame.Parent = MainFrame

local Page1Button = Instance.new("TextButton")
Page1Button.Size = UDim2.new(0.5, 0, 1, 0)
Page1Button.Position = UDim2.new(0, 0, 0, 0)
Page1Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Page1Button.Text = "Страница 1"
Page1Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Page1Button.Font = Enum.Font.Gotham
Page1Button.TextSize = 14
Page1Button.Parent = NavigationFrame

local Page2Button = Instance.new("TextButton")
Page2Button.Size = UDim2.new(0.5, 0, 1, 0)
Page2Button.Position = UDim2.new(0.5, 0, 0, 0)
Page2Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Page2Button.Text = "Страница 2"
Page2Button.TextColor3 = Color3.fromRGB(200, 200, 200)
Page2Button.Font = Enum.Font.Gotham
Page2Button.TextSize = 14
Page2Button.Parent = NavigationFrame

-- Статус панель (справа)
local StatusPanel = Instance.new("Frame")
StatusPanel.Size = UDim2.new(0, 200, 0, 120)
StatusPanel.Position = UDim2.new(1, 10, 0, 90)
StatusPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
StatusPanel.BackgroundTransparency = 0.1
StatusPanel.BorderSizePixel = 0
StatusPanel.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 8)
StatusCorner.Parent = StatusPanel

local StatusStroke = Instance.new("UIStroke")
StatusStroke.Color = Color3.fromRGB(60, 60, 60)
StatusStroke.Thickness = 2
StatusStroke.Parent = StatusPanel

-- Аватар игрока
local Avatar = Instance.new("ImageLabel")
Avatar.Size = UDim2.new(0, 50, 0, 50)
Avatar.Position = UDim2.new(0, 10, 0, 10)
Avatar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Avatar.BorderSizePixel = 0
Avatar.Parent = StatusPanel

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0, 8)
AvatarCorner.Parent = Avatar

-- Информация об игроке
local PlayerName = Instance.new("TextLabel")
PlayerName.Size = UDim2.new(1, -70, 0, 20)
PlayerName.Position = UDim2.new(0, 70, 0, 10)
PlayerName.BackgroundTransparency = 1
PlayerName.Text = "Игрок: " .. Player.Name
PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerName.Font = Enum.Font.Gotham
PlayerName.TextSize = 12
PlayerName.TextXAlignment = Enum.TextXAlignment.Left
PlayerName.Parent = StatusPanel

local GameName = Instance.new("TextLabel")
GameName.Size = UDim2.new(1, -70, 0, 20)
GameName.Position = UDim2.new(0, 70, 0, 30)
GameName.BackgroundTransparency = 1
GameName.Text = "Игра: Загрузка..."
GameName.TextColor3 = Color3.fromRGB(200, 200, 200)
GameName.Font = Enum.Font.Gotham
GameName.TextSize = 11
GameName.TextXAlignment = Enum.TextXAlignment.Left
GameName.Parent = StatusPanel

-- FPS и Ping
local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.new(1, -20, 0, 20)
FPSLabel.Position = UDim2.new(0, 10, 0, 70)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "FPS: 0"
FPSLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FPSLabel.Font = Enum.Font.Gotham
FPSLabel.TextSize = 12
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.Parent = StatusPanel

local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.new(1, -20, 0, 20)
PingLabel.Position = UDim2.new(0, 10, 0, 90)
PingLabel.BackgroundTransparency = 1
PingLabel.Text = "Пинг: 0ms"
PingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PingLabel.Font = Enum.Font.Gotham
PingLabel.TextSize = 12
PingLabel.TextXAlignment = Enum.TextXAlignment.Left
PingLabel.Parent = StatusPanel

-- Панель скриптов (Страница 1)
local ScriptsFrame1 = Instance.new("ScrollingFrame")
ScriptsFrame1.Size = UDim2.new(1, -20, 1, -180)
ScriptsFrame1.Position = UDim2.new(0, 10, 0, 150)
ScriptsFrame1.BackgroundTransparency = 1
ScriptsFrame1.BorderSizePixel = 0
ScriptsFrame1.ScrollBarThickness = 4
ScriptsFrame1.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptsFrame1.Visible = true
ScriptsFrame1.Parent = MainFrame

local ScriptsLayout1 = Instance.new("UIListLayout")
ScriptsLayout1.Padding = UDim.new(0, 8)
ScriptsLayout1.Parent = ScriptsFrame1

-- Панель скриптов (Страница 2)
local ScriptsFrame2 = Instance.new("ScrollingFrame")
ScriptsFrame2.Size = UDim2.new(1, -20, 1, -180)
ScriptsFrame2.Position = UDim2.new(0, 10, 0, 150)
ScriptsFrame2.BackgroundTransparency = 1
ScriptsFrame2.BorderSizePixel = 0
ScriptsFrame2.ScrollBarThickness = 4
ScriptsFrame2.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptsFrame2.Visible = false
ScriptsFrame2.Parent = MainFrame

local ScriptsLayout2 = Instance.new("UIListLayout")
ScriptsLayout2.Padding = UDim.new(0, 8)
ScriptsLayout2.Parent = ScriptsFrame2

-- Переменные для FPS
local FrameCount = 0
local LastTime = tick()
local FPS = 0

-- Функция обновления FPS
local function UpdateFPS()
    FrameCount = FrameCount + 1
    local CurrentTime = tick()
    if CurrentTime - LastTime >= 1 then
        FPS = math.floor(FrameCount / (CurrentTime - LastTime))
        FrameCount = 0
        LastTime = CurrentTime
        FPSLabel.Text = "FPS: " .. FPS
    end
end

-- Функция обновления пинга
local function UpdatePing()
    local Stats = game:GetService("Stats")
    local Ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    PingLabel.Text = "Пинг: " .. math.floor(Ping) .. "ms"
end

-- Функция получения информации об игре
local function UpdateGameInfo()
    local success, gameInfo = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    end)
    
    if success and gameInfo then
        GameName.Text = "Игра: " .. gameInfo.Name
    else
        GameName.Text = "Игра: Неизвестно"
    end
end

-- Функция обновления аватара
local function UpdateAvatar()
    local userId = Player.UserId
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    
    local content, isReady = game:GetService("Players"):GetUserThumbnailAsync(userId, thumbType, thumbSize)
    Avatar.Image = content
end

-- Создание кнопок скриптов
local function CreateScriptButton(text, parentFrame)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 45)
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Button.BorderSizePixel = 0
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.AutoButtonColor = false
    Button.Parent = parentFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button
    
    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Color = Color3.fromRGB(60, 60, 60)
    ButtonStroke.Thickness = 2
    ButtonStroke.Parent = Button
    
    -- Анимации при наведении
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(80, 80, 80)}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(100, 100, 100)}):Play()
        wait(0.1)
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    
    return Button
end

-- Создаем кнопки скриптов для страницы 1
local ScriptButtons1 = {}
local scriptNames1 = {
    "Fly",
    "Godmode", 
    "Noclip",
    "Universal fling",
    "Esp",
    "Mega Emotes",
    "Speed/Jump changer",
    "Aimbot(в разработке)"
}

for i = 1, 8 do
    local button = CreateScriptButton(scriptNames1[i], ScriptsFrame1)
    table.insert(ScriptButtons1, button)
end

-- Создаем кнопки скриптов для страницы 2
local ScriptButtons2 = {}
local scriptNames2 = {
    "Murder mystery 2",
    "99 night the forest",
    "Blox Fruits(скоро)",
    "Evade(скоро)",
    "Steal a brainrot(наверное скоро)"
}

for i = 1, 5 do
    local button = CreateScriptButton(scriptNames2[i], ScriptsFrame2)
    table.insert(ScriptButtons2, button)
end

-- Обновляем размер канваса
ScriptsFrame1.CanvasSize = UDim2.new(0, 0, 0, (#ScriptButtons1 * 53) + ((#ScriptButtons1 - 1) * 8))
ScriptsFrame2.CanvasSize = UDim2.new(0, 0, 0, (#ScriptButtons2 * 53) + ((#ScriptButtons2 - 1) * 8))

-- Функции переключения страниц
local CurrentPage = 1

local function SwitchToPage(pageNumber)
    if pageNumber == 1 then
        ScriptsFrame1.Visible = true
        ScriptsFrame2.Visible = false
        Page1Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Page1Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Page2Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Page2Button.TextColor3 = Color3.fromRGB(200, 200, 200)
        CurrentPage = 1
    else
        ScriptsFrame1.Visible = false
        ScriptsFrame2.Visible = true
        Page1Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Page1Button.TextColor3 = Color3.fromRGB(200, 200, 200)
        Page2Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Page2Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        CurrentPage = 2
    end
end

-- Функции открытия/закрытия меню
local MenuOpen = false

local function ToggleMenu()
    MenuOpen = not MenuOpen
    
    if MenuOpen then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
        TweenService:Create(DuckButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        TweenService:Create(DuckButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
        wait(0.3)
        MainFrame.Visible = false
    end
end

-- Обработчики кликов
DuckButton.MouseButton1Click:Connect(ToggleMenu)
CloseButton.MouseButton1Click:Connect(function()
    MenuOpen = true
    ToggleMenu()
end)

Page1Button.MouseButton1Click:Connect(function()
    SwitchToPage(1)
end)

Page2Button.MouseButton1Click:Connect(function()
    SwitchToPage(2)
end)

-- Система перетаскивания
local dragging
local dragInput
local dragStart
local startPos

local function Update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        Update(input)
    end
end)

-- Обновление информации
spawn(function()
    UpdateGameInfo()
    UpdateAvatar()
    
    while true do
        UpdateFPS()
        UpdatePing()
        wait(0.1)
    end
end)

-- Автоматическое обновление FPS
RunService.RenderStepped:Connect(UpdateFPS)

-- =============================================
-- МЕСТО ДЛЯ ВСТАВКИ ТВОИХ СКРИПТОВ - СТРАНИЦА 1
-- =============================================

-- ВСТАВЬ СВОЙ СКРИПТ СЮДА (под кнопкой Скрипт 1):
ScriptButtons1[1].MouseButton1Click:Connect(function()
    local main = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local onof = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local plus = Instance.new("TextButton")
local speed = Instance.new("TextLabel")
local mine = Instance.new("TextButton")
local closebutton = Instance.new("TextButton")
local mini = Instance.new("TextButton")
local mini2 = Instance.new("TextButton")

main.Name = "main"
main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
main.ResetOnSpawn = false

Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderColor3 = Color3.fromRGB(50, 50, 50)
Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
Frame.Size = UDim2.new(0, 190, 0, 57)

up.Name = "up"
up.Parent = Frame
up.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
up.Size = UDim2.new(0, 44, 0, 28)
up.Font = Enum.Font.SourceSans
up.Text = "UP"
up.TextColor3 = Color3.fromRGB(255, 255, 255)
up.TextSize = 14.000

down.Name = "down"
down.Parent = Frame
down.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
down.Position = UDim2.new(0, 0, 0.491228074, 0)
down.Size = UDim2.new(0, 44, 0, 28)
down.Font = Enum.Font.SourceSans
down.Text = "DOWN"
down.TextColor3 = Color3.fromRGB(255, 255, 255)
down.TextSize = 14.000

onof.Name = "onof"
onof.Parent = Frame
onof.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
onof.Size = UDim2.new(0, 56, 0, 28)
onof.Font = Enum.Font.SourceSans
onof.Text = "fly"
onof.TextColor3 = Color3.fromRGB(255, 255, 255)
onof.TextSize = 14.000

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 100, 0, 28)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "KBupTFly v1"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

plus.Name = "plus"
plus.Parent = Frame
plus.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
plus.Position = UDim2.new(0.231578946, 0, 0, 0)
plus.Size = UDim2.new(0, 45, 0, 28)
plus.Font = Enum.Font.SourceSans
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(255, 255, 255)
plus.TextScaled = true
plus.TextSize = 14.000
plus.TextWrapped = true

speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
speed.Size = UDim2.new(0, 44, 0, 28)
speed.Font = Enum.Font.SourceSans
speed.Text = "1"
speed.TextColor3 = Color3.fromRGB(255, 255, 255)
speed.TextScaled = true
speed.TextSize = 14.000
speed.TextWrapped = true

mine.Name = "mine"
mine.Parent = Frame
mine.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
mine.Size = UDim2.new(0, 45, 0, 29)
mine.Font = Enum.Font.SourceSans
mine.Text = "-"
mine.TextColor3 = Color3.fromRGB(255, 255, 255)
mine.TextScaled = true
mine.TextSize = 14.000
mine.TextWrapped = true

closebutton.Name = "Close"
closebutton.Parent = main.Frame
closebutton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
closebutton.Font = "SourceSans"
closebutton.Size = UDim2.new(0, 45, 0, 28)
closebutton.Text = "X"
closebutton.TextColor3 = Color3.fromRGB(255, 255, 255)
closebutton.TextSize = 30
closebutton.Position =  UDim2.new(0, 0, -1, 27)

mini.Name = "minimize"
mini.Parent = main.Frame
mini.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
mini.Font = "SourceSans"
mini.Size = UDim2.new(0, 45, 0, 28)
mini.Text = "-"
mini.TextColor3 = Color3.fromRGB(255, 255, 255)
mini.TextSize = 40
mini.Position = UDim2.new(0, 44, -1, 27)

mini2.Name = "minimize2"
mini2.Parent = main.Frame
mini2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
mini2.Font = "SourceSans"
mini2.Size = UDim2.new(0, 45, 0, 28)
mini2.Text = "+"
mini2.TextColor3 = Color3.fromRGB(255, 255, 255)
mini2.TextSize = 40
mini2.Position = UDim2.new(0, 44, -1, 57)
mini2.Visible = false

speeds = 1

local speaker = game:GetService("Players").LocalPlayer

local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

nowe = false

game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "KBupTFly v1";
	Text = "Загружено";
	Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"})
Duration = 5;

Frame.Active = true
Frame.Draggable = true

onof.MouseButton1Down:connect(function()

	if nowe == true then
		nowe = false

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
	else 
		nowe = true

		for i = 1, speeds do
			spawn(function()

				local hb = game:GetService("RunService").Heartbeat	

				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
		game.Players.LocalPlayer.Character.Animate.Disabled = true
		local Char = game.Players.LocalPlayer.Character
		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

		for i,v in next, Hum:GetPlayingAnimationTracks() do
			v:AdjustSpeed(0)
		end
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end

	if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then

		local plr = game.Players.LocalPlayer
		local torso = plr.Character.Torso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0

		local bg = Instance.new("BodyGyro", torso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = torso.CFrame
		local bv = Instance.new("BodyVelocity", torso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			game:GetService("RunService").RenderStepped:Wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end
			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false

	else
		local plr = game.Players.LocalPlayer
		local UpperTorso = plr.Character.UpperTorso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0

		local bg = Instance.new("BodyGyro", UpperTorso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = UpperTorso.CFrame
		local bv = Instance.new("BodyVelocity", UpperTorso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end

			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false

	end

end)

local tis

up.MouseButton1Down:connect(function()
	tis = up.MouseEnter:connect(function()
		while tis do
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)
		end
	end)
end)

up.MouseLeave:connect(function()
	if tis then
		tis:Disconnect()
		tis = nil
	end
end)

local dis

down.MouseButton1Down:connect(function()
	dis = down.MouseEnter:connect(function()
		while dis do
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)
		end
	end)
end)

down.MouseLeave:connect(function()
	if dis then
		dis:Disconnect()
		dis = nil
	end
end)

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
	wait(0.7)
	game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
	game.Players.LocalPlayer.Character.Animate.Disabled = false
end)

plus.MouseButton1Down:connect(function()
	speeds = speeds + 1
	speed.Text = speeds
	if nowe == true then
		tpwalking = false
		for i = 1, speeds do
			spawn(function()
				local hb = game:GetService("RunService").Heartbeat	
				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end
			end)
		end
	end
end)

mine.MouseButton1Down:connect(function()
	if speeds == 1 then
		speed.Text = 'min 1'
		wait(1)
		speed.Text = speeds
	else
		speeds = speeds - 1
		speed.Text = speeds
		if nowe == true then
			tpwalking = false
			for i = 1, speeds do
				spawn(function()
					local hb = game:GetService("RunService").Heartbeat	
					tpwalking = true
					local chr = game.Players.LocalPlayer.Character
					local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
					while tpwalking and hb:Wait() and chr and hum and hum.Parent do
						if hum.MoveDirection.Magnitude > 0 then
							chr:TranslateBy(hum.MoveDirection)
						end
					end
				end)
			end
		end
	end
end)

closebutton.MouseButton1Click:Connect(function()
	main:Destroy()
end)

mini.MouseButton1Click:Connect(function()
	up.Visible = false
	down.Visible = false
	onof.Visible = false
	plus.Visible = false
	speed.Visible = false
	mine.Visible = false
	mini.Visible = false
	mini2.Visible = true
	main.Frame.BackgroundTransparency = 1
	closebutton.Position =  UDim2.new(0, 0, -1, 57)
end)

mini2.MouseButton1Click:Connect(function()
	up.Visible = true
	down.Visible = true
	onof.Visible = true
	plus.Visible = true
	speed.Visible = true
	mine.Visible = true
	mini.Visible = true
	mini2.Visible = false
	main.Frame.BackgroundTransparency = 0 
	closebutton.Position =  UDim2.new(0, 0, -1, 27)
end)
    print("Скрипт 1 активирован")
end)

-- ВСТАВЬ СВОЙ СКРИПТ СЮДА (под кнопкой Скрипт 2):
ScriptButtons1[2].MouseButton1Click:Connect(function()
    local Players = game:GetService("Players")

-- Dicionário para armazenar o estado do God Mode de cada jogador
local godModePlayers = {}

-- Função para enviar уведомление
local function sendNotification()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "KBupT ESP",
        Text = "ESP загружен! Нажми [ для переключения тегов",
        Duration = 5
    })
end

-- Отправляем уведомление при запуске
sendNotification()

local function applyGodMode(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    -- Configurações invencíveis
    humanoid.MaxHealth = math.huge
    humanoid.Health = math.huge
    
    -- Conexão para prevenir qualquer dano
    humanoid:GetPropertyChangedSignal("Health"):Connect(function()
        if godModePlayers[player.UserId] and humanoid.Health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
end

local function createGodModeGUI(player)
    -- Cria a interface gráfica
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GodModeGUI"
    screenGui.ResetOnSpawn = false
    
    -- Frame principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 250, 0, 80)
    mainFrame.Position = UDim2.new(0.5, -125, 0, 10)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Efeito de borda arredondada
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = mainFrame
    
    -- Sombra/Stroke
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(80, 80, 80)
    uiStroke.Thickness = 2
    uiStroke.Parent = mainFrame
    
    -- Título
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 25)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Text = "GOD MODE CONTROL"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.Parent = mainFrame
    
    -- Borda arredondada para o título
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleLabel
    
    -- Botão de fechar (X)
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -25, 0, 2)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Text = "X"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 12
    closeButton.Parent = titleLabel
    
    -- Borda arredondada para o botão fechar
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 4)
    closeCorner.Parent = closeButton
    
    -- Botão de God Mode
    local godButton = Instance.new("TextButton")
    godButton.Name = "GodButton"
    godButton.Size = UDim2.new(0.8, 0, 0.5, 0)
    godButton.Position = UDim2.new(0.1, 0, 0.4, 0)
    godButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    godButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    godButton.Text = "GOD MODE: OFF"
    godButton.Font = Enum.Font.GothamBold
    godButton.TextSize = 14
    godButton.Parent = mainFrame
    
    -- Borda arredondada para o botão
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = godButton
    
    -- Stroke para o botão
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(100, 100, 100)
    buttonStroke.Thickness = 1
    buttonStroke.Parent = godButton
    
    -- Função para fechar a GUI
    local function closeGUI()
        screenGui:Destroy()
    end
    
    -- Função para alternar o God Mode
    local function toggleGodMode()
        godModePlayers[player.UserId] = not godModePlayers[player.UserId]
        
        if godModePlayers[player.UserId] then
            godButton.Text = "GOD MODE: ON"
            godButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            applyGodMode(player)
            
            -- Уведомление о включении
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "God Mode",
                Text = "God Mode АКТИВИРОВАН!",
                Duration = 3
            })
        else
            godButton.Text = "GOD MODE: OFF"
            godButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            
            -- Restaura configurações normais
            if player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.MaxHealth = 100
                    humanoid.Health = 100
                end
            end
            
            -- Уведомление о выключении
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "God Mode",
                Text = "God Mode ДЕАКТИВИРОВАН!",
                Duration = 3
            })
        end
    end
    
    -- Conecta os eventos
    closeButton.MouseButton1Click:Connect(closeGUI)
    godButton.MouseButton1Click:Connect(toggleGodMode)
    
    -- Efeitos hover para botões
    local function addHoverEffects(button)
        local originalColor = button.BackgroundColor3
        
        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = originalColor:Lerp(Color3.fromRGB(255, 255, 255), 0.2)
        end)
        
        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = originalColor
        end)
    end
    
    addHoverEffects(godButton)
    addHoverEffects(closeButton)
    
    -- Atualiza quando o personagem muda
    player.CharacterAdded:Connect(function(character)
        if godModePlayers[player.UserId] then
            applyGodMode(player)
        end
    end)
    
    -- Adiciona a GUI ao jogador
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

-- Configura para novos jogadores
Players.PlayerAdded:Connect(function(player)
    godModePlayers[player.UserId] = false
    createGodModeGUI(player)
end)

-- Configura para jogadores já conectados
for _, player in ipairs(Players:GetPlayers()) do
    godModePlayers[player.UserId] = false
    createGodModeGUI(player)
end
    print("Скрипт 2 активирован")
end)

-- ВСТАВЬ СВОЙ СКРИПТ СЮДА (под кнопкой Скрипт 3):
ScriptButtons1[3].MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Удаляем существующий GUI
pcall(function()
    game.CoreGui.NoclipGui:Destroy()
end)

-- Создаем GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "NoclipGui"
gui.ResetOnSpawn = false

-- Главный фрейм
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = false

-- Заголовок "KBupTNoClip"
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "KBupTNoClip"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- Надпись "noclip"
local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 0, 20)
label.Position = UDim2.new(0, 0, 0, 30)
label.Text = "Режим ноклипа"
label.TextColor3 = Color3.fromRGB(200, 200, 200)
label.BackgroundTransparency = 1
label.Font = Enum.Font.Gotham
label.TextSize = 14

-- Кнопка переключения ноклипа
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.7, 0, 0, 30)
button.Position = UDim2.new(0.15, 0, 0, 60)
button.Text = "Включить Ноклип"
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.Gotham
button.TextSize = 14
button.BorderSizePixel = 0

-- Кнопка закрытия
local closeButton = Instance.new("TextButton", frame)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(0.85, 0, 0.05, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.BorderSizePixel = 0

-- Логика ноклипа
local noclip = false
local connection
local RunService = game:GetService("RunService")

local function toggleNoclip()
	noclip = not noclip
	
	if noclip then
		button.Text = "Выключить Ноклип"
		button.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
		
		game:GetService("StarterGui"):SetCore("SendNotification", { 
			Title = "KBupTNoClip v1",
			Text = "Ноклип активирован",
			Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
			Duration = 3
		})
		
		connection = RunService.Stepped:Connect(function()
			if player.Character then
				for _, part in pairs(player.Character:GetDescendants()) do
					if part:IsA("BasePart") and part.CanCollide then
						part.CanCollide = false
					end
				end
			end
		end)
	else
		button.Text = "Включить Ноклип"
		button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		
		game:GetService("StarterGui"):SetCore("SendNotification", { 
			Title = "KBupTNoClip v1",
			Text = "Ноклип деактивирован",
			Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
			Duration = 3
		})
		
		if connection then 
			connection:Disconnect() 
		end
		
		if player.Character then
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
	end
end

button.MouseButton1Click:Connect(toggleNoclip)
closeButton.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Уведомление о загрузке
game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "KBupTNoClip v1",
	Text = "Загружено",
	Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
	Duration = 3
})

-- Система перетаскивания для мобильных устройств и ПК
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Обработка перезагрузки персонажа
player.CharacterAdded:Connect(function(newCharacter)
	character = newCharacter
	if noclip and connection then
		connection:Disconnect()
		wait(1)
		connection = RunService.Stepped:Connect(function()
			if player.Character then
				for _, part in pairs(player.Character:GetDescendants()) do
					if part:IsA("BasePart") and part.CanCollide then
						part.CanCollide = false
					end
				end
			end
		end)
	end
end)
    print("Скрипт 3 активирован")
end)

-- ВСТАВЬ СВОЙ СКРИПТ СЮДА (под кнопкой Скрипт 4):
ScriptButtons1[4].MouseButton1Click:Connect(function()
    local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KBupTFlingGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "KBUPT FLING"
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 18
CloseButton.Parent = TitleBar

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Position = UDim2.new(0, 10, 0, 40)
StatusLabel.Size = UDim2.new(1, -20, 0, 25)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Выберите цели для флинга"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 16
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = MainFrame

local SelectionFrame = Instance.new("Frame")
SelectionFrame.Position = UDim2.new(0, 10, 0, 70)
SelectionFrame.Size = UDim2.new(1, -20, 0, 200)
SelectionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SelectionFrame.BorderSizePixel = 0
SelectionFrame.Parent = MainFrame

local PlayerScrollFrame = Instance.new("ScrollingFrame")
PlayerScrollFrame.Position = UDim2.new(0, 5, 0, 5)
PlayerScrollFrame.Size = UDim2.new(1, -10, 1, -10)
PlayerScrollFrame.BackgroundTransparency = 1
PlayerScrollFrame.BorderSizePixel = 0
PlayerScrollFrame.ScrollBarThickness = 6
PlayerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerScrollFrame.Parent = SelectionFrame

local StartButton = Instance.new("TextButton")
StartButton.Position = UDim2.new(0, 10, 0, 280)
StartButton.Size = UDim2.new(0.5, -15, 0, 40)
StartButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
StartButton.BorderSizePixel = 0
StartButton.Text = "НАЧАТЬ ФЛИНГ"
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.Font = Enum.Font.SourceSansBold
StartButton.TextSize = 18
StartButton.Parent = MainFrame

local StopButton = Instance.new("TextButton")
StopButton.Position = UDim2.new(0.5, 5, 0, 280)
StopButton.Size = UDim2.new(0.5, -15, 0, 40)
StopButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
StopButton.BorderSizePixel = 0
StopButton.Text = "ОСТАНОВИТЬ"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.Font = Enum.Font.SourceSansBold
StopButton.TextSize = 18
StopButton.Parent = MainFrame

local SelectAllButton = Instance.new("TextButton")
SelectAllButton.Position = UDim2.new(0, 10, 0, 330)
SelectAllButton.Size = UDim2.new(0.5, -15, 0, 30)
SelectAllButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SelectAllButton.BorderSizePixel = 0
SelectAllButton.Text = "ВЫБРАТЬ ВСЕХ"
SelectAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectAllButton.Font = Enum.Font.SourceSans
SelectAllButton.TextSize = 14
SelectAllButton.Parent = MainFrame

local DeselectAllButton = Instance.new("TextButton")
DeselectAllButton.Position = UDim2.new(0.5, 5, 0, 330)
DeselectAllButton.Size = UDim2.new(0.5, -15, 0, 30)
DeselectAllButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
DeselectAllButton.BorderSizePixel = 0
DeselectAllButton.Text = "СНЯТЬ ВСЕХ"
DeselectAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DeselectAllButton.Font = Enum.Font.SourceSans
DeselectAllButton.TextSize = 14
DeselectAllButton.Parent = MainFrame

local SelectedTargets = {}
local PlayerCheckboxes = {}
local FlingActive = false
local FlingConnection = nil
getgenv().OldPos = nil
getgenv().FPDH = workspace.FallenPartsDestroyHeight

local function RefreshPlayerList()
    for _, child in pairs(PlayerScrollFrame:GetChildren()) do
        child:Destroy()
    end
    PlayerCheckboxes = {}
    
    local PlayerList = Players:GetPlayers()
    table.sort(PlayerList, function(a, b) return a.Name:lower() < b.Name:lower() end)
    
    local yPosition = 5
    for _, player in ipairs(PlayerList) do
        if player ~= Player then
            local PlayerEntry = Instance.new("Frame")
            PlayerEntry.Size = UDim2.new(1, -10, 0, 30)
            PlayerEntry.Position = UDim2.new(0, 5, 0, yPosition)
            PlayerEntry.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            PlayerEntry.BorderSizePixel = 0
            PlayerEntry.Parent = PlayerScrollFrame
            
            local Checkbox = Instance.new("TextButton")
            Checkbox.Size = UDim2.new(0, 24, 0, 24)
            Checkbox.Position = UDim2.new(0, 3, 0.5, -12)
            Checkbox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            Checkbox.BorderSizePixel = 0
            Checkbox.Text = ""
            Checkbox.Parent = PlayerEntry
            
            local Checkmark = Instance.new("TextLabel")
            Checkmark.Size = UDim2.new(1, 0, 1, 0)
            Checkmark.BackgroundTransparency = 1
            Checkmark.Text = "✓"
            Checkmark.TextColor3 = Color3.fromRGB(0, 255, 0)
            Checkmark.TextSize = 18
            Checkmark.Font = Enum.Font.SourceSansBold
            Checkmark.Visible = SelectedTargets[player.Name] ~= nil
            Checkmark.Parent = Checkbox
            
            local NameLabel = Instance.new("TextLabel")
            NameLabel.Size = UDim2.new(1, -35, 1, 0)
            NameLabel.Position = UDim2.new(0, 30, 0, 0)
            NameLabel.BackgroundTransparency = 1
            NameLabel.Text = player.Name
            NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            NameLabel.TextSize = 16
            NameLabel.Font = Enum.Font.SourceSans
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left
            NameLabel.Parent = PlayerEntry
            
            local ClickArea = Instance.new("TextButton")
            ClickArea.Size = UDim2.new(1, 0, 1, 0)
            ClickArea.BackgroundTransparency = 1
            ClickArea.Text = ""
            ClickArea.ZIndex = 2
            ClickArea.Parent = PlayerEntry
            
            ClickArea.MouseButton1Click:Connect(function()
                if SelectedTargets[player.Name] then
                    SelectedTargets[player.Name] = nil
                    Checkmark.Visible = false
                else
                    SelectedTargets[player.Name] = player
                    Checkmark.Visible = true
                end
                
                UpdateStatus()
            end)
            
            PlayerCheckboxes[player.Name] = {
                Entry = PlayerEntry,
                Checkmark = Checkmark
            }
            
            yPosition = yPosition + 35
        end
    end
    
    PlayerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPosition + 5)
end

local function CountSelectedTargets()
    local count = 0
    for _ in pairs(SelectedTargets) do
        count = count + 1
    end
    return count
end

local function UpdateStatus()
    local count = CountSelectedTargets()
    if FlingActive then
        StatusLabel.Text = "Флинг " .. count .. " целей"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    else
        StatusLabel.Text = count .. " целей выбрано" 
        StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

local function ToggleAllPlayers(select)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Player then
            local checkboxData = PlayerCheckboxes[player.Name]
            if checkboxData then
                if select then
                    SelectedTargets[player.Name] = player
                    checkboxData.Checkmark.Visible = true
                else
                    SelectedTargets[player.Name] = nil
                    checkboxData.Checkmark.Visible = false
                end
            end
        end
    end
    
    UpdateStatus()
end

local function Message(Title, Text, Time)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = Title,
        Text = Text,
        Duration = Time or 5
    })
end

local function SkidFling(TargetPlayer)
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart
    local TCharacter = TargetPlayer.Character
    if not TCharacter then return end
    
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle
    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessory and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end
    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        
        if THumanoid and THumanoid.Sit then
            return Message("Ошибка", TargetPlayer.Name .. " сидит", 2)
        end
        
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end
        
        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
        
        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0
            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                end
            until Time + TimeToWait < tick() or not FlingActive
        end
        
        workspace.FallenPartsDestroyHeight = 0/0
        
        local BV = Instance.new("BodyVelocity")
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(0, 0, 0)
        BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        
        if TRootPart then
            SFBasePart(TRootPart)
        elseif THead then
            SFBasePart(THead)
        elseif Handle then
            SFBasePart(Handle)
        else
            return Message("Ошибка", TargetPlayer.Name .. " нет валидных частей", 2)
        end
        
        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid
        
        if getgenv().OldPos then
            repeat
                RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                Humanoid:ChangeState("GettingUp")
                for _, part in pairs(Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Velocity, part.RotVelocity = Vector3.new(), Vector3.new()
                    end
                end
                task.wait()
            until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
            workspace.FallenPartsDestroyHeight = getgenv().FPDH
        end
    else
        return Message("Ошибка", "Ваш персонаж не готов", 2)
    end
end

local function StartFling()
    if FlingActive then return end
    
    local count = CountSelectedTargets()
    if count == 0 then
        StatusLabel.Text = "Нет выбранных целей!"
        wait(1)
        StatusLabel.Text = "Выберите цели для флинга"
        return
    end
    
    FlingActive = true
    UpdateStatus()
    Message("Запущено", "Флинг " .. count .. " целей", 2)
    
    spawn(function()
        while FlingActive do
            local validTargets = {}
            
            for name, player in pairs(SelectedTargets) do
                if player and player.Parent then
                    validTargets[name] = player
                else
                    SelectedTargets[name] = nil
                    local checkbox = PlayerCheckboxes[name]
                    if checkbox then
                        checkbox.Checkmark.Visible = false
                    end
                end
            end
            
            for _, player in pairs(validTargets) do
                if FlingActive then
                    SkidFling(player)
                    wait(0.1)
                else
                    break
                end
            end
            
            UpdateStatus()
            wait(0.5)
        end
    end)
end

local function StopFling()
    if not FlingActive then return end
    
    FlingActive = false
    
    UpdateStatus()
    Message("Остановлено", "Флинг остановлен", 2)
end

StartButton.MouseButton1Click:Connect(StartFling)
StopButton.MouseButton1Click:Connect(StopFling)
SelectAllButton.MouseButton1Click:Connect(function() ToggleAllPlayers(true) end)
DeselectAllButton.MouseButton1Click:Connect(function() ToggleAllPlayers(false) end)
CloseButton.MouseButton1Click:Connect(function()
    StopFling()
    ScreenGui:Destroy()
end)

Players.PlayerAdded:Connect(RefreshPlayerList)
Players.PlayerRemoving:Connect(function(player)
    if SelectedTargets[player.Name] then
        SelectedTargets[player.Name] = nil
    end
    RefreshPlayerList()
    UpdateStatus()
end)

RefreshPlayerList()
UpdateStatus()

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "KBupTFling v1",
    Text = "Загружено",
    Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
    Duration = 3
})
    print("Скрипт 4 активирован")
end)

-- ВСТАВЬ СВОЙ СКРИПТ СЮДА (под кнопкой Скрипт 5):
ScriptButtons1[5].MouseButton1Click:Connect(function()
    -- Простой скрипт подсветки игроков и тегов с функцией включения/выключения
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local MaxDistance = 400.5 -- Дистанция в юнитах для показа тегов

-- Переменные
local NametagsEnabled = true 
local HighlightEnabled = true

-- Создаем GUI
local ESPGUI = Instance.new("ScreenGui")
ESPGUI.Name = "KBupTESP"
ESPGUI.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ESPGUI

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(50, 50, 50)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "KBupT ESP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Кнопки управления
local NametagsButton = Instance.new("TextButton")
NametagsButton.Size = UDim2.new(0.8, 0, 0, 40)
NametagsButton.Position = UDim2.new(0.1, 0, 0, 50)
NametagsButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
NametagsButton.Text = "Теги: ON"
NametagsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NametagsButton.Font = Enum.Font.Gotham
NametagsButton.TextSize = 14
NametagsButton.Parent = MainFrame

local NametagsCorner = Instance.new("UICorner")
NametagsCorner.CornerRadius = UDim.new(0, 8)
NametagsCorner.Parent = NametagsButton

local HighlightButton = Instance.new("TextButton")
HighlightButton.Size = UDim2.new(0.8, 0, 0, 40)
HighlightButton.Position = UDim2.new(0.1, 0, 0, 100)
HighlightButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
HighlightButton.Text = "Подсветка: ON"
HighlightButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HighlightButton.Font = Enum.Font.Gotham
HighlightButton.TextSize = 14
HighlightButton.Parent = MainFrame

local HighlightCorner = Instance.new("UICorner")
HighlightCorner.CornerRadius = UDim.new(0, 8)
HighlightCorner.Parent = HighlightButton

-- Функция для создания тега игрока
local function CreateNametag(Player)
    if Player == LocalPlayer then return end -- Пропускаем локального игрока

    local function SetupNametag(Character)
        local Head = Character:FindFirstChild("Head")
        if not Head then return end -- Если нет головы, выходим

        -- Удаляем существующий тег если есть
        local OldNametag = Head:FindFirstChild("Nametag")
        if OldNametag then
            OldNametag:Destroy()
        end

        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Name = "Nametag"
        BillboardGui.Adornee = Head
        BillboardGui.Size = UDim2.new(0, 75, 0, 150)
        BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
        BillboardGui.AlwaysOnTop = true

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.Text = Player.Name
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Белый цвет
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextStrokeTransparency = 0.75 -- Обводка для лучшей видимости
        TextLabel.Font = Enum.Font.Code
        TextLabel.TextScaled = true
        TextLabel.Parent = BillboardGui

        BillboardGui.Parent = Head

        -- Функция обновления видимости на основе дистанции и переключателя
        local function UpdateVisibility()
            if NametagsEnabled and Player.Character and Player.Character:FindFirstChild("Head") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                local Distance = (Player.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude
                BillboardGui.Enabled = (Distance <= MaxDistance)
            else
                BillboardGui.Enabled = false
            end
        end

        -- Мониторинг видимости
        local Connection
        Connection = RunService.Heartbeat:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("Head") then
                UpdateVisibility()
            else
                BillboardGui:Destroy() -- Очищаем тег когда игрок умирает
                Connection:Disconnect()
            end
        end)
    end

    -- Применяем когда персонаж появляется или возрождается
    if Player.Character then
        SetupNametag(Player.Character)
    end
    Player.CharacterAdded:Connect(SetupNametag)
end

-- Функция применения подсветки к игроку
local function ApplyHighlight(Player)
    if Player == LocalPlayer then return end -- Пропускаем локального игрока

    local function SetupHighlight(Character)
        -- Удаляем старые подсветки
        for _, v in pairs(Character:GetChildren()) do
            if v:IsA("Highlight") then
                v:Destroy()
            end
        end

        if not HighlightEnabled then return end

        local Highlighter = Instance.new("Highlight")
        Highlighter.Parent = Character

        local function UpdateFillColor()
            local DefaultColor = Color3.fromRGB(255, 48, 51) -- Красный цвет по умолчанию
            Highlighter.FillColor = Player.TeamColor and Player.TeamColor.Color or DefaultColor
        end

        UpdateFillColor()
        Player:GetPropertyChangedSignal("TeamColor"):Connect(UpdateFillColor)

        -- Удаляем подсветку когда игрок умирает
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Humanoid.Died:Connect(function()
                Highlighter:Destroy()
            end)
        end
    end

    -- Применяем подсветку при спавне и возрождении
    if Player.Character then
        SetupHighlight(Player.Character)
    end
    Player.CharacterAdded:Connect(SetupHighlight)
end

-- Функция переключения тегов
local function ToggleNametags()
    NametagsEnabled = not NametagsEnabled -- Меняем состояние переключателя
    
    if NametagsEnabled then
        NametagsButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        NametagsButton.Text = "Теги: ON"
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "KBupT ESP",
            Text = "Теги игроков ВКЛЮЧЕНЫ",
            Duration = 3
        })
    else
        NametagsButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        NametagsButton.Text = "Теги: OFF"
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "KBupT ESP",
            Text = "Теги игроков ВЫКЛЮЧЕНЫ",
            Duration = 3
        })
    end

    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("Head") then
            local Nametag = Player.Character.Head:FindFirstChild("Nametag")
            if Nametag then
                Nametag.Enabled = NametagsEnabled
            end
        end
    end
end

-- Функция переключения подсветки
local function ToggleHighlight()
    HighlightEnabled = not HighlightEnabled -- Меняем состояние переключателя
    
    if HighlightEnabled then
        HighlightButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        HighlightButton.Text = "Подсветка: ON"
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "KBupT ESP",
            Text = "Подсветка игроков ВКЛЮЧЕНА",
            Duration = 3
        })
        
        -- Применяем подсветку ко всем игрокам
        for _, Player in pairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer and Player.Character then
                ApplyHighlight(Player)
            end
        end
    else
        HighlightButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        HighlightButton.Text = "Подсветка: OFF"
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "KBupT ESP",
            Text = "Подсветка игроков ВЫКЛЮЧЕНА",
            Duration = 3
        })
        
        -- Удаляем подсветку у всех игроков
        for _, Player in pairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer and Player.Character then
                for _, v in pairs(Player.Character:GetChildren()) do
                    if v:IsA("Highlight") then
                        v:Destroy()
                    end
                end
            end
        end
    end
end

-- Обработчики кнопок
NametagsButton.MouseButton1Click:Connect(ToggleNametags)
HighlightButton.MouseButton1Click:Connect(ToggleHighlight)
CloseButton.MouseButton1Click:Connect(function()
    ESPGUI:Destroy()
end)

-- Привязываем функцию переключения к клавише "["
UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if not GameProcessed and Input.KeyCode == Enum.KeyCode.LeftBracket then
        ToggleNametags()
    end
end)

-- Применяем ESP и теги ко всем текущим игрокам
for _, Player in pairs(Players:GetPlayers()) do
    CreateNametag(Player)
    ApplyHighlight(Player)
end

-- Применяем ESP и теги к игрокам которые заходят позже
Players.PlayerAdded:Connect(function(Player)
    CreateNametag(Player)
    ApplyHighlight(Player)
end)

-- Уведомление о загрузке
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "KBupT ESP",
    Text = "ESP загружен! Нажми [ для переключения тегов",
    Duration = 5
})

-- 4/3/2025 X:XXPM (Script Updated)
-- 4/4/2025 1:59PM (Edit / Update)
-- 4/4/2025 X:XXPM (Перевод на русский + GUI)
    print("Скрипт 5 активирован")
end)

-- ВСТАВЬ СВОЙ СКРИПТ СЮДА (под кнопкой Скрипт 6):
ScriptButtons1[6].MouseButton1Click:Connect(function()
    --[[ 
    Source script taken from: https://github.com/Roblox/creator-docs/blob/main/content/en-us/characters/emotes.md

    scriptblox: https://scriptblox.com/script/Universal-Script-7yd7-I-Emote-Script-48024
]]


if _G.EmotesGUIRunning then
    getgenv().Notify({
        Title = 'KBupTEmotes | Emote',
        Content = '⚠️ It works It actually works',
        Duration = 5
    })
    return
end
_G.EmotesGUIRunning = true

loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Menu-7yd7/refs/heads/Script/GUIS/Off-site/Notify.lua"))()

getgenv().Notify({
    Title = 'KBupTEmotes | Emote',
    Content = '⚠️ Загрузка скрипта...',
    Duration = 5
})

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local emoteClickConnections = {}
local isMonitoringClicks = false
local currentTimer = nil

local currentMode = "emote"
local animationsData = {}
local originalAnimationsData = {}
local filteredAnimations = {}
local favoriteAnimations = {}
local favoriteAnimationsFileName = "FavoriteAnimations.json"

getgenv().lastPlayedAnimation = getgenv().lastPlayedAnimation or nil
getgenv().autoReloadEnabled = getgenv().autoReloadEnabled or false

RunService.Heartbeat:Connect(function()
    if player.Character and player.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
        local errorMsg = CoreGui.RobloxGui.EmotesMenu.Children.ErrorMessage
        if errorMsg.Visible then
            errorMsg.ErrorText.Text = "Only r15 does not work r6"
        end
    end
end)

function ErrorMessage(text, duration)

    if currentTimer then
        task.cancel(currentTimer)
        currentTimer = nil
    end
    
    local errorMessage = CoreGui.RobloxGui.EmotesMenu.Children.ErrorMessage
    local errorText = errorMessage.ErrorText
    
    errorText.Text = text
    
    errorMessage.Visible = true
    
    currentTimer = task.delay(duration, function()
        errorMessage.Visible = false
        currentTimer = nil
    end)
end

local function stopEmotes()
    for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
        track:Stop()
    end
end

local emotesData = {}
local currentPage = 1
local itemsPerPage = 8
local totalPages = 1
local filteredEmotes = {}
local isLoading = false
local originalEmotesData = {}
local totalEmotesLoaded = 0
local scannedEmotes = {}
local favoriteEmotes = {}
local favoriteEnabled = false
local favoriteFileName = "FavoriteEmotes.json"
local emotesWalkEnabled = false
local currentEmoteTrack = nil
local currentCharacter = nil
local isGUICreated = false
local speedEmoteEnabled = false
local speedEmoteConfigFile = "SpeedEmoteConfig.json"

local Under, UIListLayout, _1left, _9right, _4pages, _3TextLabel, _2Routenumber, Top, EmoteWalkButton, UICorner1,
    UIListLayout_2, UICorner, Search, Favorite, UICorner2, UICorner_2, SpeedEmote, UICorner_4, SpeedBox, UICorner_5, Changepage,
    Reload, UICorner_6

local defaultButtonImage = "rbxassetid://71408678974152"
local enabledButtonImage = "rbxassetid://106798555684020"

local favoriteIconId = "rbxassetid://97307461910825" 
local notFavoriteIconId = "rbxassetid://124025954365505"

local function getCharacterAndHumanoid()
    local character = player.Character
    if not character then
        return nil, nil
    end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then
        return nil, nil
    end
    return character, humanoid
end

local function checkEmotesMenuExists()
    local coreGui = game:GetService("CoreGui")
    local robloxGui = coreGui:FindFirstChild("RobloxGui")
    if not robloxGui then
        return false
    end

    local emotesMenu = robloxGui:FindFirstChild("EmotesMenu")
    if not emotesMenu then
        return false
    end

    local children = emotesMenu:FindFirstChild("Children")
    if not children then
        return false
    end

    local main = children:FindFirstChild("Main")
    if not main then
        return false
    end

    local emotesWheel = main:FindFirstChild("EmotesWheel")
    if not emotesWheel then
        return false
    end

    return true, emotesWheel
end

local function getBackgroundOverlay()
    local success, result = pcall(function()
        return game:GetService("CoreGui").RobloxGui.EmotesMenu.Children.Main.EmotesWheel.Back.Background
                   .BackgroundCircleOverlay
    end)
    if success then
        return result
    end
    return nil
end

local function updateGUIColors()
    local backgroundOverlay = getBackgroundOverlay()
    if not backgroundOverlay then
        return
    end

    local bgColor = backgroundOverlay.BackgroundColor3
    local bgTransparency = backgroundOverlay.BackgroundTransparency

    if _1left then
        _1left.ImageColor3 = bgColor
        _1left.ImageTransparency = bgTransparency
    end

    if _9right then
        _9right.ImageColor3 = bgColor
        _9right.ImageTransparency = bgTransparency
    end

    if _4pages then
        _4pages.TextColor3 = bgColor
        _4pages.TextTransparency = bgTransparency
    end

    if _3TextLabel then
        _3TextLabel.TextColor3 = bgColor
        _3TextLabel.TextTransparency = bgTransparency
    end

    if _2Routenumber then
        _2Routenumber.TextColor3 = bgColor
        _2Routenumber.TextTransparency = bgTransparency
    end

    if Top then
        Top.BackgroundColor3 = bgColor
        Top.BackgroundTransparency = bgTransparency
    end

    if EmoteWalkButton then
        EmoteWalkButton.BackgroundColor3 = bgColor
        EmoteWalkButton.BackgroundTransparency = bgTransparency
    end

    if SpeedEmote then
        SpeedEmote.BackgroundColor3 = bgColor
        SpeedEmote.BackgroundTransparency = bgTransparency
    end

     if Changepage then
        Changepage.BackgroundColor3 = bgColor
        Changepage.BackgroundTransparency = bgTransparency
    end

    if SpeedBox then
        SpeedBox.BackgroundColor3 = bgColor
        SpeedBox.BackgroundTransparency = bgTransparency
    end

    if Favorite then
        Favorite.BackgroundColor3 = bgColor
        Favorite.BackgroundTransparency = bgTransparency
    end

if Reload then
    Reload.BackgroundColor3 = bgColor
    Reload.BackgroundTransparency = bgTransparency
    Reload.Visible = (currentMode == "animation")
end
end

local function urlToId(animationId)
    animationId = string.gsub(animationId, "http://www%.roblox%.com/asset/%?id=", "")
    animationId = string.gsub(animationId, "rbxassetid://", "")
    return animationId
end

local function saveFavorites()
    if writefile then
        local jsonData = HttpService:JSONEncode(favoriteEmotes)
        writefile(favoriteFileName, jsonData)
    end
end

local function loadFavorites()
    if readfile and isfile and isfile(favoriteFileName) then
        local success, result = pcall(function()
            local fileContent = readfile(favoriteFileName)
            return HttpService:JSONDecode(fileContent)
        end)
        if success and result then
            favoriteEmotes = result
        end
    end
end

local function loadFavoritesAnimations()
    if readfile and isfile and isfile(favoriteAnimationsFileName) then
        local success, result = pcall(function()
            local fileContent = readfile(favoriteAnimationsFileName)
            return HttpService:JSONDecode(fileContent)
        end)
        if success and result then
            favoriteAnimations = result
        end
    end
end

local function loadSpeedEmoteConfig()
    if readfile and isfile and isfile(speedEmoteConfigFile) then
        local success, result = pcall(function()
            local fileContent = readfile(speedEmoteConfigFile)
            return HttpService:JSONDecode(fileContent)
        end)
        if success and result then
            speedEmoteEnabled = result.Enabled or false
            if SpeedBox then
                SpeedBox.Text = tostring(result.SpeedValue or 1)
                SpeedBox.Visible = speedEmoteEnabled
            end
        end
    end
end

local function extractAssetId(imageUrl)
    local assetId = string.match(imageUrl, "Asset&id=(%d+)")
    return assetId
end

local function getEmoteName(assetId)
    local success, productInfo = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(tonumber(assetId))
    end)
    
    if success and productInfo then
        return productInfo.Name
    else
        return "Emote_" .. tostring(assetId)
    end
end

local function isInFavorites(emoteId)
    for _, favorite in pairs(favoriteEmotes) do
        if favorite.id == tostring(emoteId) then
            return true
        end
    end
    return false
end

local function updateAnimationImages(currentPageAnimations)
    local success, frontFrame = pcall(function()
        return game:GetService("CoreGui").RobloxGui.EmotesMenu.Children.Main.EmotesWheel.Front.EmotesButtons
    end)
    
    if not success or not frontFrame then
        return
    end
    
    local buttonIndex = 1
    for _, child in pairs(frontFrame:GetChildren()) do
        if child:IsA("ImageLabel") and buttonIndex <= #currentPageAnimations then
            local animationData = currentPageAnimations[buttonIndex]
            child.Image = "rbxthumb://type=BundleThumbnail&id=" .. animationData.id .. "&w=420&h=420"
            buttonIndex = buttonIndex + 1
        elseif child:IsA("ImageLabel") then
            child.Image = ""
        end
    end
end

local function updateAnimations()
    local character, humanoid = getCharacterAndHumanoid()
    if not character or not humanoid then
        return
    end

    local humanoidDescription = humanoid.HumanoidDescription
    if not humanoidDescription then
        return
    end

    local currentPageAnimations = {}
    local animationTable = {}
    local equippedAnimations = {}

    local favoritesToUse = _G.filteredFavoritesAnimationsForDisplay or favoriteAnimations
    local hasFavorites = #favoritesToUse > 0
    local favoritePagesCount = hasFavorites and math.ceil(#favoritesToUse / itemsPerPage) or 0
    local isInFavoritesPages = currentPage <= favoritePagesCount

    if isInFavoritesPages and hasFavorites then
        local startIndex = (currentPage - 1) * itemsPerPage + 1
        local endIndex = math.min(startIndex + itemsPerPage - 1, #favoritesToUse)

        for i = startIndex, endIndex do
            if favoritesToUse[i] then
                table.insert(currentPageAnimations, {
                    id = tonumber(favoritesToUse[i].id),
                    name = favoritesToUse[i].name
                })
            end
        end
    else
        local normalAnimations = {}
        for _, animation in pairs(filteredAnimations) do
            if not isInFavorites(animation.id) then
                table.insert(normalAnimations, animation)
            end
        end

        local adjustedPage = currentPage - favoritePagesCount
        local startIndex = (adjustedPage - 1) * itemsPerPage + 1
        local endIndex = math.min(startIndex + itemsPerPage - 1, #normalAnimations)

        for i = startIndex, endIndex do
            if normalAnimations[i] then
                table.insert(currentPageAnimations, normalAnimations[i])
            end
        end
    end

    for _, animation in pairs(currentPageAnimations) do
        local animationName = animation.name
        local animationId = animation.id
        animationTable[animationName] = {animationId}
        table.insert(equippedAnimations, animationName)
    end

    humanoidDescription:SetEmotes(animationTable)
    humanoidDescription:SetEquippedEmotes(equippedAnimations)
    
    task.wait(0.1)
    updateAnimationImages(currentPageAnimations)
end

local function updateEmotes()
    local character, humanoid = getCharacterAndHumanoid()
    if not character or not humanoid then
        return
    end

    if currentMode == "animation" then
        updateAnimations()
        return
    end

    local humanoidDescription = humanoid.HumanoidDescription
    if not humanoidDescription then
        return
    end

    local currentPageEmotes = {}
    local emoteTable = {}
    local equippedEmotes = {}

    local favoritesToUse = _G.filteredFavoritesForDisplay or favoriteEmotes
    local hasFavorites = #favoritesToUse > 0
    local favoritePagesCount = hasFavorites and math.ceil(#favoritesToUse / itemsPerPage) or 0
    local isInFavoritesPages = currentPage <= favoritePagesCount

    if isInFavoritesPages and hasFavorites then
        local startIndex = (currentPage - 1) * itemsPerPage + 1
        local endIndex = math.min(startIndex + itemsPerPage - 1, #favoritesToUse)

        for i = startIndex, endIndex do
            if favoritesToUse[i] then
                table.insert(currentPageEmotes, {
                    id = tonumber(favoritesToUse[i].id),
                    name = favoritesToUse[i].name
                })
            end
        end
    else
        local normalEmotes = {}
        for _, emote in pairs(filteredEmotes) do
            if not isInFavorites(emote.id) then
                table.insert(normalEmotes, emote)
            end
        end

        local adjustedPage = currentPage - favoritePagesCount
        local startIndex = (adjustedPage - 1) * itemsPerPage + 1
        local endIndex = math.min(startIndex + itemsPerPage - 1, #normalEmotes)

        for i = startIndex, endIndex do
            if normalEmotes[i] then
                table.insert(currentPageEmotes, normalEmotes[i])
            end
        end
    end

    for _, emote in pairs(currentPageEmotes) do
        local emoteName = emote.name
        local emoteId = emote.id
        emoteTable[emoteName] = {emoteId}
        table.insert(equippedEmotes, emoteName)
    end

    humanoidDescription:SetEmotes(emoteTable)
    humanoidDescription:SetEquippedEmotes(equippedEmotes)
end

local function calculateTotalPages()
      if currentMode == "animation" then
        local favoritesToUse = _G.filteredFavoritesAnimationsForDisplay or favoriteAnimations
        local hasFavorites = #favoritesToUse > 0
        local normalAnimationsCount = 0

        for _, animation in pairs(filteredAnimations) do
            if not isInFavorites(animation.id) then
                normalAnimationsCount = normalAnimationsCount + 1
            end
        end

        local pages = 0
        if hasFavorites then
            pages = pages + math.ceil(#favoritesToUse / itemsPerPage)
        end
        if normalAnimationsCount > 0 then
            pages = pages + math.ceil(normalAnimationsCount / itemsPerPage)
        end
        return math.max(pages, 1)
    end
    
    local favoritesToUse = _G.filteredFavoritesForDisplay or favoriteEmotes
    local hasFavorites = #favoritesToUse > 0
    local normalEmotesCount = 0

    for _, emote in pairs(filteredEmotes) do
        if not isInFavorites(emote.id) then
            normalEmotesCount = normalEmotesCount + 1
        end
    end

    local pages = 0

    if hasFavorites then
        pages = pages + math.ceil(#favoritesToUse / itemsPerPage)
    end

    if normalEmotesCount > 0 then
        pages = pages + math.ceil(normalEmotesCount / itemsPerPage)
    end

    return math.max(pages, 1)
end

local function isGivenAnimation(animationHolder, animationId)
    for _, animation in animationHolder:GetChildren() do
        if animation:IsA("Animation") and urlToId(animation.AnimationId) == animationId then
            return true
        end
    end
    return false
end

local function isDancing(character, animationTrack)
    local animationId = urlToId(animationTrack.Animation.AnimationId)
    for _, animationHolder in character.Animate:GetChildren() do
        if animationHolder:IsA("StringValue") then
            local sharesAnimationId = isGivenAnimation(animationHolder, animationId)
            if sharesAnimationId then
                return false
            end
        end
    end
    return true
end

local function createGUIElements()
    local exists, emotesWheel = checkEmotesMenuExists()
    if not exists then
        return false
    end

    if emotesWheel:FindFirstChild("Under") then
        emotesWheel.Under:Destroy()
    end
    if emotesWheel:FindFirstChild("Top") then
        emotesWheel.Top:Destroy()
    end
    if emotesWheel:FindFirstChild("EmoteWalkButton") then
        emotesWheel.EmoteWalkButton:Destroy()
    end
    if emotesWheel:FindFirstChild("Favorite") then
        emotesWheel.Favorite:Destroy()
    end
    if emotesWheel:FindFirstChild("SpeedEmote") then
        emotesWheel.SpeedEmote:Destroy()
    end
    if emotesWheel:FindFirstChild("Changepage") then
        emotesWheel.Changepage:Destroy()
    end
    if emotesWheel:FindFirstChild("SpeedBox") then
        emotesWheel.SpeedBox:Destroy()
    end
    if emotesWheel:FindFirstChild("Reload") then
        emotesWheel.Reload:Destroy()
    end

    Under = Instance.new("Frame")
    UIListLayout = Instance.new("UIListLayout")
    _1left = Instance.new("ImageButton")
    _9right = Instance.new("ImageButton")
    _4pages = Instance.new("TextLabel")
    _3TextLabel = Instance.new("TextLabel")
    _2Routenumber = Instance.new("TextBox")
    EmoteWalkButton = Instance.new("ImageButton")
    UICorner1 = Instance.new("UICorner")
    Top = Instance.new("Frame")
    UIListLayout_2 = Instance.new("UIListLayout")
    UICorner = Instance.new("UICorner")
    Search = Instance.new("TextBox")
    Favorite = Instance.new("ImageButton")
    UICorner2 = Instance.new("UICorner")
    SpeedBox = Instance.new("TextBox")
    UICorner_4 = Instance.new("UICorner")
    SpeedEmote = Instance.new("ImageButton")
    UICorner_2 = Instance.new("UICorner")
    Changepage = Instance.new("ImageButton")
     UICorner_5 = Instance.new("UICorner")
     Reload = Instance.new("ImageButton")
     UICorner_6 = Instance.new("UICorner")

    Under.Name = "Under"
    Under.Parent = emotesWheel
    Under.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Under.BackgroundTransparency = 1.000
    Under.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Under.BorderSizePixel = 0
    Under.Position = UDim2.new(0.129999995, 0, 1, 0)
    Under.Size = UDim2.new(0.737500012, 0, 0.132499993, 0)

    UIListLayout.Parent = Under
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    _1left.Name = "1left"
    _1left.Parent = Under
    _1left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _1left.BackgroundTransparency = 1.000
    _1left.BorderColor3 = Color3.fromRGB(0, 0, 0)
    _1left.BorderSizePixel = 0
    _1left.Position = UDim2.new(0.0289389063, 0, -0.0849056691, 0)
    _1left.Rotation = 7456.000
    _1left.Size = UDim2.new(0.169491529, 0, 0.94339627, 0)
    _1left.Image = "rbxassetid://93111945058621"
    _1left.ImageColor3 = Color3.fromRGB(0, 0, 0)
    _1left.ImageTransparency = 0.400

    _9right.Name = "9right"
    _9right.Parent = Under
    _9right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _9right.BackgroundTransparency = 1.000
    _9right.BorderColor3 = Color3.fromRGB(0, 0, 0)
    _9right.BorderSizePixel = 0
    _9right.Position = UDim2.new(0.0289389063, 0, -0.0849056691, 0)
    _9right.Rotation = 7456.000
    _9right.Size = UDim2.new(0.169491529, 0, 0.94339627, 0)
    _9right.Image = "rbxassetid://107938916240738"
    _9right.ImageColor3 = Color3.fromRGB(0, 0, 0)
    _9right.ImageTransparency = 0.400

    _4pages.Name = "4pages"
    _4pages.Parent = Under
    _4pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _4pages.BackgroundTransparency = 1.000
    _4pages.BorderColor3 = Color3.fromRGB(0, 0, 0)
    _4pages.BorderSizePixel = 0
    _4pages.Position = UDim2.new(0.630225062, 0, 0.188679263, 0)
    _4pages.Size = UDim2.new(0.159322038, 0, 0.811320841, 0)
    _4pages.Font = Enum.Font.SourceSansBold
    _4pages.Text = "1"
    _4pages.TextColor3 = Color3.fromRGB(0, 0, 0)
    _4pages.TextScaled = true
    _4pages.TextSize = 14.000
    _4pages.TextTransparency = 0.400
    _4pages.TextWrapped = true

    _3TextLabel.Name = "3TextLabel"
    _3TextLabel.Parent = Under
    _3TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _3TextLabel.BackgroundTransparency = 1.000
    _3TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    _3TextLabel.BorderSizePixel = 0
    _3TextLabel.Position = UDim2.new(0.363344043, 0, 0.0283018891, 0)
    _3TextLabel.Size = UDim2.new(0.338983059, 0, 0.94339627, 0)
    _3TextLabel.Font = Enum.Font.SourceSansBold
    _3TextLabel.Text = " ------ "
    _3TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    _3TextLabel.TextScaled = true
    _3TextLabel.TextSize = 14.000
    _3TextLabel.TextTransparency = 0.400
    _3TextLabel.TextWrapped = true

    _2Routenumber.Name = "2Route-number"
    _2Routenumber.Parent = Under
    _2Routenumber.Active = true
    _2Routenumber.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _2Routenumber.BackgroundTransparency = 1.000
    _2Routenumber.BorderColor3 = Color3.fromRGB(0, 0, 0)
    _2Routenumber.BorderSizePixel = 0
    _2Routenumber.Position = UDim2.new(0.138263673, 0, 0.0283018891, 0)
    _2Routenumber.Selectable = true
    _2Routenumber.Size = UDim2.new(0.159322038, 0, 0.811320841, 0)
    _2Routenumber.Font = Enum.Font.SourceSansBold
    _2Routenumber.PlaceholderColor3 = Color3.fromRGB(0, 0, 0)
    _2Routenumber.Text = "1"
    _2Routenumber.TextColor3 = Color3.fromRGB(0, 0, 0)
    _2Routenumber.TextScaled = true
    _2Routenumber.TextSize = 14.000
    _2Routenumber.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    _2Routenumber.TextTransparency = 0.400
    _2Routenumber.TextWrapped = true

    Top.Name = "Top"
    Top.Parent = emotesWheel
    Top.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Top.BackgroundTransparency = 0.400
    Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Top.BorderSizePixel = 0
    Top.Position = UDim2.new(0.127499998, 0, -0.109999999, 0)
    Top.Size = UDim2.new(0.737500012, 0, 0.0949999914, 0)

    UIListLayout_2.Parent = Top
    UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center

    UICorner.CornerRadius = UDim.new(0, 20)
    UICorner.Parent = Top

    Search.Name = "Search"
    Search.Parent = Top
    Search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Search.BackgroundTransparency = 1.000
    Search.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Search.Position = UDim2.new(0.0677966103, 0, 0)
    Search.Size = UDim2.new(0.864406765, 0, 0.81578958, 0)
    Search.Font = Enum.Font.SourceSansBold
    Search.PlaceholderText = "Search/ID"
    Search.Text = ""
    Search.TextColor3 = Color3.fromRGB(255, 255, 255)
    Search.TextScaled = true
    Search.TextSize = 14.000
    Search.TextWrapped = true

    EmoteWalkButton.Name = "EmoteWalkButton"
    EmoteWalkButton.Parent = emotesWheel
    EmoteWalkButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    EmoteWalkButton.BackgroundTransparency = 0.400
    EmoteWalkButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    EmoteWalkButton.BorderSizePixel = 0
    EmoteWalkButton.Position = UDim2.new(0.889999986, 0, -0.107500002, 0)
    EmoteWalkButton.Size = UDim2.new(0.0874999985, 0, 0.0874999985, 0)
    EmoteWalkButton.Image = defaultButtonImage

    UICorner1.CornerRadius = UDim.new(0, 10)
    UICorner1.Parent = EmoteWalkButton

    Favorite.Name = "Favorite"
    Favorite.Parent = emotesWheel
    Favorite.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Favorite.BackgroundTransparency = 0.400
    Favorite.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Favorite.BorderSizePixel = 0
    Favorite.Position = UDim2.new(0.0189999994, 0, -0.108000003, 0)
    Favorite.Size = UDim2.new(0.0874999985, 0, 0.0874999985, 0)
    Favorite.Image = "rbxassetid://124025954365505"

    UICorner2.CornerRadius = UDim.new(0, 10)
    UICorner2.Parent = Favorite

    SpeedBox.Name = "SpeedBox"
    SpeedBox.Parent = emotesWheel
    SpeedBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    SpeedBox.BackgroundTransparency = 0.400
    SpeedBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SpeedBox.BorderSizePixel = 0
    SpeedBox.Position = UDim2.new(0.0189999398, 0, -0.000499992399, 0)
    SpeedBox.Size = UDim2.new(0.0874999985, 0, 0.0874999985, 0)
    SpeedBox.Visible = false
    SpeedBox.Font = Enum.Font.SourceSansBold
    SpeedBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
    SpeedBox.Text = "1"
    SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedBox.TextScaled = true
    SpeedBox.TextWrapped = true
    SpeedBox:GetPropertyChangedSignal("Text"):Connect(function()
       SpeedBox.Text = SpeedBox.Text:gsub("[^%d.]", "")
    end)
    SpeedBox.ZIndex = 2

    UICorner_4.CornerRadius = UDim.new(0, 10)
    UICorner_4.Parent = SpeedBox

    SpeedEmote.Name = "SpeedEmote"
    SpeedEmote.Parent = emotesWheel
    SpeedEmote.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    SpeedEmote.BackgroundTransparency = 0.400
    SpeedEmote.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SpeedEmote.BorderSizePixel = 0
    SpeedEmote.Position = UDim2.new(0.888999999, 0, -0, 0)
    SpeedEmote.Size = UDim2.new(0.0874999985, 0, 0.0874999985, 0)
    SpeedEmote.Image = "rbxassetid://116056570415896"
    SpeedEmote.ZIndex = 2

    UICorner_2.CornerRadius = UDim.new(0, 10)
    UICorner_2.Parent = SpeedEmote

Changepage.Name = "Changepage"
Changepage.Parent = emotesWheel
Changepage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Changepage.BackgroundTransparency = 0.400
Changepage.BorderColor3 = Color3.fromRGB(0, 0, 0)
Changepage.BorderSizePixel = 0
Changepage.Position = UDim2.new(0.019, 0,1.021, 0)
Changepage.Size = UDim2.new(0.087, 0,0.087, 0)
Changepage.ZIndex = 3
Changepage.Image = "rbxassetid://13285615740"

UICorner_5.CornerRadius = UDim.new(0, 10)
UICorner_5.Parent = Changepage

Reload.Name = "Reload"
Reload.Parent = emotesWheel
Reload.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Reload.BackgroundTransparency = 0.400
Reload.BorderColor3 = Color3.fromRGB(0, 0, 0)
Reload.BorderSizePixel = 0
Reload.Position = UDim2.new(0.888999999, 0, 1.02100003, 0)
Reload.Size = UDim2.new(0.0869999975, 0, 0.0869999975, 0)
Reload.ZIndex = 3
Reload.Image = "rbxassetid://127493377027615"

UICorner_6.CornerRadius = UDim.new(0, 10)
UICorner_6.Parent = Reload

    loadSpeedEmoteConfig()

    connectEvents()
    isGUICreated = true
    updateGUIColors()
    return true
end

local function updatePageDisplay()
    if _4pages and _2Routenumber then
        _4pages.Text = tostring(totalPages)
        _2Routenumber.Text = tostring(currentPage)
    end
end

local function updateFavoriteIcon(imageLabel, assetId, isFavorite)
    local favoriteIcon = imageLabel:FindFirstChild("FavoriteIcon")
    
    if not favoriteIcon then
        favoriteIcon = Instance.new("ImageLabel")
        favoriteIcon.Name = "FavoriteIcon"
        favoriteIcon.Size = UDim2.new(0.3, 0, 0.3, 0) 
        favoriteIcon.Position = UDim2.new(0.7, 0, 0, 0)
        favoriteIcon.AnchorPoint = Vector2.new(0, 0)
        favoriteIcon.BackgroundTransparency = 1
        favoriteIcon.ZIndex = imageLabel.ZIndex + 5
        favoriteIcon.ScaleType = Enum.ScaleType.Fit
        favoriteIcon.Parent = imageLabel
    end
    
    if isFavorite then
        favoriteIcon.Image = favoriteIconId
    else
        favoriteIcon.Image = notFavoriteIconId 
    end
end

local function updateAllFavoriteIcons()
    local success, frontFrame = pcall(function()
        return game:GetService("CoreGui").RobloxGui.EmotesMenu.Children.Main.EmotesWheel.Front.EmotesButtons
    end)
    
    if success and frontFrame then
        for _, child in pairs(frontFrame:GetChildren()) do
            if child:IsA("ImageLabel") and child.Image ~= "" then
                local imageUrl = child.Image
                local assetId = extractAssetId(imageUrl)
                
                if assetId then
                    local isFavorite = isInFavorites(assetId)
                    updateFavoriteIcon(child, assetId, isFavorite)
                end
            end
        end
    end
end


local function toggleFavorite(emoteId, emoteName)
    local found = false
    local index = 0

    for i, fav in pairs(favoriteEmotes) do
        if fav.id == emoteId then
            found = true
            index = i
            break
        end
    end

    if found then
        table.remove(favoriteEmotes, index)
        getgenv().Notify({
            Title = 'KBupTEmotes | Favorite System',
            Content = '🗑️ Removed "' .. emoteName .. '" from favorites',
            Duration = 3
        })
    else
        table.insert(favoriteEmotes, {
            id = emoteId,
            name = emoteName .. " - ⭐"
        })
        getgenv().Notify({
            Title = 'KBupTEmotes | Favorite System',
            Content = '✅ Added "' .. emoteName .. '" to favorites',
            Duration = 3
        })
    end

    saveFavorites()
    totalPages = calculateTotalPages()
    updatePageDisplay()
    updateEmotes()
    
    updateAllFavoriteIcons()
end

local function setupEmoteClickDetection()
    if isMonitoringClicks then
        return
    end
   
    local function monitorEmotes()
        while favoriteEnabled do
            local success, frontFrame = pcall(function()
                return game:GetService("CoreGui").RobloxGui.EmotesMenu.Children.Main.EmotesWheel.Front.EmotesButtons
            end)
           
            if success and frontFrame then
                for _, connection in pairs(emoteClickConnections) do
                    if connection then
                        connection:Disconnect()
                    end
                end
                emoteClickConnections = {}
               
                for _, child in pairs(frontFrame:GetChildren()) do
                    if child:IsA("ImageLabel") and child.Image ~= "" then
                        local clickDetector = child:FindFirstChild("ClickDetector") or Instance.new("TextButton")
                        clickDetector.Name = "ClickDetector"
                        clickDetector.Size = UDim2.new(1, 0, 1, 0)
                        clickDetector.Position = UDim2.new(0, 0, 0, 0)
                        clickDetector.BackgroundTransparency = 1
                        clickDetector.Text = ""
                        clickDetector.ZIndex = child.ZIndex + 1
                        clickDetector.Parent = child
                        
                        local imageUrl = child.Image
                        local assetId = extractAssetId(imageUrl)
                        if assetId then
                            local isFavorite = isInFavorites(assetId)
                            updateFavoriteIcon(child, assetId, isFavorite)
                        end
                       
                        local connection = clickDetector.MouseButton1Click:Connect(function()
                            if favoriteEnabled then
                                if assetId then
                                    local emoteName = getEmoteName(assetId)
                                    toggleFavorite(assetId, emoteName)
                                end
                            end
                        end)
                       
                        table.insert(emoteClickConnections, connection)
                    end
                end
            end
           
            task.wait(0.1)
        end
       
        for _, connection in pairs(emoteClickConnections) do
            if connection then
                connection:Disconnect()
            end
        end
        emoteClickConnections = {}
        isMonitoringClicks = false
    end
   
    if favoriteEnabled then
        isMonitoringClicks = true
        task.spawn(monitorEmotes)
    end
end

local function applyAnimation(animationData)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChild("Humanoid")
    local animate = character:FindFirstChild("Animate")
    
    if not animate or not humanoid then
        getgenv().Notify({
            Title = 'KBupTEmotes | Animation Error',
            Content = '❌ Animate or Humanoid not found',
            Duration = 3
        })
        return
    end
    
    local bundleId = animationData.id
    local bundledItems = animationData.bundledItems

    getgenv().lastPlayedAnimation = animationData
    
    if not bundledItems then
        getgenv().Notify({
            Title = 'KBupTEmotes | Animation Error', 
            Content = '❌ No bundled items found',
            Duration = 3
        })
        return
    end
    
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        track:Stop()
    end
    
    for key, assetIds in pairs(bundledItems) do
        for _, assetId in pairs(assetIds) do
            spawn(function()
                local success, objects = pcall(function()
                    return game:GetObjects("rbxassetid://" .. assetId)
                end)
                
                if success and objects then
                    local function searchForAnimations(parent, parentPath)
                        for _, child in pairs(parent:GetChildren()) do
                            if child:IsA("Animation") then
                                local animationPath = parentPath .. "." .. child.Name
                                local pathParts = animationPath:split(".")
                                
                                if #pathParts >= 2 then
                                    local animateCategory = pathParts[#pathParts - 1]
                                    local animationName = pathParts[#pathParts]
                                    
                                    if animate:FindFirstChild(animateCategory) then
                                        local categoryFolder = animate[animateCategory]
                                        if categoryFolder:FindFirstChild(animationName) then
                                            categoryFolder[animationName].AnimationId = child.AnimationId
                                            
                                            task.wait(0.1)
                                            local animation = Instance.new("Animation")
                                            animation.AnimationId = child.AnimationId
                                            
                                            local animTrack = humanoid.Animator:LoadAnimation(animation)
                                            animTrack.Priority = Enum.AnimationPriority.Action
                                            animTrack:Play()
                                            
                                            task.wait(0.1)
                                            animTrack:Stop()
                                        end
                                    end
                                end
                            elseif #child:GetChildren() > 0 then
                                searchForAnimations(child, parentPath .. "." .. child.Name)
                            end
                        end
                    end
                    
                    for _, obj in pairs(objects) do
                        searchForAnimations(obj, obj.Name)
                        obj.Parent = workspace
                        task.delay(1, function()
                            if obj then obj:Destroy() end
                        end)
                    end
                end
            end)
        end
    end
    
    task.wait(.2)
    spawn(function()
        local humanoidDescription = humanoid:FindFirstChild("HumanoidDescription")
        if humanoidDescription then
            humanoid:ApplyDescription(humanoidDescription)
        end
    end)
end


local function monitorAnimations()
    while currentMode == "animation" do
        local success, frontFrame = pcall(function()
            return game:GetService("CoreGui").RobloxGui.EmotesMenu.Children.Main.EmotesWheel.Front.EmotesButtons
        end)
        
        if success and frontFrame then
            for _, connection in pairs(emoteClickConnections) do
                if connection then
                    connection:Disconnect()
                end
            end
            emoteClickConnections = {}
            
            local favoritesToUse = _G.filteredFavoritesAnimationsForDisplay or favoriteAnimations
            local hasFavorites = #favoritesToUse > 0
            local favoritePagesCount = hasFavorites and math.ceil(#favoritesToUse / itemsPerPage) or 0
            local isInFavoritesPages = currentPage <= favoritePagesCount
            
            local currentPageAnimations = {}
            
            if isInFavoritesPages and hasFavorites then
                local startIndex = (currentPage - 1) * itemsPerPage + 1
                local endIndex = math.min(startIndex + itemsPerPage - 1, #favoritesToUse)
                
                for i = startIndex, endIndex do
                    if favoritesToUse[i] then
                        table.insert(currentPageAnimations, favoritesToUse[i])
                    end
                end
            else
                local normalAnimations = {}
                for _, animation in pairs(filteredAnimations) do
                    if not isInFavorites(animation.id) then
                        table.insert(normalAnimations, animation)
                    end
                end
                
                local adjustedPage = currentPage - favoritePagesCount
                local startIndex = (adjustedPage - 1) * itemsPerPage + 1
                local endIndex = math.min(startIndex + itemsPerPage - 1, #normalAnimations)
                
                for i = startIndex, endIndex do
                    if normalAnimations[i] then
                        table.insert(currentPageAnimations, normalAnimations[i])
                    end
                end
            end
            
            local buttonIndex = 1
            for _, child in pairs(frontFrame:GetChildren()) do
                if child:IsA("ImageLabel") and buttonIndex <= #currentPageAnimations then
                    local clickDetector = child:FindFirstChild("ClickDetector") or Instance.new("TextButton")
                    clickDetector.Name = "ClickDetector"
                    clickDetector.Size = UDim2.new(1, 0, 1, 0)
                    clickDetector.Position = UDim2.new(0, 0, 0, 0)
                    clickDetector.BackgroundTransparency = 1
                    clickDetector.Text = ""
                    clickDetector.ZIndex = child.ZIndex + 1
                    clickDetector.Parent = child
                    
                    local animationData = currentPageAnimations[buttonIndex]
                    
                    local connection = clickDetector.MouseButton1Click:Connect(function()
                        applyAnimation(animationData)
                    end)
                    
                    table.insert(emoteClickConnections, connection)
                    buttonIndex = buttonIndex + 1
                end
            end
        end
        
        task.wait(0.1)
    end
end

local function stopEmoteClickDetection()
    isMonitoringClicks = false
    
    for _, connection in pairs(emoteClickConnections) do
        if connection then
            connection:Disconnect()
        end
    end
    emoteClickConnections = {}
    
    local success, frontFrame = pcall(function()
        return game:GetService("CoreGui").RobloxGui.EmotesMenu.Children.Main.EmotesWheel.Front.EmotesButtons
    end)
    
    if success and frontFrame then
        for _, child in pairs(frontFrame:GetChildren()) do
            if child:IsA("ImageLabel") then
                local clickDetector = child:FindFirstChild("ClickDetector")
                if clickDetector then
                    clickDetector:Destroy()
                end
                
                local favoriteIcon = child:FindFirstChild("FavoriteIcon")
                if favoriteIcon then
                    favoriteIcon:Destroy()
                end
            end
        end
    end
end


local function fetchAllEmotes()
    if isLoading then
        return
    end
    isLoading = true
    emotesData = {}
    totalEmotesLoaded = 0

    local success, result = pcall(function()
        local jsonContent = game:HttpGet("https://raw.githubusercontent.com/7yd7/sniper-Emote/refs/heads/test/EmoteSniper.json")
        
        if jsonContent and jsonContent ~= "" then
            local data = HttpService:JSONDecode(jsonContent)
            return data.data or {}
        else
            return nil
        end
    end)

    if success and result then
        for _, item in pairs(result) do
            local emoteData = {
                id = tonumber(item.id),
                name = item.name or ("Emote_" .. (item.id or "Unknown"))
            }
            if emoteData.id and emoteData.id > 0 then
                table.insert(emotesData, emoteData)
                totalEmotesLoaded = totalEmotesLoaded + 1
            end
        end
    else
        emotesData = {
            {id = 3360686498, name = "Stadium"},
            {id = 3360692915, name = "Tilt"},
            {id = 3576968026, name = "Shrug"},
            {id = 3360689775, name = "Salute"}
        }
        totalEmotesLoaded = #emotesData
    end

    originalEmotesData = emotesData
    filteredEmotes = emotesData

    totalPages = calculateTotalPages()
    currentPage = 1
    updatePageDisplay()
    updateEmotes()
    
    getgenv().Notify({
        Title = 'KBupTEmotes | Emote',
        Content = "🎉 Loaded Successfully! Total Emotes: " .. totalEmotesLoaded,
        Duration = 5
    })
    
    isLoading = false
end

local function fetchAllAnimations()
    if isLoading then
        return
    end
    isLoading = true
    animationsData = {}
    
    local success, result = pcall(function()
        local jsonContent = game:HttpGet("https://raw.githubusercontent.com/7yd7/sniper-Emote/refs/heads/test/AnimationSniper.json")
        
        if jsonContent and jsonContent ~= "" then
            local data = HttpService:JSONDecode(jsonContent)
            return data.data or {}
        else
            return nil
        end
    end)

    if success and result then
        for _, item in pairs(result) do
            local animationData = {
                id = tonumber(item.id),
                name = item.name or ("Animation_" .. (item.id or "Unknown")),
                bundledItems = item.bundledItems
            }
            if animationData.id and animationData.id > 0 then
                table.insert(animationsData, animationData)
            end
        end
    end

    originalAnimationsData = animationsData
    filteredAnimations = animationsData
    isLoading = false
end

local function searchEmotes(searchTerm)
    if isLoading then
        getgenv().Notify({
            Title = 'KBupTEmotes | Emote',
            Content = '⚠️ Loading please wait...',
            Duration = 5
        })
        return
    end

    searchTerm = searchTerm:lower()

    if searchTerm == "" then
        filteredEmotes = originalEmotesData
        if _G.originalFavoritesBackup then
            _G.originalFavoritesBackup = nil
        end
        _G.filteredFavoritesForDisplay = nil
    else
        local isIdSearch = searchTerm:match("^%d%d%d%d%d+$")
        
        local newFilteredList = {}
        
        if isIdSearch then
            for _, emote in pairs(originalEmotesData) do
                if tostring(emote.id) == searchTerm then
                    table.insert(newFilteredList, emote)
                end
            end
            
            if #newFilteredList == 0 then
                local emoteId = tonumber(searchTerm)
                if emoteId then
                    local emoteName = getEmoteName(emoteId)
                    local newEmote = {
                        id = emoteId,
                        name = emoteName
                    }
                    
                    table.insert(originalEmotesData, newEmote)
                    table.insert(newFilteredList, newEmote)
                end
            end
        else
            for _, emote in pairs(originalEmotesData) do
                if emote.name:lower():find(searchTerm) then
                    table.insert(newFilteredList, emote)
                end
            end
        end
        
        filteredEmotes = newFilteredList

        if not isIdSearch then
            if not _G.originalFavoritesBackup then
                _G.originalFavoritesBackup = {}
                for i, favorite in pairs(favoriteEmotes) do
                    _G.originalFavoritesBackup[i] = {
                        id = favorite.id,
                        name = favorite.name
                    }
                end
            end

            _G.filteredFavoritesForDisplay = {}
            for _, favorite in pairs(favoriteEmotes) do
                if favorite.name:lower():find(searchTerm) then
                    table.insert(_G.filteredFavoritesForDisplay, favorite)
                end
            end
        end
    end

    totalPages = calculateTotalPages()
    currentPage = 1
    updatePageDisplay()
    updateEmotes()
end

local function goToPage(pageNumber)
    if pageNumber < 1 then
        currentPage = 1
    elseif pageNumber > totalPages then
        currentPage = totalPages
    else
        currentPage = pageNumber
    end
    updatePageDisplay()
    updateEmotes()
end

local function previousPage()
    if currentPage <= 1 then
        currentPage = totalPages
    else
        currentPage = currentPage - 1
    end
    updatePageDisplay()
    updateEmotes()
end

local function nextPage()
    if currentPage >= totalPages then
        currentPage = 1
    else
        currentPage = currentPage + 1
    end
    updatePageDisplay()
    updateEmotes()
end

local function stopCurrentEmote()
    if currentEmoteTrack then
        currentEmoteTrack:Stop()
        currentEmoteTrack = nil
    end
end

local function playEmote(humanoid, emoteId)
    stopCurrentEmote()
    stopEmotes()

    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://" .. emoteId

    local success, animTrack = pcall(function()
        return humanoid.Animator:LoadAnimation(animation)
    end)

    if success and animTrack then
        currentEmoteTrack = animTrack
        currentEmoteTrack.Priority = Enum.AnimationPriority.Action
        currentEmoteTrack.Looped = true
        task.wait(0.1)
        if speedEmoteEnabled or emotesWalkEnabled then
            currentEmoteTrack:Play()

            if speedEmoteEnabled then
                local speedValue = tonumber(SpeedBox.Text) or 1
                currentEmoteTrack:AdjustSpeed(speedValue)
            end
        end
    end
end

local function onCharacterAdded(character)
    currentCharacter = character
    stopCurrentEmote()

    local humanoid = character:WaitForChild("Humanoid")
    local animator = humanoid:WaitForChild("Animator")

 if getgenv().autoReloadEnabled and getgenv().lastPlayedAnimation then
    task.wait(.3)
    applyAnimation(getgenv().lastPlayedAnimation)
    getgenv().Notify({
        Title = 'KBupTEmotes | Auto Reload Animation',
        Content = '🔄 The last animation was automatically \n reapplied',
        Duration = 3
    })
end

    animator.AnimationPlayed:Connect(function(animationTrack)
        if isDancing(character, animationTrack) then
            local playedEmoteId = urlToId(animationTrack.Animation.AnimationId)

            if emotesWalkEnabled then
                if currentEmoteTrack then
                    local currentEmoteId = urlToId(currentEmoteTrack.Animation.AnimationId)
                    if currentEmoteId == playedEmoteId then
                        return
                    else
                        stopCurrentEmote()
                    end
                end

                playEmote(humanoid, playedEmoteId)

                if currentEmoteTrack then
                    currentEmoteTrack.Ended:Connect(function()
                        if currentEmoteTrack == animationTrack then
                            currentEmoteTrack = nil
                        end
                    end)
                end
            end

            if speedEmoteEnabled and not emotesWalkEnabled then
                if currentEmoteTrack then
                    local currentEmoteId = urlToId(currentEmoteTrack.Animation.AnimationId)
                    if currentEmoteId == playedEmoteId then
                        return
                    else
                        stopCurrentEmote()
                    end
                end

                playEmote(humanoid, playedEmoteId)

                if currentEmoteTrack then
                    currentEmoteTrack.Ended:Connect(function()
                        if currentEmoteTrack == animationTrack then
                            currentEmoteTrack = nil
                        end
                    end)
                end
            end
        end
    end)

    humanoid.Died:Connect(function()
    emotesWalkEnabled = false
    speedEmoteEnabled = false
    favoriteEnabled = false
    currentEmoteTrack = nil

    stopEmotes()
        stopCurrentEmote()
    end)
end

local function toggleEmoteWalk()
    emotesWalkEnabled = not emotesWalkEnabled

    if emotesWalkEnabled then
        getgenv().Notify({
            Title = 'KBupTEmotes | Emote Freeze',
            Content = "🔒 Emote freeze ON",
            Duration = 5
        })

        EmoteWalkButton.Image = enabledButtonImage
        task.wait(0.1)
        stopCurrentEmote()
        if currentEmoteTrack and currentEmoteTrack.IsPlaying then
            currentEmoteTrack:AdjustSpeed(1)
        end
    else
        getgenv().Notify({
            Title = 'KBupTEmotes | Emote Freeze',
            Content = '🔓 Emote freeze OFF',
            Duration = 5
        })
        EmoteWalkButton.Image = defaultButtonImage
        task.wait(0.1)
        stopCurrentEmote()

        if currentEmoteTrack and currentEmoteTrack.IsPlaying and speedEmoteEnabled then
            local speedValue = tonumber(SpeedBox.Text) or 1
            currentEmoteTrack:AdjustSpeed(speedValue)
        elseif currentEmoteTrack and currentEmoteTrack.IsPlaying then
            currentEmoteTrack:AdjustSpeed(1)
        end
    end
end
print(Players.LocalPlayer.Name)
local function toggleSpeedEmote()
    speedEmoteEnabled = not speedEmoteEnabled

    SpeedBox.Visible = speedEmoteEnabled

    if speedEmoteEnabled then
        getgenv().Notify({
            Title = 'KBupTEmotes | Speed Emote',
            Content = "⚡ Speed Emote ON",
            Duration = 5
        })
        task.wait(0.1)
        stopCurrentEmote()
    else
        getgenv().Notify({
            Title = 'KBupTEmotes | Speed Emote',
            Content = '⚡ Speed Emote OFF',
            Duration = 5
        })
        task.wait(0.1)
        stopCurrentEmote()
    end

    if writefile then
        writefile(speedEmoteConfigFile, HttpService:JSONEncode({
            Enabled = speedEmoteEnabled,
            SpeedValue = tonumber(SpeedBox.Text) or 1
        }))
    end
end

local function toggleFavoriteMode()
    favoriteEnabled = not favoriteEnabled

    if favoriteEnabled then
        Favorite.Image = "rbxassetid://97307461910825"
        getgenv().Notify({
            Title = 'KBupTEmotes | Favorite System',
            Content = "🔒 Emote Favorite ON",
            Duration = 5
        })

        getgenv().Notify({
            Title = 'KBupTEmotes | Favorite System',
            Content = "⚠️ Click on any emote to add/remove from \n favorites ( Click to image )",
            Duration = 5
        })
        
        setupEmoteClickDetection()
    else
        Favorite.Image = "rbxassetid://124025954365505"
        getgenv().Notify({
            Title = 'KBupTEmotes | Favorite System',
            Content = '🔓 Emote Favorite OFF',
            Duration = 3
        })
        
        stopEmoteClickDetection()
    end
end

local clickCooldown = {}
local CLICK_COOLDOWN_TIME = 0.1

local function safeButtonClick(buttonName, callback)
    local currentTime = tick()
    if not clickCooldown[buttonName] or (currentTime - clickCooldown[buttonName]) > CLICK_COOLDOWN_TIME then
        clickCooldown[buttonName] = currentTime
        callback()
    end
end

local function setupAnimationClickDetection()
    if isMonitoringClicks then
        return
    end
    
    if currentMode == "animation" then
        isMonitoringClicks = true
        task.spawn(monitorAnimations)
    end
end

local function toggleAutoReload()
    getgenv().autoReloadEnabled = not getgenv().autoReloadEnabled
    
    if getgenv().autoReloadEnabled then
        getgenv().Notify({
            Title = 'KBupTEmotes | Auto Reload Animation',
            Content = "🔄 Auto Reload ON",
            Duration = 5
        })
    else
        getgenv().Notify({
            Title = 'KBupTEmotes | Auto Reload Animation',
            Content = '🔄 Auto Reload OFF',
            Duration = 3
        })
    end
end

function connectEvents()
    if _1left then
        _1left.MouseButton1Click:Connect(previousPage)
    end

    if _9right then
        _9right.MouseButton1Click:Connect(nextPage)
    end

      if _2Routenumber then
        _2Routenumber.FocusLost:Connect(function(enterPressed)
            local pageNum = tonumber(_2Routenumber.Text)
            if pageNum then
                goToPage(pageNum)
            else
                _2Routenumber.Text = tostring(currentPage)
            end
        end)
    end

    if Search then
        Search.Changed:Connect(function(property)
            if property == "Text" then
                searchEmotes(Search.Text)
            end
        end)
    end

    if EmoteWalkButton then
        EmoteWalkButton.MouseButton1Click:Connect(function()
            safeButtonClick("EmoteWalk", toggleEmoteWalk)
        end)
    end

    if Favorite then
        Favorite.MouseButton1Click:Connect(function()
            safeButtonClick("Favorite", toggleFavoriteMode)
        end)
    end

    if SpeedEmote then
        SpeedEmote.MouseButton1Click:Connect(function()
            safeButtonClick("SpeedEmote", toggleSpeedEmote)
        end)
    end

    if Reload then
    Reload.MouseButton1Click:Connect(function()
        safeButtonClick("AutoReload", toggleAutoReload)
    end)
end

if Changepage then
    Changepage.MouseButton1Click:Connect(function()
        stopEmoteClickDetection()
        
        if currentMode == "emote" then
            currentMode = "animation"
            
            spawn(function()
                fetchAllAnimations()
                currentPage = 1
                totalPages = calculateTotalPages()
                updatePageDisplay()
                updateEmotes()
                isMonitoringClicks = true
                task.spawn(monitorAnimations)
            end)
            
            getgenv().Notify({
                Title = 'KBupTEmotes | Animation',
                Content = '📄 Changed to Emote > Animation Mode',
                Duration = 3
            })

         getgenv().Notify({
            Title = 'KBupTEmotes | Animation',
            Content = "⚠️ Кликни по эмоцит ( Кликни по картинке )",
            Duration = 5
        })
        else
            currentMode = "emote"
            currentPage = 1
            totalPages = calculateTotalPages()
            updatePageDisplay() 
            updateEmotes()
            
            getgenv().Notify({
                Title = 'KBupTEmotes | Emote', 
                Content = '📄 Поменять анимацию > Режим эмоции',
                Duration = 3
            })
        end
    end)
end

    if SpeedBox then
        SpeedBox.FocusLost:Connect(function()
            if writefile then
                writefile(speedEmoteConfigFile, HttpService:JSONEncode({
                    Enabled = speedEmoteEnabled,
                    SpeedValue = tonumber(SpeedBox.Text) or 1
                }))
            end
        end)
    end
end

local function checkAndRecreateGUI()
    local exists, emotesWheel = checkEmotesMenuExists()
    if not exists then
        isGUICreated = false
        return
    end

    if not emotesWheel:FindFirstChild("Under") or not emotesWheel:FindFirstChild("Top") or
        not emotesWheel:FindFirstChild("EmoteWalkButton") or not emotesWheel:FindFirstChild("Favorite") or
        not emotesWheel:FindFirstChild("SpeedEmote") or not emotesWheel:FindFirstChild("SpeedBox") or
        not emotesWheel:FindFirstChild("Changepage") or not emotesWheel:FindFirstChild("Reload") then
        isGUICreated = false
        if createGUIElements() then
            updatePageDisplay()
            updateEmotes()
            loadSpeedEmoteConfig()
        end
    end
end

if player.Character then
    onCharacterAdded(player.Character)
end

player.CharacterAdded:Connect(function(character)
    onCharacterAdded(character)
    task.wait(0.3) 
    spawn(function()
        while not checkEmotesMenuExists() do
            task.wait(0.1) 
        end
        task.wait(0.3) 
        stopEmotes()
        if createGUIElements() then
            if #emotesData > 0 then
                updatePageDisplay()
                updateEmotes()
                loadSpeedEmoteConfig()
            end
        end
    end)
end)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    emotesWalkEnabled = false
    speedEmoteEnabled = false
    favoriteEnabled = false
    currentEmoteTrack = nil
    stopEmotes()
end)


local heartbeatConnection = RunService.Heartbeat:Connect(function()
    if not isGUICreated then
        checkAndRecreateGUI()
    else
        updateGUIColors()
    end
end)


local function safeFind(path, name)
    if not path then return nil end
    local ok, result = pcall(function()
        return path:FindFirstChild(name)
    end)
    if ok then
        return result
    end
    return nil
end

RunService.Stepped:Connect(function()
    if humanoid and currentEmoteTrack and currentEmoteTrack.IsPlaying then
        if humanoid.MoveDirection.Magnitude > 0 then
            if speedEmoteEnabled and not emotesWalkEnabled then
                currentEmoteTrack:Stop()
                currentEmoteTrack = nil
            end
        end
    end
end)

spawn(function()
    while not checkEmotesMenuExists() do
        wait(0.1)
    end
    if createGUIElements() then
        loadFavorites()
        fetchAllEmotes()
        loadSpeedEmoteConfig()
    end
end)

task.spawn(function()
    local StarterGui = game:GetService("StarterGui")
    local CoreGui = game:GetService("CoreGui")

    while true do
        local robloxGui = CoreGui:FindFirstChild("RobloxGui")
        local emotesMenu = robloxGui and robloxGui:FindFirstChild("EmotesMenu")

        if not emotesMenu then
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, true)

        else
            local exists = emotesMenu:FindFirstChild("Children") and emotesMenu.Children:FindFirstChild("Main") and
                               emotesMenu.Children.Main:FindFirstChild("EmotesWheel")

            if exists then
                local emotesWheel = emotesMenu.Children.Main.EmotesWheel
                if not emotesWheel:FindFirstChild("Under") or not emotesWheel:FindFirstChild("Top") then
                    if createGUIElements then
                        createGUIElements()
                        loadSpeedEmoteConfig()
                    end

                    if updateGUIColors then
                        updateGUIColors()
                        updatePageDisplay()
                        loadFavorites()
                    end
                end
            end
        end

        task.wait(.3)
    end
end)

if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/OpenEmote.lua"))()
    getgenv().Notify({
        Title = 'KBupTEmotes | Emote Mobile',
        Content = '📱 Added emote open button for ease of use',
        Duration = 10
    })
end

if UserInputService.KeyboardEnabled then
    getgenv().Notify({
        Title = 'KBupTEmotes | Эмоция ПК',
        Content = '💻 Открой меню нажав "."',
        Duration = 10
    })
end
    print("Скрипт 6 активирован")
end)

-- ВСТАВЬ СВОЙ СКРИПТ СЮДА (под кнопкой Скрипт 7):
ScriptButtons1[7].MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
local gui = player.PlayerGui

-- GUI для изменения скорости и прыжка
local speedWalkGui = Instance.new("ScreenGui")
speedWalkGui.Parent = gui
speedWalkGui.IgnoreGuiInset = true
speedWalkGui.Enabled = true

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 150)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = speedWalkGui

-- Заголовок
local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "KBupTChanger v1"
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Size = UDim2.new(1, 0, 0, 25)
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
titleLabel.Parent = mainFrame

-- Заголовок скорости
local speedLabel = Instance.new("TextLabel")
speedLabel.Text = "Скорость"
speedLabel.Position = UDim2.new(0, 10, 0, 30)
speedLabel.Size = UDim2.new(0, 80, 0, 20)
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.BackgroundTransparency = 1
speedLabel.Parent = mainFrame

local walkSpeedTextBox = Instance.new("TextBox")
walkSpeedTextBox.Position = UDim2.new(0, 10, 0, 50)
walkSpeedTextBox.Size = UDim2.new(0, 80, 0, 20)
walkSpeedTextBox.BackgroundColor3 = Color3.new(0, 0, 0)
walkSpeedTextBox.TextColor3 = Color3.new(1, 1, 1)
walkSpeedTextBox.Text = "16"
walkSpeedTextBox.Parent = mainFrame

-- Заголовок прыжка
local jumpLabel = Instance.new("TextLabel")
jumpLabel.Text = "Прыжок"
jumpLabel.Position = UDim2.new(0, 120, 0, 30)
jumpLabel.Size = UDim2.new(0, 80, 0, 20)
jumpLabel.TextColor3 = Color3.new(1, 1, 1)
jumpLabel.BackgroundTransparency = 1
jumpLabel.Parent = mainFrame

local jumpPowerTextBox = Instance.new("TextBox")
jumpPowerTextBox.Position = UDim2.new(0, 120, 0, 50)
jumpPowerTextBox.Size = UDim2.new(0, 80, 0, 20)
jumpPowerTextBox.BackgroundColor3 = Color3.new(0, 0, 0)
jumpPowerTextBox.TextColor3 = Color3.new(1, 1, 1)
jumpPowerTextBox.Text = "50"
jumpPowerTextBox.Parent = mainFrame

local applyButton = Instance.new("TextButton")
applyButton.Text = "Применить"
applyButton.Position = UDim2.new(0.5, -80, 0, 80)
applyButton.Size = UDim2.new(0, 160, 0, 20)
applyButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
applyButton.TextColor3 = Color3.new(1, 1, 1)
applyButton.Parent = mainFrame

local resetButton = Instance.new("TextButton")
resetButton.Text = "Сбросить"
resetButton.Position = UDim2.new(0.5, -80, 0, 105)
resetButton.Size = UDim2.new(0, 160, 0, 20)
resetButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
resetButton.TextColor3 = Color3.new(1, 1, 1)
resetButton.Parent = mainFrame

-- Крестик для закрытия
local closeButton = Instance.new("TextButton")
closeButton.Text = "X"
closeButton.Position = UDim2.new(1, -25, 0, 0)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Parent = mainFrame

-- Функция для применения изменений
applyButton.MouseButton1Click:Connect(function()
    local walkSpeed = tonumber(walkSpeedTextBox.Text) or 16
    local jumpPower = tonumber(jumpPowerTextBox.Text) or 50

    local character = player.Character
    if character and character:FindFirstChildOfClass("Humanoid") then
        character:FindFirstChildOfClass("Humanoid").WalkSpeed = walkSpeed
        character:FindFirstChildOfClass("Humanoid").JumpPower = jumpPower
    end
    
    -- Уведомление KBupTChanger
    game:GetService("StarterGui"):SetCore("SendNotification", { 
        Title = "KBupTChanger v1",
        Text = "Скорость и прыжок изменены",
        Duration = 3
    })
end)

-- Функция для сброса
resetButton.MouseButton1Click:Connect(function()
    walkSpeedTextBox.Text = "16"
    jumpPowerTextBox.Text = "50"

    local character = player.Character
    if character and character:FindFirstChildOfClass("Humanoid") then
        character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
        character:FindFirstChildOfClass("Humanoid").JumpPower = 50
    end
    
    -- Уведомление KBupTChanger
    game:GetService("StarterGui"):SetCore("SendNotification", { 
        Title = "KBupTChanger v1",
        Text = "Скорость и прыжок сброшены",
        Duration = 3
    })
end)

-- Функция для закрытия GUI
closeButton.MouseButton1Click:Connect(function()
    speedWalkGui.Enabled = false
end)

-- Автоматическое применение изменений при вводе (уменьшенная задержка)
local function applyChangesWithDelay()
    local walkSpeed = tonumber(walkSpeedTextBox.Text) or 16
    local jumpPower = tonumber(jumpPowerTextBox.Text) or 50

    local character = player.Character
    if character and character:FindFirstChildOfClass("Humanoid") then
        character:FindFirstChildOfClass("Humanoid").WalkSpeed = walkSpeed
        character:FindFirstChildOfClass("Humanoid").JumpPower = jumpPower
    end
end

-- Автоматическое применение при изменении текста (с уменьшенной задержкой)
walkSpeedTextBox:GetPropertyChangedSignal("Text"):Connect(function()
    wait(0.1)
    applyChangesWithDelay()
end)

jumpPowerTextBox:GetPropertyChangedSignal("Text"):Connect(function()
    wait(0.1)
    applyChangesWithDelay()
end)

-- Первоначальное уведомление
game:GetService("StarterGui"):SetCore("SendNotification", { 
    Title = "KBupTChanger v1",
    Text = "Меню активировано",
    Duration = 3
})
    print("Скрипт 7 активирован")
end)

-- ВСТАВЬ СВОЙ СКРИПТ СЮДА (под кнопкой Скрипт 8):
ScriptButtons1[8].MouseButton1Click:Connect(function()
    -- ТВОЙ СКРИПТ ДЛЯ КНОПКИ 8 ЗДЕСЬ
    print("Скрипт 8 активирован")
end)

-- =============================================
-- МЕСТО ДЛЯ ВСТАВКИ ТВОИХ СКРИПТОВ - СТРАНИЦА 2
-- =============================================

-- ВСТАВЬ СВОЙ СКРИПТ СЮДА (под кнопкой Скрипт 9):
ScriptButtons2[1].MouseButton1Click:Connect(function()
    --[[
  __  __ __  __ ___                _           _         _____                 _ 
 |  \/  |  \/  |__ \      /\      | |         (_)       |  __ \               | |
 | \  / | \  / |  ) |    /  \   __| |_ __ ___  _ _ __   | |__) |_ _ _ __   ___| |
 | |\/| | |\/| | / /    / /\ \ / _` | '_ ` _ \| | '_ \  |  ___/ _` | '_ \ / _ \ |
 | |  | | |  | |/ /_   / ____ \ (_| | | | | | | | | | | | |  | (_| | | | |  __/ |
 |_|  |_|_|  |_|____| /_/    \_\__,_|_| |_| |_|_|_| |_| |_|   \__,_|_| |_|\___|_|

MM2 Admin Panel is a fork of the popular Vynixu's MM2 script, and a few Generic MM2 Scripts.
MM2 Admin Panel brings a more compact, smaller design, inspired by Owl Hub,
MM2 Admin Script brings Axon based DLL Compatibility, meaning exploits like
Skisploit and Acrylix are able to utilize MM2 Admin Panel without any issues.

Thank you to my friends Zyrex and Vegie for helping me with Kill Murderer
]]--

local MM2AdminPanel = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local StartFrame = Instance.new("ImageLabel")
local BottomFrame = Instance.new("Frame")
local Tab1 = Instance.new("TextButton")
local Tab2 = Instance.new("TextButton")
local Tab4 = Instance.new("TextButton")
local PlayerFrame = Instance.new("ScrollingFrame")
local Fly = Instance.new("Frame")
local Activation = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local Noclip = Instance.new("Frame")
local Activation_2 = Instance.new("TextButton")
local Title_2 = Instance.new("TextLabel")
local Walkspeed = Instance.new("Frame")
local SetActivation = Instance.new("TextButton")
local WalkspeedTB = Instance.new("TextBox")
local ResetActivation = Instance.new("TextButton")
local JumpPower = Instance.new("Frame")
local SetActivation_2 = Instance.new("TextButton")
local JumpPowerTB = Instance.new("TextBox")
local ResetActivation_2 = Instance.new("TextButton")
local InfiniteJump = Instance.new("Frame")
local Activation_3 = Instance.new("TextButton")
local Title_3 = Instance.new("TextLabel")
local Tab3 = Instance.new("TextButton")
local MainFrame_2 = Instance.new("ScrollingFrame")
local CoinFarm = Instance.new("Frame")
local Activation_4 = Instance.new("TextButton")
local Title_4 = Instance.new("TextLabel")
local XRay = Instance.new("Frame")
local Activation_5 = Instance.new("TextButton")
local Title_5 = Instance.new("TextLabel")
local AFKFarm = Instance.new("Frame")
local Activation_6 = Instance.new("TextButton")
local Title_6 = Instance.new("TextLabel")
local KillMurderer = Instance.new("Frame")
local Activation_7 = Instance.new("TextButton")
local Title_7 = Instance.new("TextLabel")
local GunGrabber = Instance.new("Frame")
local Activation_8 = Instance.new("TextButton")
local Title_8 = Instance.new("TextLabel")
local KillAll = Instance.new("Frame")
local Activation_9 = Instance.new("TextButton")
local Title_9 = Instance.new("TextLabel")
local AntiLag = Instance.new("Frame")
local Activation_10 = Instance.new("TextButton")
local Title_10 = Instance.new("TextLabel")
local AimPlayer = Instance.new("Frame")
local AimActivation = Instance.new("TextButton")
local AimTB = Instance.new("TextBox")
local DeAimActivation = Instance.new("TextButton")
local VisualFrame = Instance.new("ScrollingFrame")
local AllESP = Instance.new("Frame")
local Activation_11 = Instance.new("TextButton")
local Title_11 = Instance.new("TextLabel")
local RefreshESP = Instance.new("Frame")
local Activation_12 = Instance.new("TextButton")
local Title_12 = Instance.new("TextLabel")
local TeleportFrame = Instance.new("ScrollingFrame")
local TP1 = Instance.new("Frame")
local Activation_13 = Instance.new("TextButton")
local Title_13 = Instance.new("TextLabel")
local TP2 = Instance.new("Frame")
local Activation_14 = Instance.new("TextButton")
local Title_14 = Instance.new("TextLabel")
local TeleportName = Instance.new("Frame")
local TeleportTB = Instance.new("TextBox")
local TeleportButton = Instance.new("TextButton")
local TP3 = Instance.new("Frame")
local Activation_15 = Instance.new("TextButton")
local Title_15 = Instance.new("TextLabel")
local TP4 = Instance.new("Frame")
local Activation_16 = Instance.new("TextButton")
local Title_16 = Instance.new("TextLabel")
local TopFrame = Instance.new("Frame")
local Title_17 = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")

MM2AdminPanel.Name = "MM2AdminPanel"
MM2AdminPanel.Parent = game.CoreGui
MM2AdminPanel.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = MM2AdminPanel
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 1.000
MainFrame.BorderColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 387, 0, 229)

StartFrame.Name = "StartFrame"
StartFrame.Parent = MainFrame
StartFrame.AnchorPoint = Vector2.new(0.5, 0.5)
StartFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
StartFrame.BackgroundTransparency = 1.000
StartFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
StartFrame.Image = "rbxassetid://3570695787"
StartFrame.ImageColor3 = Color3.fromRGB(20, 20, 20)
StartFrame.ScaleType = Enum.ScaleType.Slice
StartFrame.SliceCenter = Rect.new(100, 100, 100, 100)

BottomFrame.Name = "BottomFrame"
BottomFrame.Parent = MainFrame
BottomFrame.AnchorPoint = Vector2.new(0.5, 0.5)
BottomFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
BottomFrame.BorderColor3 = Color3.fromRGB(20, 20, 20)
BottomFrame.BorderSizePixel = 0
BottomFrame.ClipsDescendants = true
BottomFrame.Position = UDim2.new(0.5, 0, 1.5, 0)
BottomFrame.Size = UDim2.new(0, 387, 0, 229)

Tab1.Name = "Tab1"
Tab1.Parent = BottomFrame
Tab1.AnchorPoint = Vector2.new(0.5, 0.5)
Tab1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Tab1.BorderSizePixel = 0
Tab1.ClipsDescendants = true
Tab1.Position = UDim2.new(0.111912139, 0, 0.216999963, 0)
Tab1.Size = UDim2.new(0, 65, 0, 23)
Tab1.Font = Enum.Font.Gotham
Tab1.Text = "MAIN"
Tab1.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab1.TextSize = 14.000

Tab2.Name = "Tab2"
Tab2.Parent = BottomFrame
Tab2.AnchorPoint = Vector2.new(0.5, 0.5)
Tab2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Tab2.BorderSizePixel = 0
Tab2.ClipsDescendants = true
Tab2.Position = UDim2.new(0.292790681, 0, 0.216999978, 0)
Tab2.Size = UDim2.new(0, 75, 0, 23)
Tab2.Font = Enum.Font.Gotham
Tab2.Text = "PLAYER"
Tab2.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab2.TextSize = 14.000

Tab4.Name = "Tab4"
Tab4.Parent = BottomFrame
Tab4.AnchorPoint = Vector2.new(0.5, 0.5)
Tab4.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Tab4.BorderSizePixel = 0
Tab4.ClipsDescendants = true
Tab4.Position = UDim2.new(0.688384891, 0, 0.216999963, 0)
Tab4.Size = UDim2.new(0, 83, 0, 23)
Tab4.Font = Enum.Font.Gotham
Tab4.Text = "TELEPORT"
Tab4.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab4.TextSize = 14.000

PlayerFrame.Name = "PlayerFrame"
PlayerFrame.Parent = BottomFrame
PlayerFrame.Active = true
PlayerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
PlayerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PlayerFrame.BorderSizePixel = 0
PlayerFrame.Position = UDim2.new(0.5, 0, 0.611353695, 0)
PlayerFrame.Size = UDim2.new(0, 367, 0, 158)
PlayerFrame.Visible = false
PlayerFrame.CanvasSize = UDim2.new(0, 0, 1, 0)
PlayerFrame.ScrollBarThickness = 3

Fly.Name = "Fly"
Fly.Parent = PlayerFrame
Fly.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Fly.BackgroundTransparency = 1.000
Fly.BorderColor3 = Color3.fromRGB(30, 30, 30)
Fly.BorderSizePixel = 0
Fly.ClipsDescendants = true
Fly.Position = UDim2.new(0.0199999996, 0, 0.0199999996, 0)
Fly.Size = UDim2.new(0, 161, 0, 20)

Activation.Name = "Activation"
Activation.Parent = Fly
Activation.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
Activation.BorderSizePixel = 0
Activation.Size = UDim2.new(0, 20, 0, 20)
Activation.Font = Enum.Font.Gotham
Activation.Text = ""
Activation.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation.TextSize = 14.000

Title.Name = "Title"
Title.Parent = Fly
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.161490679, 0, 0, 0)
Title.Size = UDim2.new(0.838509321, 0, 1, 0)
Title.Font = Enum.Font.Gotham
Title.Text = "Fly [X]"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14.000
Title.TextWrapped = true
Title.TextXAlignment = Enum.TextXAlignment.Left

Noclip.Name = "Noclip"
Noclip.Parent = PlayerFrame
Noclip.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Noclip.BorderColor3 = Color3.fromRGB(30, 30, 30)
Noclip.BorderSizePixel = 0
Noclip.ClipsDescendants = true
Noclip.Position = UDim2.new(0.0199999996, 0, 0.126000002, 0)
Noclip.Size = UDim2.new(0, 161, 0, 20)

Activation_2.Name = "Activation"
Activation_2.Parent = Noclip
Activation_2.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
Activation_2.BorderSizePixel = 0
Activation_2.Size = UDim2.new(0, 20, 0, 20)
Activation_2.Font = Enum.Font.Gotham
Activation_2.Text = ""
Activation_2.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_2.TextSize = 14.000

Title_2.Name = "Title"
Title_2.Parent = Noclip
Title_2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_2.BackgroundTransparency = 1.000
Title_2.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_2.BorderSizePixel = 0
Title_2.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_2.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_2.Font = Enum.Font.Gotham
Title_2.Text = "Noclip [C]"
Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_2.TextSize = 14.000
Title_2.TextWrapped = true
Title_2.TextXAlignment = Enum.TextXAlignment.Left

Walkspeed.Name = "Walkspeed"
Walkspeed.Parent = PlayerFrame
Walkspeed.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Walkspeed.BorderColor3 = Color3.fromRGB(30, 30, 30)
Walkspeed.BorderSizePixel = 0
Walkspeed.ClipsDescendants = true
Walkspeed.Position = UDim2.new(0.0199999996, 0, 0.335999995, 0)
Walkspeed.Size = UDim2.new(0, 161, 0, 42)

SetActivation.Name = "SetActivation"
SetActivation.Parent = Walkspeed
SetActivation.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SetActivation.BorderSizePixel = 0
SetActivation.Position = UDim2.new(0, 0, 0.555555582, 0)
SetActivation.Size = UDim2.new(0, 36, 0, 20)
SetActivation.Font = Enum.Font.Gotham
SetActivation.Text = "Set"
SetActivation.TextColor3 = Color3.fromRGB(255, 255, 255)
SetActivation.TextSize = 14.000

WalkspeedTB.Name = "WalkspeedTB"
WalkspeedTB.Parent = Walkspeed
WalkspeedTB.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
WalkspeedTB.BorderColor3 = Color3.fromRGB(40, 40, 40)
WalkspeedTB.BorderSizePixel = 0
WalkspeedTB.Position = UDim2.new(-0.000559931214, 0, -0.0166666675, 0)
WalkspeedTB.Size = UDim2.new(0.732458353, 0, 0.394444436, 0)
WalkspeedTB.Font = Enum.Font.Gotham
WalkspeedTB.Text = "Insert Walkspeed"
WalkspeedTB.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkspeedTB.TextSize = 14.000

ResetActivation.Name = "ResetActivation"
ResetActivation.Parent = Walkspeed
ResetActivation.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ResetActivation.BorderSizePixel = 0
ResetActivation.Position = UDim2.new(0.259848803, 0, 0.555555582, 0)
ResetActivation.Size = UDim2.new(0, 76, 0, 20)
ResetActivation.Font = Enum.Font.Gotham
ResetActivation.Text = "Reset"
ResetActivation.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetActivation.TextSize = 14.000

JumpPower.Name = "JumpPower"
JumpPower.Parent = PlayerFrame
JumpPower.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
JumpPower.BorderColor3 = Color3.fromRGB(30, 30, 30)
JumpPower.BorderSizePixel = 0
JumpPower.ClipsDescendants = true
JumpPower.Position = UDim2.new(0.0199999996, 0, 0.537, 0)
JumpPower.Size = UDim2.new(0, 161, 0, 42)

SetActivation_2.Name = "SetActivation"
SetActivation_2.Parent = JumpPower
SetActivation_2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SetActivation_2.BorderSizePixel = 0
SetActivation_2.Position = UDim2.new(0, 0, 0.555555582, 0)
SetActivation_2.Size = UDim2.new(0, 36, 0, 20)
SetActivation_2.Font = Enum.Font.Gotham
SetActivation_2.Text = "Set"
SetActivation_2.TextColor3 = Color3.fromRGB(255, 255, 255)
SetActivation_2.TextSize = 14.000

JumpPowerTB.Name = "JumpPowerTB"
JumpPowerTB.Parent = JumpPower
JumpPowerTB.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
JumpPowerTB.BorderColor3 = Color3.fromRGB(40, 40, 40)
JumpPowerTB.BorderSizePixel = 0
JumpPowerTB.Position = UDim2.new(-0.000559931214, 0, -0.0166666675, 0)
JumpPowerTB.Size = UDim2.new(0.732458353, 0, 0.394444436, 0)
JumpPowerTB.Font = Enum.Font.Gotham
JumpPowerTB.Text = "Insert JumpPower"
JumpPowerTB.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpPowerTB.TextSize = 14.000

ResetActivation_2.Name = "ResetActivation"
ResetActivation_2.Parent = JumpPower
ResetActivation_2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ResetActivation_2.BorderSizePixel = 0
ResetActivation_2.Position = UDim2.new(0.259848803, 0, 0.555555582, 0)
ResetActivation_2.Size = UDim2.new(0, 76, 0, 20)
ResetActivation_2.Font = Enum.Font.Gotham
ResetActivation_2.Text = "Reset"
ResetActivation_2.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetActivation_2.TextSize = 14.000

InfiniteJump.Name = "InfiniteJump"
InfiniteJump.Parent = PlayerFrame
InfiniteJump.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
InfiniteJump.BorderColor3 = Color3.fromRGB(30, 30, 30)
InfiniteJump.BorderSizePixel = 0
InfiniteJump.ClipsDescendants = true
InfiniteJump.Position = UDim2.new(0.0199999996, 0, 0.229000002, 0)
InfiniteJump.Size = UDim2.new(0, 161, 0, 20)

Activation_3.Name = "Activation"
Activation_3.Parent = InfiniteJump
Activation_3.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
Activation_3.BorderSizePixel = 0
Activation_3.Size = UDim2.new(0, 20, 0, 20)
Activation_3.Font = Enum.Font.Gotham
Activation_3.Text = ""
Activation_3.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_3.TextSize = 14.000

Title_3.Name = "Title"
Title_3.Parent = InfiniteJump
Title_3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_3.BackgroundTransparency = 1.000
Title_3.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_3.BorderSizePixel = 0
Title_3.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_3.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_3.Font = Enum.Font.Gotham
Title_3.Text = "Infinite Jump [V]"
Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_3.TextSize = 14.000
Title_3.TextWrapped = true
Title_3.TextXAlignment = Enum.TextXAlignment.Left

Tab3.Name = "Tab3"
Tab3.Parent = BottomFrame
Tab3.AnchorPoint = Vector2.new(0.5, 0.5)
Tab3.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Tab3.BorderSizePixel = 0
Tab3.ClipsDescendants = true
Tab3.Position = UDim2.new(0.486589134, 0, 0.216999978, 0)
Tab3.Size = UDim2.new(0, 75, 0, 23)
Tab3.Font = Enum.Font.Gotham
Tab3.Text = "VISUALS"
Tab3.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab3.TextSize = 14.000

MainFrame_2.Name = "MainFrame"
MainFrame_2.Parent = BottomFrame
MainFrame_2.Active = true
MainFrame_2.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame_2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame_2.BorderSizePixel = 0
MainFrame_2.Position = UDim2.new(0.5, 0, 0.611353695, 0)
MainFrame_2.Size = UDim2.new(0, 367, 0, 158)
MainFrame_2.CanvasSize = UDim2.new(0, 0, 1, 0)
MainFrame_2.ScrollBarThickness = 3

CoinFarm.Name = "CoinFarm"
CoinFarm.Parent = MainFrame_2
CoinFarm.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CoinFarm.BackgroundTransparency = 1.000
CoinFarm.BorderColor3 = Color3.fromRGB(30, 30, 30)
CoinFarm.BorderSizePixel = 0
CoinFarm.ClipsDescendants = true
CoinFarm.Position = UDim2.new(0.0199999996, 0, 0.0199999996, 0)
CoinFarm.Size = UDim2.new(0, 161, 0, 20)

Activation_4.Name = "Activation"
Activation_4.Parent = CoinFarm
Activation_4.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
Activation_4.BorderSizePixel = 0
Activation_4.Size = UDim2.new(0, 20, 0, 20)
Activation_4.Font = Enum.Font.Gotham
Activation_4.Text = ""
Activation_4.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_4.TextSize = 14.000

Title_4.Name = "Title"
Title_4.Parent = CoinFarm
Title_4.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_4.BackgroundTransparency = 1.000
Title_4.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_4.BorderSizePixel = 0
Title_4.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_4.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_4.Font = Enum.Font.Gotham
Title_4.Text = "Coin Farm (RISKY)"
Title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_4.TextSize = 14.000
Title_4.TextWrapped = true
Title_4.TextXAlignment = Enum.TextXAlignment.Left

XRay.Name = "XRay"
XRay.Parent = MainFrame_2
XRay.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
XRay.BorderColor3 = Color3.fromRGB(30, 30, 30)
XRay.BorderSizePixel = 0
XRay.ClipsDescendants = true
XRay.Position = UDim2.new(0.0199999996, 0, 0.123999998, 0)
XRay.Size = UDim2.new(0, 161, 0, 20)

Activation_5.Name = "Activation"
Activation_5.Parent = XRay
Activation_5.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
Activation_5.BorderSizePixel = 0
Activation_5.Size = UDim2.new(0, 20, 0, 20)
Activation_5.Font = Enum.Font.Gotham
Activation_5.Text = ""
Activation_5.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_5.TextSize = 14.000

Title_5.Name = "Title"
Title_5.Parent = XRay
Title_5.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_5.BackgroundTransparency = 1.000
Title_5.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_5.BorderSizePixel = 0
Title_5.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_5.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_5.Font = Enum.Font.Gotham
Title_5.Text = "X-Ray"
Title_5.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_5.TextSize = 14.000
Title_5.TextWrapped = true
Title_5.TextXAlignment = Enum.TextXAlignment.Left

AFKFarm.Name = "AFKFarm"
AFKFarm.Parent = MainFrame_2
AFKFarm.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AFKFarm.BorderColor3 = Color3.fromRGB(30, 30, 30)
AFKFarm.BorderSizePixel = 0
AFKFarm.ClipsDescendants = true
AFKFarm.Position = UDim2.new(0.0199999996, 0, 0.331, 0)
AFKFarm.Size = UDim2.new(0, 161, 0, 20)

Activation_6.Name = "Activation"
Activation_6.Parent = AFKFarm
Activation_6.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Activation_6.BorderSizePixel = 0
Activation_6.Size = UDim2.new(0, 20, 0, 20)
Activation_6.Font = Enum.Font.Gotham
Activation_6.Text = ""
Activation_6.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_6.TextSize = 14.000

Title_6.Name = "Title"
Title_6.Parent = AFKFarm
Title_6.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_6.BackgroundTransparency = 1.000
Title_6.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_6.BorderSizePixel = 0
Title_6.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_6.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_6.Font = Enum.Font.Gotham
Title_6.Text = "AFK Farm"
Title_6.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_6.TextSize = 14.000
Title_6.TextWrapped = true
Title_6.TextXAlignment = Enum.TextXAlignment.Left

KillMurderer.Name = "KillMurderer"
KillMurderer.Parent = MainFrame_2
KillMurderer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KillMurderer.BorderColor3 = Color3.fromRGB(30, 30, 30)
KillMurderer.BorderSizePixel = 0
KillMurderer.ClipsDescendants = true
KillMurderer.Position = UDim2.new(0.0199999996, 0, 0.542999983, 0)
KillMurderer.Size = UDim2.new(0, 161, 0, 20)

Activation_7.Name = "Activation"
Activation_7.Parent = KillMurderer
Activation_7.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Activation_7.BorderSizePixel = 0
Activation_7.Size = UDim2.new(0, 20, 0, 20)
Activation_7.Font = Enum.Font.Gotham
Activation_7.Text = ""
Activation_7.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_7.TextSize = 14.000

Title_7.Name = "Title"
Title_7.Parent = KillMurderer
Title_7.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_7.BackgroundTransparency = 1.000
Title_7.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_7.BorderSizePixel = 0
Title_7.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_7.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_7.Font = Enum.Font.Gotham
Title_7.Text = "Kill Murderer"
Title_7.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_7.TextSize = 14.000
Title_7.TextWrapped = true
Title_7.TextXAlignment = Enum.TextXAlignment.Left

GunGrabber.Name = "GunGrabber"
GunGrabber.Parent = MainFrame_2
GunGrabber.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
GunGrabber.BorderColor3 = Color3.fromRGB(30, 30, 30)
GunGrabber.BorderSizePixel = 0
GunGrabber.ClipsDescendants = true
GunGrabber.Position = UDim2.new(0.0199999996, 0, 0.648999989, 0)
GunGrabber.Size = UDim2.new(0, 161, 0, 20)

Activation_8.Name = "Activation"
Activation_8.Parent = GunGrabber
Activation_8.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Activation_8.BorderSizePixel = 0
Activation_8.Size = UDim2.new(0, 20, 0, 20)
Activation_8.Font = Enum.Font.Gotham
Activation_8.Text = ""
Activation_8.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_8.TextSize = 14.000

Title_8.Name = "Title"
Title_8.Parent = GunGrabber
Title_8.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_8.BackgroundTransparency = 1.000
Title_8.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_8.BorderSizePixel = 0
Title_8.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_8.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_8.Font = Enum.Font.Gotham
Title_8.Text = "Gun Grabber"
Title_8.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_8.TextSize = 14.000
Title_8.TextWrapped = true
Title_8.TextXAlignment = Enum.TextXAlignment.Left

KillAll.Name = "KillAll"
KillAll.Parent = MainFrame_2
KillAll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KillAll.BorderColor3 = Color3.fromRGB(30, 30, 30)
KillAll.BorderSizePixel = 0
KillAll.ClipsDescendants = true
KillAll.Position = UDim2.new(0.0199999996, 0, 0.437000006, 0)
KillAll.Size = UDim2.new(0, 161, 0, 20)

Activation_9.Name = "Activation"
Activation_9.Parent = KillAll
Activation_9.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Activation_9.BorderSizePixel = 0
Activation_9.Size = UDim2.new(0, 20, 0, 20)
Activation_9.Font = Enum.Font.Gotham
Activation_9.Text = ""
Activation_9.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_9.TextSize = 14.000

Title_9.Name = "Title"
Title_9.Parent = KillAll
Title_9.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_9.BackgroundTransparency = 1.000
Title_9.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_9.BorderSizePixel = 0
Title_9.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_9.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_9.Font = Enum.Font.Gotham
Title_9.Text = "Kill All"
Title_9.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_9.TextSize = 14.000
Title_9.TextWrapped = true
Title_9.TextXAlignment = Enum.TextXAlignment.Left

AntiLag.Name = "AntiLag"
AntiLag.Parent = MainFrame_2
AntiLag.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AntiLag.BorderColor3 = Color3.fromRGB(30, 30, 30)
AntiLag.BorderSizePixel = 0
AntiLag.ClipsDescendants = true
AntiLag.Position = UDim2.new(0.0199999996, 0, 0.226999998, 0)
AntiLag.Size = UDim2.new(0, 161, 0, 20)

Activation_10.Name = "Activation"
Activation_10.Parent = AntiLag
Activation_10.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Activation_10.BorderSizePixel = 0
Activation_10.Size = UDim2.new(0, 20, 0, 20)
Activation_10.Font = Enum.Font.Gotham
Activation_10.Text = ""
Activation_10.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_10.TextSize = 14.000

Title_10.Name = "Title"
Title_10.Parent = AntiLag
Title_10.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_10.BackgroundTransparency = 1.000
Title_10.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_10.BorderSizePixel = 0
Title_10.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_10.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_10.Font = Enum.Font.Gotham
Title_10.Text = "Anti-Lag"
Title_10.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_10.TextSize = 14.000
Title_10.TextWrapped = true
Title_10.TextXAlignment = Enum.TextXAlignment.Left

AimPlayer.Name = "AimPlayer"
AimPlayer.Parent = MainFrame_2
AimPlayer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AimPlayer.BorderColor3 = Color3.fromRGB(30, 30, 30)
AimPlayer.BorderSizePixel = 0
AimPlayer.ClipsDescendants = true
AimPlayer.Position = UDim2.new(0.0170000009, 0, 0.763999999, 0)
AimPlayer.Size = UDim2.new(0, 161, 0, 42)

AimActivation.Name = "AimActivation"
AimActivation.Parent = AimPlayer
AimActivation.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AimActivation.BorderSizePixel = 0
AimActivation.Position = UDim2.new(0, 0, 0.55555582, 0)
AimActivation.Size = UDim2.new(0, 66, 0, 20)
AimActivation.Font = Enum.Font.Gotham
AimActivation.Text = "Aim User"
AimActivation.TextColor3 = Color3.fromRGB(255, 255, 255)
AimActivation.TextSize = 14.000

AimTB.Name = "AimTB"
AimTB.Parent = AimPlayer
AimTB.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AimTB.BorderColor3 = Color3.fromRGB(40, 40, 40)
AimTB.BorderSizePixel = 0
AimTB.Position = UDim2.new(-0.000559931214, 0, -0.0166666675, 0)
AimTB.Size = UDim2.new(0.732458353, 0, 0.394444436, 0)
AimTB.Font = Enum.Font.Gotham
AimTB.Text = "Player name"
AimTB.TextColor3 = Color3.fromRGB(255, 255, 255)
AimTB.TextSize = 14.000

DeAimActivation.Name = "DeAimActivation"
DeAimActivation.Parent = AimPlayer
DeAimActivation.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DeAimActivation.BorderSizePixel = 0
DeAimActivation.Position = UDim2.new(0.447204977, 0, 0.55555582, 0)
DeAimActivation.Size = UDim2.new(0, 45, 0, 20)
DeAimActivation.Font = Enum.Font.Gotham
DeAimActivation.Text = "Off"
DeAimActivation.TextColor3 = Color3.fromRGB(255, 255, 255)
DeAimActivation.TextSize = 14.000

VisualFrame.Name = "VisualFrame"
VisualFrame.Parent = BottomFrame
VisualFrame.Active = true
VisualFrame.AnchorPoint = Vector2.new(0.5, 0.5)
VisualFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
VisualFrame.BorderSizePixel = 0
VisualFrame.Position = UDim2.new(0.5, 0, 0.611353695, 0)
VisualFrame.Size = UDim2.new(0, 367, 0, 158)
VisualFrame.Visible = false
VisualFrame.CanvasSize = UDim2.new(0, 0, 0.5, 0)
VisualFrame.ScrollBarThickness = 3

AllESP.Name = "AllESP"
AllESP.Parent = VisualFrame
AllESP.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AllESP.BackgroundTransparency = 1.000
AllESP.BorderColor3 = Color3.fromRGB(30, 30, 30)
AllESP.BorderSizePixel = 0
AllESP.ClipsDescendants = true
AllESP.Position = UDim2.new(0.0199999996, 0, 0.0399999991, 0)
AllESP.Size = UDim2.new(0, 161, 0, 20)

Activation_11.Name = "Activation"
Activation_11.Parent = AllESP
Activation_11.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
Activation_11.BorderSizePixel = 0
Activation_11.Size = UDim2.new(0, 20, 0, 20)
Activation_11.Font = Enum.Font.Gotham
Activation_11.Text = ""
Activation_11.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_11.TextSize = 14.000

Title_11.Name = "Title"
Title_11.Parent = AllESP
Title_11.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_11.BackgroundTransparency = 1.000
Title_11.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_11.BorderSizePixel = 0
Title_11.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_11.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_11.Font = Enum.Font.Gotham
Title_11.Text = "Everyone ESP"
Title_11.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_11.TextSize = 14.000
Title_11.TextWrapped = true
Title_11.TextXAlignment = Enum.TextXAlignment.Left

RefreshESP.Name = "RefreshESP"
RefreshESP.Parent = VisualFrame
RefreshESP.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
RefreshESP.BorderColor3 = Color3.fromRGB(30, 30, 30)
RefreshESP.BorderSizePixel = 0
RefreshESP.ClipsDescendants = true
RefreshESP.Position = UDim2.new(0.0199999996, 0, 0.202000007, 0)
RefreshESP.Size = UDim2.new(0, 161, 0, 20)

Activation_12.Name = "Activation"
Activation_12.Parent = RefreshESP
Activation_12.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Activation_12.BorderSizePixel = 0
Activation_12.Size = UDim2.new(0, 20, 0, 20)
Activation_12.Font = Enum.Font.Gotham
Activation_12.Text = ""
Activation_12.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_12.TextSize = 14.000

Title_12.Name = "Title"
Title_12.Parent = RefreshESP
Title_12.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_12.BackgroundTransparency = 1.000
Title_12.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_12.BorderSizePixel = 0
Title_12.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_12.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_12.Font = Enum.Font.Gotham
Title_12.Text = "Refresh ESP"
Title_12.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_12.TextSize = 14.000
Title_12.TextWrapped = true
Title_12.TextXAlignment = Enum.TextXAlignment.Left

TeleportFrame.Name = "TeleportFrame"
TeleportFrame.Parent = BottomFrame
TeleportFrame.Active = true
TeleportFrame.AnchorPoint = Vector2.new(0.5, 0.5)
TeleportFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TeleportFrame.BorderSizePixel = 0
TeleportFrame.Position = UDim2.new(0.5, 0, 0.611353695, 0)
TeleportFrame.Size = UDim2.new(0, 367, 0, 158)
TeleportFrame.Visible = false
TeleportFrame.CanvasSize = UDim2.new(0, 0, 1, 0)
TeleportFrame.ScrollBarThickness = 3

TP1.Name = "TP1"
TP1.Parent = TeleportFrame
TP1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TP1.BackgroundTransparency = 1.000
TP1.BorderColor3 = Color3.fromRGB(30, 30, 30)
TP1.BorderSizePixel = 0
TP1.ClipsDescendants = true
TP1.Position = UDim2.new(0.0199999996, 0, 0.0199999996, 0)
TP1.Size = UDim2.new(0, 161, 0, 20)

Activation_13.Name = "Activation"
Activation_13.Parent = TP1
Activation_13.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Activation_13.BorderSizePixel = 0
Activation_13.Size = UDim2.new(0, 20, 0, 20)
Activation_13.Font = Enum.Font.Gotham
Activation_13.Text = ""
Activation_13.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_13.TextSize = 14.000

Title_13.Name = "Title"
Title_13.Parent = TP1
Title_13.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_13.BackgroundTransparency = 1.000
Title_13.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_13.BorderSizePixel = 0
Title_13.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_13.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_13.Font = Enum.Font.Gotham
Title_13.Text = "TP to Lobby"
Title_13.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_13.TextSize = 14.000
Title_13.TextWrapped = true
Title_13.TextXAlignment = Enum.TextXAlignment.Left

TP2.Name = "TP2"
TP2.Parent = TeleportFrame
TP2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TP2.BorderColor3 = Color3.fromRGB(30, 30, 30)
TP2.BorderSizePixel = 0
TP2.ClipsDescendants = true
TP2.Position = UDim2.new(0.0199999996, 0, 0.126000002, 0)
TP2.Size = UDim2.new(0, 161, 0, 20)

Activation_14.Name = "Activation"
Activation_14.Parent = TP2
Activation_14.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Activation_14.BorderSizePixel = 0
Activation_14.Size = UDim2.new(0, 20, 0, 20)
Activation_14.Font = Enum.Font.Gotham
Activation_14.Text = ""
Activation_14.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_14.TextSize = 14.000

Title_14.Name = "Title"
Title_14.Parent = TP2
Title_14.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_14.BackgroundTransparency = 1.000
Title_14.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_14.BorderSizePixel = 0
Title_14.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_14.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_14.Font = Enum.Font.Gotham
Title_14.Text = "TP to Map"
Title_14.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_14.TextSize = 14.000
Title_14.TextWrapped = true
Title_14.TextXAlignment = Enum.TextXAlignment.Left

TeleportName.Name = "TeleportName"
TeleportName.Parent = TeleportFrame
TeleportName.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TeleportName.BorderColor3 = Color3.fromRGB(30, 30, 30)
TeleportName.BorderSizePixel = 0
TeleportName.ClipsDescendants = true
TeleportName.Position = UDim2.new(0.0199999996, 0, 0.455000013, 0)
TeleportName.Size = UDim2.new(0, 161, 0, 42)

TeleportTB.Name = "TeleportTB"
TeleportTB.Parent = TeleportName
TeleportTB.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TeleportTB.BorderColor3 = Color3.fromRGB(40, 40, 40)
TeleportTB.BorderSizePixel = 0
TeleportTB.Position = UDim2.new(-0.000559931214, 0, -0.0166666675, 0)
TeleportTB.Size = UDim2.new(0.732458353, 0, 0.394444436, 0)
TeleportTB.Font = Enum.Font.Gotham
TeleportTB.Text = "Insert Name"
TeleportTB.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportTB.TextSize = 14.000

TeleportButton.Name = "TeleportButton"
TeleportButton.Parent = TeleportName
TeleportButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TeleportButton.BorderSizePixel = 0
TeleportButton.Position = UDim2.new(0, 0, 0.55555582, 0)
TeleportButton.Size = UDim2.new(0, 117, 0, 20)
TeleportButton.Font = Enum.Font.Gotham
TeleportButton.Text = "Teleport"
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.TextSize = 14.000

TP3.Name = "TP3"
TP3.Parent = TeleportFrame
TP3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TP3.BorderColor3 = Color3.fromRGB(30, 30, 30)
TP3.BorderSizePixel = 0
TP3.ClipsDescendants = true
TP3.Position = UDim2.new(0.0199999996, 0, 0.232999995, 0)
TP3.Size = UDim2.new(0, 161, 0, 20)

Activation_15.Name = "Activation"
Activation_15.Parent = TP3
Activation_15.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Activation_15.BorderSizePixel = 0
Activation_15.Size = UDim2.new(0, 20, 0, 20)
Activation_15.Font = Enum.Font.Gotham
Activation_15.Text = ""
Activation_15.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_15.TextSize = 14.000

Title_15.Name = "Title"
Title_15.Parent = TP3
Title_15.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_15.BackgroundTransparency = 1.000
Title_15.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_15.BorderSizePixel = 0
Title_15.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_15.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_15.Font = Enum.Font.Gotham
Title_15.Text = "TP to Murderer"
Title_15.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_15.TextSize = 14.000
Title_15.TextWrapped = true
Title_15.TextXAlignment = Enum.TextXAlignment.Left

TP4.Name = "TP4"
TP4.Parent = TeleportFrame
TP4.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TP4.BorderColor3 = Color3.fromRGB(30, 30, 30)
TP4.BorderSizePixel = 0
TP4.ClipsDescendants = true
TP4.Position = UDim2.new(0.0199999996, 0, 0.338999987, 0)
TP4.Size = UDim2.new(0, 161, 0, 20)

Activation_16.Name = "Activation"
Activation_16.Parent = TP4
Activation_16.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Activation_16.BorderSizePixel = 0
Activation_16.Size = UDim2.new(0, 20, 0, 20)
Activation_16.Font = Enum.Font.Gotham
Activation_16.Text = ""
Activation_16.TextColor3 = Color3.fromRGB(0, 0, 0)
Activation_16.TextSize = 14.000

Title_16.Name = "Title"
Title_16.Parent = TP4
Title_16.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title_16.BackgroundTransparency = 1.000
Title_16.BorderColor3 = Color3.fromRGB(30, 30, 30)
Title_16.BorderSizePixel = 0
Title_16.Position = UDim2.new(0.161490679, 0, 0, 0)
Title_16.Size = UDim2.new(0.838509321, 0, 1, 0)
Title_16.Font = Enum.Font.Gotham
Title_16.Text = "TP to Sheriff"
Title_16.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_16.TextSize = 14.000
Title_16.TextWrapped = true
Title_16.TextXAlignment = Enum.TextXAlignment.Left

TopFrame.Name = "TopFrame"
TopFrame.Parent = MainFrame
TopFrame.AnchorPoint = Vector2.new(0.5, 0.5)
TopFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TopFrame.BorderColor3 = Color3.fromRGB(20, 20, 20)
TopFrame.BorderSizePixel = 0
TopFrame.ClipsDescendants = true
TopFrame.Position = UDim2.new(0.5, 0, -0.057, 0)
TopFrame.Size = UDim2.new(0, 387, 0, 26)

Title_17.Name = "Title"
Title_17.Parent = TopFrame
Title_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_17.BackgroundTransparency = 1.000
Title_17.BorderSizePixel = 0
Title_17.Position = UDim2.new(0.0199999996, 0, 0, 0)
Title_17.Size = UDim2.new(0.405684769, 0, 1, 0)
Title_17.Font = Enum.Font.Gotham
Title_17.Text = "MM2 Admin Panel - CHEATER.FUN"
Title_17.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_17.TextSize = 14.000
Title_17.TextXAlignment = Enum.TextXAlignment.Left

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopFrame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MinimizeButton.BackgroundTransparency = 1.000
MinimizeButton.BorderColor3 = Color3.fromRGB(20, 20, 20)
MinimizeButton.Position = UDim2.new(0.931999981, 0, 0.153999999, 0)
MinimizeButton.Size = UDim2.new(0, 18, 0, 18)
MinimizeButton.Font = Enum.Font.Gotham
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 25.000

local function ZIRG_fake_script() -- MainFrame.DraggingScript 
	local script = Instance.new('LocalScript', MainFrame)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.TopFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(ZIRG_fake_script)()
local function YMZQ_fake_script() -- MainFrame.TweenIntro 
	local script = Instance.new('LocalScript', MainFrame)

	wait(1)
	script.Parent.StartFrame:TweenSize(UDim2.new(0,100,0,100), "Out", "Quad", 0.5, true)
	wait(1)
	script.Parent.StartFrame:TweenSize(UDim2.new(0,500,0,500), "Out", "Quad", 0.9, true)
	wait(0.9)
	script.Parent.TopFrame:TweenPosition(UDim2.new(0.5,0,0.057,0), "Out", "Quad", 0.5, true)
	script.Parent.BottomFrame:TweenPosition(UDim2.new(0.5,0,0.5,0), "Out", "Quad", 0.5, true)
	wait(0.5)
	script.Parent.StartFrame.Visible = false
end
coroutine.wrap(YMZQ_fake_script)()
local function MXBYD_fake_script() -- Activation.Script 
	local script = Instance.new('Script', Activation)

		flying = false
		lplayer = game.Players.LocalPlayer
		speedget = 1
		speedfly = 1
		Mouse = lplayer:GetMouse()
		
		script.Parent.MouseButton1Click:Connect(function()
			if flying == false then
				script.Parent.BackgroundColor3 = Color3.fromRGB(52, 255, 52)
				
				repeat wait() until lplayer and lplayer.Character and lplayer.Character:FindFirstChild('HumanoidRootPart') and lplayer.Character:FindFirstChild('Humanoid')
				repeat wait() until Mouse
				
				local T = lplayer.Character.HumanoidRootPart
				local CONTROL = {F = 0, B = 0, L = 0, R = 0}
				local lCONTROL = {F = 0, B = 0, L = 0, R = 0}
				local SPEED = speedget
				
				local function fly()
					flying = true
					local BG = Instance.new('BodyGyro', T)
					local BV = Instance.new('BodyVelocity', T)
					BG.P = 9e4
					BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
					BG.cframe = T.CFrame
					BV.velocity = Vector3.new(0, 0.1, 0)
					BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
					spawn(function()
					repeat wait()
					lplayer.Character.Humanoid.PlatformStand = true
					if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 then
						SPEED = 50
					elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and SPEED ~= 0 then
						SPEED = 0
					end
					if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 then
						BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
						lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
					elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and SPEED ~= 0 then
						BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					else
						BV.velocity = Vector3.new(0, 0.1, 0)
					end
					BG.cframe = workspace.CurrentCamera.CoordinateFrame
					until not flying
						CONTROL = {F = 0, B = 0, L = 0, R = 0}
						lCONTROL = {F = 0, B = 0, L = 0, R = 0}
						SPEED = 0
						BG:destroy()
						BV:destroy()
						lplayer.Character.Humanoid.PlatformStand = false
					end)
				end
				Mouse.KeyDown:connect(function(KEY)
					if KEY:lower() == 'w' then
						CONTROL.F = speedfly
					elseif KEY:lower() == 's' then
						CONTROL.B = -speedfly
					elseif KEY:lower() == 'a' then
						CONTROL.L = -speedfly 
					elseif KEY:lower() == 'd' then 
						CONTROL.R = speedfly
					end
				end)
				Mouse.KeyUp:connect(function(KEY)
					if KEY:lower() == 'w' then
						CONTROL.F = 0
					elseif KEY:lower() == 's' then
						CONTROL.B = 0
					elseif KEY:lower() == 'a' then
						CONTROL.L = 0
					elseif KEY:lower() == 'd' then
						CONTROL.R = 0
					end
				end)
				fly()
			else
				flying = false
				script.Parent.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
				lplayer.Character.Humanoid.PlatformStand = false
			end
		end)
		
		Mouse.KeyDown:Connect(function(k)
			if k == "x" then
				
				if flying == false then
					script.Parent.BackgroundColor3 = Color3.fromRGB(52, 255, 52)
					
					repeat wait() until lplayer and lplayer.Character and lplayer.Character:FindFirstChild('HumanoidRootPart') and lplayer.Character:FindFirstChild('Humanoid')
					repeat wait() until Mouse
					
					local T = lplayer.Character.HumanoidRootPart
					local CONTROL = {F = 0, B = 0, L = 0, R = 0}
					local lCONTROL = {F = 0, B = 0, L = 0, R = 0}
					local SPEED = speedget
					
					local function fly()
						flying = true
						local BG = Instance.new('BodyGyro', T)
						local BV = Instance.new('BodyVelocity', T)
						BG.P = 9e4
						BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
						BG.cframe = T.CFrame
						BV.velocity = Vector3.new(0, 0.1, 0)
						BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
						spawn(function()
						repeat wait()
						lplayer.Character.Humanoid.PlatformStand = true
						if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 then
							SPEED = 50
						elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and SPEED ~= 0 then
							SPEED = 0
						end
						if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 then
							BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
							lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
						elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and SPEED ~= 0 then
							BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
						else
							BV.velocity = Vector3.new(0, 0.1, 0)
						end
						BG.cframe = workspace.CurrentCamera.CoordinateFrame
						until not flying
							CONTROL = {F = 0, B = 0, L = 0, R = 0}
							lCONTROL = {F = 0, B = 0, L = 0, R = 0}
							SPEED = 0
							BG:destroy()
							BV:destroy()
							lplayer.Character.Humanoid.PlatformStand = false
						end)
					end
					Mouse.KeyDown:connect(function(KEY)
						if KEY:lower() == 'w' then
							CONTROL.F = speedfly
						elseif KEY:lower() == 's' then
							CONTROL.B = -speedfly
						elseif KEY:lower() == 'a' then
							CONTROL.L = -speedfly 
						elseif KEY:lower() == 'd' then 
							CONTROL.R = speedfly
						end
					end)
					Mouse.KeyUp:connect(function(KEY)
						if KEY:lower() == 'w' then
							CONTROL.F = 0
						elseif KEY:lower() == 's' then
							CONTROL.B = 0
						elseif KEY:lower() == 'a' then
							CONTROL.L = 0
						elseif KEY:lower() == 'd' then
							CONTROL.R = 0
						end
					end)
					fly()
				else
					flying = false
					script.Parent.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
					lplayer.Character.Humanoid.PlatformStand = false
				end
				
			end
		end)
end
coroutine.wrap(MXBYD_fake_script)()
local function HREBVA_fake_script() -- Activation_2.Script 
	local script = Instance.new('Script', Activation_2)

		noclip = false
		local Mouse = game.Players.LocalPlayer:GetMouse()
		
		game:GetService('RunService').Stepped:connect(function()
			if noclip then
				game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
			end
		end)
		
		script.Parent.MouseButton1Down:connect(function()
			noclip = not noclip
			if noclip then
				script.Parent.BackgroundColor3 = Color3.fromRGB(52, 255, 52)
			else
				script.Parent.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
			end
		end)
		
		Mouse.KeyDown:Connect(function(k)
			if k == "c" then
				
				noclip = not noclip
				if noclip then
					script.Parent.BackgroundColor3 = Color3.fromRGB(52, 255, 52)
				else
					script.Parent.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
				end
				
			end	
		end)
end
coroutine.wrap(HREBVA_fake_script)()
local function WLZBXL_fake_script() -- SetActivation.Script 
	local script = Instance.new('Script', SetActivation)

		script.Parent.MouseButton1Down:connect(function()	
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = script.Parent.Parent.WalkspeedTB.Text	
		end)
end
coroutine.wrap(WLZBXL_fake_script)()
local function YRYWA_fake_script() -- ResetActivation.Script 
	local script = Instance.new('Script', ResetActivation)

		script.Parent.MouseButton1Down:connect(function()	
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
		script.Parent.Parent.WalkspeedTB.Text = ""
		end)
end
coroutine.wrap(YRYWA_fake_script)()
local function CFCRCM_fake_script() -- SetActivation_2.Script 
	local script = Instance.new('Script', SetActivation_2)

		script.Parent.MouseButton1Down:connect(function()	
			game.Players.LocalPlayer.Character.Humanoid.JumpPower = script.Parent.Parent.JumpPowerTB.Text	
		end)
end
coroutine.wrap(CFCRCM_fake_script)()
local function PDGD_fake_script() -- ResetActivation_2.Script 
	local script = Instance.new('Script', ResetActivation_2)

		script.Parent.MouseButton1Down:connect(function()	
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 48
		script.Parent.Parent.JumpPowerTB.Text = ""
		end)
end
coroutine.wrap(PDGD_fake_script)()
local function SPNLPQB_fake_script() -- Activation_3.Script 
	local script = Instance.new('Script', Activation_3)

	local Mouse = game.Players.LocalPlayer:GetMouse()
	local InfiniteJump = false
	
	script.Parent.MouseButton1Down:connect(function()
		if InfiniteJump == false then
			InfiniteJump = true
			script.Parent.BackgroundColor3 = Color3.fromRGB(52, 255, 52)
		else
			InfiniteJump = false
			script.Parent.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
		end
	end)
	
	Mouse.KeyDown:Connect(function(k)
		if k == "v" then
			if InfiniteJump == false then
				InfiniteJump = true
				script.Parent.BackgroundColor3 = Color3.fromRGB(52, 255, 52)
			else
				InfiniteJump = false
				script.Parent.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
			end	
		end
	end)
	
	game:GetService("UserInputService").JumpRequest:connect(function()
		if InfiniteJump == true then
			game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
		end
	end)
end
coroutine.wrap(SPNLPQB_fake_script)()
local function YFSUJW_fake_script() -- Activation_4.Script 
	local script = Instance.new('Script', Activation_4)

		local toggle = false
		
		script.Parent.MouseButton1Click:Connect(function()	
			if toggle == false then
				toggle = true
				script.Parent.BackgroundColor3 = Color3.fromRGB(52, 255, 52)
			else
				toggle = false
				script.Parent.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
			end
			
			while toggle do wait(.25)
				local place = workspace:GetChildren()	
				local currentX = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X
				local currentY = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y
				local currentZ = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z
				
				for i,v in pairs(place) do	    
				    local vChildren = v:GetChildren()
				    for i,child in pairs(vChildren) do
				        if child.Name == "CoinContainer" then
				            
							if child.Coin_Server:FindFirstChild("Coin") ~= nil then
					            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = child.Coin_Server.Coin.CFrame
							else
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(currentX, currentY, currentZ)
								script.Parent.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
								toggle = false
							end
				
				        end
				    end	
				end
			end
			
		end)
end
coroutine.wrap(YFSUJW_fake_script)()
local function CKAW_fake_script() -- Activation_5.Script 
	local script = Instance.new('Script', Activation_5)

	local obj = game.workspace
	function XrayOn(obj) --Enables xray
	    for _,v in pairs(obj:GetChildren()) do
	        if (v:IsA("BasePart")) and not v.Parent:FindFirstChild("Humanoid") then
	            v.LocalTransparencyModifier = 0.75
	        end
	    XrayOn(v)
	    end
	end
	 
	function XrayOff(obj) --Disables xray
	    for _,v in pairs(obj:GetChildren()) do
	        if (v:IsA("BasePart")) and not v.Parent:FindFirstChild("Humanoid") then
	            v.LocalTransparencyModifier = 0
	        end XrayOff(v)
	    end
	end
	
	local toggle = false
		
		script.Parent.MouseButton1Click:Connect(function()	
			if toggle == false then
				toggle = true
			script.Parent.BackgroundColor3 = Color3.fromRGB(52, 255, 52)
			XrayOn(obj)
			else
				toggle = false
			script.Parent.BackgroundColor3 = Color3.fromRGB(255, 51, 51)
			XrayOff(obj)
		end
	end)
end
coroutine.wrap(CKAW_fake_script)()
local function NJKYNZM_fake_script() -- Activation_6.Script 
	local script = Instance.new('Script', Activation_6)

	script.Parent.MouseButton1Down:Connect(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/MarsQQ/ScriptHubScripts/master/MM2Autofarm"))();
	end)
end
coroutine.wrap(NJKYNZM_fake_script)()
local function QHWFTYB_fake_script() -- Activation_7.Script 
	local script = Instance.new('Script', Activation_7)

	
	local function GetMurderer()
	    local plrs = game:GetService("Players")
	    for i,v in pairs(plrs:GetPlayers()) do
	        if v.Character:FindFirstChild("Knife") or v.Backpack:FindFirstChild("Knife") then
	            return v
	        end
	    end
	end
	script.Parent.MouseButton1Click:Connect(function()
	local Murderer = GetMurderer() --// Gets the userdata of the murderer
		local pos = Murderer.Character.HumanoidRootPart.Position
	repeat
	    if Murderer ~= nil then --// Checking if there actually is a murderer
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Murderer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
				workspace.CurrentCamera.CFrame = Murderer.Character.HumanoidRootPart.CFrame
				
			end
	    wait()
		until Murderer.Character.Humanoid.Health == 0
		end)
	
end
coroutine.wrap(QHWFTYB_fake_script)()
local function PIWZ_fake_script() -- Activation_8.Script 
	local script = Instance.new('Script', Activation_8)

		script.Parent.MouseButton1Click:Connect(function()
			
			local currentX = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X
			local currentY = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y
			local currentZ = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z	
			
			if workspace:FindFirstChild("GunDrop") ~= nil then
			
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("GunDrop").CFrame	
			wait(.25)	
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(currentX, currentY, currentZ)
				
			else
				
			    game.StarterGui:SetCore("SendNotification", {
	    Title = "MM2 Admin Panel - CHEATER.FUN";
	    Text = "Wait for the Sheriff's death to grab the gun";
	    Icon = "";
	    Duration = "2";
	})
				
			end	
		end)
end
coroutine.wrap(PIWZ_fake_script)()
local function GTOJAZG_fake_script() -- Activation_9.Script 
	local script = Instance.new('Script', Activation_9)

	script.Parent.MouseButton1Click:Connect(function()
		    	local Players = game:GetService("Players")	
			    for i, Victim in pairs(Players:GetPlayers()) do
			        if Victim.Name ~= game.Players.LocalPlayer.Name then
			
			            repeat wait()
			                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Victim.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
			            until
				                Victim.Character.Humanoid.Health == 0
				end
			end
		end)
end
coroutine.wrap(GTOJAZG_fake_script)()
local function TJPSA_fake_script() -- Activation_10.Script 
	local script = Instance.new('Script', Activation_10)

	script.Parent.MouseButton1Down:Connect(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/MarsQQ/ScriptHubScripts/master/FPS%20Boost"))();
	end)
end
coroutine.wrap(TJPSA_fake_script)()
local function FGLRVKA_fake_script() -- AimTB.LocalScript 
	local script = Instance.new('LocalScript', AimTB)

	script.Parent.FocusLost:connect(function()
		for i,v in pairs(game.Players:GetChildren()) do
			if (string.sub(string.lower(v.Name),1,string.len(script.Parent.Text))) == string.lower(script.Parent.Text) then
				script.Parent.Text = v.Name
			end
		end
	end)
	
end
coroutine.wrap(FGLRVKA_fake_script)()
local function LZHKGTA_fake_script() -- AimPlayer.Script 
	local script = Instance.new('Script', AimPlayer)

	script.Parent.AimActivation.MouseButton1Click:Connect(function()
		_G.on = true
		local user = script.Parent.AimTB.Text
		local plr = game.Players.LocalPlayer
		while _G.on == true do
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				if v.Character:FindFirstChild("HumanoidRootPart") and v.Name == user then
					repeat
						local pos = v.Character.HumanoidRootPart.Position
						workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position,pos)
						wait()
					until v.Character.Humanoid.Health < 1 or _G.on == false
				end
			end
		end
	end)
	
	script.Parent.DeAimActivation.MouseButton1Click:Connect(function()
		_G.on = false
	end)
end
coroutine.wrap(LZHKGTA_fake_script)()
local function MVWHPW_fake_script() -- VisualFrame.Script1 
	local script = Instance.new('Script', VisualFrame)

	local ESPToggle = false
	
	local plrs = game:GetService("Players")
	local faces = {"Back","Bottom","Front","Left","Right","Top"}
	function MakeESP()
		for _, v in pairs(game.Players:GetChildren()) do if v.Name ~= game.Players.LocalPlayer.Name then
				local bgui = Instance.new("BillboardGui",v.Character.Head)
				bgui.Name = ("EGUI")
				bgui.AlwaysOnTop = true
				bgui.ExtentsOffset = Vector3.new(0,2,0)
				bgui.Size = UDim2.new(0,200,0,50)
				local nam = Instance.new("TextLabel",bgui)
				nam.Text = v.Name
				nam.BackgroundTransparency = 1
				nam.TextSize = 15
				nam.Font = ("GothamBold")
				nam.TextColor3 = Color3.new(255,255,255)
				nam.Size = UDim2.new(0,200,0,50)
				if v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
					for _, p in pairs(v.Character:GetChildren()) do
						if p.Name == ("Head") or p.Name == ("Torso") or p.Name == ("Right Arm") or p.Name == ("Right Leg") or p.Name == ("Left Arm") or p.Name == ("Left Leg") then 
							for _, f in pairs(faces) do
								local m = Instance.new("SurfaceGui",p)
								m.Name = ("EGUI")
								m.Face = f
								m.AlwaysOnTop = true
								local mf = Instance.new("Frame",m)
								mf.Size = UDim2.new(1,0,1,0)
								mf.BorderSizePixel = 0
								mf.BackgroundTransparency = 0.5
								mf.BackgroundColor3 = Color3.new(0,0,255)
							end
						end
					end
				elseif v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
					for _, p in pairs(v.Character:GetChildren()) do
						if p.Name == ("Head") or p.Name == ("Torso") or p.Name == ("Right Arm") or p.Name == ("Right Leg") or p.Name == ("Left Arm") or p.Name == ("Left Leg") then 
							for _, f in pairs(faces) do
								local m = Instance.new("SurfaceGui",p)
								m.Name = ("EGUI")
								m.Face = f
								m.AlwaysOnTop = true
								local mf = Instance.new("Frame",m)
								mf.Size = UDim2.new(1,0,1,0)
								mf.BorderSizePixel = 0
								mf.BackgroundTransparency = 0.5
								mf.BackgroundColor3 = Color3.new(255,0,0)
							end
						end
					end
				else
					for _, p in pairs(v.Character:GetChildren()) do
						if p.Name == ("Head") or p.Name == ("Torso") or p.Name == ("Right Arm") or p.Name == ("Right Leg") or p.Name == ("Left Arm") or p.Name == ("Left Leg") then 
							for _, f in pairs(faces) do
								local m = Instance.new("SurfaceGui",p)
								m.Name = ("EGUI")
								m.Face = f
								m.AlwaysOnTop = true
								local mf = Instance.new("Frame",m)
								mf.Size = UDim2.new(1,0,1,0)
								mf.BorderSizePixel = 0
								mf.BackgroundTransparency = 0.5
								mf.BackgroundColor3 = Color3.new(255,255,255)
							end
						end
					end
				end
			end
		end
	end
	
	function ClearESP()
		for _, v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == ("EGUI") then
				v:Remove()
			end
		end
	end
	
	script.Parent.AllESP.Activation.MouseButton1Click:Connect(function()
			if ESPToggle == false then
				ESPToggle = true
				pcall(ClearESP)
				pcall(MakeESP)
			else
				ESPToggle = false
				pcall(ClearESP)
			end
		end)
	script.Parent.RefreshESP.Activation.MouseButton1Click:Connect(function()
			if ESPToggle == true then
			wait(1)
			pcall(ClearESP)
			pcall(MakeESP)
		end
	end)
	
	
	game:GetService("Players").PlayerAdded:Connect(function(v)
		if ESPToggle == true then
			wait(1)
			pcall(ClearESP)
			pcall(MakeESP)
		end
	end)
	
	game:GetService("Players").PlayerRemoving:Connect(function(v)
		if ESPToggle == true then
			wait(1)
			pcall(ClearESP)
			pcall(MakeESP)
		end
	end)
	
	while wait(60) do
		if ESPToggle == true then
			wait(1)
			pcall(ClearESP)
			pcall(MakeESP)
		end
	end
	
	
end
coroutine.wrap(MVWHPW_fake_script)()
local function OVVPNM_fake_script() -- Activation_13.Script 
	local script = Instance.new('Script', Activation_13)

		script.Parent.MouseButton1Click:Connect(function()
			
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108.5, 145, 0.6)
			
		end)
end
coroutine.wrap(OVVPNM_fake_script)()
local function ODJNX_fake_script() -- Activation_14.Script 
	local script = Instance.new('Script', Activation_14)

		script.Parent.MouseButton1Click:Connect(function()	
			local Workplace = workspace:GetChildren()
			
			for i, Thing in pairs(Workplace) do
			
			    local ThingChildren = Thing:GetChildren()
			    for i, Child in pairs(ThingChildren) do
			        if Child.Name == "Spawns" then
			           
			           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Child.Spawn.CFrame
			
			        end
			    end
			end
		end)
end
coroutine.wrap(ODJNX_fake_script)()
local function CQNKW_fake_script() -- TeleportTB.LocalScript 
	local script = Instance.new('LocalScript', TeleportTB)

	script.Parent.FocusLost:connect(function()
		for i,v in pairs(game.Players:GetChildren()) do
			if (string.sub(string.lower(v.Name),1,string.len(script.Parent.Text))) == string.lower(script.Parent.Text) then
				script.Parent.Text = v.Name
			end
		end
	end)
	
end
coroutine.wrap(CQNKW_fake_script)()
local function XYYM_fake_script() -- TeleportButton.LocalScript 
	local script = Instance.new('LocalScript', TeleportButton)

		script.Parent.MouseButton1Click:Connect(function()	
		
			local Victim = script.Parent.Parent.TeleportTB.Text
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[Victim].Character.HumanoidRootPart.CFrame 
		
		end)
end
coroutine.wrap(XYYM_fake_script)()
local function JZRZ_fake_script() -- Activation_15.Script 
	local script = Instance.new('Script', Activation_15)

		script.Parent.MouseButton1Click:Connect(function()	
			local Players = game:GetService("Players")			
			for i, player in pairs(Players:GetPlayers()) do
				
			    local bp = player.Backpack:GetChildren()
			    for i, tool in pairs(bp) do
			        if tool.Name == "Knife" then
													
				    	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[tool.Parent.Parent.Name].Character.HumanoidRootPart.CFrame
				
					end
				end
			
			end
		end)
end
coroutine.wrap(JZRZ_fake_script)()
local function KFEOGB_fake_script() -- Activation_16.Script 
	local script = Instance.new('Script', Activation_16)

		script.Parent.MouseButton1Click:Connect(function()	
			local Players = game:GetService("Players")			
			for i, player in pairs(Players:GetPlayers()) do
				
			    local bp = player.Backpack:GetChildren()
			    for i, tool in pairs(bp) do
			        if tool.Name == "Gun" then
													
				    	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[tool.Parent.Parent.Name].Character.HumanoidRootPart.CFrame
				
					end
				end
			
			end
		end)
end
coroutine.wrap(KFEOGB_fake_script)()
local function JIPBTDH_fake_script() -- BottomFrame.LocalScript 
	local script = Instance.new('LocalScript', BottomFrame)

	script.Parent.Tab1.MouseButton1Click:Connect(function()
		script.Parent.MainFrame.Visible = true
		script.Parent.PlayerFrame.Visible = false
		script.Parent.VisualFrame.Visible = false
		script.Parent.TeleportFrame.Visible = false
		script.Parent.Tab1.BackgroundColor3 = Color3.fromRGB(30,30,30)
		script.Parent.Tab2.BackgroundColor3 = Color3.fromRGB(20,20,20)
		script.Parent.Tab3.BackgroundColor3 = Color3.fromRGB(20,20,20)
		script.Parent.Tab4.BackgroundColor3 = Color3.fromRGB(20,20,20)
	end)
	script.Parent.Tab2.MouseButton1Click:Connect(function()
		script.Parent.MainFrame.Visible = false
		script.Parent.PlayerFrame.Visible = true
		script.Parent.VisualFrame.Visible = false
		script.Parent.TeleportFrame.Visible = false
		script.Parent.Tab1.BackgroundColor3 = Color3.fromRGB(20,20,20)
		script.Parent.Tab2.BackgroundColor3 = Color3.fromRGB(30,30,30)
		script.Parent.Tab3.BackgroundColor3 = Color3.fromRGB(20,20,20)
		script.Parent.Tab4.BackgroundColor3 = Color3.fromRGB(20,20,20)
	end)
	script.Parent.Tab3.MouseButton1Click:Connect(function()
		script.Parent.MainFrame.Visible = false
		script.Parent.PlayerFrame.Visible = false
		script.Parent.VisualFrame.Visible = true
		script.Parent.TeleportFrame.Visible = false
		script.Parent.Tab1.BackgroundColor3 = Color3.fromRGB(20,20,20)
		script.Parent.Tab2.BackgroundColor3 = Color3.fromRGB(20,20,20)
		script.Parent.Tab3.BackgroundColor3 = Color3.fromRGB(30,30,30)
		script.Parent.Tab4.BackgroundColor3 = Color3.fromRGB(20,20,20)
	end)
	script.Parent.Tab4.MouseButton1Click:Connect(function()
		script.Parent.MainFrame.Visible = false
		script.Parent.PlayerFrame.Visible = false
		script.Parent.VisualFrame.Visible = false
		script.Parent.TeleportFrame.Visible = true
		script.Parent.Tab1.BackgroundColor3 = Color3.fromRGB(20,20,20)
		script.Parent.Tab2.BackgroundColor3 = Color3.fromRGB(20,20,20)
		script.Parent.Tab3.BackgroundColor3 = Color3.fromRGB(20,20,20)
		script.Parent.Tab4.BackgroundColor3 = Color3.fromRGB(30,30,30)
	end)
end
coroutine.wrap(JIPBTDH_fake_script)()
local function AVLOK_fake_script() -- MinimizeButton.LocalScript 
	local script = Instance.new('LocalScript', MinimizeButton)

	local minimize = false
	
	script.Parent.MouseButton1Click:connect(function()
		if minimize == false then
			minimize = true
			script.Parent.Parent.Parent.BottomFrame:TweenPosition(UDim2.new(0.5,0,-0.5,0), "Out", "Quad", 0.5, true)
		else
			minimize = false
			script.Parent.Parent.Parent.BottomFrame:TweenPosition(UDim2.new(0.5,0,0.5,0), "Out", "Quad", 0.5, true)
		end
	end)
	
end
coroutine.wrap(AVLOK_fake_script)()
    print("Скрипт 9 активирован")
end)

-- ВСТАВЬ СВОЙ СКРИПТ СЮДА (под кнопкой Скрипт 10):
ScriptButtons2[2].MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()
    print("Скрипт 10 активирован")
end)

-- ВСТАВЬ СВОЙ СКРИПТ СЮДА (под кнопкой Скрипт 11):
ScriptButtons2[3].MouseButton1Click:Connect(function()
    -- ТВОЙ СКРИПТ ДЛЯ КНОПКИ 11 ЗДЕСЬ
    print("Скрипт 11 активирован")
end)

-- ВСТАВЬ СВОЙ СКРИПТ СЮДА (под кнопкой Скрипт 12):
ScriptButtons2[4].MouseButton1Click:Connect(function()
    -- ТВОЙ СКРИПТ ДЛЯ КНОПКИ 12 ЗДЕСЬ
    print("Скрипт 12 активирован")
end)

-- ВСТАВЬ СВОЙ СКРИПТ СЮДА (под кнопкой Скрипт 13):
ScriptButtons2[5].MouseButton1Click:Connect(function()
    -- ТВОЙ СКРИПТ ДЛЯ КНОПКИ 13 ЗДЕСЬ
    print("Скрипт 13 активирован")
end)

-- Уведомление при загрузке
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "KBupT Menu",
    Text = "Меню загружено! Нажми на утку",
    Duration = 5
})
