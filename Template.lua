-- ═══════════════════════════════════════
--      MIDNIGHT CHASERS - AUTO FARM
-- ═══════════════════════════════════════

-- Anti AFK
warn("Anti AFK running...")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    warn("Anti AFK ran!")
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Variables
local autoFarmActive = false
local blackScreen = nil
local speed = 550

-- ═══════════════════════════════════════
--          CHARGEMENT DRRAY
-- ═══════════════════════════════════════
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()

local window = DrRayLibrary:Load("Midnight Chasers", "Default")

-- ═══════════════════════════════════════
--         TAB 1 — AUTO FARM
-- ═══════════════════════════════════════
local tab1 = DrRayLibrary.newTab("Auto Farm", "ImageIdHere")

tab1.newLabel("== Auto Farm ==")

tab1.newToggle("Auto Farm", "Active ou désactive l'auto farm", false, function(toggleState)
    autoFarmActive = toggleState

    if autoFarmActive then

        -- Boucle destruction obstacles
        spawn(function()
            while autoFarmActive do
                for _, v in pairs(workspace:GetChildren()) do
                    if v.ClassName == "Model" and (v:FindFirstChild("Container") or v.Name == "PortCraneOversized") then
                        v:Destroy()
                    end
                end
                wait(1)
            end
        end)

        -- Boucle déplacement véhicule
        spawn(function()
            while autoFarmActive do
                local success, err = pcall(function()
                    local hum = LocalPlayer.Character.Humanoid
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

                    -- Point A
                    local locationA = Vector3.new(-6205.29833984375, 100, 8219.853515625)
                    repeat
                        task.wait()
                        car.PrimaryPart.Velocity = car.PrimaryPart.CFrame.LookVector * speed
                        car:PivotTo(CFrame.new(car.PrimaryPart.Position, locationA))
                    until LocalPlayer:DistanceFromCharacter(locationA) < 50 or not autoFarmActive

                    car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                    wait(0.5)

                    -- Point B
                    local locationB = Vector3.new(-7594.541015625, 100, 5130.95263671875)
                    repeat
                        task.wait()
                        car.PrimaryPart.Velocity = car.PrimaryPart.CFrame.LookVector * speed
                        car:PivotTo(CFrame.new(car.PrimaryPart.Position, locationB))
                    until LocalPlayer:DistanceFromCharacter(locationB) < 50 or not autoFarmActive

                    car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                    wait(0.5)
                end)

                if not success then
                    warn("Auto Farm erreur : " .. tostring(err))
                    wait(2)
                end
            end
        end)
    end
end)

tab1.newSlider("Vitesse", "Modifie la vitesse du véhicule", 1000, 100, 550, function(value)
    speed = value
    warn("Vitesse changée : " .. tostring(value))
end)

-- ═══════════════════════════════════════
--         TAB 2 — VISUEL
-- ═══════════════════════════════════════
local tab2 = DrRayLibrary.newTab("Visuel", "ImageIdLogoHere")

tab2.newLabel("== Options Visuelles ==")

tab2.newToggle("Black Screen", "Rend l'écran noir pour farmer en fond", false, function(toggleState)
    if toggleState then
        blackScreen = Instance.new("ScreenGui")
        blackScreen.Name = "BlackScreen"
        blackScreen.DisplayOrder = -1000
        blackScreen.Parent = game.CoreGui

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.new(0, 0, 0)
        frame.BorderSizePixel = 0
        frame.Parent = blackScreen
    else
        if blackScreen then
            blackScreen:Destroy()
            blackScreen = nil
        end
    end
end)

