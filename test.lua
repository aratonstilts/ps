local Player = game:GetService("Players").LocalPlayer
local playerGUI = Player.PlayerGui
local instances = playerGUI:WaitForChild("_INSTANCES")
local fishingGame = instances:WaitForChild("FishingGame")
local gameBar = fishingGame:WaitForChild("GameBar")

local camera = workspace.CurrentCamera

local function clickScreen()
  local screenSize = Camera.ViewportSize
	VirtualInputManager:SendTouchEvent(1, 0, screenSize.X/2, screenSize.Y/2)
  task.wait()
  VirtualInputManager:SendTouchEvent(1, 2, screenSize.X/2, screenSize.Y/2)
end

--while Toggled58 == true do
	
  v = 0
  clickScreen()
           
	task.wait(2)
    
	repeat clickScreen() task.wait() until gameBar.Visible == false
	
--end
