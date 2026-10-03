--[[
    ╔═══════════════════════════════════════════╗
    ║         Zazu Library v2.0                 ║
    ║      Advanced UI Library for Roblox       ║
    ╚═══════════════════════════════════════════╝
]]

local Zazu = {}
Zazu.__index = Zazu

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

--// Theme System
local Themes = {
    Dark = {
        Background = Color3.fromRGB(14, 14, 18),
        Surface = Color3.fromRGB(20, 20, 26),
        SurfaceLight = Color3.fromRGB(28, 28, 36),
        Element = Color3.fromRGB(34, 34, 44),
        ElementHover = Color3.fromRGB(42, 42, 54),
        Accent = Color3.fromRGB(147, 112, 255),
        AccentDark = Color3.fromRGB(106, 76, 210),
        AccentGlow = Color3.fromRGB(180, 150, 255),
        Text = Color3.fromRGB(240, 240, 250),
        SubText = Color3.fromRGB(150, 150, 170),
        Muted = Color3.fromRGB(90, 90, 110),
        Stroke = Color3.fromRGB(45, 45, 58),
        StrokeLight = Color3.fromRGB(60, 60, 78),
        Success = Color3.fromRGB(80, 220, 140),
        Warning = Color3.fromRGB(255, 190, 80),
        Error = Color3.fromRGB(255, 90, 100)
    },
    Midnight = {
        Background = Color3.fromRGB(10, 14, 26),
        Surface = Color3.fromRGB(16, 22, 38),
        SurfaceLight = Color3.fromRGB(22, 30, 50),
        Element = Color3.fromRGB(28, 38, 60),
        ElementHover = Color3.fromRGB(36, 48, 74),
        Accent = Color3.fromRGB(80, 160, 255),
        AccentDark = Color3.fromRGB(50, 110, 200),
        AccentGlow = Color3.fromRGB(130, 190, 255),
        Text = Color3.fromRGB(230, 240, 255),
        SubText = Color3.fromRGB(130, 150, 180),
        Muted = Color3.fromRGB(80, 95, 120),
        Stroke = Color3.fromRGB(40, 55, 85),
        StrokeLight = Color3.fromRGB(55, 75, 110),
        Success = Color3.fromRGB(80, 220, 140),
        Warning = Color3.fromRGB(255, 190, 80),
        Error = Color3.fromRGB(255, 90, 100)
    },
    Blood = {
        Background = Color3.fromRGB(18, 10, 12),
        Surface = Color3.fromRGB(26, 14, 18),
        SurfaceLight = Color3.fromRGB(36, 20, 26),
        Element = Color3.fromRGB(44, 24, 30),
        ElementHover = Color3.fromRGB(56, 30, 38),
        Accent = Color3.fromRGB(230, 60, 80),
        AccentDark = Color3.fromRGB(180, 40, 60),
        AccentGlow = Color3.fromRGB(255, 110, 130),
        Text = Color3.fromRGB(250, 235, 240),
        SubText = Color3.fromRGB(170, 140, 150),
        Muted = Color3.fromRGB(110, 80, 90),
        Stroke = Color3.fromRGB(60, 30, 38),
        StrokeLight = Color3.fromRGB(80, 40, 50),
        Success = Color3.fromRGB(80, 220, 140),
        Warning = Color3.fromRGB(255, 190, 80),
        Error = Color3.fromRGB(255, 100, 100)
    }
}

local Config = {
    Font = Enum.Font.Gotham,
    FontMedium = Enum.Font.GothamMedium,
    FontBold = Enum.Font.GothamBold,
    AnimSpeed = 0.18,
    CornerRadius = UDim.new(0, 10),
    ShadowImage = "rbxassetid://5028857084"
}

--// Utility Functions
local function Create(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do
        inst[k] = v
    end
    return inst
end

local function Tween(obj, time, props, style, dir)
    local t = TweenService:Create(
        obj,
        TweenInfo.new(time or Config.AnimSpeed, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out),
        props
    )
    t:Play()
    return t
end

local function Corner(parent, radius)
    return Create("UICorner", {
        CornerRadius = radius or Config.CornerRadius,
        Parent = parent
    })
end

local function Stroke(parent, color, thickness, transparency)
    return Create("UIStroke", {
        Color = color or Color3.new(0, 0, 0),
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent
    })
end

local function Gradient(parent, colorSeq, rotation, transparency)
    return Create("UIGradient", {
        Color = colorSeq or ColorSequence.new(Color3.new(1,1,1), Color3.new(1,1,1)),
        Rotation = rotation or 90,
        Transparency = transparency,
        Parent = parent
    })
end

local function Padding(parent, top, bottom, left, right)
    return Create("UIPadding", {
        PaddingTop = UDim.new(0, top or 0),
        PaddingBottom = UDim.new(0, bottom or 0),
        PaddingLeft = UDim.new(0, left or 0),
        PaddingRight = UDim.new(0, right or 0),
        Parent = parent
    })
end

local function ListLayout(parent, padding, order)
    return Create("UIListLayout", {
        Padding = UDim.new(0, padding or 0),
        SortOrder = order or Enum.SortOrder.LayoutOrder,
        Parent = parent
    })
end

local function AddShadow(parent, size, transparency)
    return Create("ImageLabel", {
        Parent = parent,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, (size or 20) * 2, 1, (size or 20) * 2),
        Position = UDim2.new(0, -(size or 20), 0, -(size or 20)),
        Image = Config.ShadowImage,
        ImageColor3 = Color3.new(0, 0, 0),
        ImageTransparency = transparency or 0.5,
        ZIndex = -1,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(24, 24, 276, 276)
    })
