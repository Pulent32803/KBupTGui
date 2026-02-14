local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Delta Ultimate Script by Gemini",
   LoadingTitle = "Загрузка скрипта...",
   LoadingSubtitle = "by Gemini AI",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, 
      FileName = "BigHub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvuelink", 
      RememberJoins = true 
   },
   KeySystem = false, 
})

-- === ПЕРЕМЕННЫЕ ===
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local SelectedPlayer = nil -- Для выбора игрока из списка

-- === ФУНКЦИИ ===

-- Обновление списка игроков
local function GetPlayerNames()
    local names = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(names, p.Name)
        end
    end
    return names
end

-- Fly Функция
local flying = false
local speed = 50
local function ToggleFly(state)
    flying = state
    if flying then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"
        bv.Parent = LocalPlayer.Character.HumanoidRootPart
        bv.MaxForce = Vector3.new(100000, 100000, 100000)
        bv.Velocity = Vector3.new(0,0,0)
        
        local bg = Instance.new("BodyGyro")
        bg.Name = "FlyGyro"
        bg.Parent = LocalPlayer.Character.HumanoidRootPart
        bg.MaxTorque = Vector3.new(100000, 100000, 100000)
        bg.P = 10000
        bg.D = 1000
        
        while flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0 do
            RunService.RenderStepped:Wait()
            if not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then break end
            
            local camCF = Camera.CFrame
            bv.Velocity = Vector3.new(0,0,0)
            bg.CFrame = camCF
            
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                bv.Velocity = camCF.LookVector * speed
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                bv.Velocity = -camCF.LookVector * speed
            end
        end
        bv:Destroy()
        bg:Destroy()
    else
        pcall(function()
            LocalPlayer.Character.HumanoidRootPart.FlyVelocity:Destroy()
            LocalPlayer.Character.HumanoidRootPart.FlyGyro:Destroy()
        end)
    end
end

-- === TABS (ВКЛАДКИ) ===

local TabMain = Window:CreateTab("Персонаж", 4483362458) -- Вкладка настроек себя
local TabPlayers = Window:CreateTab("Игроки", 4483362458) -- Взаимодействие
local TabVisuals = Window:CreateTab("Визуал", 4483362458) -- ESP и прочее
local TabMisc = Window:CreateTab("Разное (+15)", 4483362458) -- Куча фич

-- === Вкладка 1: ПЕРСОНАЖ ===

TabMain:CreateSlider({
   Name = "Скорость (WalkSpeed)",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeedSlider", 
   Callback = function(Value)
        if LocalPlayer.Character then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
   end,
})

TabMain:CreateSlider({
   Name = "Высота Прыжка (JumpPower)",
   Range = {50, 500},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpPowerSlider", 
   Callback = function(Value)
        if LocalPlayer.Character then
            LocalPlayer.Character.Humanoid.UseJumpPower = true
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
   end,
})

TabMain:CreateToggle({
   Name = "Полет (Fly) - Управление WASD/Камерой",
   CurrentValue = false,
   Flag = "FlyToggle", 
   Callback = function(Value)
       ToggleFly(Value)
   end,
})

TabMain:CreateSlider({
   Name = "Скорость полета",
   Range = {10, 200},
   Increment = 10,
   CurrentValue = 50,
   Callback = function(Value)
       speed = Value
   end,
})

TabMain:CreateToggle({
   Name = "Noclip (Проход сквозь стены)",
   CurrentValue = false,
   Callback = function(Value)
       local connection
       if Value then
           connection = RunService.Stepped:Connect(function()
               for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                   if part:IsA("BasePart") then
                       part.CanCollide = false
                   end
               end
           end)
       else
           if connection then connection:Disconnect() end
       end
   end,
})

TabMain:CreateToggle({
   Name = "Infinite Jump (Беск. прыжки)",
   CurrentValue = false,
   Callback = function(Value)
       game:GetService("UserInputService").JumpRequest:Connect(function()
           if Value then
               LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
           end
       end)
   end,
})


-- === Вкладка 2: ИГРОКИ (Teleport, Target) ===

