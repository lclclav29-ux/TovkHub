local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

if CoreGui:FindFirstChild("TockHubPineapple") then
    CoreGui.TockHubPineapple:Destroy()
end

-- ==========================================
-- Конфигурация и Ссылки
-- ==========================================
local Config = {
    SpeedBypass = false,
    SpeedMult = 1.5,
    JumpBypass = false,
    JumpForce = 50,
    NoclipBypass = false,
    FlyBypass = false,
    FlySpeed = 50,
    HitboxBypass = false,
    HitboxSize = 6,
    ESPBypass = false
}

local Links = {
    Discord = "https://discord.gg/yourlink",
    Telegram = "https://t.me/yourlink",
    YouTube = "https://www.youtube.com/@HOBONI-f9t"
}

local AccentColor = Color3.fromRGB(255, 180, 40)

local function GetChar() return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait() end
local function GetHRP() local c = GetChar() return c and c:FindFirstChild("HumanoidRootPart") end
local function GetHum() local c = GetChar() return c and c:FindFirstChildOfClass("Humanoid") end

local function Tween(obj, time, prop)
    TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), prop):Play()
end

local function OpenLink(url)
    local setClipboardFunc = setclipboard or toclipboard or (syn and syn.write_clipboard)
    if setClipboardFunc then
        setClipboardFunc(url)
    end
end

-- ==========================================
-- Главное Окно
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TockHubPineapple"
ScreenGui.ResetOnSpawn = false
if gethui then ScreenGui.Parent = gethui() else ScreenGui.Parent = CoreGui end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 460, 0, 320)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 17, 22)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.Transparency = 0.92
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

-- Боковая панель (Sidebar)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 140, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 13, 17)
Sidebar.BackgroundTransparency = 0.2
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

-- Хедер с ананасом
local HeaderContainer = Instance.new("Frame")
HeaderContainer.Size = UDim2.new(1, -16, 0, 32)
HeaderContainer.Position = UDim2.new(0, 8, 0, 10)
HeaderContainer.BackgroundTransparency = 1
HeaderContainer.Parent = Sidebar

local PineappleIcon = Instance.new("ImageLabel")
PineappleIcon.Size = UDim2.new(0, 26, 0, 26)
PineappleIcon.Position = UDim2.new(0, 2, 0.5, -13)
PineappleIcon.BackgroundTransparency = 1
PineappleIcon.Image = "rbxassetid://6023426915"
PineappleIcon.ImageColor3 = AccentColor
PineappleIcon.Parent = HeaderContainer

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, -32, 1, 0)
LogoText.Position = UDim2.new(0, 32, 0, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "TOCK<font color='#FFB428'>.H</font>"
LogoText.RichText = true
LogoText.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoText.TextSize = 12
LogoText.Font = Enum.Font.GothamBold
LogoText.TextXAlignment = Enum.TextXAlignment.Left
LogoText.Parent = HeaderContainer

-- Навигация
local NavList = Instance.new("Frame")
NavList.Size = UDim2.new(1, -16, 0, 160)
NavList.Position = UDim2.new(0, 8, 0, 52)
NavList.BackgroundTransparency = 1
NavList.Parent = Sidebar

local NavLayout = Instance.new("UIListLayout")
NavLayout.SortOrder = Enum.SortOrder.LayoutOrder
NavLayout.Padding = UDim.new(0, 4)
NavLayout.Parent = NavList

-- Блок Соцсетей внизу
local SocialsFrame = Instance.new("Frame")
SocialsFrame.Size = UDim2.new(1, -16, 0, 32)
SocialsFrame.Position = UDim2.new(0, 8, 1, -42)
SocialsFrame.BackgroundTransparency = 1
SocialsFrame.Parent = Sidebar

local SocialsLayout = Instance.new("UIListLayout")
SocialsLayout.FillDirection = Enum.FillDirection.Horizontal
SocialsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SocialsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
SocialsLayout.Padding = UDim.new(0, 4)
SocialsLayout.Parent = SocialsFrame

local function CreateSocialBtn(iconId, url, hoverColor)
    local Btn = Instance.new("ImageButton")
    Btn.Size = UDim2.new(0, 26, 0, 26)
    Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Btn.BackgroundTransparency = 0.95
    Btn.Image = iconId
    Btn.ImageColor3 = Color3.fromRGB(180, 180, 190)
    Btn.Parent = SocialsFrame

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    Btn.MouseEnter:Connect(function()
        Tween(Btn, 0.2, {BackgroundTransparency = 0.85, ImageColor3 = hoverColor})
    end)

    Btn.MouseLeave:Connect(function()
        Tween(Btn, 0.2, {BackgroundTransparency = 0.95, ImageColor3 = Color3.fromRGB(180, 180, 190)})
    end)

    Btn.MouseButton1Click:Connect(function()
        OpenLink(url)
    end)
end

CreateSocialBtn("rbxassetid://6031075938", Links.Discord, Color3.fromRGB(114, 137, 218))
CreateSocialBtn("rbxassetid://6023426923", Links.Telegram, Color3.fromRGB(0, 136, 204))
CreateSocialBtn("rbxassetid://6023426915", Links.YouTube, Color3.fromRGB(255, 60, 60))

-- Контейнер для вкладок
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -152, 1, -16)
ContentArea.Position = UDim2.new(0, 146, 0, 8)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local Pages = {}
local function CreatePage()
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    Page.ScrollBarImageTransparency = 0.85
    Page.Visible = false
    Page.Parent = ContentArea

    local Layout = Instance.new("UIListLayout")
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 5)
    Layout.Parent = Page

    return Page
