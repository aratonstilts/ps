local Player = game:GetService("Players").LocalPlayer
local playerGUI = Player.PlayerGui
local instances = playerGUI:WaitForChild("_INSTANCES")
local fishingGame = instances:WaitForChild("FishingGame")

local camera = workspace.CurrentCamera
local VIP = game:GetService("VirtualInputManager")

local function clickScreen()
  	local screenSize = camera.ViewportSize
	VIP:SendTouchEvent(1, 0, screenSize.X/2, screenSize.Y/2)
  	task.wait()
  	VIP:SendTouchEvent(1, 2, screenSize.X/2, screenSize.Y/2)
end

task.wait(2)

while true do
 	clickScreen()
	task.wait(2)
	repeat clickScreen() task.wait() until fishingGame.Enabled == false
end
