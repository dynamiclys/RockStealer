local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- GUI creation
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "RockStealer"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(20, 0, 20)
frame.BorderColor3 = Color3.fromRGB(150, 0, 150)
frame.BorderSizePixel = 3
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Title
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -30, 0, 25)
label.Position = UDim2.new(0, 5, 0, 5)
label.BackgroundTransparency = 1
label.Text = "rs 1.0.1"
label.TextColor3 = Color3.fromRGB(200, 60, 200)
label.Font = Enum.Font.Arcade
label.TextScaled = true
label.Parent = frame

-- Close button
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -30, 0, 5)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 60, 60)
close.Font = Enum.Font.Arcade
close.TextScaled = true
close.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
close.BorderColor3 = Color3.fromRGB(150, 0, 0)
close.Parent = frame

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- TextBox
local textbox = Instance.new("TextBox")
textbox.Text = "Username"
textbox.Size = UDim2.new(0.45, 0, 0, 40)
textbox.Position = UDim2.new(0.05, 0, 0.4, 0)
textbox.BackgroundColor3 = Color3.fromRGB(10, 0, 10)
textbox.TextColor3 = Color3.fromRGB(180, 60, 180)
textbox.BorderColor3 = Color3.fromRGB(120, 0, 120)
textbox.BorderSizePixel = 2
textbox.Font = Enum.Font.Arcade
textbox.TextScaled = true
textbox.ClearTextOnFocus = true
textbox.Parent = frame

-- Button
local button = Instance.new("TextButton")
button.Text = "Target"
button.Size = UDim2.new(0.45, 0, 0, 40)
button.Position = UDim2.new(0.05, 0, 0.65, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.TextColor3 = Color3.fromRGB(200, 60, 200)
button.BorderColor3 = Color3.fromRGB(150, 0, 150)
button.BorderSizePixel = 2
button.Font = Enum.Font.Arcade
button.TextScaled = true
button.Parent = frame

-- Functional vars
local username = ""

textbox:GetPropertyChangedSignal("Text"):Connect(function()
	username = textbox.Text
end)

button.MouseButton1Click:Connect(function()
	if username == "" then return end
	
	spawn(function()
		while gui and gui.Parent do
			task.wait(0.25)

			local target = workspace:FindFirstChild(username)
			if target and target:FindFirstChild("Rock") then
				local rock = target.Rock
				local handle = rock:FindFirstChild("Handle")
				if handle then
					local prompt = handle:FindFirstChildWhichIsA("ProximityPrompt")
					if prompt then
						-- Move player to rock and interact
						if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
							player.Character:MoveTo(handle.Position + Vector3.new(0, 3, 0))
							task.wait(0.2)
							prompt:InputHoldBegin()
							task.wait(0.4)
							prompt:InputHoldEnd()
						end
					end
				end
			end
		end
	end)
end)