local PlayerDropdown = TabPlayers:CreateDropdown({
   Name = "Выбери игрока",
   Options = GetPlayerNames(),
   CurrentOption = "",
   Flag = "PlayerSelector", 
   Callback = function(Option)
       SelectedPlayer = Players[Option[1]]
   end,
})

TabPlayers:CreateButton({
   Name = "Обновить список игроков",
   Callback = function()
       PlayerDropdown:Refresh(GetPlayerNames(), true)
   end,
})

TabPlayers:CreateButton({
   Name = "Телепорт к игроку",
   Callback = function()
       if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
           LocalPlayer.Character.HumanoidRootPart.CFrame = SelectedPlayer.Character.HumanoidRootPart.CFrame
       end
   end,
})

TabPlayers:CreateButton({
   Name = "Spectate (Следить за игроком)",
   Callback = function()
       if SelectedPlayer then
           Camera.CameraSubject = SelectedPlayer.Character.Humanoid
       end
   end,
})

TabPlayers:CreateButton({
   Name = "Вернуть камеру (Stop Spectate)",
   Callback = function()
       Camera.CameraSubject = LocalPlayer.Character.Humanoid
   end,
})

TabPlayers:CreateToggle({
   Name = "Simple AimLock (Камера на голову)",
   CurrentValue = false,
   Callback = function(Value)
       getgenv().AimLock = Value
       
       RunService.RenderStepped:Connect(function()
           if getgenv().AimLock and SelectedPlayer and SelectedPlayer.Character then
               local head = SelectedPlayer.Character:FindFirstChild("Head")
               if head then
                   Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
               end
           end
       end)
   end,
})

-- === Вкладка 3: ВИЗУАЛ (ESP, Chams) ===

TabVisuals:CreateToggle({
   Name = "ESP (Highlight Chams)",
   CurrentValue = false,
   Callback = function(Value)
       getgenv().ESPEnabled = Value
       
       if Value then
           -- Loop to add highlight
           spawn(function()
               while getgenv().ESPEnabled do
                   for _, p in pairs(Players:GetPlayers()) do
                       if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("ESPHighlight") then
                           local hl = Instance.new("Highlight")
                           hl.Name = "ESPHighlight"
                           hl.Parent = p.Character
                           hl.FillColor = Color3.fromRGB(255, 0, 0)
                           hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                           hl.FillTransparency = 0.5
                           hl.OutlineTransparency = 0
                       end
                   end
                   wait(1)
               end
           end)
       else
           -- Remove all highlights
           for _, p in pairs(Players:GetPlayers()) do
               if p.Character and p.Character:FindFirstChild("ESPHighlight") then
                   p.Character.ESPHighlight:Destroy()
               end
           end
       end
   end,
})

TabVisuals:CreateButton({
   Name = "Fullbright (Светло везде)",
   Callback = function()
       game:GetService("Lighting").Brightness = 2
       game:GetService("Lighting").ClockTime = 14
       game:GetService("Lighting").FogEnd = 100000
       game:GetService("Lighting").GlobalShadows = false
       game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
   end,
})

-- === Вкладка 4: РАЗНОЕ (+15 ФИЧ) ===

-- 1. Anti-AFK
TabMisc:CreateButton({
   Name = "Anti-AFK (Не кикнет)",
   Callback = function()
       local vu = game:GetService("VirtualUser")
       LocalPlayer.Idled:connect(function()
           vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
           wait(1)
           vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
       end)
       Rayfield:Notify({Title = "Success", Content = "Anti-AFK включен!", Duration = 3})
   end,
})

-- 2. FPS Booster
TabMisc:CreateButton({
   Name = "FPS Booster (Удалить текстуры)",
   Callback = function()
       for _,v in pairs(game:GetDescendants()) do
           if v:IsA("Texture") or v:IsA("Decal") then
               v:Destroy()
           end
       end
   end,
})

-- 3. Rejoin
TabMisc:CreateButton({
   Name = "Перезайти (Rejoin)",
   Callback = function()
       game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
   end,
})

