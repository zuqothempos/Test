-- Anti AFK
warn("Anti afk running")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    warn("Anti afk ran")
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

-- Variables
local autoFarmActive = false

-- Chargement de DrRay
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("DrRay!", "Default")

-- ═══════════════════════════
--         TAB 1 - FARM
-- ═══════════════════════════
local tab1 = DrRayLibrary.newTab("Auto Farm", "ImageIdHere")

tab1.newLabel("Contrôles de l'Auto Farm")

-- Toggle Auto Farm
tab1.newToggle("Auto Farm", "Active ou désactive l'auto farm", false, function(toggleState)
    autoFarmActive = toggleState

    if autoFarmActive then
        -- Boucle destruction des obstacles
        spawn(function()
            while autoFarmActive do
                for i, v in pairs(workspace:GetChildren()) do
                    if v.ClassName == "Model" and (v:FindFirstChild("Container") or v.Name == "PortCraneOversized") then
                        v:Destroy()
                    end
                end
                wait(1)
            end
        end)

        -- Boucle déplacement du véhicule
        spawn(function()
            while autoFarmActive do
                local hum = game.Players.LocalPlayer.Character.Humanoid
                local car = hum.SeatPart.Parent
                car.PrimaryPart = car.Body:FindFirstChild("#Weight")

                if not getfenv().first then
                    if workspace:FindFirstChild("Buildings") then
                        workspace.Buildings:Destroy()
                    end
                    car:PivotTo(CFrame.new(
                        Vector3.new(-7594.541015625, -3.513848304748535, 5130.95263671875),
                        Vector3.new(-6205.29833984375, -3.5030133724212646, 8219.853515625)
                    ))
                    wait(0.1)
                end

                car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                getfenv().first = true

                local location = Vector3.new(-6205.29833984375, 100, 8219.853515625)
                repeat
                    task.wait()
                    car.PrimaryPart.Velocity = car.PrimaryPart.CFrame.LookVector * 550
                    car:PivotTo(CFrame.new(car.PrimaryPart.Position, location))
                until game.Players.LocalPlayer:DistanceFromCharacter(location) < 50 or not autoFarmActive

                car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)

                location = Vector3.new(-7594.541015625, 100, 5130.95263671875)
                repeat
                    task.wait()
                    car.PrimaryPart.Velocity = car.PrimaryPart.CFrame.LookVector * 550
                    car:PivotTo(CFrame.new(car.PrimaryPart.Position, location))
                until game.Players.LocalPlayer:DistanceFromCharacter(location) < 50 or not autoFarmActive

                car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    end
end)

-- ═══════════════════════════
--       TAB 2 - VISUEL
-- ═══════════════════════════
local tab2 = DrRayLibrary.newTab("Visuel", "ImageIdLogoHere")

tab2.newLabel("Options visuelles")

-- Toggle Black Screen
local blackScreen = nil

tab2.newToggle("Black Screen", "Rend l'écran noir (farm en arrière-plan)", false, function(toggleState)
    if toggleState then
        blackScreen = Instance.new("ScreenGui")
        blackScreen.Name = "BlackScreen"
        blackScreen.DisplayOrder = -1000
        blackScreen.Parent = game.CoreGui

        local blackFrame = Instance.new("Frame")
        blackFrame.Size = UDim2.new(1, 0, 1, 0)
        blackFrame.BackgroundColor3 = Color3.new(0, 0, 0)
        blackFrame.BorderSizePixel = 0
        blackFrame.Parent = blackScreen
    else
        if blackScreen then
            blackScreen:Destroy()
            blackScreen = nil
        end
    end
end)
