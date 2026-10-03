--[[
    ╔══════════════════════════════════════════════════════════╗
    ║                                                          ║
    ║          Zazu Library v3.0 - Obsidian Edition            ║
    ║                                                          ║
    ║      Premium UI Library with Obsidian Aesthetic          ║
    ║                                                          ║
    ╚══════════════════════════════════════════════════════════╝
]]

local Zazu = {}
Zazu.__index = Zazu

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

--// Obsidian Themes
local Themes = {
    Obsidian = {
        Base = Color3.fromRGB(8, 8, 11),
        Surface = Color3.fromRGB(13, 13, 17),
        Surface2 = Color3.fromRGB(18, 18, 23),
        Surface3 = Color3.fromRGB(24, 24, 30),
        Surface4 = Color3.fromRGB(32, 32, 40),
        Border = Color3.fromRGB(36, 36, 46),
        BorderBright = Color3.fromRGB(58, 58, 74),
        Accent = Color3.fromRGB(168, 130, 255),
        AccentDeep = Color3.fromRGB(120, 85, 220),
        AccentGlow = Color3.fromRGB(200, 175, 255),
        AccentSoft = Color3.fromRGB(90, 70, 160),
        Text = Color3.fromRGB(245, 245, 255),
        Text2 = Color3.fromRGB(200, 200, 215),
        SubText = Color3.fromRGB(140, 140, 160),
        Muted = Color3.fromRGB(80, 80, 100),
        Success = Color3.fromRGB(120, 240, 170),
        Warning = Color3.fromRGB(255, 200, 100),
        Error = Color3.fromRGB(255, 110, 130),
        Info = Color3.fromRGB(130, 190, 255),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Nebula = {
        Base = Color3.fromRGB(10, 6, 20),
        Surface = Color3.fromRGB(16, 10, 30),
        Surface2 = Color3.fromRGB(22, 14, 40),
        Surface3 = Color3.fromRGB(30, 20, 52),
        Surface4 = Color3.fromRGB(40, 26, 68),
        Border = Color3.fromRGB(48, 30, 78),
        BorderBright = Color3.fromRGB(72, 46, 110),
        Accent = Color3.fromRGB(200, 100, 255),
        AccentDeep = Color3.fromRGB(140, 60, 200),
        AccentGlow = Color3.fromRGB(230, 160, 255),
        AccentSoft = Color3.fromRGB(100, 50, 150),
        Text = Color3.fromRGB(250, 245, 255),
        Text2 = Color3.fromRGB(210, 195, 235),
        SubText = Color3.fromRGB(155, 135, 185),
        Muted = Color3.fromRGB(90, 75, 115),
        Success = Color3.fromRGB(120, 240, 170),
        Warning = Color3.fromRGB(255, 200, 100),
        Error = Color3.fromRGB(255, 110, 130),
        Info = Color3.fromRGB(130, 190, 255),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Abyss = {
        Base = Color3.fromRGB(4, 8, 14),
        Surface = Color3.fromRGB(7, 13, 22),
        Surface2 = Color3.fromRGB(11, 20, 34),
        Surface3 = Color3.fromRGB(17, 28, 46),
        Surface4 = Color3.fromRGB(24, 38, 62),
        Border = Color3.fromRGB(30, 46, 74),
        BorderBright = Color3.fromRGB(50, 72, 110),
        Accent = Color3.fromRGB(100, 210, 255),
        AccentDeep = Color3.fromRGB(60, 160, 220),
        AccentGlow = Color3.fromRGB(160, 230, 255),
        AccentSoft = Color3.fromRGB(50, 100, 150),
        Text = Color3.fromRGB(240, 248, 255),
        Text2 = Color3.fromRGB(200, 215, 235),
        SubText = Color3.fromRGB(140, 165, 195),
        Muted = Color3.fromRGB(80, 100, 130),
        Success = Color3.fromRGB(120, 240, 170),
        Warning = Color3.fromRGB(255, 200, 100),
        Error = Color3.fromRGB(255, 110, 130),
        Info = Color3.fromRGB(130, 190, 255),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Crimson = {
        Base = Color3.fromRGB(12, 5, 8),
        Surface = Color3.fromRGB(20, 8, 14),
        Surface2 = Color3.fromRGB(28, 12, 20),
        Surface3 = Color3.fromRGB(40, 18, 28),
        Surface4 = Color3.fromRGB(54, 24, 38),
        Border = Color3.fromRGB(62, 28, 44),
        BorderBright = Color3.fromRGB(90, 42, 62),
        Accent = Color3.fromRGB(255, 90, 130),
        AccentDeep = Color3.fromRGB(210, 50, 90),
        AccentGlow = Color3.fromRGB(255, 150, 180),
        AccentSoft = Color3.fromRGB(150, 50, 80),
        Text = Color3.fromRGB(255, 240, 245),
        Text2 = Color3.fromRGB(230, 195, 210),
        SubText = Color3.fromRGB(190, 145, 165),
        Muted = Color3.fromRGB(120, 80, 100),
        Success = Color3.fromRGB(120, 240, 170),
        Warning = Color3.fromRGB(255, 200, 100),
        Error = Color3.fromRGB(255, 110, 130),
        Info = Color3.fromRGB(130, 190, 255),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Emerald = {
        Base = Color3.fromRGB(5, 12, 9),
        Surface = Color3.fromRGB(8, 20, 15),
        Surface2 = Color3.fromRGB(13, 30, 22),
        Surface3 = Color3.fromRGB(20, 42, 32),
        Surface4 = Color3.fromRGB(28, 58, 44),
        Border = Color3.fromRGB(34, 68, 52),
        BorderBright = Color3.fromRGB(54, 98, 76),
        Accent = Color3.fromRGB(80, 240, 180),
        AccentDeep = Color3.fromRGB(40, 180, 130),
        AccentGlow = Color3.fromRGB(150, 255, 210),
        AccentSoft = Color3.fromRGB(40, 120, 90),
        Text = Color3.fromRGB(235, 255, 245),
        Text2 = Color3.fromRGB(195, 230, 215),
        SubText = Color3.fromRGB(135, 180, 160),
        Muted = Color3.fromRGB(75, 110, 95),
        Success = Color3.fromRGB(120, 240, 170),
        Warning = Color3.fromRGB(255, 200, 100),
        Error = Color3.fromRGB(255, 110, 130),
        Info = Color3.fromRGB(130, 190, 255),
        Shadow = Color3.fromRGB(0, 0, 0)
    }
}

local Config = {
    Font = Enum.Font.Gotham,
    FontMedium = Enum.Font.GothamMedium,
    FontBold = Enum.Font.GothamBold,
    FontBlack = Enum.Font.GothamBlack,
    AnimFast = 0.12,
    AnimSpeed = 0.2,
    AnimSlow = 0.35,
    CornerRadius = UDim.new(0, 12),
    ShadowImage = "rbxassetid://5028857084",
    GlowImage = "rbxassetid://4996891970",
    IconFont = Enum.Font.GothamBold
}

--// Utility
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

local function Gradient(parent, colorSeq, rotation, transparency, offset)
    return Create("UIGradient", {
        Color = colorSeq or ColorSequence.new(Color3.new(1,1,1), Color3.new(1,1,1)),
        Rotation = rotation or 90,
        Transparency = transparency,
        Offset = offset or Vector2.new(0, 0),
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

local function GridLayout(parent, cellSize, cellPadding)
    return Create("UIGridLayout", {
        CellSize = cellSize or UDim2.new(0, 100, 0, 100),
        CellPadding = cellPadding or UDim2.new(0, 8, 0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = parent
    })
end

local function AddShadow(parent, size, transparency)
    local shadow = Create("ImageLabel", {
        Parent = parent,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, (size or 24) * 2, 1, (size or 24) * 2),
        Position = UDim2.new(0, -(size or 24), 0, -(size or 24)),
        Image = Config.ShadowImage,
        ImageColor3 = Color3.new(0, 0, 0),
        ImageTransparency = transparency or 0.5,
        ZIndex = -1,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(24, 24, 276, 276)
    })
    return shadow
end

local function AddGlow(parent, color, size, transparency)
    local glow = Create("ImageLabel", {
        Parent = parent,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, (size or 16) * 2, 1, (size or 16) * 2),
        Position = UDim2.new(0, -(size or 16), 0, -(size or 16)),
        Image = Config.GlowImage,
        ImageColor3 = color,
        ImageTransparency = transparency or 0.7,
        ZIndex = -2,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(24, 24, 276, 276)
    })
    return glow
end

local function RippleEffect(button, color)
    button.ClipsDescendants = true
    button.MouseButton1Down:Connect(function()
        local x = Mouse.X - button.AbsolutePosition.X
        local y = Mouse.Y - button.AbsolutePosition.Y
        local ripple = Create("Frame", {
            Parent = button,
            BackgroundColor3 = color or Color3.new(1, 1, 1),
            BackgroundTransparency = 0.6,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, x, 0, y),
            ZIndex = 10
        })
        Corner(ripple, UDim.new(1, 0))
        Tween(ripple, 0.6, {
            Size = UDim2.new(0, button.AbsoluteSize.X * 2.5, 0, button.AbsoluteSize.X * 2.5),
            Position = UDim2.new(0, x - button.AbsoluteSize.X * 1.25, 0, y - button.AbsoluteSize.X * 1.25),
            BackgroundTransparency = 1
        }, Enum.EasingStyle.Quad)
        task.delay(0.6, function() ripple:Destroy() end)
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

local function GetGuiParent()
    local success, result = pcall(function() return CoreGui end)
    if success and result then
        local test = Create("ScreenGui", {Parent = result})
        test:Destroy()
        return result
    end
    return LocalPlayer:WaitForChild("PlayerGui")
end

--// Particle Background Effect
local function CreateParticles(parent, theme)
    local container = Create("Frame", {
        Parent = parent,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        ClipsDescendants = true,
        ZIndex = 0
    })
    
    for i = 1, 12 do
        local particle = Create("Frame", {
            Parent = container,
            BackgroundColor3 = theme.Accent,
            BackgroundTransparency = math.random(85, 95) / 100,
            BorderSizePixel = 0,
            Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6)),
            Position = UDim2.new(math.random() * 100 / 100, 0, math.random() * 100 / 100, 0),
            ZIndex = 0
        })
        Corner(particle, UDim.new(1, 0))
        
        local duration = math.random(15, 30)
        local xEnd = math.random() * 100 / 100
        local yEnd = math.random() * 100 / 100
        
        local tween = TweenService:Create(
            particle,
            TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
            {Position = UDim2.new(xEnd, 0, yEnd, 0)}
        )
        tween:Play()
    end
    
    return container
end

--// Main Notification System
function Zazu:Notify(config)
    config = config or {}
    local title = config.Title or "Zazu"
    local text = config.Text or ""
    local duration = config.Duration or 4
    local notifType = config.Type or "Info"
    local icon = config.Icon
    
    local theme = self.Theme
    local typeColors = {
        Info = theme.Info,
        Success = theme.Success,
        Warning = theme.Warning,
        Error = theme.Error,
        Accent = theme.Accent
    }
    local typeIcons = {
        Info = "i",
        Success = "✓",
        Warning = "!",
        Error = "✕",
        Accent = "★"
    }
    
    if not self._NotifContainer then
        self._NotifContainer = Create("Frame", {
            Name = "Notifications",
            Parent = self.ScreenGui,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 340, 1, -40),
            Position = UDim2.new(1, -360, 0, 20),
            ZIndex = 100
        })
        ListLayout(self._NotifContainer, 10, Enum.SortOrder.LayoutOrder)
        self._NotifContainer.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    end
    
    local accentColor = typeColors[notifType] or theme.Accent
    local iconText = icon or typeIcons[notifType] or "i"
    
    local notif = Create("Frame", {
        Parent = self._NotifContainer,
        BackgroundColor3 = theme.Surface,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        ClipsDescendants = true
    })
    Corner(notif, UDim.new(0, 12))
    local nStroke = Stroke(notif, theme.Border, 1, 1)
    AddShadow(notif, 16, 0.6)
    
    -- Gradient overlay
    local notifGrad = Gradient(notif, ColorSequence.new({
        ColorSequenceKeypoint.new(0, theme.Surface2),
        ColorSequenceKeypoint.new(1, theme.Surface)
    }), 135)
    
    -- Left accent bar
    local accentBar = Create("Frame", {
        Parent = notif,
        BackgroundColor3 = accentColor,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 3, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        ZIndex = 2
    })
    local accentGrad = Gradient(accentBar, ColorSequence.new({
        ColorSequenceKeypoint.new(0, accentColor),
        ColorSequenceKeypoint.new(1, theme.AccentDeep)
    }), 90)
    
    -- Icon container
    local iconFrame = Create("Frame", {
        Parent = notif,
        BackgroundColor3 = accentColor,
        BackgroundTransparency = 0.85,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 36, 0, 36),
        Position = UDim2.new(0, 16, 0, 14),
        ZIndex = 2
    })
    Corner(iconFrame, UDim.new(0, 10))
    Stroke(iconFrame, accentColor, 1, 0.5)
    
    Create("TextLabel", {
        Parent = iconFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Config.FontBlack,
        Text = iconText,
        TextColor3 = accentColor,
        TextSize = 16,
        ZIndex = 3
    })
    
    local titleLbl = Create("TextLabel", {
        Parent = notif,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -80, 0, 20),
        Position = UDim2.new(0, 62, 0, 14),
        Font = Config.FontBold,
        Text = title,
        TextColor3 = theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2
    })
    
    local textLbl = Create("TextLabel", {
        Parent = notif,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -80, 0, 30),
        Position = UDim2.new(0, 62, 0, 36),
        Font = Config.Font,
        Text = text,
        TextColor3 = theme.SubText,
        TextSize = 12,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 2
    })
    
    local targetHeight = math.max(64, 50 + textLbl.TextBounds.Y)
    notif.Size = UDim2.new(1, 0, 0, 0)
    notif.BackgroundTransparency = 1
    Tween(notif, 0.35, {Size = UDim2.new(1, 0, 0, targetHeight), BackgroundTransparency = 0}, Enum.EasingStyle.Back)
    Tween(nStroke, 0.35, {Transparency = 0})
    
    -- Progress bar
    local progressBg = Create("Frame", {
        Parent = notif,
        BackgroundColor3 = theme.Border,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -32, 0, 2),
        Position = UDim2.new(0, 16, 1, -10),
        ZIndex = 2
    })
    Corner(progressBg, UDim.new(1, 0))
    
    local progress = Create("Frame", {
        Parent = progressBg,
        BackgroundColor3 = accentColor,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 3
    })
    Corner(progress, UDim.new(1, 0))
    Gradient(progress, ColorSequence.new(accentColor, theme.AccentGlow), 0)
    
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
    self.Subtitle = config.Subtitle or "Obsidian Edition"
    self.ThemeName = config.Theme or "Obsidian"
    self.Theme = Themes[self.ThemeName] or Themes.Obsidian
    self.Tabs = {}
    self.ActiveTab = nil
    self.Minimized = false
    self.Size = config.Size or UDim2.new(0, 680, 0, 440)
    
    local gui = Create("ScreenGui", {
        Name = "Zazu_" .. HttpService:GenerateGUID(false),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true
    })
    gui.Parent = GetGuiParent()
    self.ScreenGui = gui
    
    -- Main window
    local main = Create("Frame", {
        Name = "Main",
        Parent = gui,
        BackgroundColor3 = self.Theme.Base,
        BorderSizePixel = 0,
        Size = self.Size,
        Position = UDim2.new(0.5, -self.Size.X.Offset / 2, 0.5, -self.Size.Y.Offset / 2),
        ClipsDescendants = true
    })
    Corner(main, UDim.new(0, 16))
    local mainStroke = Stroke(main, self.Theme.Border, 1.5)
    AddShadow(main, 32, 0.35)
    self.Main = main
    
    -- Inner gradient
    local mainGrad = Gradient(main, ColorSequence.new({
        ColorSequenceKeypoint.new(0, self.Theme.Surface),
        ColorSequenceKeypoint.new(0.5, self.Theme.Base),
        ColorSequenceKeypoint.new(1, self.Theme.Surface)
    }), 135)
    
    -- Particles
    self.Particles = CreateParticles(main, self.Theme)
    
    -- Top bar
    local topBar = Create("Frame", {
        Name = "TopBar",
        Parent = main,
        BackgroundColor3 = self.Theme.Surface,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 62),
        ZIndex = 3
    })
    Corner(topBar, UDim.new(0, 16))
    
    local topBarCover = Create("Frame", {
        Parent = topBar,
        BackgroundColor3 = self.Theme.Surface,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 25),
        Position = UDim2.new(0, 0, 1, -25),
        ZIndex = 3
    })
    
    local topGrad = Gradient(topBar, ColorSequence.new({
        ColorSequenceKeypoint.new(0, self.Theme.Surface3),
        ColorSequenceKeypoint.new(1, self.Theme.Surface)
    }), 90)
    
    -- Bottom border of topbar
    local topBorder = Create("Frame", {
        Parent = topBar,
        BackgroundColor3 = self.Theme.Border,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        ZIndex = 4
    })
    Gradient(topBorder, ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.5, self.Theme.Accent),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    }), 0)
    
    -- Logo with glow
    local logoWrap = Create("Frame", {
        Parent = topBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(0, 18, 0.5, -20),
        ZIndex = 5
    })
    
    local logoGlow = Create("ImageLabel", {
        Parent = logoWrap,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 30, 1, 30),
        Position = UDim2.new(0, -15, 0, -15),
        Image = Config.GlowImage,
        ImageColor3 = self.Theme.Accent,
        ImageTransparency = 0.3,
        ZIndex = 4,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(24, 24, 276, 276)
    })
    
    local logo = Create("Frame", {
        Parent = logoWrap,
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 5
    })
    Corner(logo, UDim.new(0, 12))
    local logoGrad = Gradient(logo, ColorSequence.new({
        ColorSequenceKeypoint.new(0, self.Theme.AccentGlow),
        ColorSequenceKeypoint.new(0.5, self.Theme.Accent),
        ColorSequenceKeypoint.new(1, self.Theme.AccentDeep)
    }), 135)
    
    Create("TextLabel", {
        Parent = logo,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Config.FontBlack,
        Text = "Z",
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 22,
        ZIndex = 6
    })
    
    -- Title
    local titleBox = Create("Frame", {
        Parent = topBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0, 72, 0, 0),
        ZIndex = 5
    })
    
    Create("TextLabel", {
        Parent = titleBox,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 24),
        Position = UDim2.new(0, 0, 0, 12),
        Font = Config.FontBlack,
        Text = self.Title,
        TextColor3 = self.Theme.Text,
        TextSize = 17,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 5
    })
    
    local subtitleFrame = Create("Frame", {
        Parent = titleBox,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 16),
        Position = UDim2.new(0, 0, 0, 34),
        ZIndex = 5
    })
    
    Create("TextLabel", {
        Parent = subtitleFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Config.FontMedium,
        Text = self.Subtitle,
        TextColor3 = self.Theme.Accent,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 5
    })
    
    -- Window controls
    local controls = Create("Frame", {
        Parent = topBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 80, 0, 34),
        Position = UDim2.new(1, -96, 0.5, -17),
        ZIndex = 5
    })
    
    local function makeCtrlBtn(icon, xPos, hoverColor)
        local btn = Create("TextButton", {
            Parent = controls,
            BackgroundColor3 = self.Theme.Surface3,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 34, 0, 34),
            Position = UDim2.new(0, xPos, 0, 0),
            Font = Config.FontBold,
            Text = icon,
            TextColor3 = self.Theme.SubText,
            TextSize = 13,
            AutoButtonColor = false,
            ZIndex = 6
        })
        Corner(btn, UDim.new(0, 10))
        local bStroke = Stroke(btn, self.Theme.Border, 1)
        
        btn.MouseEnter:Connect(function()
            Tween(btn, 0.15, {BackgroundColor3 = hoverColor or self.Theme.Surface4, TextColor3 = self.Theme.Text})
            Tween(bStroke, 0.15, {Color = self.Theme.BorderBright})
        end)
        btn.MouseLeave:Connect(function()
            Tween(btn, 0.15, {BackgroundColor3 = self.Theme.Surface3, TextColor3 = self.Theme.SubText})
            Tween(bStroke, 0.15, {Color = self.Theme.Border})
        end)
        return btn
    end
    
    local minBtn = makeCtrlBtn("—", 0)
    local closeBtn = makeCtrlBtn("✕", 42, self.Theme.Error)
    
    minBtn.MouseButton1Click:Connect(function()
        self.Minimized = not self.Minimized
        local targetSize = self.Minimized and UDim2.new(self.Size.X.Scale, self.Size.X.Offset, 0, 62) or self.Size
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
        Size = UDim2.new(0, 180, 1, -84),
        Position = UDim2.new(0, 12, 0, 74),
        ZIndex = 2
    })
    Corner(sidebar, UDim.new(0, 14))
    local sStroke = Stroke(sidebar, self.Theme.Border, 1)
    self.Sidebar = sidebar
    
    -- User card
    local userCard = Create("Frame", {
        Parent = sidebar,
        BackgroundColor3 = self.Theme.Surface3,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -20, 0, 54),
        Position = UDim2.new(0, 10, 0, 10),
        ZIndex = 3
    })
    Corner(userCard, UDim.new(0, 12))
    local ucStroke = Stroke(userCard, self.Theme.Border, 1)
    Gradient(userCard, ColorSequence.new({
        ColorSequenceKeypoint.new(0, self.Theme.Surface4),
        ColorSequenceKeypoint.new(1, self.Theme.Surface3)
    }), 135)
    
    local avatarWrap = Create("Frame", {
        Parent = userCard,
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 36, 0, 36),
        Position = UDim2.new(0, 10, 0.5, -18),
        ZIndex = 4
    })
    Corner(avatarWrap, UDim.new(0, 10))
    Gradient(avatarWrap, ColorSequence.new({
        ColorSequenceKeypoint.new(0, self.Theme.AccentGlow),
        ColorSequenceKeypoint.new(1, self.Theme.AccentDeep)
    }), 135)
    
    local avatar = Create("ImageLabel", {
        Parent = avatarWrap,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -4, 1, -4),
        Position = UDim2.new(0, 2, 0, 2),
        Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=48&h=48",
        ZIndex = 5
    })
    Corner(avatar, UDim.new(0, 8))
    
    Create("TextLabel", {
        Parent = userCard,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -60, 0, 18),
        Position = UDim2.new(0, 54, 0, 10),
        Font = Config.FontBold,
        Text = LocalPlayer.DisplayName,
        TextColor3 = self.Theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 4
    })
    
    local statusRow = Create("Frame", {
        Parent = userCard,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -60, 0, 14),
        Position = UDim2.new(0, 54, 0, 30),
        ZIndex = 4
    })
    
    local statusDot = Create("Frame", {
        Parent = statusRow,
        BackgroundColor3 = self.Theme.Success,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 6, 0, 6),
        Position = UDim2.new(0, 0, 0.5, -3),
        ZIndex = 5
    })
    Corner(statusDot, UDim.new(1, 0))
    
    Create("TextLabel", {
        Parent = statusRow,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -12, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        Font = Config.Font,
        Text = "online",
        TextColor3 = self.Theme.SubText,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 5
    })
    
    -- Tab container
    local tabContainer = Create("ScrollingFrame", {
        Parent = sidebar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 1, -96),
        Position = UDim2.new(0, 10, 0, 74),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = self.Theme.Accent,
        ScrollBarImageTransparency = 0.6,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ZIndex = 3
    })
    ListLayout(tabContainer, 6, Enum.SortOrder.LayoutOrder)
    self.TabContainer = tabContainer
    
    -- Content area
    local content = Create("Frame", {
        Name = "Content",
        Parent = main,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -216, 1, -84),
        Position = UDim2.new(0, 204, 0, 74),
        ZIndex = 2
    })
    self.Content = content
    
    -- Bottom bar
    local bottomBar = Create("Frame", {
        Parent = main,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -24, 0, 20),
        Position = UDim2.new(0, 12, 1, -26),
        ZIndex = 3
    })
    
    -- Status indicators
    local statusLeft = Create("Frame", {
        Parent = bottomBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0)
    })
    
    local fpsDot = Create("Frame", {
        Parent = statusLeft,
        BackgroundColor3 = self.Theme.Success,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 5, 0, 5),
        Position = UDim2.new(0, 0, 0.5, -2.5)
    })
    Corner(fpsDot, UDim.new(1, 0))
    
    local fpsLbl = Create("TextLabel", {
        Parent = statusLeft,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 100, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Font = Config.Font,
        Text = "fps: 60",
        TextColor3 = self.Theme.Muted,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    task.spawn(function()
        while gui.Parent do
            local fps = math.floor(1 / RunService.RenderStepped:Wait())
            fpsLbl.Text = "fps: " .. tostring(math.clamp(fps, 0, 999))
            task.wait(0.5)
        end
    end)
    
    Create("TextLabel", {
        Parent = bottomBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        Font = Config.Font,
        Text = "Zazu Library v3.0",
        TextColor3 = self.Theme.Muted,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Right
    })
    
    -- Fade in
    main.BackgroundTransparency = 1
    main.Size = UDim2.new(0, 0, 0, 0)
    Tween(main, 0.5, {
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

--// Tab
function Zazu:Tab(name, icon)
    local tab = {Name = name, Icon = icon or "●"}
    local theme = self.Theme
    
    local btn = Create("TextButton", {
        Parent = self.TabContainer,
        BackgroundColor3 = theme.Surface2,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -4, 0, 42),
        Font = Config.FontMedium,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 4
    })
    Corner(btn, UDim.new(0, 10))
    
    local btnStroke = Stroke(btn, theme.Border, 1, 0.5)
    
    local iconFrame = Create("Frame", {
        Parent = btn,
        BackgroundColor3 = theme.Surface4,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 26, 0, 26),
        Position = UDim2.new(0, 10, 0.5, -13),
        ZIndex = 5
    })
    Corner(iconFrame, UDim.new(0, 8))
    
    local iconLbl = Create("TextLabel", {
        Parent = iconFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Config.FontBold,
        Text = tab.Icon,
        TextColor3 = theme.SubText,
        TextSize = 12,
        ZIndex = 6
    })
    
    local textLbl = Create("TextLabel", {
        Parent = btn,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.new(0, 42, 0, 0),
        Font = Config.FontMedium,
        Text = name,
        TextColor3 = theme.SubText,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 5
    })
    
    local indicator = Create("Frame", {
        Parent = btn,
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 3, 0, 0),
        Position = UDim2.new(1, -1.5, 0.5, 0),
        ZIndex = 6
    })
    Corner(indicator, UDim.new(1, 0))
    
    local page = Create("ScrollingFrame", {
        Parent = self.Content,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = theme.Accent,
        ScrollBarImageTransparency = 0.5,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ZIndex = 3
    })
    ListLayout(page, 12, Enum.SortOrder.LayoutOrder)
    Padding(page, 4, 12, 0, 12)
    
    tab.Button = btn
    tab.Page = page
    tab.Indicator = indicator
    tab.IconLbl = iconLbl
    tab.TextLbl = textLbl
    tab.IconFrame = iconFrame
    tab.Stroke = btnStroke
    
    btn.MouseEnter:Connect(function()
        if self.ActiveTab ~= tab then
            Tween(btn, 0.15, {BackgroundColor3 = theme.Surface3})
            Tween(textLbl, 0.15, {TextColor3 = theme.Text2})
            Tween(iconFrame, 0.15, {BackgroundColor3 = theme.AccentSoft})
            Tween(iconLbl, 0.15, {TextColor3 = theme.AccentGlow})
            Tween(btnStroke, 0.15, {Color = theme.BorderBright})
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if self.ActiveTab ~= tab then
            Tween(btn, 0.15, {BackgroundColor3 = theme.Surface2})
            Tween(textLbl, 0.15, {TextColor3 = theme.SubText})
            Tween(iconFrame, 0.15, {BackgroundColor3 = theme.Surface4})
            Tween(iconLbl, 0.15, {TextColor3 = theme.SubText})
            Tween(btnStroke, 0.15, {Color = theme.Border})
        end
    end)
    
    btn.MouseButton1Click:Connect(function()
        if self.ActiveTab == tab then return end
        
        if self.ActiveTab then
            local oldTab = self.ActiveTab
            Tween(oldTab.Button, 0.15, {BackgroundColor3 = theme.Surface2})
            Tween(oldTab.TextLbl, 0.15, {TextColor3 = theme.SubText})
            Tween(oldTab.IconFrame, 0.15, {BackgroundColor3 = theme.Surface4})
            Tween(oldTab.IconLbl, 0.15, {TextColor3 = theme.SubText})
            Tween(oldTab.Indicator, 0.15, {Size = UDim2.new(0, 3, 0, 0)})
            Tween(oldTab.Stroke, 0.15, {Color = theme.Border})
            oldTab.Page.Visible = false
        end
        
        self.ActiveTab = tab
        Tween(btn, 0.15, {BackgroundColor3 = theme.Surface4})
        Tween(textLbl, 0.15, {TextColor3 = theme.Text})
        Tween(iconFrame, 0.2, {BackgroundColor3 = theme.Accent})
        Tween(iconLbl, 0.2, {TextColor3 = Color3.new(1, 1, 1)})
        Tween(indicator, 0.3, {Size = UDim2.new(0, 3, 0.6, 0)}, Enum.EasingStyle.Back)
        Tween(btnStroke, 0.15, {Color = theme.AccentSoft})
        page.Visible = true
    end)
    
    if not self.ActiveTab then
        self.ActiveTab = tab
        btn.BackgroundColor3 = theme.Surface4
        textLbl.TextColor3 = theme.Text
        iconFrame.BackgroundColor3 = theme.Accent
        iconLbl.TextColor3 = Color3.new(1, 1, 1)
        indicator.Size = UDim2.new(0, 3, 0.6, 0)
        btnStroke.Color = theme.AccentSoft
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
        Size = UDim2.new(1, 0, 0, 52),
        AutomaticSize = Enum.AutomaticSize.Y,
        ClipsDescendants = true
    })
    Corner(container, UDim.new(0, 14))
    local cStroke = Stroke(container, theme.Border, 1)
    Padding(container, 16, 16, 16, 16)
    
    -- Subtle gradient
    Gradient(container, ColorSequence.new({
        ColorSequenceKeypoint.new(0, theme.Surface2),
        ColorSequenceKeypoint.new(1, theme.Surface)
    }), 135)
    
    local header = Create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 22),
        Text = "",
        AutoButtonColor = false
    })
    
    -- Accent bar
    local accentBar = Create("Frame", {
        Parent = header,
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 3, 0, 14),
        Position = UDim2.new(0, 0, 0.5, -7)
    })
    Corner(accentBar, UDim.new(1, 0))
    Gradient(accentBar, ColorSequence.new(theme.AccentGlow, theme.AccentDeep), 90)
    
    Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -30, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        Font = Config.FontBlack,
        Text = string.upper(name),
        TextColor3 = theme.Text2,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- divider line
    local divider = Create("Frame", {
        Parent = container,
        BackgroundColor3 = theme.Border,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 0, 32),
        ZIndex = 1
    })
    Gradient(divider, ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(0.5, theme.BorderBright),
        ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
    }), 0)
    
    local contentFrame = Create("Frame", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 44),
        AutomaticSize = Enum.AutomaticSize.Y
    })
    ListLayout(contentFrame, 8, Enum.SortOrder.LayoutOrder)
    
    section.Container = container
    section.Content = contentFrame
    section.Stroke = cStroke
    
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
            local targetPos = section.Collapsed and UDim2.new(0, 0, 0, 0) or UDim2.new(0, 0, 0, 44)
            Tween(contentFrame, 0.3, {Position = targetPos}, Enum.EasingStyle.Quart)
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
        BackgroundColor3 = theme.Surface3,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 40),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text,
        TextSize = 13,
        AutoButtonColor = false
    })
    Corner(btn, UDim.new(0, 10))
    local btnStroke = Stroke(btn, theme.Border, 1)
    Gradient(btn, ColorSequence.new({
        ColorSequenceKeypoint.new(0, theme.Surface4),
        ColorSequenceKeypoint.new(1, theme.Surface3)
    }), 90)
    
    RippleEffect(btn, theme.AccentGlow)
    
    btn.MouseEnter:Connect(function()
        Tween(btn, 0.18, {BackgroundColor3 = theme.Accent})
        Tween(btnStroke, 0.18, {Color = theme.AccentGlow, Transparency = 0})
    end)
    
    btn.MouseLeave:Connect(function()
        Tween(btn, 0.18, {BackgroundColor3 = theme.Surface3})
        Tween(btnStroke, 0.18, {Color = theme.Border, Transparency = 0})
    end)
    
    btn.MouseButton1Click:Connect(function()
        Tween(btn, 0.08, {Size = UDim2.new(0.97, 0, 0, 40)})
        task.wait(0.08)
        Tween(btn, 0.08, {Size = UDim2.new(1, 0, 0, 40)})
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
        BackgroundColor3 = theme.Surface2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 42)
    })
    Corner(container, UDim.new(0, 10))
    local cStroke = Stroke(container, theme.Border, 1)
    
    Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text2,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local track = Create("Frame", {
        Parent = container,
        BackgroundColor3 = state and theme.Accent or theme.Surface4,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 44, 0, 22),
        Position = UDim2.new(1, -60, 0.5, -11)
    })
    Corner(track, UDim.new(1, 0))
    local tStroke = Stroke(track, state and theme.AccentGlow or theme.Border, 1)
    local tGrad = Gradient(track, ColorSequence.new({
        ColorSequenceKeypoint.new(0, state and theme.AccentGlow or theme.Surface4),
        ColorSequenceKeypoint.new(1, state and theme.AccentDeep or theme.Surface3)
    }), 90)
    
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
        Tween(container, 0.15, {BackgroundColor3 = theme.Surface3})
        Tween(cStroke, 0.15, {Color = theme.BorderBright})
    end)
    btn.MouseLeave:Connect(function()
        Tween(container, 0.15, {BackgroundColor3 = theme.Surface2})
        Tween(cStroke, 0.15, {Color = theme.Border})
    end)
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        Tween(track, 0.2, {BackgroundColor3 = state and theme.Accent or theme.Surface4})
        Tween(tStroke, 0.2, {Color = state and theme.AccentGlow or theme.Border})
        tGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, state and theme.AccentGlow or theme.Surface4),
            ColorSequenceKeypoint.new(1, state and theme.AccentDeep or theme.Surface3)
        })
        Tween(knob, 0.25, {Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}, Enum.EasingStyle.Back)
        if callback then callback(state) end
    end)
    
    return {
        Set = function(v)
            state = v
            Tween(track, 0.2, {BackgroundColor3 = state and theme.Accent or theme.Surface4})
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
        BackgroundColor3 = theme.Surface2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 60)
    })
    Corner(container, UDim.new(0, 10))
    Stroke(container, theme.Border, 1)
    
    Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.65, 0, 0, 20),
        Position = UDim2.new(0, 16, 0, 10),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text2,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local valBox = Create("Frame", {
        Parent = container,
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 62, 0, 22),
        Position = UDim2.new(1, -78, 0, 9)
    })
    Corner(valBox, UDim.new(0, 8))
    Gradient(valBox, ColorSequence.new(theme.AccentGlow, theme.AccentDeep), 135)
    
    local valLbl = Create("TextLabel", {
        Parent = valBox,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Config.FontBold,
        Text = tostring(value),
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 12
    })
    
    local barBg = Create("Frame", {
        Parent = container,
        BackgroundColor3 = theme.Surface4,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -32, 0, 6),
        Position = UDim2.new(0, 16, 0, 42)
    })
    Corner(barBg, UDim.new(1, 0))
    Stroke(barBg, theme.Border, 1, 0.5)
    
    local fill = Create("Frame", {
        Parent = barBg,
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
    })
    Corner(fill, UDim.new(1, 0))
    Gradient(fill, ColorSequence.new(theme.AccentDeep, theme.AccentGlow), 0)
    
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
        BackgroundColor3 = theme.Surface2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 42)
    })
    Corner(container, UDim.new(0, 10))
    local cStroke = Stroke(container, theme.Border, 1)
    
    Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.4, 0, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text2,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local box = Create("TextBox", {
        Parent = container,
        BackgroundColor3 = theme.Surface4,
        BorderSizePixel = 0,
        Size = UDim2.new(0.55, -16, 0, 30),
        Position = UDim2.new(0.45, 0, 0.5, -15),
        Font = Config.Font,
        PlaceholderText = placeholder or "Введите...",
        PlaceholderColor3 = theme.Muted,
        Text = "",
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Center,
        ClearTextOnFocus = false
    })
    Corner(box, UDim.new(0, 8))
    local bStroke = Stroke(box, theme.Border, 1)
    
    box.Focused:Connect(function()
        Tween(bStroke, 0.18, {Color = theme.Accent, Thickness = 1.5})
        Tween(container, 0.18, {BackgroundColor3 = theme.Surface3})
        Tween(cStroke, 0.18, {Color = theme.AccentSoft})
    end)
    
    box.FocusLost:Connect(function()
        Tween(bStroke, 0.18, {Color = theme.Border, Thickness = 1})
        Tween(container, 0.18, {BackgroundColor3 = theme.Surface2})
        Tween(cStroke, 0.18, {Color = theme.Border})
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
        BackgroundColor3 = theme.Surface2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 42),
        ClipsDescendants = true
    })
    Corner(container, UDim.new(0, 10))
    local cStroke = Stroke(container, theme.Border, 1)
    
    local header = Create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 42),
        Text = "",
        AutoButtonColor = false
    })
    
    Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text2,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local selBox = Create("Frame", {
        Parent = header,
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 100, 0, 24),
        Position = UDim2.new(1, -132, 0.5, -12)
    })
    Corner(selBox, UDim.new(0, 8))
    Gradient(selBox, ColorSequence.new(theme.AccentGlow, theme.AccentDeep), 135)
    
    local selLbl = Create("TextLabel", {
        Parent = selBox,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -8, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Font = Config.FontBold,
        Text = tostring(selected),
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 11,
        TextTruncate = Enum.TextTruncate.AtEnd
    })
    
    local arrow = Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(1, -24, 0, 0),
        Font = Config.FontBold,
        Text = "▼",
        TextColor3 = theme.SubText,
        TextSize = 9
    })
    
    local optContainer = Create("Frame", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -16, 0, 0),
        Position = UDim2.new(0, 8, 0, 46),
        AutomaticSize = Enum.AutomaticSize.Y
    })
    ListLayout(optContainer, 4, Enum.SortOrder.LayoutOrder)
    
    for _, opt in ipairs(options) do
        local ob = Create("TextButton", {
            Parent = optContainer,
            BackgroundColor3 = theme.Surface4,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 32),
            Font = Config.Font,
            Text = tostring(opt),
            TextColor3 = theme.Text2,
            TextSize = 12,
            AutoButtonColor = false
        })
        Corner(ob, UDim.new(0, 8))
        
        ob.MouseEnter:Connect(function()
            Tween(ob, 0.12, {BackgroundColor3 = theme.Accent, TextColor3 = Color3.new(1, 1, 1)})
        end)
        ob.MouseLeave:Connect(function()
            Tween(ob, 0.12, {BackgroundColor3 = theme.Surface4, TextColor3 = theme.Text2})
        end)
        ob.MouseButton1Click:Connect(function()
            selected = opt
            selLbl.Text = tostring(opt)
            open = false
            Tween(container, 0.25, {Size = UDim2.new(1, 0, 0, 42)})
            Tween(arrow, 0.2, {Rotation = 0})
            if callback then callback(opt) end
        end)
    end
    
    header.MouseButton1Click:Connect(function()
        open = not open
        if open then
            local h = 42 + (#options * 36) + 12
            Tween(container, 0.3, {Size = UDim2.new(1, 0, 0, h)}, Enum.EasingStyle.Quart)
            Tween(arrow, 0.25, {Rotation = 180})
        else
            Tween(container, 0.3, {Size = UDim2.new(1, 0, 0, 42)}, Enum.EasingStyle.Quart)
            Tween(arrow, 0.25, {Rotation = 0})
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
        BackgroundColor3 = theme.Surface2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 42),
        ClipsDescendants = true
    })
    Corner(container, UDim.new(0, 10))
    Stroke(container, theme.Border, 1)
    
    local header = Create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 42),
        Text = "",
        AutoButtonColor = false
    })
    
    Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text2,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local countBox = Create("Frame", {
        Parent = header,
        BackgroundColor3 = theme.Surface4,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 100, 0, 24),
        Position = UDim2.new(1, -132, 0.5, -12)
    })
    Corner(countBox, UDim.new(0, 8))
    Stroke(countBox, theme.Border, 1)
    
    local countLbl = Create("TextLabel", {
        Parent = countBox,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Config.FontBold,
        Text = "0 выбрано",
        TextColor3 = theme.Accent,
        TextSize = 11
    })
    
    local arrow = Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(1, -24, 0, 0),
        Font = Config.FontBold,
        Text = "▼",
        TextColor3 = theme.SubText,
        TextSize = 9
    })
    
    local optContainer = Create("Frame", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -16, 0, 0),
        Position = UDim2.new(0, 8, 0, 46),
        AutomaticSize = Enum.AutomaticSize.Y
    })
    ListLayout(optContainer, 4, Enum.SortOrder.LayoutOrder)
    
    local function updateCount()
        countLbl.Text = #selected .. " выбрано"
        if callback then callback(selected) end
    end
    
    for _, opt in ipairs(options) do
        local ob = Create("TextButton", {
            Parent = optContainer,
            BackgroundColor3 = theme.Surface4,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 32),
            Font = Config.Font,
            Text = "  " .. tostring(opt),
            TextColor3 = theme.Text2,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutoButtonColor = false
        })
        Corner(ob, UDim.new(0, 8))
        
        local check = Create("Frame", {
            Parent = ob,
            BackgroundColor3 = theme.Muted,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 16, 0, 16),
            Position = UDim2.new(1, -24, 0.5, -8)
        })
        Corner(check, UDim.new(0, 4))
        
        ob.MouseButton1Click:Connect(function()
            local isSelected = table.find(selected, opt)
            if isSelected then
                table.remove(selected, isSelected)
                Tween(ob, 0.12, {BackgroundColor3 = theme.Surface4, TextColor3 = theme.Text2})
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
            local h = 42 + (#options * 36) + 12
            Tween(container, 0.3, {Size = UDim2.new(1, 0, 0, h)}, Enum.EasingStyle.Quart)
            Tween(arrow, 0.25, {Rotation = 180})
        else
            Tween(container, 0.3, {Size = UDim2.new(1, 0, 0, 42)}, Enum.EasingStyle.Quart)
            Tween(arrow, 0.25, {Rotation = 0})
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
        BackgroundColor3 = theme.Surface2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 42)
    })
    Corner(container, UDim.new(0, 10))
    Stroke(container, theme.Border, 1)
    
    Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.6, 0, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text2,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local keyBtn = Create("TextButton", {
        Parent = container,
        BackgroundColor3 = theme.Surface4,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 70, 0, 28),
        Position = UDim2.new(1, -86, 0.5, -14),
        Font = Config.FontBold,
        Text = key,
        TextColor3 = theme.Text,
        TextSize = 12,
        AutoButtonColor = false
    })
    Corner(keyBtn, UDim.new(0, 8))
    local kStroke = Stroke(keyBtn, theme.Border, 1)
    
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
            Tween(kStroke, 0.15, {Color = theme.Border, Thickness = 1})
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
        BackgroundColor3 = theme.Surface2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 42),
        ClipsDescendants = true
    })
    Corner(container, UDim.new(0, 10))
    Stroke(container, theme.Border, 1)
    
    local header = Create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 42),
        Text = "",
        AutoButtonColor = false
    })
    
    Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.6, 0, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        Font = Config.FontMedium,
        Text = text,
        TextColor3 = theme.Text2,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local preview = Create("Frame", {
        Parent = header,
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 70, 0, 26),
        Position = UDim2.new(1, -86, 0.5, -13)
    })
    Corner(preview, UDim.new(0, 8))
    Stroke(preview, theme.BorderBright, 1)
    
    local pickerFrame = Create("Frame", {
        Parent = container,
        BackgroundColor3 = theme.Surface3,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -20, 0, 130),
        Position = UDim2.new(0, 10, 0, 48)
    })
    Corner(pickerFrame, UDim.new(0, 10))
    pickerFrame.Visible = false
    
    local satValBox = Create("Frame", {
        Parent = pickerFrame,
        BackgroundColor3 = Color3.fromHSV(hue, 1, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(1, -90, 1, -20),
        Position = UDim2.new(0, 10, 0, 10)
    })
    Corner(satValBox, UDim.new(0, 8))
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
    Corner(svBlack, UDim.new(0, 8))
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
        Size = UDim2.new(0, 22, 1, -20),
        Position = UDim2.new(1, -76, 0, 10)
    })
    Corner(hueBar, UDim.new(0, 8))
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
    
    local hexBox = Create("TextBox", {
        Parent = pickerFrame,
        BackgroundColor3 = theme.Surface4,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 88, 0, 24),
        Position = UDim2.new(1, -42, 1, -32),
        Font = Config.FontBold,
        Text = "#" .. color:ToHex(),
        TextColor3 = theme.Accent,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Center
    })
    Corner(hexBox, UDim.new(0, 6))
    Stroke(hexBox, theme.Border, 1)
    
    header.MouseButton1Click:Connect(function()
        open = not open
        pickerFrame.Visible = open
        local targetH = open and 42 + 138 or 42
        Tween(container, 0.32, {Size = UDim2.new(1, 0, 0, targetH)}, Enum.EasingStyle.Quart)
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
                hexBox.Text = "#" .. color:ToHex()
                if callback then callback(color) end
            elseif draggingHue then
                local y = math.clamp((input.Position.Y - hueBar.AbsolutePosition.Y) / hueBar.AbsoluteSize.Y, 0, 1)
                hue = y
                hueKnob.Position = UDim2.new(0, -3, y, -2)
                satValBox.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
                color = Color3.fromHSV(hue, sat, val)
                preview.BackgroundColor3 = color
                hexBox.Text = "#" .. color:ToHex()
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
            hexBox.Text = "#" .. c:ToHex()
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
        Size = UDim2.new(1, 0, 0, 22),
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

--// Paragraph
function Zazu:Paragraph(section, title, text)
    local theme = self.Theme
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = theme.Surface3,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    })
    Corner(container, UDim.new(0, 10))
    Stroke(container, theme.Border, 1)
    Padding(container, 14, 14, 16, 16)
    
    local bar = Create("Frame", {
        Parent = container,
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 3, 0, 16),
        Position = UDim2.new(0, 0, 0, 0)
    })
    Corner(bar, UDim.new(1, 0))
    Gradient(bar, ColorSequence.new(theme.AccentGlow, theme.AccentDeep), 90)
    
    Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -14, 0, 18),
        Position = UDim2.new(0, 14, 0, 0),
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
        Position = UDim2.new(0, 0, 0, 24),
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
    local theme = self.Theme
    local div = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = theme.Border,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1)
    })
    Gradient(div, ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(0.5, theme.BorderBright),
        ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
    }), 0)
    return div
end

--// Separator (with label)
function Zazu:Separator(section, text)
    local theme = self.Theme
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 16)
    })
    
    local leftLine = Create("Frame", {
        Parent = container,
        BackgroundColor3 = theme.Border,
        BorderSizePixel = 0,
        Size = UDim2.new(0.35, 0, 0, 1),
        Position = UDim2.new(0, 0, 0.5, 0)
    })
    
    local rightLine = Create("Frame", {
        Parent = container,
        BackgroundColor3 = theme.Border,
        BorderSizePixel = 0,
        Size = UDim2.new(0.35, 0, 0, 1),
        Position = UDim2.new(0.65, 0, 0.5, 0)
    })
    
    Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.3, 0, 1, 0),
        Position = UDim2.new(0.35, 0, 0, 0),
        Font = Config.FontBold,
        Text = string.upper(text),
        TextColor3 = theme.Muted,
        TextSize = 10
    })
    
    return container
end

return Zazu