end

Pages.Main = CreatePage()
Pages.Visuals = CreatePage()
Pages.Main.Visible = true

local navTabs = {}
local function AddTab(name, page)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 28)
    Btn.BackgroundColor3 = AccentColor
    Btn.BackgroundTransparency = (#navTabs == 0) and 0.88 or 1
    Btn.Text = "   " .. name
    Btn.TextColor3 = (#navTabs == 0) and AccentColor or Color3.fromRGB(150, 150, 160)
    Btn.TextSize = 11
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Parent = NavList

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    table.insert(navTabs, {Btn = Btn, Page = page})

    Btn.MouseButton1Click:Connect(function()
        for _, tab in pairs(navTabs) do
            tab.Page.Visible = false
            Tween(tab.Btn, 0.2, {BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(150, 150, 160)})
        end
        page.Visible = true
        Tween(Btn, 0.2, {BackgroundTransparency = 0.88, TextColor3 = AccentColor})
    end)
end

AddTab("Movement", Pages.Main)
AddTab("Visuals", Pages.Visuals)

-- ==========================================
-- Элементы управления
-- ==========================================
local function AddToggle(parent, text, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -4, 0, 32)
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BackgroundTransparency = 0.96
    Frame.Parent = parent

    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -45, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(220, 220, 230)
    Label.TextSize = 10
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local Switch = Instance.new("Frame")
    Switch.Size = UDim2.new(0, 28, 0, 14)
    Switch.Position = UDim2.new(1, -36, 0.5, -7)
    Switch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Switch.BackgroundTransparency = 0.85
    Switch.Parent = Frame

    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 10, 0, 10)
    Dot.Position = UDim2.new(0, 2, 0.5, -5)
    Dot.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
    Dot.Parent = Switch

    Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.Parent = Frame

    local active = false
    Btn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            Tween(Dot, 0.2, {Position = UDim2.new(1, -12, 0.5, -5), BackgroundColor3 = Color3.fromRGB(20, 20, 20)})
            Tween(Switch, 0.2, {BackgroundTransparency = 0.1, BackgroundColor3 = AccentColor})
        else
            Tween(Dot, 0.2, {Position = UDim2.new(0, 2, 0.5, -5), BackgroundColor3 = Color3.fromRGB(180, 180, 190)})
            Tween(Switch, 0.2, {BackgroundTransparency = 0.85, BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
        end
        callback(active)
    end)
end

local function AddSlider(parent, text, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -4, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BackgroundTransparency = 0.96
    Frame.Parent = parent

    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 0, 18)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(220, 220, 230)
    Label.TextSize = 10
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local Val = Instance.new("TextLabel")
    Val.Size = UDim2.new(0, 35, 0, 18)
    Val.Position = UDim2.new(1, -42, 0, 5)
    Val.BackgroundTransparency = 1
    Val.Text = tostring(default)
    Val.TextColor3 = Color3.fromRGB(150, 150, 160)
    Val.TextSize = 10
    Val.Font = Enum.Font.Gotham
    Val.TextXAlignment = Enum.TextXAlignment.Right
    Val.Parent = Frame

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1, -20, 0, 3)
    Bar.Position = UDim2.new(0, 10, 0, 28)
    Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Bar.BackgroundTransparency = 0.85
    Bar.Parent = Frame

    Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = AccentColor
    Fill.Parent = Bar

    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function Update(input)
        local pos = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        Tween(Fill, 0.05, {Size = UDim2.new(pos, 0, 1, 0)})
        Val.Text = tostring(value)
        callback(value)
    end

    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; Update(input) end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then Update(input) end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

-- ==========================================
-- Вкладки
-- ==========================================
AddToggle(Pages.Main, "Speed Bypass", function(st) Config.SpeedBypass = st end)
AddSlider(Pages.Main, "Speed Multiplier", 1, 5, 2, function(v) Config.SpeedMult = v end)
AddToggle(Pages.Main, "Jump Bypass", function(st) Config.JumpBypass = st end)
AddSlider(Pages.Main, "Jump Force", 30, 150, 60, function(v) Config.JumpForce = v end)
AddToggle(Pages.Main, "Noclip Bypass", function(st) Config.NoclipBypass = st end)
AddToggle(Pages.Main, "Fly Bypass [E]", function(st) Config.FlyBypass = st end)

AddToggle(Pages.Visuals, "CoreGui Safe ESP", function(st) Config.ESPBypass = st end)
AddToggle(Pages.Visuals, "Expand Hitbox", function(st) Config.HitboxBypass = st end)
AddSlider(Pages.Visuals, "Hitbox Size", 2, 25, 6, function(v) Config.HitboxSize = v end)

-- ==========================================
-- Игровая Логика
-- ==========================================
RunService.RenderStepped:Connect(function(delta)
    if Config.SpeedBypass then
        local hrp = GetHRP()
        local hum = GetHum()
        if hrp and hum and hum.MoveDirection.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (Config.SpeedMult * delta * 10))
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Config.JumpBypass then
        local hrp = GetHRP()
        if hrp then hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, Config.JumpForce, hrp.AssemblyLinearVelocity.Z) end
    end
end)

RunService.Stepped:Connect(function()
    if Config.NoclipBypass then
        local char = GetChar()
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

local flyBV, flyBG = nil, nil
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.E and Config.FlyBypass then
        local hrp = GetHRP()
        if hrp then
            if not flyBV then
                flyBV = Instance.new("BodyVelocity")
                flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                flyBV.Velocity = Vector3.zero
                flyBV.Parent = hrp
                
                flyBG = Instance.new("BodyGyro")
                flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                flyBG.CFrame = hrp.CFrame
                flyBG.Parent = hrp
            else
                if flyBV then flyBV:Destroy(); flyBV = nil end
                if flyBG then flyBG:Destroy(); flyBG = nil end
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if flyBV and flyBG then
        local hrp = GetHRP()
        if hrp then
            flyBG.CFrame = Camera.CFrame
            local moveDir = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
            flyBV.Velocity = moveDir * Config.FlySpeed
        end
    end
end)
