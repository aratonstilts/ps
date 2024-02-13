local Player = game:GetService("Players").LocalPlayer
local playerGUI = Player.PlayerGui
local instances = playerGUI:WaitForChild("_INSTANCES")
local fishingGame = instances:WaitForChild("FishingGame")

local camera = workspace.CurrentCamera
local VIP = game:GetService("VirtualInputManager")

if game:GetService("CoreGui"):FindFirstChild("ui") then
	game:GetService("CoreGui"):FindFirstChild("ui"):Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "ui"
gui.Parent = game:GetService("CoreGui")

local mainBackground = Instance.new("Frame")
mainBackground.Name = "Background"
mainBackground.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainBackground.Transparency = 0.5
mainBackground.BorderSizePixel = 0
mainBackground.BorderColor3 = Color3.new(1,0,1)
mainBackground.Position = UDim2.new(0.05, 0, 0.5, 0)
mainBackground.Size = UDim2.new(0.15, 0, 0.4, 0)
mainBackground.Active = true
mainBackground.Parent = gui

local backgroundStroke = Instance.new("UIStroke")
backgroundStroke.Thickness = 2
backgroundStroke.Parent = mainBackground

local backgroundCorner = Instance.new("UICorner")
backgroundCorner.CornerRadius = UDim.new(0.3, 0)
backgroundCorner.Parent = mainBackground

local title = Instance.new("TextButton")
title.Name = "title"
title.AutoButtonColor = false
title.Parent = mainBackground
title.BackgroundColor3 = Color3.fromRGB(250, 100, 100)
title.BorderSizePixel = 0
title.Size = UDim2.new(1, 0, .1, 0)
title.Font = Enum.Font.GothamBlack
title.Text = "Pet sim"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.TextSize = 14.000
title.TextWrapped = true
Dragg = false
title.MouseButton1Down:Connect(function()Dragg = true while Dragg do game.TweenService:Create(mainBackground, TweenInfo.new(.06), {Position = UDim2.new(0,GetM.X-60,0,GetM.Y-15)}):Play()wait()end end)
title.MouseButton1Up:Connect(function()Dragg = false end)

local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Parent = mainBackground
Close.BackgroundColor3 = Color3.fromRGB(155, 0, 0)
Close.BorderSizePixel = 0
Close.AnchorPoint = Vector2.new(1,0)
Close.Position = UDim2.new(1, 0, 0, 0)
Close.Size = UDim2.new(.2, 0, 0.1, 0)
Close.Font = Enum.Font.SourceSans
Close.Text = "X"
Close.TextStrokeTransparency = 0
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 14.000
Close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local function clickScreen()
  	local screenSize = camera.ViewportSize
	VIP:SendTouchEvent(1, 0, screenSize.X/2, screenSize.Y/2)
  	task.wait()
  	VIP:SendTouchEvent(1, 2, screenSize.X/2, screenSize.Y/2)
end

task.wait(2)

local autoFish = Instance.new("TextButton")
autoFish.Name = "autoFish"
autoFish.Position = UDim2.new(0,0,0.33,0)
autoFish.Size = UDim2.new(0.98,0,0.2,0)
autoFish.BackgroundColor3 = Color3.fromRGB(50,100,50)
autoFish.BackgroundTransparency = 0.8
autoFish.BorderColor3 = Color3.new(1,1,1)
autoFish.ZIndex = 2
autoFish.Parent = mainBackground
autoFish.Text = "Auto-Fish"
autoFish.TextStrokeTransparency = 0
autoFish.TextColor3 = Color3.new(1,1,1)
autoFish.TextScaled = true
autoFish.MouseButton1Click:Connect(function()

	if autoFish.Text ~= "Auto-Fish" then
		autoFish.Text = "Auto-Fish"
		autoFish.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
		return
	end
	
	autoFish.Text = "Fishing!"
	autoFish.BackgroundColor3 = Color3.fromRGB(50,100,50)

	while autoFish.Text == "Fishing!" do
		clickScreen()
		task.wait(3)
		if autoFish.Text == "Fishing!" then
			clickScreen()
		end
		task.wait(0.5)
		repeat clickScreen() task.wait() until fishingGame.Enabled == false or autoFish.Text ~= "Fishing!"
	end
end)
