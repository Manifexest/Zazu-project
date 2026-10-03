-- Zazu Library v1.0
-- UI Library for Roblox

local Zazu = {}
Zazu.__index = Zazu

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

--// Config
local Config = {
    Colors = {
        Background = Color3.fromRGB(15, 15, 20),
        Secondary = Color3.fromRGB(25, 25, 32),
        Accent = Color3.fromRGB(138, 43, 226),
        AccentDark = Color3.fromRGB(98, 20, 186),
        Text = Color3.fromRGB(240, 240, 245),
        SubText = Color3.fromRGB(150, 150, 160),
        Toggle = Color3.fromRGB(138, 43, 226),
        ToggleOff = Color3.fromRGB(50, 50, 60),
        Slider = Color3.fromRGB(138, 43, 226),
        SliderBg = Color3.fromRGB(40, 40, 48),
        Outline = Color3.fromRGB(60, 60, 75),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Font = Enum.Font.Gotham,
    FontBold = Enum.Font.GothamBold,
    CornerRadius = UDim.new(0, 8),
    AnimSpeed = 0.2
}

--// Utility
local function Create(className, props)
    local inst = Instance.new(className)
    for k, v in pairs(props or {}) do
        inst[k] = v
    end
    return inst
end

local function Tween(obj, time, props, style)
    local t = TweenService:Create(obj, TweenInfo.new(time or Config.AnimSpeed, style or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local function Corner(parent, radius)
    return Create("UICorner", {
        CornerRadius = radius or Config.CornerRadius,
        Parent = parent
    })
end

local function Stroke(parent, color, thickness)
    return Create("UIStroke", {
        Color = color or Config.Colors.Outline,
        Thickness = thickness or 1,
        Parent = parent
    })
end

local function Gradient(parent, color1, color2, rotation)
    return Create("UIGradient", {
        Color = ColorSequence.new(color1, color2),
        Rotation = rotation or 90,
        Parent = parent
    })
end

--// Dragging
local function MakeDraggable(frame, dragArea)
    dragArea = dragArea or frame
    local dragging, dragInput, dragStart, startPos
    
    dragArea.InputBegan:Connect(function(input)
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
    
    dragArea.InputChanged:Connect(function(input)
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

--// Notification
function Zazu:Notify(title, text, duration)
    duration = duration or 3
    
    local notif = Create("Frame", {
        Name = "ZazuNotify",
        Parent = self.ScreenGui,
        BackgroundColor3 = Config.Colors.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 300, 0, 80),
        Position = UDim2.new(1, -320, 1, -100),
        BackgroundTransparency = 1
    })
    Corner(notif)
    Stroke(notif, Config.Colors.Accent, 1.5)
    
    local accent = Create("Frame", {
        Parent = notif,
        BackgroundColor3 = Config.Colors.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 4, 1, -16),
        Position = UDim2.new(0, 8, 0, 8)
    })
    Corner(accent, UDim.new(1, 0))
    
    local titleLbl = Create("TextLabel", {
        Parent = notif,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -30, 0, 25),
        Position = UDim2.new(0, 22, 0, 10),
        Font = Config.FontBold,
        Text = title,
        TextColor3 = Config.Colors.Text,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local textLbl = Create("TextLabel", {
        Parent = notif,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -30, 0, 35),
        Position = UDim2.new(0, 22, 0, 32),
        Font = Config.Font,
        Text = text,
        TextColor3 = Config.Colors.SubText,
        TextSize = 13,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top
    })
    
    notif.Position = UDim2.new(1, 0, 1, -100)
    Tween(notif, 0.4, {Position = UDim2.new(1, -320, 1, -100)})
    
    task.delay(duration, function()
        Tween(notif, 0.3, {Position = UDim2.new(1, 0, 1, -100)})
        task.wait(0.3)
        notif:Destroy()
    end)
end

--// Window
function Zazu.new(title, subtitle)
    local self = setmetatable({}, Zazu)
    
    self.Title = title or "Zazu"
    self.Subtitle = subtitle or "Library"
    self.Tabs = {}
    self.ActiveTab = nil
    self.Minimized = false
    
    local gui = Create("ScreenGui", {
        Name = "ZazuLibrary",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
    self.ScreenGui = gui
    
    local main = Create("Frame", {
        Name = "Main",
        Parent = gui,
        BackgroundColor3 = Config.Colors.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 600, 0, 400),
        Position = UDim2.new(0.5, -300, 0.5, -200),
        ClipsDescendants = true
    })
    Corner(main)
    Stroke(main, Config.Colors.Outline, 1)
    
    local shadow = Create("ImageLabel", {
        Parent = main,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 40, 1, 40),
        Position = UDim2.new(0, -20, 0, -20),
        Image = "rbxassetid://5028857084",
        ImageColor3 = Config.Colors.Shadow,
        ImageTransparency = 0.6,
        ZIndex = -1,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(24, 24, 276, 276)
    })
    
    -- Top Bar
    local topBar = Create("Frame", {
        Name = "TopBar",
        Parent = main,
        BackgroundColor3 = Config.Colors.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 50)
    })
    Corner(topBar, UDim.new(0, 8))
    
    local topBarCover = Create("Frame", {
        Parent = topBar,
        BackgroundColor3 = Config.Colors.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 15),
        Position = UDim2.new(0, 0, 1, -15)
    })
    
    local gradient = Gradient(topBar, Config.Colors.Secondary, Config.Colors.Background, 90)
    
    local titleLbl = Create("TextLabel", {
        Parent = topBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0, 20, 0, 0),
        Font = Config.FontBold,
        Text = self.Title,
        TextColor3 = Config.Colors.Text,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local accentDot = Create("Frame", {
        Parent = topBar,
        BackgroundColor3 = Config.Colors.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 8, 0, 8),
        Position = UDim2.new(0, 8, 0.5, -4)
    })
    Corner(accentDot, UDim.new(1, 0))
    
    -- Minimize Button
    local minBtn = Create("TextButton", {
        Parent = topBar,
        BackgroundColor3 = Config.Colors.ToggleOff,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -75, 0.5, -15),
        Font = Config.FontBold,
        Text = "—",
        TextColor3 = Config.Colors.Text,
        TextSize = 16,
        AutoButtonColor = false
    })
    Corner(minBtn, UDim.new(0, 6))
    
    -- Close Button
    local closeBtn = Create("TextButton", {
        Parent = topBar,
        BackgroundColor3 = Config.Colors.ToggleOff,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 0.5, -15),
        Font = Config.FontBold,
        Text = "✕",
        TextColor3 = Config.Colors.Text,
        TextSize = 14,
        AutoButtonColor = false
    })
    Corner(closeBtn, UDim.new(0, 6))
    
    minBtn.MouseEnter:Connect(function() Tween(minBtn, 0.15, {BackgroundColor3 = Config.Colors.Accent}) end)
    minBtn.MouseLeave:Connect(function() Tween(minBtn, 0.15, {BackgroundColor3 = Config.Colors.ToggleOff}) end)
    closeBtn.MouseEnter:Connect(function() Tween(closeBtn, 0.15, {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}) end)
    closeBtn.MouseLeave:Connect(function() Tween(closeBtn, 0.15, {BackgroundColor3 = Config.Colors.ToggleOff}) end)
    
    minBtn.MouseButton1Click:Connect(function()
        self.Minimized = not self.Minimized
        local targetSize = self.Minimized and UDim2.new(0, 600, 0, 50) or UDim2.new(0, 600, 0, 400)
        Tween(main, 0.3, {Size = targetSize})
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        Tween(main, 0.2, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)})
        task.wait(0.2)
        gui:Destroy()
    end)
    
    MakeDraggable(main, topBar)
    
    -- Sidebar
    local sidebar = Create("Frame", {
        Name = "Sidebar",
        Parent = main,
        BackgroundColor3 = Config.Colors.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 140, 1, -70),
        Position = UDim2.new(0, 10, 0, 60)
    })
    Corner(sidebar)
    
    local tabContainer = Create("ScrollingFrame", {
        Parent = sidebar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 1, -10),
        Position = UDim2.new(0, 5, 0, 5),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = Config.Colors.Accent,
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    })
    
    local tabLayout = Create("UIListLayout", {
        Parent = tabContainer,
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    -- Content Area
    local content = Create("Frame", {
        Name = "Content",
        Parent = main,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -170, 1, -70),
        Position = UDim2.new(0, 160, 0, 60)
    })
    
    self.Main = main
    self.Sidebar = sidebar
    self.TabContainer = tabContainer
    self.Content = content
    self.TopBar = topBar
    
    -- Fade in
    main.BackgroundTransparency = 1
    main.Size = UDim2.new(0, 0, 0, 0)
    Tween(main, 0.4, {BackgroundTransparency = 0, Size = UDim2.new(0, 600, 0, 400)})
    
    return self
end

--// Tab
function Zazu:Tab(name)
    local tab = {}
    tab.Name = name
    tab.Controls = {}
    
    local btn = Create("TextButton", {
        Parent = self.TabContainer,
        BackgroundColor3 = Config.Colors.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -4, 0, 36),
        Font = Config.Font,
        Text = "  " .. name,
        TextColor3 = Config.Colors.SubText,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false
    })
    Corner(btn, UDim.new(0, 6))
    
    local indicator = Create("Frame", {
        Parent = btn,
        BackgroundColor3 = Config.Colors.Accent,
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
        ScrollBarImageColor3 = Config.Colors.Accent,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false
    })
    
    local pageLayout = Create("UIListLayout", {
        Parent = page,
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    local pagePadding = Create("UIPadding", {
        Parent = page,
        PaddingRight = UDim.new(0, 8)
    })
    
    tab.Button = btn
    tab.Page = page
    tab.Layout = pageLayout
    
    btn.MouseEnter:Connect(function()
        if self.ActiveTab ~= tab then
            Tween(btn, 0.15, {BackgroundColor3 = Config.Colors.ToggleOff})
            Tween(btn, 0.15, {TextColor3 = Config.Colors.Text})
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if self.ActiveTab ~= tab then
            Tween(btn, 0.15, {BackgroundColor3 = Config.Colors.Background})
            Tween(btn, 0.15, {TextColor3 = Config.Colors.SubText})
        end
    end)
    
    btn.MouseButton1Click:Connect(function()
        if self.ActiveTab then
            Tween(self.ActiveTab.Button, 0.15, {BackgroundColor3 = Config.Colors.Background})
            Tween(self.ActiveTab.Button, 0.15, {TextColor3 = Config.Colors.SubText})
            Tween(self.ActiveTab.Button:FindFirstChildOfClass("Frame"), 0.15, {Size = UDim2.new(0, 3, 0, 0)})
            self.ActiveTab.Page.Visible = false
        end
        
        self.ActiveTab = tab
        Tween(btn, 0.15, {BackgroundColor3 = Config.Colors.ToggleOff})
        Tween(btn, 0.15, {TextColor3 = Config.Colors.Text})
        Tween(indicator, 0.2, {Size = UDim2.new(0, 3, 0.7, 0)})
        page.Visible = true
    end)
    
    if not self.ActiveTab then
        self.ActiveTab = tab
        btn.BackgroundColor3 = Config.Colors.ToggleOff
        btn.TextColor3 = Config.Colors.Text
        indicator.Size = UDim2.new(0, 3, 0.7, 0)
        page.Visible = true
    end
    
    table.insert(self.Tabs, tab)
    return tab
end

--// Section
function Zazu:Section(tab, name)
    local section = {}
    
    local container = Create("Frame", {
        Parent = tab.Page,
        BackgroundColor3 = Config.Colors.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 40),
        AutomaticSize = Enum.AutomaticSize.Y
    })
    Corner(container)
    Stroke(container, Config.Colors.Outline, 1)
    
    local padding = Create("UIPadding", {
        Parent = container,
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12)
    })
    
    local label = Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        Font = Config.FontBold,
        Text = name,
        TextColor3 = Config.Colors.Accent,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local contentFrame = Create("Frame", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 25),
        AutomaticSize = Enum.AutomaticSize.Y
    })
    
    local layout = Create("UIListLayout", {
        Parent = contentFrame,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    section.Container = container
    section.Content = contentFrame
    section.Layout = layout
    
    return section
end

--// Button
function Zazu:Button(section, text, callback)
    local btn = Create("TextButton", {
        Parent = section.Content,
        BackgroundColor3 = Config.Colors.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 34),
        Font = Config.Font,
        Text = text,
        TextColor3 = Config.Colors.Text,
        TextSize = 14,
        AutoButtonColor = false
    })
    Corner(btn, UDim.new(0, 6))
    Stroke(btn, Config.Colors.Outline, 1)
    
    btn.MouseEnter:Connect(function()
        Tween(btn, 0.15, {BackgroundColor3 = Config.Colors.Accent})
    end)
    btn.MouseLeave:Connect(function()
        Tween(btn, 0.15, {BackgroundColor3 = Config.Colors.Background})
    end)
    
    btn.MouseButton1Click:Connect(function()
        Tween(btn, 0.1, {Size = UDim2.new(0.97, 0, 0, 34)})
        task.wait(0.1)
        Tween(btn, 0.1, {Size = UDim2.new(1, 0, 0, 34)})
        if callback then callback() end
    end)
    
    return btn
end

--// Toggle
function Zazu:Toggle(section, text, default, callback)
    local state = default or false
    
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = Config.Colors.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 34)
    })
    Corner(container, UDim.new(0, 6))
    Stroke(container, Config.Colors.Outline, 1)
    
    local label = Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Font = Config.Font,
        Text = text,
        TextColor3 = Config.Colors.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local toggleBg = Create("Frame", {
        Parent = container,
        BackgroundColor3 = state and Config.Colors.Toggle or Config.Colors.ToggleOff,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 40, 0, 20),
        Position = UDim2.new(1, -50, 0.5, -10)
    })
    Corner(toggleBg, UDim.new(1, 0))
    
    local knob = Create("Frame", {
        Parent = toggleBg,
        BackgroundColor3 = Config.Colors.Text,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 16, 0, 16),
        Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    })
    Corner(knob, UDim.new(1, 0))
    
    local btn = Create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = ""
    })
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        Tween(toggleBg, 0.2, {BackgroundColor3 = state and Config.Colors.Toggle or Config.Colors.ToggleOff})
        Tween(knob, 0.2, {Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)})
        if callback then callback(state) end
    end)
    
    return {Set = function(v) state = v end, Get = function() return state end}