end

local function RippleEffect(button, theme)
    button.ClipsDescendants = true
    button.MouseButton1Down:Connect(function()
        local x, y = Mouse.X - button.AbsolutePosition.X, Mouse.Y - button.AbsolutePosition.Y
        local ripple = Create("Frame", {
            Parent = button,
            BackgroundColor3 = theme.AccentGlow,
            BackgroundTransparency = 0.6,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, x, 0, y),
            ZIndex = 5
        })
        Corner(ripple, UDim.new(1, 0))
        Tween(ripple, 0.5, {
            Size = UDim2.new(0, button.AbsoluteSize.X * 2.5, 0, button.AbsoluteSize.X * 2.5),
            Position = UDim2.new(0, x - button.AbsoluteSize.X * 1.25, 0, y - button.AbsoluteSize.X * 1.25),
            BackgroundTransparency = 1
        }, Enum.EasingStyle.Quad)
        task.delay(0.5, function() ripple:Destroy() end)
    end)
end

local function Draggable(frame, handle)
    handle = handle or frame
    local dragging, dragInput, dragStart, startPos
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

--// Get GUI Parent
local function GetGuiParent()
    local success, result = pcall(function() return CoreGui end)
    if success and result then
        local test = Create("ScreenGui", {Parent = result})
        test:Destroy()
        return result
    end
    return LocalPlayer:WaitForChild("PlayerGui")
end

--// Notification System
function Zazu:Notify(config)
    config = config or {}
    local title = config.Title or "Zazu"
    local text = config.Text or ""
    local duration = config.Duration or 4
    local notifType = config.Type or "Info"
    
    local theme = self.Theme
    local typeColors = {
        Info = theme.Accent,
        Success = theme.Success,
        Warning = theme.Warning,
        Error = theme.Error
    }
    local typeIcons = {
        Info = "ℹ",
        Success = "✓",
        Warning = "⚠",
        Error = "✕"
    }
    
    if not self._NotifContainer then
        self._NotifContainer = Create("Frame", {
            Name = "Notifications",
            Parent = self.ScreenGui,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 320, 1, -40),
            Position = UDim2.new(1, -340, 0, 20),
            ZIndex = 100
        })
        ListLayout(self._NotifContainer, 8, Enum.SortOrder.LayoutOrder)
        Padding(self._NotifContainer, 0, 0, 0, 0)
        self._NotifContainer.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    end
    
    local accentColor = typeColors[notifType] or theme.Accent
    local icon = typeIcons[notifType] or "ℹ"
    
    local notif = Create("Frame", {
        Parent = self._NotifContainer,
        BackgroundColor3 = theme.Surface,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        ClipsDescendants = true,
        AutomaticSize = Enum.AutomaticSize.None
    })
    Corner(notif, UDim.new(0, 10))
    local nStroke = Stroke(notif, theme.Stroke, 1)
    
    local accentBar = Create("Frame", {
        Parent = notif,
        BackgroundColor3 = accentColor,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 3, 1, 0),
        Position = UDim2.new(0, 0, 0, 0)
    })
    Corner(accentBar, UDim.new(0, 10))
    
    local accentCover = Create("Frame", {
        Parent = accentBar,
        BackgroundColor3 = accentColor,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 10, 1, 0),
        Position = UDim2.new(0, 0, 0, 0)
    })
    
    local iconFrame = Create("Frame", {
        Parent = notif,
        BackgroundColor3 = accentColor,
        BackgroundTransparency = 0.85,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 32, 0, 32),
        Position = UDim2.new(0, 14, 0, 14)
    })
    Corner(iconFrame, UDim.new(0, 8))
    
    Create("TextLabel", {
        Parent = iconFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Config.FontBold,
        Text = icon,
        TextColor3 = accentColor,
        TextSize = 16
    })
    
    local titleLbl = Create("TextLabel", {
        Parent = notif,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -70, 0, 20),
        Position = UDim2.new(0, 56, 0, 14),
        Font = Config.FontBold,
        Text = title,
        TextColor3 = theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local textLbl = Create("TextLabel", {
        Parent = notif,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -70, 0, 30),
        Position = UDim2.new(0, 56, 0, 34),
        Font = Config.Font,
        Text = text,
        TextColor3 = theme.SubText,
        TextSize = 12,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        AutomaticSize = Enum.AutomaticSize.Y
    })
    
    local targetHeight = math.max(60, 46 + textLbl.TextBounds.Y)
    notif.Size = UDim2.new(1, 0, 0, 0)
    notif.BackgroundTransparency = 1
    Tween(notif, 0.3, {Size = UDim2.new(1, 0, 0, targetHeight), BackgroundTransparency = 0})
    Tween(nStroke, 0.3, {Transparency = 0})
    
    local progressBg = Create("Frame", {
        Parent = notif,
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -28, 0, 3),
        Position = UDim2.new(0, 14, 1, -8)
    })
    Corner(progressBg, UDim.new(1, 0))
    
    local progress = Create("Frame", {
        Parent = progressBg,
        BackgroundColor3 = accentColor,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0)
    })
    Corner(progress, UDim.new(1, 0))
    
    Tween(progress, duration, {Size = UDim2.new(0, 0, 1, 0)}, Enum.EasingStyle.Linear)
    
    task.delay(duration, function()
        Tween(notif, 0.3, {Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1})
        task.wait(0.3)
        notif:Destroy()
    end)
    
    return notif
end

