-- Load the DrRay library from the GitHub repository Library
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/zuqorl/CDTStorm/refs/heads/main/Uidesign.lua"))()

-- Create a new window and set its title and theme
local window = DrRayLibrary:Load("CDTStorm", "Default")

-- Create the first tab with an image ID
local tab1 = DrRayLibrary.newTab("Information", "ImageIdHere")

-- Add elements to the first tab
tab1.newLabel("Information's Tab")
tab1.newButton("Button", "Prints Hello!", function()
    print('Hello!')
end)
tab1.newToggle("Toggle", "Toggle! (prints the state)", false, function(state)
  getfenv().auto = (state and true or false)
  wait(1)
  workspace.Gravity = getfenv().grav
  while getfenv().auto do
    task.wait()
  local chr = game.Players.LocalPlayer.Character
  local car = chr.Humanoid.SeatPart.Parent.Parent
    if not workspace:FindFirstChild("justapart") then
      local new = Instance.new("Part",workspace)
      new.Name = "justapart"
      new.Size = Vector3.new(10000,20,10000)
      new.Anchored = true
      new.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position+Vector3.new(0,1000,0)
  end
  car:PivotTo(workspace:FindFirstChild("justapart").CFrame*CFrame.new(0,7,1000))
  local pos = workspace:FindFirstChild("justapart").CFrame*CFrame.new(0,7,-1000)
  repeat task.wait()
    local speed =  getfenv().speed or 300
    local accel = 300
    workspace.Gravity = 500
            car.PrimaryPart.Velocity = Vector3.new(car.PrimaryPart.Velocity.X,-100,car.PrimaryPart.Velocity.Z) 
    car:PivotTo(CFrame.new(car.PrimaryPart.Position,Vector3.new(pos.X,car.PrimaryPart.Position.Y,pos.Z)))
            car.PrimaryPart.Velocity = Vector3.new(car.PrimaryPart.Velocity.X,-100,car.PrimaryPart.Velocity.Z) 
    car.PrimaryPart.AssemblyLinearVelocity = car.PrimaryPart.CFrame.LookVector*speed
    car.PrimaryPart.Velocity = Vector3.new(car.PrimaryPart.Velocity.X,-100,car.PrimaryPart.Velocity.Z) 
  until game.Players.LocalPlayer:DistanceFromCharacter(Vector3.new(pos.X,pos.Y,pos.Z)) < 200 or getfenv().test == false
  end
  end)
tab1.newToggle("Auto open VW", "Auto open VW! (prints the state)", false, function(state)
getfenv().open = (state and true or false)
while getfenv().open do
task.wait()
game:GetService("ReplicatedStorage").Remotes.Services.VolkswagenEventServiceRemotes.ClaimFreePack:InvokeServer()
end
 end)
tab1.newToggle("Race test", "Auto open VW! (prints the state)", false, function(state)
            _G.racetest = (state and true or false)
            while _G.racetest do
                wait()
            if game:GetService("Players").LocalPlayer.PlayerGui.Menu.Race.Visible == false then
                local chr = game.Players.LocalPlayer.Character
            local car = chr.Humanoid.SeatPart.Parent.Parent
              car:PivotTo(CFrame.new(1049.2476806640625, 609.7359008789062, 2511.8427734375))
                chr.Head.Anchored = true
            wait(1)
            chr.Head.Anchored = false
            wait(1)
workspace:WaitForChild("Races"):WaitForChild("RaceHandler"):WaitForChild("StartLobby"):FireServer(unpack(Race))

            task.wait(15)
workspace.Races.Race.Script.Vote:FireServer("10", "Vote")
            repeat wait()
            until game:GetService("Players").LocalPlayer.PlayerGui.Menu.Race.Visible == true or _G.racetest == false
            elseif game:GetService("Players").LocalPlayer.PlayerGui.Menu.Race.Visible == true then
            for i =1,50 do
workspace.Races.Race.Script.Checkpoint:FireServer(i)
end
end
end
end)
tab1.newInput("Input", "Prints your input.", function(text)
    print("Entered text in Tab 1: " .. text)
end)