end

--// Slider
function Zazu:Slider(section, text, min, max, default, callback)
    min = min or 0
    max = max or 100
    local value = default or min
    
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = Config.Colors.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 50)
    })
    Corner(container, UDim.new(0, 6))
    Stroke(container, Config.Colors.Outline, 1)
    
    local label = Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.7, 0, 0, 20),
        Position = UDim2.new(0, 10, 0, 5),
        Font = Config.Font,
        Text = text,
        TextColor3 = Config.Colors.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local valueLbl = Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.3, -10, 0, 20),
        Position = UDim2.new(0.7, 0, 0, 5),
        Font = Config.FontBold,
        Text = tostring(value),
        TextColor3 = Config.Colors.Accent,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Right
    })
    
    local sliderBg = Create("Frame", {
        Parent = container,
        BackgroundColor3 = Config.Colors.SliderBg,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -20, 0, 6),
        Position = UDim2.new(0, 10, 0, 35)
    })
    Corner(sliderBg, UDim.new(1, 0))
    
    local fill = Create("Frame", {
        Parent = sliderBg,
        BackgroundColor3 = Config.Colors.Slider,
        BorderSizePixel = 0,
        Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
    })
    Corner(fill, UDim.new(1, 0))
    
    local knob = Create("Frame", {
        Parent = sliderBg,
        BackgroundColor3 = Config.Colors.Text,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new((value - min) / (max - min), -7, 0.5, -7),
        ZIndex = 2
    })
    Corner(knob, UDim.new(1, 0))
    Stroke(knob, Config.Colors.Accent, 2)
    
    local dragging = false
    
    local function update(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        value = math.floor(min + (max - min) * pos + 0.5)
        valueLbl.Text = tostring(value)
        Tween(fill, 0.05, {Size = UDim2.new(pos, 0, 1, 0)})
        Tween(knob, 0.05, {Position = UDim2.new(pos, -7, 0.5, -7)})
        if callback then callback(value) end
    end
    
    sliderBg.InputBegan:Connect(function(input)
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
    
    return {Set = function(v) value = v; valueLbl.Text = tostring(v) end, Get = function() return value end}
end

--// Textbox
function Zazu:Textbox(section, text, placeholder, callback)
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = Config.Colors.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 34)
    })
    Corner(container, UDim.new(0, 6))
    Stroke(container, Config.Colors.Outline, 1)
    
    local label = Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.4, 0, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Font = Config.Font,
        Text = text,
        TextColor3 = Config.Colors.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local box = Create("TextBox", {
        Parent = container,
        BackgroundColor3 = Config.Colors.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(0.55, -10, 0, 24),
        Position = UDim2.new(0.45, 0, 0.5, -12),
        Font = Config.Font,
        PlaceholderText = placeholder or "Введите...",
        PlaceholderColor3 = Config.Colors.SubText,
        Text = "",
        TextColor3 = Config.Colors.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Center
    })
    Corner(box, UDim.new(0, 4))
    Stroke(box, Config.Colors.Outline, 1)
    
    box.Focused:Connect(function()
        Tween(box, 0.15, {Size = UDim2.new(0.55, -10, 0, 26)})
        Stroke(box, Config.Colors.Accent, 1.5)
    end)
    
    box.FocusLost:Connect(function()
        Tween(box, 0.15, {Size = UDim2.new(0.55, -10, 0, 24)})
        if callback then callback(box.Text) end
    end)
    
    return box
