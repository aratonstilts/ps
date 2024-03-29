local Player = game:GetService("Players").LocalPlayer
local character = Player.Character or Player.CharacterAdded:Wait()
local HR = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local playerGUI = Player.PlayerGui
local instances = playerGUI:WaitForChild("_INSTANCES")
local fishingGame = instances:WaitForChild("FishingGame")
local activeInstances = workspace:WaitForChild("__THINGS"):WaitForChild("__INSTANCE_CONTAINER"):WaitForChild("Active")

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
closeStroke.ApplyStrokeMode = "Border"
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

	Player.CameraMaxZoomDistance = 0.01
	
	if camera.CameraType ~= Enum.CameraType.Scriptable then
		camera.CameraType = Enum.CameraType.Scriptable
	end
end

local function focusCamera(position)
	makeCameraScriptable()
	
	camera.CFrame = CFrame.new(HR.Position, position)
end

local timeout = 600

local function mineBlock(block)
	focusCamera(block.Position)
	tapDown()
	
	local attempts = 0
	
	repeat 
	attempts = attempts + 1 
	task.wait() 
	until block == nil or block.Parent == nil or block.Transparency == 1 or HR.Position.Y > 60 or attempts == timeout
	
	tapUp()
	Player.CameraMaxZoomDistance = 60
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

local miningArea = "Digsite"

local Advanced = Instance.new("TextButton")
Advanced.Name = "Advanced"
Advanced.Position = UDim2.new(0,0,0.73,0)
Advanced.Size = UDim2.new(0.49,0,0.2,0)
Advanced.BackgroundColor3 = Color3.fromRGB(50,100,50)
Advanced.BackgroundTransparency = 0.8
Advanced.BorderColor3 = Color3.new(1,1,1)
Advanced.ZIndex = 2
Advanced.Parent = mainBackground
Advanced.Text = "Advanced"
Advanced.TextStrokeTransparency = 0
Advanced.TextColor3 = Color3.new(1,1,1)
Advanced.TextScaled = true


local regular = Instance.new("TextButton")
regular.Name = "regular"
regular.Position = UDim2.new(0.5,0,0.73,0)
regular.Size = UDim2.new(0.49,0,0.2,0)
regular.BackgroundColor3 = Color3.fromRGB(50,100,50)
regular.BackgroundTransparency = 0.8
regular.BorderColor3 = Color3.new(1,1,1)
regular.ZIndex = 2
regular.Parent = mainBackground
regular.Text = "regular"
regular.TextStrokeTransparency = 0
regular.TextColor3 = Color3.new(1,1,1)
regular.TextScaled = true

Advanced.MouseButton1Click:Connect(function()
	if regular.BackgroundColor3 == Color3.fromRGB(150,250,150) then
		regular.BackgroundColor3 = Color3.fromRGB(50,100,50)
	end
	
	miningArea = "AdvancedDigsite"
	Advanced.BackgroundColor3 = Color3.fromRGB(150,250,150)
end)

regular.MouseButton1Click:Connect(function()
	if Advanced.BackgroundColor3 == Color3.fromRGB(150,250,150) then
		Advanced.BackgroundColor3 = Color3.fromRGB(50,100,50)
	end
	
	miningArea = "Digsite"
	regular.BackgroundColor3 = Color3.fromRGB(150,250,150)
end)

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
		camera.CameraType = "Custom"
		return
	end
	
	local digsiteFolder = activeInstances:FindFirstChild(miningArea)
	if not digsiteFolder then return end

	local important = digsiteFolder:FindFirstChild("Important")
	if not important then return end

	local activeBlocks = important:FindFirstChild("ActiveBlocks")
	if not activeBlocks then return end
	
	local activeChests = important:FindFirstChild("ActiveChests")
	
	autoMine.Text = "Mining!"
	autoMine.BackgroundColor3 = Color3.fromRGB(50,100,50)

	while autoMine.Text == "Mining!" do
			task.wait()
			
			if HR.Position.Y > 60 then
				if miningArea == "AdvancedDigsite" then
					humanoid:MoveTo(Vector3.new(638,59,-2509))
					humanoid.MoveToFinished:Wait()
				end
			end
			
		for _,chest in pairs(activeChests:GetChildren()) do
			
			if distance.Text == nil or distance.Text == "" then distance.Text = 20 end
			
			if chest:IsA("Model") and (HR.Position - chest.PrimaryPart.Position).Magnitude < tonumber(distance.Text) then
				mineBlock(chest.PrimaryPart)
			end	
			
			if chest:IsA("Part") or chest:IsA("MeshPart") and (HR.Position - chest.Position).Magnitude < tonumber(distance.Text) then
				mineBlock(chest)
			end	
		end
		
		for _,block in pairs(activeBlocks:GetChildren()) do
		
			if distance.Text == nil or distance.Text == "" then distance.Text = 20 end
		
			if block:IsA("Part") and (HR.Position - block.Position).Magnitude < tonumber(distance.Text) then
				mineBlock(block)
				break
			end		
		end
		
		

	end
end)