-- Create the second tab with a different image ID
local tab2 = DrRayLibrary.newTab("Events !", "ImageIdLogoHere")

-- Add elements to the second tab
tab2.newLabel("Hello, this is Tab 2.")
tab2.newButton("Button", "Prints Hello!", function(
warn("Anti afk running")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    warn("Anti afk ran")
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

local guiScreen = Instance.new("ScreenGui")
guiScreen.Name = "TopGUI"
guiScreen.DisplayOrder = 1000
guiScreen.Parent = game.CoreGui

local guiFrame = Instance.new("Frame")
guiFrame.Size = UDim2.new(0, 200, 0, 150)
guiFrame.Position = UDim2.new(0, 10, 0, 10)
guiFrame.BackgroundTransparency = 0.5
guiFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
guiFrame.BorderSizePixel = 0
guiFrame.Parent = guiScreen


local autoFarmToggle = Instance.new("TextButton")
autoFarmToggle.Size = UDim2.new(0, 180, 0, 30)
autoFarmToggle.Position = UDim2.new(0.5, -90, 0, 10)
autoFarmToggle.Text = "Auto Farm: OFF"
autoFarmToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoFarmToggle.BackgroundTransparency = 0.3
autoFarmToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
autoFarmToggle.Parent = guiFrame

local autoFarmActive = false

autoFarmToggle.MouseButton1Click:Connect(function()
    autoFarmActive = not autoFarmActive
    if autoFarmActive then
        autoFarmToggle.Text = "Auto Farm: ON"
        -- Implement the Auto Farm functionality here
        spawn(function()
            while autoFarmActive do
                for i, v in pairs(workspace:GetChildren()) do
                    if v.ClassName == "Model" and v:FindFirstChild("Container") or v.Name == "PortCraneOversized" then
                        v:Destroy()
                    end
                end
                wait(1)
            end
        end)
        spawn(function()
            while autoFarmActive do
                local hum = game.Players.LocalPlayer.Character.Humanoid
                local car = hum.SeatPart.Parent
                car.PrimaryPart = car.Body:FindFirstChild("#Weight")
                if not getfenv().first then
                    if workspace.Workspace:FindFirstChild("Buildings") then
                        workspace.Workspace.Buildings:Destroy()
                    end
                    car:PivotTo(CFrame.new(Vector3.new(-7594.541015625, -3.513848304748535, 5130.95263671875), Vector3.new(-6205.29833984375, -3.5030133724212646, 8219.853515625)))
                    wait(0.1)
                end
                car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                getfenv().first = true
                local location = Vector3.new(-6205.29833984375, 100, 8219.853515625)
                repeat
                    task.wait()
                    mathlock = 550
                    car.PrimaryPart.Velocity = car.PrimaryPart.CFrame.LookVector * mathlock
                    car:PivotTo(CFrame.new(car.PrimaryPart.Position, location))
                until game.Players.LocalPlayer:DistanceFromCharacter(location) < 50 or not autoFarmActive
                car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                location = Vector3.new(-7594.541015625, 100, 5130.95263671875)
                repeat
                    task.wait()
                    mathlock = 550
                    car.PrimaryPart.Velocity = car.PrimaryPart.CFrame.LookVector * mathlock
                    car:PivotTo(CFrame.new(car.PrimaryPart.Position, location))
                until game.Players.LocalPlayer:DistanceFromCharacter(location) < 50 or not autoFarmActive
                car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    else
        autoFarmToggle.Text = "Auto Farm: OFF"
        -- Stop Auto Farm functionality here
    end
end)
)
    print('Hello!')
end)
tab2.newToggle("Toggle", "Toggle! (prints the state)", true, 

function ()

end)
tab2.newDropdown("Dropdown", "Select one of these options!", {"water", "dog", "air", "bb", "airplane", "wohhho", "yeay", "delete"}, function(selectedOption)
    print(selectedOption)
end)
tab.newInput("Input", "Prints your input.", function(text)
    print("Entered text: " .. text)
end)
tab.newSlider("Slider", "Epic slider", 1000, false, function(num)
    print(num)
end)
@zuqothempos
Comment
