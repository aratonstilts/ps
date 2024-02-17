local activeInstances = workspace:WaitForChild("__THINGS"):WaitForChild("__INSTANCE_CONTAINER"):WaitForChild("Active")

local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local HR = character:WaitForChild("HumanoidRootPart")

local VIP = game:GetService("VirtualInputManager")

local function tapDown()
	local screenSize = camera.ViewportSize
	VIP:SendTouchEvent(1, 0, screenSize.X/2, screenSize.Y/2)
end

local function tapUp()
	VIP:SendTouchEvent(1, 2, 1, 1)
end

local function makeCameraScriptable()
	if camera.CameraType ~= Enum.CameraType.Scriptable then
		camera.CameraType = Enum.CameraType.Scriptable
	end
end

local function focusCamera(block)
	makeCameraScriptable()
	
	camera.CFrame = CFrame.new(Player.Position, block.Position)
end

local timeout = 600

local function mineBlock(block)
	focusCamera(block.Position)
	tapDown()
	
	local attempts = 0
	
	repeat 
	attempts = attempts + 1 
	task.wait() 
	until block.Parent == nil or block.Transparency = 1 or attempts == timeout
	
	tapUp()
end
	
local digsiteFolder = activeInstances:FindFirstChild("Digsite")
if not digsiteFolder then return end

local important = digsiteFolder:FindFirstChild("Important")
if not important then return end

local activeBlocks = important:FindFirstChild("ActiveBlocks")
if not activeBlocks then return end

for _,block in pairs(activeBlocks:GetChildren()) do
	if block:IsA("Part") (HR.Position - block.Position).Magnitude < 30 then
		mineBlock(block)
	end
end