--// Window Constructor
function Zazu.new(config)
    config = config or {}
    local self = setmetatable({}, Zazu)
    
    self.Title = config.Title or "Zazu"
    self.Subtitle = config.Subtitle or "v2.0"
    self.ThemeName = config.Theme or "Dark"
    self.Theme = Themes[self.ThemeName] or Themes.Dark
    self.Tabs = {}
    self.ActiveTab = nil
    self.Minimized = false
    self.Size = config.Size or UDim2.new(0, 640, 0, 420)
    
    local gui = Create("ScreenGui", {
        Name = "Zazu_" .. HttpService:GenerateGUID(false),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true
    })
    gui.Parent = GetGuiParent()
    self.ScreenGui = gui
    
    -- Blur background
    local blur = Create("Frame", {
        Name = "BackgroundBlur",
        Parent = gui,
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0)
    })
    
    -- Main window
    local main = Create("Frame", {
        Name = "Main",
        Parent = gui,
        BackgroundColor3 = self.Theme.Background,
        BorderSizePixel = 0,
        Size = self.Size,
        Position = UDim2.new(0.5, -self.Size.X.Offset / 2, 0.5, -self.Size.Y.Offset / 2),
        ClipsDescendants = true
    })
    Corner(main, UDim.new(0, 12))
    Stroke(main, self.Theme.Stroke, 1.5)
    AddShadow(main, 24, 0.4)
    self.Main = main
    
    -- Gradient overlay on main
    local mainGrad = Gradient(main, ColorSequence.new({
        ColorSequenceKeypoint.new(0, self.Theme.Surface),
        ColorSequenceKeypoint.new(1, self.Theme.Background)
    }), 135)
    
    -- Top bar
    local topBar = Create("Frame", {
        Name = "TopBar",
        Parent = main,
        BackgroundColor3 = self.Theme.Surface,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 56),
        ZIndex = 2
    })
    Corner(topBar, UDim.new(0, 12))
    
    local topBarCover = Create("Frame", {
        Parent = topBar,
        BackgroundColor3 = self.Theme.Surface,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 1, -20),
        ZIndex = 2
    })
    
    local topGrad = Gradient(topBar, ColorSequence.new({
        ColorSequenceKeypoint.new(0, self.Theme.SurfaceLight),
        ColorSequenceKeypoint.new(1, self.Theme.Surface)
    }), 90)
    
    -- Logo
    local logo = Create("Frame", {
        Parent = topBar,
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 32, 0, 32),
        Position = UDim2.new(0, 16, 0.5, -16)
    })
    Corner(logo, UDim.new(0, 8))
    local logoGrad = Gradient(logo, ColorSequence.new({
        ColorSequenceKeypoint.new(0, self.Theme.AccentGlow),
        ColorSequenceKeypoint.new(1, self.Theme.AccentDark)
    }), 135)
    
    Create("TextLabel", {
        Parent = logo,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Config.FontBold,
        Text = "Z",
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 18,
        ZIndex = 3
    })
    
    local titleBox = Create("Frame", {
        Parent = topBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0, 60, 0, 0)
    })
    
    Create("TextLabel", {
        Parent = titleBox,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 22),
        Position = UDim2.new(0, 0, 0, 10),
        Font = Config.FontBold,
        Text = self.Title,
        TextColor3 = self.Theme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    Create("TextLabel", {
        Parent = titleBox,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 16),
        Position = UDim2.new(0, 0, 0, 30),
        Font = Config.Font,
        Text = self.Subtitle,
        TextColor3 = self.Theme.SubText,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Window controls
    local controls = Create("Frame", {
        Parent = topBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 80, 0, 32),
        Position = UDim2.new(1, -92, 0.5, -16)
    })
    
    local function makeCtrlBtn(icon, xPos, hoverColor)
        local btn = Create("TextButton", {
            Parent = controls,
            BackgroundColor3 = self.Theme.Element,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 32, 0, 32),
            Position = UDim2.new(0, xPos, 0, 0),
            Font = Config.FontBold,
            Text = icon,
            TextColor3 = self.Theme.SubText,
            TextSize = 14,
            AutoButtonColor = false,
            ZIndex = 3
        })
        Corner(btn, UDim.new(0, 8))
        Stroke(btn, self.Theme.Stroke, 1)
        
        btn.MouseEnter:Connect(function()
            Tween(btn, 0.15, {BackgroundColor3 = hoverColor or self.Theme.ElementHover, TextColor3 = self.Theme.Text})
        end)
        btn.MouseLeave:Connect(function()
            Tween(btn, 0.15, {BackgroundColor3 = self.Theme.Element, TextColor3 = self.Theme.SubText})
        end)
        return btn
    end
    
    local minBtn = makeCtrlBtn("—", 0)
    local closeBtn = makeCtrlBtn("✕", 42, self.Theme.Error)
    
    minBtn.MouseButton1Click:Connect(function()
        self.Minimized = not self.Minimized
        local targetSize = self.Minimized and UDim2.new(self.Size.X.Scale, self.Size.X.Offset, 0, 56) or self.Size
        Tween(main, 0.35, {Size = targetSize}, Enum.EasingStyle.Back)
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        Tween(main, 0.25, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.25)
        gui:Destroy()
    end)
    
    Draggable(main, topBar)
    
    -- Sidebar
    local sidebar = Create("Frame", {
        Name = "Sidebar",
        Parent = main,
        BackgroundColor3 = self.Theme.Surface,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 160, 1, -76),
        Position = UDim2.new(0, 10, 0, 66)
    })
    Corner(sidebar, UDim.new(0, 10))
    Stroke(sidebar, self.Theme.Stroke, 1)
    self.Sidebar = sidebar
    
    -- User info at top of sidebar
    local userCard = Create("Frame", {
        Parent = sidebar,
        BackgroundColor3 = self.Theme.Element,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -16, 0, 48),
        Position = UDim2.new(0, 8, 0, 8)
    })
    Corner(userCard, UDim.new(0, 8))
    
    local avatar = Create("ImageLabel", {
        Parent = userCard,
        BackgroundColor3 = self.Theme.SurfaceLight,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 32, 0, 32),
        Position = UDim2.new(0, 8, 0.5, -16),
        Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=48&h=48"
    })
    Corner(avatar, UDim.new(0, 8))
    
    Create("TextLabel", {
        Parent = userCard,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -54, 0, 16),
        Position = UDim2.new(0, 48, 0, 8),
        Font = Config.FontBold,
        Text = LocalPlayer.DisplayName,
        TextColor3 = self.Theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd
    })
    
    Create("TextLabel", {
        Parent = userCard,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -54, 0, 14),
        Position = UDim2.new(0, 48, 0, 24),
        Font = Config.Font,
        Text = "@" .. LocalPlayer.Name,
        TextColor3 = self.Theme.SubText,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd
    })
    
    -- Tabs container
    local tabContainer = Create("ScrollingFrame", {
        Parent = sidebar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -16, 1, -80),
        Position = UDim2.new(0, 8, 0, 64),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = self.Theme.Accent,
        ScrollBarImageTransparency = 0.4,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y
    })
    ListLayout(tabContainer, 4, Enum.SortOrder.LayoutOrder)
    self.TabContainer = tabContainer
    
    -- Content area
    local content = Create("Frame", {
        Name = "Content",
        Parent = main,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -190, 1, -76),
        Position = UDim2.new(0, 180, 0, 66)
    })
    self.Content = content
    
    -- Bottom bar with version
    local bottomBar = Create("Frame", {
        Parent = main,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 0, 20),
        Position = UDim2.new(0, 10, 1, -26)
    })
    
    Create("TextLabel", {
        Parent = bottomBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Font = Config.Font,
        Text = "Zazu Library " .. self.Subtitle,
        TextColor3 = self.Theme.Muted,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    Create("TextLabel", {
        Parent = bottomBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        Font = Config.Font,
        Text = "RAGE mode",
        TextColor3 = self.Theme.Muted,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Right
    })
    
    -- Fade in animation
    main.BackgroundTransparency = 1
    main.Size = UDim2.new(0, 0, 0, 0)
    Tween(main, 0.45, {
        BackgroundTransparency = 0,
        Size = self.Size
    }, Enum.EasingStyle.Back)
    
    return self
end

--// Set Theme
function Zazu:SetTheme(themeName)
    if Themes[themeName] then
        self.ThemeName = themeName
        self.Theme = Themes[themeName]
    end
end

--// Tab Method
function Zazu:Tab(name, icon)
    local tab = {Name = name, Icon = icon or "•"}
    local theme = self.Theme
    
    local btn = Create("TextButton", {
        Parent = self.TabContainer,
        BackgroundColor3 = theme.Background,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -4, 0, 38),
        Font = Config.FontMedium,
        Text = "",
        TextColor3 = theme.SubText,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false
    })
    Corner(btn, UDim.new(0, 8))
    
    local iconLbl = Create("TextLabel", {
        Parent = btn,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Font = Config.FontBold,
        Text = tab.Icon,
        TextColor3 = theme.SubText,
        TextSize = 13
    })
    
    local textLbl = Create("TextLabel", {
        Parent = btn,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 34, 0, 0),
        Font = Config.FontMedium,
        Text = name,
        TextColor3 = theme.SubText,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local indicator = Create("Frame", {
        Parent = btn,
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 3, 0, 0),
        Position = UDim2.new(0, 0, 0.5, 0)
    })
    Corner(indicator, UDim.new(1, 0))
    
    local page = Create("ScrollingFrame", {
        Parent = self.Content,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = theme.Accent,
        ScrollBarImageTransparency = 0.4,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
        ScrollingDirection = Enum.ScrollingDirection.Y
    })
    ListLayout(page, 10, Enum.SortOrder.LayoutOrder)
    Padding(page, 0, 8, 0, 8)
    
    tab.Button = btn
    tab.Page = page
    tab.Indicator = indicator
    tab.IconLbl = iconLbl
    tab.TextLbl = textLbl
    
    btn.MouseEnter:Connect(function()
        if self.ActiveTab ~= tab then
            Tween(btn, 0.15, {BackgroundTransparency = 0, BackgroundColor3 = theme.Element})
            Tween(textLbl, 0.15, {TextColor3 = theme.Text})
            Tween(iconLbl, 0.15, {TextColor3 = theme.Accent})
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if self.ActiveTab ~= tab then
            Tween(btn, 0.15, {BackgroundTransparency = 0.5, BackgroundColor3 = theme.Background})
            Tween(textLbl, 0.15, {TextColor3 = theme.SubText})
            Tween(iconLbl, 0.15, {TextColor3 = theme.SubText})
        end
    end)
    
    btn.MouseButton1Click:Connect(function()
        if self.ActiveTab == tab then return end
        
        if self.ActiveTab then
            local oldTab = self.ActiveTab
            Tween(oldTab.Button, 0.15, {BackgroundTransparency = 0.5, BackgroundColor3 = theme.Background})
            Tween(oldTab.TextLbl, 0.15, {TextColor3 = theme.SubText})
            Tween(oldTab.IconLbl, 0.15, {TextColor3 = theme.SubText})
            Tween(oldTab.Indicator, 0.15, {Size = UDim2.new(0, 3, 0, 0)})
            oldTab.Page.Visible = false
        end
        
        self.ActiveTab = tab
        Tween(btn, 0.15, {BackgroundTransparency = 0, BackgroundColor3 = theme.Element})
        Tween(textLbl, 0.15, {TextColor3 = theme.Text})
        Tween(iconLbl, 0.15, {TextColor3 = theme.Accent})
        Tween(indicator, 0.25, {Size = UDim2.new(0, 3, 0.65, 0)}, Enum.EasingStyle.Back)
        page.Visible = true
    end)
    
    if not self.ActiveTab then
        self.ActiveTab = tab
        btn.BackgroundTransparency = 0
        btn.BackgroundColor3 = theme.Element
        textLbl.TextColor3 = theme.Text
        iconLbl.TextColor3 = theme.Accent
        indicator.Size = UDim2.new(0, 3, 0.65, 0)
        page.Visible = true
    end
    
    table.insert(self.Tabs, tab)
    return tab
end

--// Section
function Zazu:Section(tab, name, collapsible)
    local theme = self.Theme
    local section = {Name = name, Collapsed = false, Collapsible = collapsible}
    
    local container = Create("Frame", {
        Parent = tab.Page,
        BackgroundColor3 = theme.Surface,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 44),
        AutomaticSize = Enum.AutomaticSize.Y,
        ClipsDescendants = true
    })
    Corner(container, UDim.new(0, 10))
    Stroke(container, theme.Stroke, 1)
    Padding(container, 14, 14, 14, 14)
    
    local header = Create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        Text = "",
        AutoButtonColor = false
    })
    
    local accentDot = Create("Frame", {
        Parent = header,
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 4, 0, 4),
        Position = UDim2.new(0, 0, 0.5, -2)
    })
    Corner(accentDot, UDim.new(1, 0))
    
    Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -30, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        Font = Config.FontBold,
        Text = string.upper(name),
        TextColor3 = theme.Text,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local contentFrame = Create("Frame", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 28),
        AutomaticSize = Enum.AutomaticSize.Y
    })
    ListLayout(contentFrame, 8, Enum.SortOrder.LayoutOrder)
    
    section.Container = container
    section.Content = contentFrame
    
    if collapsible then
        local arrow = Create("TextLabel", {
            Parent = header,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 20, 1, 0),
            Position = UDim2.new(1, -20, 0, 0),
            Font = Config.FontBold,
            Text = "▼",
            TextColor3 = theme.SubText,
            TextSize = 10
        })
        
        header.MouseButton1Click:Connect(function()
            section.Collapsed = not section.Collapsed
            local targetPos = section.Collapsed and UDim2.new(0, 0, 0, 0) or UDim2.new(0, 0, 0, 28)
            local targetSize = section.Collapsed and UDim2.new(1, 0, 0, 0) or UDim2.new(1, 0, 0, contentFrame.AbsoluteSize.Y)
            Tween(contentFrame, 0.25, {Size = targetSize})
            Tween(arrow, 0.25, {Rotation = section.Collapsed and -90 or 0})
        end)
    end
    
    return section