end

--// Dropdown
function Zazu:Dropdown(section, text, options, callback)
    local selected = options[1]
    local open = false
    
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = Config.Colors.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 34),
        ClipsDescendants = true
    })
    Corner(container, UDim.new(0, 6))
    Stroke(container, Config.Colors.Outline, 1)
    
    local label = Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 0, 34),
        Position = UDim2.new(0, 10, 0, 0),
        Font = Config.Font,
        Text = text,
        TextColor3 = Config.Colors.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local selectedLbl = Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.4, 0, 0, 34),
        Position = UDim2.new(0.55, 0, 0, 0),
        Font = Config.Font,
        Text = selected,
        TextColor3 = Config.Colors.Accent,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Right
    })
    
    local arrow = Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 0, 34),
        Position = UDim2.new(1, -25, 0, 0),
        Font = Config.FontBold,
        Text = "▼",
        TextColor3 = Config.Colors.SubText,
        TextSize = 10
    })
    
    local btn = Create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 34),
        Text = ""
    })
    
    local optionContainer = Create("Frame", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 34),
        AutomaticSize = Enum.AutomaticSize.Y
    })
    
    local optLayout = Create("UIListLayout", {
        Parent = optionContainer,
        Padding = UDim.new(0, 2),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    for i, opt in ipairs(options) do
        local optBtn = Create("TextButton", {
            Parent = optionContainer,
            BackgroundColor3 = Config.Colors.Secondary,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -8, 0, 28),
            Position = UDim2.new(0, 4, 0, 0),
            Font = Config.Font,
            Text = opt,
            TextColor3 = Config.Colors.Text,
            TextSize = 13,
            AutoButtonColor = false
        })
        Corner(optBtn, UDim.new(0, 4))
        
        optBtn.MouseEnter:Connect(function()
            Tween(optBtn, 0.1, {BackgroundColor3 = Config.Colors.Accent})
        end)
        optBtn.MouseLeave:Connect(function()
            Tween(optBtn, 0.1, {BackgroundColor3 = Config.Colors.Secondary})
        end)
        optBtn.MouseButton1Click:Connect(function()
            selected = opt
            selectedLbl.Text = opt
            open = false
            Tween(container, 0.2, {Size = UDim2.new(1, 0, 0, 34)})
            Tween(arrow, 0.2, {Rotation = 0})
            if callback then callback(opt) end
        end)
    end
    
    btn.MouseButton1Click:Connect(function()
        open = not open
        if open then
            local h = 34 + (#options * 30) + 6
            Tween(container, 0.25, {Size = UDim2.new(1, 0, 0, h)})
            Tween(arrow, 0.2, {Rotation = 180})
        else
            Tween(container, 0.25, {Size = UDim2.new(1, 0, 0, 34)})
            Tween(arrow, 0.2, {Rotation = 0})
        end
    end)
    
    return {Set = function(v) selected = v; selectedLbl.Text = v end, Get = function() return selected end}
end

--// Label
function Zazu:Label(section, text)
    local lbl = Create("TextLabel", {
        Parent = section.Content,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        Font = Config.Font,
        Text = text,
        TextColor3 = Config.Colors.SubText,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    return lbl
end

--// Divider
function Zazu:Divider(section)
    local div = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = Config.Colors.Outline,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1)
    })
    return div
end

--// Keybind
function Zazu:Keybind(section, text, default, callback)
    local key = default or "F"
    local listening = false
    
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = Config.Colors.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 34)
    })
    Corner(container, UDim.new(0, 6))
    Stroke(container, Config.Colors.Outline, 1)
    
    local label = Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.6, 0, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Font = Config.Font,
        Text = text,
        TextColor3 = Config.Colors.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local keyBtn = Create("TextButton", {
        Parent = container,
        BackgroundColor3 = Config.Colors.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 50, 0, 24),
        Position = UDim2.new(1, -60, 0.5, -12),
        Font = Config.FontBold,
        Text = key,
        TextColor3 = Config.Colors.Text,
        TextSize = 12,
        AutoButtonColor = false
    })
    Corner(keyBtn, UDim.new(0, 4))
    Stroke(keyBtn, Config.Colors.Outline, 1)
    
    keyBtn.MouseButton1Click:Connect(function()
        listening = true
        keyBtn.Text = "..."
        keyBtn.TextColor3 = Config.Colors.Accent
    end)
    
    UserInputService.InputBegan:Connect(function(input)
        if listening and input.UserInputType == Enum.UserInputType.Keyboard then
            key = input.KeyCode.Name
            keyBtn.Text = key
            keyBtn.TextColor3 = Config.Colors.Text
            listening = false
            if callback then callback(key) end
        end
    end)
    
    return {Get = function() return key end}
