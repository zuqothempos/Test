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
local RunService = game:GetService("RunService")

-- Variables
local autoFarmActive = false
local blackScreen = nil
local speed = 550
local startTime = nil
local argentDebut = 0

-- Fonction pour récupérer l'argent actuel
local function getArgent()
    local success, result = pcall(function()
        -- Adapte ce chemin selon où est stocké l'argent dans le jeu
        return LocalPlayer.leaderstats.Cash.Value
    end)
    if success then
        return result
    end
    return 0
end

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

-- Labels timer et argent
local timerLabel = tab1.newLabel("⏱ Timer : 00:00:00")
local argentLabel = tab1.newLabel("💰 Argent gagné : 0")

-- Mise à jour timer et compteur en temps réel
spawn(function()
    while true do
        task.wait(1)
        if autoFarmActive and startTime then
            -- Timer
            local elapsed = os.time() - startTime
            local heures = math.floor(elapsed / 3600)
            local minutes = math.floor((elapsed % 3600) / 60)
            local secondes = elapsed % 60
            timerLabel.update(string.format("⏱ Timer : %02d:%02d:%02d", heures, minutes, secondes))

            -- Argent gagné
            local argentActuel = getArgent()
            local argentGagne = argentActuel - argentDebut
            argentLabel.update(string.format("💰 Argent gagné : %d", argentGagne))
        end
    end
end)

tab1.newToggle("Auto Farm", "Active ou désactive l'auto farm", false, function(toggleState)
    autoFarmActive = toggleState

    if autoFarmActive then
        -- Reset timer et compteur
        startTime = os.time()
        argentDebut = getArgent()
        timerLabel.update("⏱ Timer : 00:00:00")
        argentLabel.update("💰 Argent gagné : 0")

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

        -- Boucle déplacement véhicule OPTIMISÉE (sans arrêt entre les points)
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
                        task.wait(0.1)
                    end

                    getfenv().first = true

                    -- Point A (sans arrêt, enchaîne directement sur B)
                    local locationA = Vector3.new(-6205.29833984375, 100, 8219.853515625)
                    repeat
                        task.wait()
                        car.PrimaryPart.Velocity = car.PrimaryPart.CFrame.LookVector * speed
                        car:PivotTo(CFrame.new(car.PrimaryPart.Position, locationA))
                    until LocalPlayer:DistanceFromCharacter(locationA) < 50 or not autoFarmActive

                    -- Point B (sans arrêt, enchaîne directement sur A)
                    local locationB = Vector3.new(-7594.541015625, 100, 5130.95263671875)
                    repeat
                        task.wait()
                        car.PrimaryPart.Velocity = car.PrimaryPart.CFrame.LookVector * speed
                        car:PivotTo(CFrame.new(car.PrimaryPart.Position, locationB))
                    until LocalPlayer:DistanceFromCharacter(locationB) < 50 or not autoFarmActive
                end)

                if not success then
                    warn("Auto Farm erreur : " .. tostring(err))
                    -- Auto-restart si erreur (ex: sorti du véhicule)
                    task.wait(2)
                    getfenv().first = false
                end
            end
        end)

    else
        -- Reset au stop
        startTime = nil
        timerLabel.update("⏱ Timer : 00:00:00")
        argentLabel.update("💰 Argent gagné : 0")
    end
end)

-- Input vitesse
tab1.newInput("Vitesse (défaut: 550)", "Entrez un nombre et appuyez sur Entrée", function(text)
    local value = tonumber(text)
    if value then
        speed = value
        warn("Vitesse changée : " .. tostring(speed))
    else
        warn("Vitesse invalide ! Entre un nombre.")
    end
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