end

--// Button
function Zazu:Button(section, text, callback)
    local theme = self.Theme
    
    local btn = Create("TextButton", {
        Parent = section.Content,
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 36),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text,
        TextSize = 13,
        AutoButtonColor = false
    })
    Corner(btn, UDim.new(0, 8))
    local btnStroke = Stroke(btn, theme.Stroke, 1)
    
    RippleEffect(btn, theme)
    
    btn.MouseEnter:Connect(function()
        Tween(btn, 0.15, {BackgroundColor3 = theme.Accent, TextColor3 = Color3.new(1, 1, 1)})
        Tween(btnStroke, 0.15, {Color = theme.AccentGlow})
    end)
    
    btn.MouseLeave:Connect(function()
        Tween(btn, 0.15, {BackgroundColor3 = theme.Element, TextColor3 = theme.Text})
        Tween(btnStroke, 0.15, {Color = theme.Stroke})
    end)
    
    btn.MouseButton1Click:Connect(function()
        Tween(btn, 0.08, {Size = UDim2.new(0.97, 0, 0, 36)})
        task.wait(0.08)
        Tween(btn, 0.08, {Size = UDim2.new(1, 0, 0, 36)})
        if callback then callback() end
    end)
    
    return btn
end

--// Toggle
function Zazu:Toggle(section, text, default, callback)
    local theme = self.Theme
    local state = default or false
    
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 38)
    })
    Corner(container, UDim.new(0, 8))
    local cStroke = Stroke(container, theme.Stroke, 1)
    
    Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -70, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local track = Create("Frame", {
        Parent = container,
        BackgroundColor3 = state and theme.Accent or theme.Muted,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 42, 0, 22),
        Position = UDim2.new(1, -56, 0.5, -11)
    })
    Corner(track, UDim.new(1, 0))
    local tStroke = Stroke(track, state and theme.AccentGlow or theme.StrokeLight, 1)
    
    local knob = Create("Frame", {
        Parent = track,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 18, 0, 18),
        Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    })
    Corner(knob, UDim.new(1, 0))
    
    local btn = Create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = ""
    })
    
    btn.MouseEnter:Connect(function()
        Tween(container, 0.15, {BackgroundColor3 = theme.ElementHover})
    end)
    btn.MouseLeave:Connect(function()
        Tween(container, 0.15, {BackgroundColor3 = theme.Element})
    end)
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        Tween(track, 0.2, {BackgroundColor3 = state and theme.Accent or theme.Muted})
        Tween(tStroke, 0.2, {Color = state and theme.AccentGlow or theme.StrokeLight})
        Tween(knob, 0.2, {Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}, Enum.EasingStyle.Back)
        if callback then callback(state) end
    end)
    
    return {
        Set = function(v)
            state = v
            Tween(track, 0.2, {BackgroundColor3 = state and theme.Accent or theme.Muted})
            Tween(knob, 0.2, {Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)})
        end,
        Get = function() return state end
    }
