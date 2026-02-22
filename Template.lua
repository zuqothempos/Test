-- Load the DrRay library from the GitHub repository Library
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()

-- Create a new window and set its title and theme
local window = DrRayLibrary:Load("DrRay!", "Default")

-- Create the first tab with an image ID
local tab1 = DrRayLibrary.newTab("Tab 1", "ImageIdHere")

-- Add elements to the first tab
tab1.newLabel("Hello, this is Tab 1.")
tab1.newButton("Button", "Prints Hello!"), function()
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
tab1.newToggle("Toggle", "Toggle! (prints the state)", true, function(toggleState)
    if toggleState then
        print("On")
    else
        print("Off")
    end
end)
tab1.newInput("Input", "Prints your input.", function(text)
    print("Entered text in Tab 1: " .. text)
end)

-- Create the second tab with a different image ID
local tab2 = DrRayLibrary.newTab("Tab 2", "ImageIdLogoHere")

-- Add elements to the second tab
tab2.newLabel("Hello, this is Tab 2.")
tab2.newButton("Button", "Prints Hello!", function()
    print('Hello!')
end)
tab2.newToggle("Toggle", "Toggle! (prints the state)", true, function(toggleState)
    if toggleState then
        print("On")
    else
        print("Off")
    end
end)
tab2.newDropdown("Dropdown", "Select one of these options!", {"water", "dog", "air", "bb", "airplane", "wohhho", "yeay", "delete"}, function(selectedOption)
    print(selectedOption)
end)