-- 4. Server Hop
TabMisc:CreateButton({
   Name = "Сменить сервер (Server Hop)",
   Callback = function()
       local Http = game:GetService("HttpService")
       local TPS = game:GetService("TeleportService")
       local Api = "https://games.roblox.com/v1/games/"
       local _place = game.PlaceId
       local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
       
       local function ListServers(cursor)
          local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
          return Http:JSONDecode(Raw)
       end
       
       local Server, Next; repeat
          local Servers = ListServers(Next)
          Server = Servers.data[1]
          Next = Servers.nextPageCursor
       until Server
       
       TPS:TeleportToPlaceInstance(_place, Server.id, LocalPlayer)
   end,
})

-- 5. FOV Slider
TabMisc:CreateSlider({
   Name = "FOV (Угол обзора)",
   Range = {70, 120},
   Increment = 1,
   CurrentValue = 70,
   Callback = function(Value)
       workspace.CurrentCamera.FieldOfView = Value
   end,
})

-- 6. Instant Proximity Prompt
TabMisc:CreateToggle({
   Name = "Быстрое взаимодействие (E)",
   CurrentValue = false,
   Callback = function(Value)
       getgenv().InstaPrompt = Value
       spawn(function()
           while getgenv().InstaPrompt do
               for _, v in pairs(workspace:GetDescendants()) do
                   if v:IsA("ProximityPrompt") then
                       v.HoldDuration = 0
                   end
               end
               wait(1)
           end
       end)
   end,
})

-- 7. Suicide
TabMisc:CreateButton({
   Name = "Reset Character (Умереть)",
   Callback = function()
       LocalPlayer.Character:BreakJoints()
   end,
})

-- 8. SpinBot
TabMisc:CreateToggle({
   Name = "SpinBot (Крутилка)",
   CurrentValue = false,
   Callback = function(Value)
       getgenv().Spin = Value
       local bg = Instance.new("BodyGyro", LocalPlayer.Character.HumanoidRootPart)
       bg.MaxTorque = Vector3.new(0, math.huge, 0)
       bg.P = 10000
       
       spawn(function()
           while getgenv().Spin do
               if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                   bg.CFrame = bg.CFrame * CFrame.Angles(0, math.rad(30), 0)
               end
               wait()
           end
           bg:Destroy()
       end)
   end,
})

-- 9. Sit
TabMisc:CreateButton({
   Name = "Сесть (Sit)",
   Callback = function()
       LocalPlayer.Character.Humanoid.Sit = true
   end,
})

-- 10. X-Ray (Simple)
TabMisc:CreateToggle({
   Name = "X-Ray (Прозрачные стены)",
   CurrentValue = false,
   Callback = function(Value)
       for _, v in pairs(workspace:GetDescendants()) do
           if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
               v.Transparency = Value and 0.5 or 0
           end
       end
   end,
})

-- 11. Low Gravity
TabMisc:CreateButton({
   Name = "Low Gravity (Гравитация)",
   Callback = function()
       workspace.Gravity = 50
   end,
})

-- 12. Normal Gravity
TabMisc:CreateButton({
   Name = "Reset Gravity",
   Callback = function()
       workspace.Gravity = 196.2
   end,
})

-- 13. Ctrl + Click TP
TabMisc:CreateToggle({
    Name = "Ctrl + Click TP",
    CurrentValue = false,
    Callback = function(Value)
        local Mouse = LocalPlayer:GetMouse()
        if Value then
            Mouse.Button1Down:Connect(function()
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) and Mouse.Target then
                    LocalPlayer.Character:MoveTo(Mouse.Hit.p)
                end
            end)
        end
    end,
})

-- 14. Remove Fog
TabMisc:CreateButton({
   Name = "Убрать туман",
   Callback = function()
       game.Lighting.FogEnd = 1000000
   end,
})

-- 15. Unload UI
TabMisc:CreateButton({
   Name = "Закрыть/Удалить GUI",
   Callback = function()
       Rayfield:Destroy()
   end,
})

Rayfield:Notify({
   Title = "Скрипт Загружен!",
   Content = "Приятной игры на Delta.",
   Duration = 5,
   Image = 4483362458,
})