end

--// Slider
function Zazu:Slider(section, text, min, max, default, callback)
    min, max = min or 0, max or 100
    local theme = self.Theme
    local value = default or min
    
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 54)
    })
    Corner(container, UDim.new(0, 8))
    Stroke(container, theme.Stroke, 1)
    
    Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.65, 0, 0, 20),
        Position = UDim2.new(0, 14, 0, 8),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local valBox = Create("Frame", {
        Parent = container,
        BackgroundColor3 = theme.SurfaceLight,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 60, 0, 20),
        Position = UDim2.new(1, -74, 0, 8)
    })
    Corner(valBox, UDim.new(0, 6))
    Stroke(valBox, theme.Stroke, 1)
    
    local valLbl = Create("TextLabel", {
        Parent = valBox,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Config.FontBold,
        Text = tostring(value),
        TextColor3 = theme.Accent,
        TextSize = 12
    })
    
    local barBg = Create("Frame", {
        Parent = container,
        BackgroundColor3 = theme.SurfaceLight,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -28, 0, 6),
        Position = UDim2.new(0, 14, 0, 36)
    })
    Corner(barBg, UDim.new(1, 0))
    
    local fill = Create("Frame", {
        Parent = barBg,
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
    })
    Corner(fill, UDim.new(1, 0))
    Gradient(fill, ColorSequence.new(theme.Accent, theme.AccentGlow), 0)
    
    local knob = Create("Frame", {
        Parent = barBg,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new((value - min) / (max - min), -7, 0.5, -7),
        ZIndex = 2
    })
    Corner(knob, UDim.new(1, 0))
    Stroke(knob, theme.Accent, 2)
    
    local dragging = false
    local function update(input)
        local pos = math.clamp((input.Position.X - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
        value = math.floor(min + (max - min) * pos + 0.5)
        valLbl.Text = tostring(value)
        Tween(fill, 0.05, {Size = UDim2.new(pos, 0, 1, 0)})
        Tween(knob, 0.05, {Position = UDim2.new(pos, -7, 0.5, -7)})
        if callback then callback(value) end
    end
    
    barBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    return {
        Set = function(v) value = v; valLbl.Text = tostring(v) end,
        Get = function() return value end
    }
end

--// Textbox
function Zazu:Textbox(section, text, placeholder, callback)
    local theme = self.Theme
    
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 38)
    })
    Corner(container, UDim.new(0, 8))
    local cStroke = Stroke(container, theme.Stroke, 1)
    
    Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.4, 0, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local box = Create("TextBox", {
        Parent = container,
        BackgroundColor3 = theme.SurfaceLight,
        BorderSizePixel = 0,
        Size = UDim2.new(0.55, -14, 0, 26),
        Position = UDim2.new(0.45, 0, 0.5, -13),
        Font = Config.Font,
        PlaceholderText = placeholder or "Введите...",
        PlaceholderColor3 = theme.Muted,
        Text = "",
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Center,
        ClearTextOnFocus = false
    })
    Corner(box, UDim.new(0, 6))
    local bStroke = Stroke(box, theme.Stroke, 1)
    
    box.Focused:Connect(function()
        Tween(bStroke, 0.15, {Color = theme.Accent, Thickness = 1.5})
        Tween(container, 0.15, {BackgroundColor3 = theme.ElementHover})
    end)
    
    box.FocusLost:Connect(function()
        Tween(bStroke, 0.15, {Color = theme.Stroke, Thickness = 1})
        Tween(container, 0.15, {BackgroundColor3 = theme.Element})
        if callback then callback(box.Text) end
    end)
    
    return box
