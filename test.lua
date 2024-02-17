local Player = game:GetService("Players").LocalPlayer
local character = Player.Character or Player.CharacterAdded:Wait()
local HR = character:WaitForChild("HumanoidRootPart")
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
title.BackgroundTransparency = 1
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

local titleStroke = Instance.new("UIStroke")
titleStroke.Thickness = 2
titleStroke.Parent = title

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

local closeStroke = Instance.new("UIStroke")
closeStroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
closeStroke.Parent = Close

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0.3, 0)
closeCorner.Parent = Close

local function tapDown()
	local screenSize = camera.ViewportSize
	VIP:SendTouchEvent(1, 0, screenSize.X/2, screenSize.Y/2)
end

local function tapUp()
	VIP:SendTouchEvent(1, 2, 1, 1)
end

local function clickScreen()
	tapDown()
  	task.wait()
  	tapUp()
end

local autoFish = Instance.new("TextButton")
autoFish.Name = "autoFish"
autoFish.Position = UDim2.new(0,0,0.13,0)
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

local function makeCameraScriptable()
	if camera.CameraType ~= Enum.CameraType.Scriptable then
		camera.CameraType = Enum.CameraType.Scriptable
	end
end

local function focusCamera(block)
	makeCameraScriptable()
	
	camera.CFrame = CFrame.new(HR.Position, block.Position)
end

local timeout = 600

local function mineBlock(block)
	focusCamera(block.Position)
	tapDown()
	
	local attempts = 0
	
	repeat 
	attempts = attempts + 1 
	task.wait() 
	until block.Parent == nil or block.Transparency == 1 or attempts == timeout
	
	tapUp()
end

local distance = Instance.new("TextBox")
distance.Name = "distance"
distance.Position = UDim2.new(0,0,0.34,0)
distance.Size = UDim2.new(0.98,0,0.19,0)
distance.BackgroundColor3 = Color3.fromRGB(50,100,50)
distance.BackgroundTransparency = 0.8
distance.BorderColor3 = Color3.new(1,1,1)
distance.ZIndex = 2
distance.Parent = mainBackground
distance.PlaceholderText = "Distance from character"
distance.Text = ""
distance.TextStrokeTransparency = 0
distance.TextColor3 = Color3.new(1,1,1)
distance.TextScaled = true

local autoMine = Instance.new("TextButton")
autoMine.Name = "autoMine"
autoMine.Position = UDim2.new(0,0,0.53,0)
autoMine.Size = UDim2.new(0.98,0,0.2,0)
autoMine.BackgroundColor3 = Color3.fromRGB(50,100,50)
autoMine.BackgroundTransparency = 0.8
autoMine.BorderColor3 = Color3.new(1,1,1)
autoMine.ZIndex = 2
autoMine.Parent = mainBackground
autoMine.Text = "Auto-Mine"
autoMine.TextStrokeTransparency = 0
autoMine.TextColor3 = Color3.new(1,1,1)
autoMine.TextScaled = true
autoMine.MouseButton1Click:Connect(function()

	if autoMine.Text ~= "Auto-Mine" then
		autoMine.Text = "Auto-Mine"
		autoMine.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
		return
	end
	
	local digsiteFolder = activeInstances:FindFirstChild("Digsite")
	if not digsiteFolder then return end

	local important = digsiteFolder:FindFirstChild("Important")
	if not important then return end

	local activeBlocks = important:FindFirstChild("ActiveBlocks")
	if not activeBlocks then return end
	
	autoMine.Text = "Mining!"
	autoMine.BackgroundColor3 = Color3.fromRGB(50,100,50)

	while autoMine.Text == "Mining!" do
	
		for _,block in pairs(activeBlocks:GetChildren()) do
		
			if distance.Text == nil or distance.Text == "" then distance.Text = 30 end
		
			if block:IsA("Part") (HR.Position - block.Position).Magnitude < distance.Text then
				mineBlock(block)
			end		
		end

	end
end)