end

--// Color Picker
function Zazu:ColorPicker(section, text, default, callback)
    local color = default or Color3.fromRGB(138, 43, 226)
    local hue = 0.75
    local open = false
    
    local container = Create("Frame", {
        Parent = section.Content,
        BackgroundColor3 = Config.Colors.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 34),
        ClipsDescendants = true
    })
    Corner(container, UDim.new(0, 6))
    Stroke(container, Config.Colors.Outline, 1)
    
    local label = Create("TextLabel", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.6, 0, 0, 34),
        Position = UDim2.new(0, 10, 0, 0),
        Font = Config.Font,
        Text = text,
        TextColor3 = Config.Colors.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local preview = Create("Frame", {
        Parent = container,
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 50, 0, 20),
        Position = UDim2.new(1, -60, 0.5, -10)
    })
    Corner(preview, UDim.new(0, 4))
    Stroke(preview, Config.Colors.Outline, 1)
    
    local btn = Create("TextButton", {
        Parent = container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 34),
        Text = ""
    })
    
    local pickerFrame = Create("Frame", {
        Parent = container,
        BackgroundColor3 = Config.Colors.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -8, 0, 100),
        Position = UDim2.new(0, 4, 0, 38)
    })
    Corner(pickerFrame, UDim.new(0, 6))
    
    local hueBar = Create("Frame", {
        Parent = pickerFrame,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 20, 1, -16),
        Position = UDim2.new(0, 8, 0, 8)
    })
    Corner(hueBar, UDim.new(0, 4))
    Gradient(hueBar, Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 0, 0), 0)
    local hueGrad = Create("UIGradient", {
        Parent = hueBar,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        }),
        Rotation = 90
    })
    
    local hueKnob = Create("Frame", {
        Parent = hueBar,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 4, 0, 4),
        Position = UDim2.new(0, -2, 0.75, -2),
        ZIndex = 2
    })
    Corner(hueKnob, UDim.new(1, 0))
    
    pickerFrame.Visible = false
    
    btn.MouseButton1Click:Connect(function()
        open = not open
        pickerFrame.Visible = open
        Tween(container, 0.25, {Size = open and UDim2.new(1, 0, 0, 145) or UDim2.new(1, 0, 0, 34)})
    end)
    
    local hueDragging = false
    hueBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            hueDragging = true
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if hueDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = math.clamp((input.Position.Y - hueBar.AbsolutePosition.Y) / hueBar.AbsoluteSize.Y, 0, 1)
            hueKnob.Position = UDim2.new(0, -2, pos, -2)
            hue = pos
            color = Color3.fromHSV(hue, 0.8, 1)
            preview.BackgroundColor3 = color
            if callback then callback(color) end
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            hueDragging = false
        end
    end)
    
    return {Set = function(c) color = c; preview.BackgroundColor3 = c end, Get = function() return color end}
end

return Zazu