end

--// Dropdown
function Zazu:Dropdown(section, text, options, default, callback)
    local theme = self.Theme
    local selected = default or options[1]
    local open = false
    
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 38),
        ClipsDescendants = true
    })
    Corner(container, UDim.new(0, 8))
    Stroke(container, theme.Stroke, 1)
    
    local header = Create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 38),
        Text = "",
        AutoButtonColor = false
    })
    
    Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local selLbl = Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.4, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        Font = Config.FontMedium,
        Text = tostring(selected),
        TextColor3 = theme.Accent,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right
    })
    
    local arrow = Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(1, -26, 0, 0),
        Font = Config.FontBold,
        Text = "▼",
        TextColor3 = theme.SubText,
        TextSize = 9
    })
    
    local optContainer = Create("Frame", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -12, 0, 0),
        Position = UDim2.new(0, 6, 0, 40),
        AutomaticSize = Enum.AutomaticSize.Y
    })
    ListLayout(optContainer, 4, Enum.SortOrder.LayoutOrder)
    
    for _, opt in ipairs(options) do
        local ob = Create("TextButton", {
            Parent = optContainer,
            BackgroundColor3 = theme.SurfaceLight,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 30),
            Font = Config.Font,
            Text = tostring(opt),
            TextColor3 = theme.Text,
            TextSize = 12,
            AutoButtonColor = false
        })
        Corner(ob, UDim.new(0, 6))
        
        ob.MouseEnter:Connect(function()
            Tween(ob, 0.12, {BackgroundColor3 = theme.Accent, TextColor3 = Color3.new(1, 1, 1)})
        end)
        ob.MouseLeave:Connect(function()
            Tween(ob, 0.12, {BackgroundColor3 = theme.SurfaceLight, TextColor3 = theme.Text})
        end)
        ob.MouseButton1Click:Connect(function()
            selected = opt
            selLbl.Text = tostring(opt)
            open = false
            local targetH = 38
            Tween(container, 0.25, {Size = UDim2.new(1, 0, 0, targetH)})
            Tween(arrow, 0.2, {Rotation = 0})
            if callback then callback(opt) end
        end)
    end
    
    header.MouseButton1Click:Connect(function()
        open = not open
        if open then
            local h = 38 + (#options * 34) + 8
            Tween(container, 0.3, {Size = UDim2.new(1, 0, 0, h)})
            Tween(arrow, 0.2, {Rotation = 180})
        else
            Tween(container, 0.3, {Size = UDim2.new(1, 0, 0, 38)})
            Tween(arrow, 0.2, {Rotation = 0})
        end
    end)
    
    return {
        Set = function(v) selected = v; selLbl.Text = tostring(v) end,
        Get = function() return selected end
    }
end

--// Multi Dropdown
function Zazu:MultiDropdown(section, text, options, callback)
    local theme = self.Theme
    local selected = {}
    local open = false
    
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 38),
        ClipsDescendants = true
    })
    Corner(container, UDim.new(0, 8))
    Stroke(container, theme.Stroke, 1)
    
    local header = Create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 38),
        Text = "",
        AutoButtonColor = false
    })
    
    Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local countLbl = Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.4, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        Font = Config.FontMedium,
        Text = "0 выбрано",
        TextColor3 = theme.Accent,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right
    })
    
    local arrow = Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(1, -26, 0, 0),
        Font = Config.FontBold,
        Text = "▼",
        TextColor3 = theme.SubText,
        TextSize = 9
    })
    
    local optContainer = Create("Frame", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -12, 0, 0),
        Position = UDim2.new(0, 6, 0, 40),
        AutomaticSize = Enum.AutomaticSize.Y
    })
    ListLayout(optContainer, 4, Enum.SortOrder.LayoutOrder)
    
    local toggles = {}
    
    local function updateCount()
        countLbl.Text = #selected .. " выбрано"
        if callback then callback(selected) end
    end
    
    for _, opt in ipairs(options) do
        local ob = Create("TextButton", {
            Parent = optContainer,
            BackgroundColor3 = theme.SurfaceLight,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 30),
            Font = Config.Font,
            Text = "  " .. tostring(opt),
            TextColor3 = theme.Text,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutoButtonColor = false
        })
        Corner(ob, UDim.new(0, 6))
        
        local check = Create("Frame", {
            Parent = ob,
            BackgroundColor3 = theme.Muted,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 16, 0, 16),
            Position = UDim2.new(1, -24, 0.5, -8)
        })
        Corner(check, UDim.new(0, 4))
        
        toggles[opt] = {Button = ob, Check = check}
        
        ob.MouseButton1Click:Connect(function()
            local isSelected = table.find(selected, opt)
            if isSelected then
                table.remove(selected, isSelected)
                Tween(ob, 0.12, {BackgroundColor3 = theme.SurfaceLight, TextColor3 = theme.Text})
                Tween(check, 0.15, {BackgroundColor3 = theme.Muted})
            else
                table.insert(selected, opt)
                Tween(ob, 0.12, {BackgroundColor3 = theme.Accent, TextColor3 = Color3.new(1, 1, 1)})
                Tween(check, 0.15, {BackgroundColor3 = theme.AccentGlow})
            end
            updateCount()
        end)
    end
    
    header.MouseButton1Click:Connect(function()
        open = not open
        if open then
            local h = 38 + (#options * 34) + 8
            Tween(container, 0.3, {Size = UDim2.new(1, 0, 0, h)})
            Tween(arrow, 0.2, {Rotation = 180})
        else
            Tween(container, 0.3, {Size = UDim2.new(1, 0, 0, 38)})
            Tween(arrow, 0.2, {Rotation = 0})
        end
    end)
    
    return {
        Get = function() return selected end,
        Set = function(v) selected = v; updateCount() end
    }
end

--// Keybind
function Zazu:Keybind(section, text, default, callback)
    local theme = self.Theme
    local key = default or "F"
    local listening = false
    
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 38)
    })
    Corner(container, UDim.new(0, 8))
    Stroke(container, theme.Stroke, 1)
    
    Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.6, 0, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local keyBtn = Create("TextButton", {
        Parent = container,
        BackgroundColor3 = theme.SurfaceLight,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 60, 0, 26),
        Position = UDim2.new(1, -74, 0.5, -13),
        Font = Config.FontBold,
        Text = key,
        TextColor3 = theme.Text,
        TextSize = 11,
        AutoButtonColor = false
    })
    Corner(keyBtn, UDim.new(0, 6))
    local kStroke = Stroke(keyBtn, theme.Stroke, 1)
    
    keyBtn.MouseButton1Click:Connect(function()
        listening = true
        keyBtn.Text = "..."
        keyBtn.TextColor3 = theme.Accent
        Tween(kStroke, 0.15, {Color = theme.Accent, Thickness = 1.5})
    end)
    
    UserInputService.InputBegan:Connect(function(input)
        if listening and input.UserInputType == Enum.UserInputType.Keyboard then
            key = input.KeyCode.Name
            keyBtn.Text = key
            keyBtn.TextColor3 = theme.Text
            listening = false
            Tween(kStroke, 0.15, {Color = theme.Stroke, Thickness = 1})
            if callback then callback(key) end
        end
    end)
    
    return {Get = function() return key end, Set = function(k) key = k; keyBtn.Text = k end}
end

--// Color Picker
function Zazu:ColorPicker(section, text, default, callback)
    local theme = self.Theme
    local color = default or theme.Accent
    local hue, sat, val = Color3.toHSV(color)
    local open = false
    
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 38),
        ClipsDescendants = true
    })
    Corner(container, UDim.new(0, 8))
    Stroke(container, theme.Stroke, 1)
    
    local header = Create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 38),
        Text = "",
        AutoButtonColor = false
    })
    
    Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.6, 0, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local preview = Create("Frame", {
        Parent = header,
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 60, 0, 24),
        Position = UDim2.new(1, -74, 0.5, -12)
    })
    Corner(preview, UDim.new(0, 6))
    Stroke(preview, theme.StrokeLight, 1)
    
    local pickerFrame = Create("Frame", {
        Parent = container,
        BackgroundColor3 = theme.SurfaceLight,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -16, 0, 120),
        Position = UDim2.new(0, 8, 0, 44)
    })
    Corner(pickerFrame, UDim.new(0, 8))
    pickerFrame.Visible = false
    
    local satValBox = Create("Frame", {
        Parent = pickerFrame,
        BackgroundColor3 = Color3.fromHSV(hue, 1, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(1, -80, 1, -16),
        Position = UDim2.new(0, 8, 0, 8)
    })
    Corner(satValBox, UDim.new(0, 6))
    Gradient(satValBox, ColorSequence.new(Color3.new(1,1,1), Color3.new(1,1,1)), 0, NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    }))
    
    local svBlack = Create("Frame", {
        Parent = satValBox,
        BackgroundColor3 = Color3.new(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0)
    })
    Corner(svBlack, UDim.new(0, 6))
    Gradient(svBlack, ColorSequence.new(Color3.new(1,1,1), Color3.new(1,1,1)), 90, NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    }))
    
    local svKnob = Create("Frame", {
        Parent = satValBox,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 12, 0, 12),
        Position = UDim2.new(sat, -6, 1 - val, -6),
        ZIndex = 2
    })
    Corner(svKnob, UDim.new(1, 0))
    Stroke(svKnob, Color3.new(0, 0, 0), 2)
    
    local hueBar = Create("Frame", {
        Parent = pickerFrame,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 20, 1, -16),
        Position = UDim2.new(1, -68, 0, 8)
    })
    Corner(hueBar, UDim.new(0, 6))
    Gradient(hueBar, ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    }), 90)
    
    local hueKnob = Create("Frame", {
        Parent = hueBar,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 6, 0, 4),
        Position = UDim2.new(0, -3, hue, -2),
        ZIndex = 2
    })
    Corner(hueKnob, UDim.new(1, 0))
    Stroke(hueKnob, Color3.new(0, 0, 0), 2)
    
    header.MouseButton1Click:Connect(function()
        open = not open
        pickerFrame.Visible = open
        local targetH = open and 38 + 128 or 38
        Tween(container, 0.3, {Size = UDim2.new(1, 0, 0, targetH)})
    end)
    
    local draggingSV = false
    local draggingHue = false
    
    satValBox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSV = true end
    end)
    hueBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingHue = true end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if draggingSV then
                local x = math.clamp((input.Position.X - satValBox.AbsolutePosition.X) / satValBox.AbsoluteSize.X, 0, 1)
                local y = math.clamp((input.Position.Y - satValBox.AbsolutePosition.Y) / satValBox.AbsoluteSize.Y, 0, 1)
                sat, val = x, 1 - y
                svKnob.Position = UDim2.new(x, -6, y, -6)
                color = Color3.fromHSV(hue, sat, val)
                preview.BackgroundColor3 = color
                if callback then callback(color) end
            elseif draggingHue then
                local y = math.clamp((input.Position.Y - hueBar.AbsolutePosition.Y) / hueBar.AbsoluteSize.Y, 0, 1)
                hue = y
                hueKnob.Position = UDim2.new(0, -3, y, -2)
                satValBox.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
                color = Color3.fromHSV(hue, sat, val)
                preview.BackgroundColor3 = color
                if callback then callback(color) end
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSV = false
            draggingHue = false
        end
    end)
    
    return {
        Set = function(c)
            color = c
            hue, sat, val = Color3.toHSV(c)
            preview.BackgroundColor3 = c
            satValBox.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
            svKnob.Position = UDim2.new(sat, -6, 1 - val, -6)
            hueKnob.Position = UDim2.new(0, -3, hue, -2)
        end,
        Get = function() return color end
    }
end

--// Label
function Zazu:Label(section, text)
    local theme = self.Theme
    local lbl = Create("TextLabel", {
        Parent = section.Content,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        Font = Config.Font,
        Text = text,
        TextColor3 = theme.SubText,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y
    })
    return lbl
end

--// Paragraph (with title)
function Zazu:Paragraph(section, title, text)
    local theme = self.Theme
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = theme.SurfaceLight,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    })
    Corner(container, UDim.new(0, 8))
    Stroke(container, theme.Stroke, 1)
    Padding(container, 12, 12, 14, 14)
    
    Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        Font = Config.FontBold,
        Text = title,
        TextColor3 = theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 0, 22),
        Font = Config.Font,
        Text = text,
        TextColor3 = theme.SubText,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y
    })
    
    return container
end

--// Divider
function Zazu:Divider(section)
    local div = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = self.Theme.Stroke,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1)
    })
    return div
end

return Zazu
