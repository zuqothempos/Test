-- ═══════════════════════════════════════
--      MIDNIGHT CHASERS - AUTO FARM
-- ═══════════════════════════════════════

-- Stream des objets workspace
task.spawn(function()
    for i, v in pairs(workspace:GetDescendants()) do
        if v.ClassName == "Model" then
            task.spawn(function()
                game.Players.LocalPlayer:RequestStreamAroundAsync(v.WorldPivot.Position, 3)
            end)
            task.wait()
        end
    end
end)

-- Anti AFK
warn("Anti AFK running...")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    warn("Anti AFK launched successfully!")
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

-- ═══════════════════════════════════════
--              FONCTIONS
-- ═══════════════════════════════════════
local function reachedMax(value)
    local test = 0
    for i, v in pairs(value:GetDescendants()) do
        if v:IsA("Seat") then
            test += 1
        end
    end
    test = test * 5
    if value:FindFirstChild("Gifts") and #value.Gifts:GetChildren() == test then
        return true
    end
    return false
end

local function hideWorkspaceObjects(plr)
    if not game.ReplicatedStorage:FindFirstChild("mrbackupfolder") then
        local folder = Instance.new("Folder", game.ReplicatedStorage)
        folder.Name = "mrbackupfolder"
    end
    for i, v in pairs(workspace:GetChildren()) do
        if (v.ClassName == "Model" and not string.find(v.Name, plr.Name) and not string.find(v.Name, plr.DisplayName) and not string.find(v.Name, "Gift") and v.Name ~= "") or
           (v.ClassName == "Folder" and not string.find(v.Name, plr.Name) and not string.find(v.Name, plr.DisplayName) and not string.find(v.Name, "Gift") and v.Name ~= "") or
           v:IsA("MeshPart") then
            v.Parent = game.ReplicatedStorage:FindFirstChild("mrbackupfolder")
        end
    end
end

local function restoreWorkspaceObjects()
    if game.ReplicatedStorage:FindFirstChild("mrbackupfolder") then
        for i, v in pairs(game.ReplicatedStorage:FindFirstChild("mrbackupfolder"):GetChildren()) do
            v.Parent = workspace
            task.wait()
        end
    end
end

local function ensureGroundPart()
    if not _G.ooga then
        local new = Instance.new("Part", workspace)
        new.Anchored = true
        new.Size = Vector3.new(10000, 10, 10000)
        _G.ooga = new
    end
end

local function tweenToPosition(car, targetPos, speed)
    local plr = game.Players.LocalPlayer
    local dist = (plr.Character.HumanoidRootPart.Position - targetPos.Position).magnitude
    local TweenService = game:GetService("TweenService")
    local TweenInfoToUse = TweenInfo.new(dist / speed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
    local TweenValue = Instance.new("CFrameValue")
    TweenValue.Value = car:GetPrimaryPartCFrame()

    TweenValue.Changed:Connect(function()
        local test = TweenValue.Value.Position
        _G.ooga.Position = test - Vector3.new(0, 14, 0)
        car:PivotTo(CFrame.new(_G.ooga.Position + Vector3.new(0, 7, 0), targetPos.Position))
        car.PrimaryPart.AssemblyLinearVelocity = car.PrimaryPart.CFrame.LookVector * speed
    end)

    getfenv().tween = TweenService:Create(TweenValue, TweenInfoToUse, {Value = targetPos})
    getfenv().tween:Play()
    repeat task.wait(0)
    until getfenv().tween.PlaybackState == Enum.PlaybackState.Cancelled
       or getfenv().tween.PlaybackState == Enum.PlaybackState.Completed
       or getfenv().tween.PlaybackState == Enum.PlaybackState.Paused
end

local function tweenToLocation(car, locations, plr)
    repeat
        task.wait()
        local speed = getfenv().speed or 230
        getfenv().car = car
        if getfenv().cancelman then speed = 50 end

        local pos = locations.WorldPivot + Vector3.new(0, 5, 0)
        local dist = (plr.Character.HumanoidRootPart.Position - pos.Position).magnitude
        local TweenService = game:GetService("TweenService")
        local TweenInfoToUse = TweenInfo.new(dist / speed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
        local TweenValue = Instance.new("CFrameValue")
        TweenValue.Value = car:GetPrimaryPartCFrame()

        TweenValue.Changed:Connect(function()
            local test = TweenValue.Value.Position
            local playerDist = plr:DistanceFromCharacter(pos.Position)
            if playerDist > 100 then
                _G.ooga.Position = test - Vector3.new(0, 14, 0)
                car:PivotTo(CFrame.new(_G.ooga.Position + Vector3.new(0, 7, 0), pos.Position))
                car.PrimaryPart.AssemblyLinearVelocity = car.PrimaryPart.CFrame.LookVector * speed
            elseif playerDist < 100 and playerDist > 10 then
                if not getfenv().cancelman then
                    getfenv().cancelman = true
                    getfenv().tween:Cancel()
                end
                _G.ooga.Position = test - Vector3.new(0, 8, 0)
                car:PivotTo(CFrame.new(_G.ooga.Position + Vector3.new(0, 7, 0), Vector3.new(pos.X, car.PrimaryPart.CFrame.Y, pos.Z)))
                car.PrimaryPart.AssemblyLinearVelocity = car.PrimaryPart.CFrame.LookVector * 20
            elseif playerDist < 5 then
                local lookat = car.PrimaryPart.CFrame * CFrame.new(0, 0, -10000)
                car:PivotTo(CFrame.new(Vector3.new(pos.X, _G.ooga.CFrame.Y + 7, pos.Z), lookat.Position))
                car.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
            end
        end)

        getfenv().tween = TweenService:Create(TweenValue, TweenInfoToUse, {Value = pos})
        getfenv().tween:Play()
        repeat task.wait(0)
        until getfenv().tween.PlaybackState == Enum.PlaybackState.Cancelled
           or getfenv().tween.PlaybackState == Enum.PlaybackState.Completed
           or getfenv().tween.PlaybackState == Enum.PlaybackState.Paused
    until not locations:FindFirstChild("Highlight") or not _G.test
    getfenv().cancelman = nil
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

-- Input vitesse
tab1.newInput("Vitesse (défaut: 300)", "Entrez un nombre et appuyez sur Entrée", function(text)
    local value = tonumber(text)
    if value then
        getfenv().speed = value
        warn("Vitesse changée : " .. tostring(value))
    else
        warn("Vitesse invalide !")
    end
end)

-- Toggle Auto Farm
tab1.newToggle("Auto Farm", "Fait les trajets automatiquement", false, function(state)
    getfenv().auto = state

    if state then
        local plr = game.Players.LocalPlayer
        hideWorkspaceObjects(plr)
        task.wait()

        local frames = {
            CFrame.new(105.419128, -26.0098934, 7965.37988, -3.36170197e-05, 0.951051414, -0.309032798, -1, -3.36170197e-05, 5.31971455e-06, -5.31971455e-06, 0.309032798, 0.951051414),
            CFrame.new(2751.86499, -26.0098934, 3694.63354, 3.34978104e-05, 0.951051414, -0.309032798, -1, 3.34978104e-05, -5.31971455e-06, 5.31971455e-06, 0.309032798, 0.951051414),
            CFrame.new(-8821.48438, -26.0098934, 2042.49939, -3.36170197e-05, 0.951051414, -0.309032798, -1, -3.36170197e-05, 5.31971455e-06, -5.31971455e-06, 0.309032798, 0.951051414),
            CFrame.new(-6408.62109, -26.0098934, -727.765198, 3.34978104e-05, 0.951051414, -0.309032798, -1, 3.34978104e-05, -5.31971455e-06, 5.31971455e-06, 0.309032798, 0.951051414),
            CFrame.new(-6099.79639, -26.00989345, -1027.94556, -3.36170197e-05, 0.951051414, -0.309032798, -1, -3.36170197e-05, 5.31971455e-06, -5.31971455e-06, 0.309032798, 0.951051414),
            CFrame.new(-6066.70068, -26.0098934, 493.255524, 3.34978104e-05, 0.951051414, -0.309032798, -1, 3.34978104e-05, -5.31971455e-06, 5.31971455e-06, 0.309032798, 0.951051414),
            CFrame.new(132.786133, -26.0098934, 15.2286377, 3.34978104e-05, 0.951051414, -0.309032798, -1, 3.34978104e-05, -5.31971455e-06, 5.31971455e-06, 0.309032798, 0.951051414),
            CFrame.new(-7692.85449, -26.0098934, -4668.61963, -3.36170197e-05, 0.951051414, -0.309032798, -1, -3.36170197e-05, 5.31971455e-06, -5.31971455e-06, 0.309032798, 0.951051414),
            CFrame.new(4887.24609, -26.0098934, 1222.96826, -3.36170197e-05, 0.951051414, -0.309032798, -1, -3.36170197e-05, 5.31971455e-06, -5.31971455e-06, 0.309032798, 0.951051414)
        }

        task.spawn(function()
            while getfenv().auto do
                local plr = game.Players.LocalPlayer
                local chr = plr.Character
                local hum = chr.Humanoid
                local car = hum.SeatPart.Parent
                getfenv().car = car
                ensureGroundPart()
                car.PrimaryPart = car.Body:FindFirstChild("#Weight")

                for i, v in pairs(frames) do
                    if not getfenv().auto then break end
                    local speed = getfenv().speed or 300
                    local pos = v + Vector3.new(0, 5, 0)
                    tweenToPosition(car, pos, speed)
                end
            end
        end)
    else
        if getfenv().tween then
            getfenv().tween:Cancel()
        end
        restoreWorkspaceObjects()
    end
end)

-- ═══════════════════════════════════════
--       TAB 2 — AUTO DELIVER (EVENT)
-- ═══════════════════════════════════════
local tab2 = DrRayLibrary.newTab("Auto Deliver", "ImageIdHere")

tab2.newLabel("== Auto Deliver [Event] ==")

tab2.newToggle("Auto Deliver", "Livre automatiquement les colis", false, function(state)
    _G.test = state

    if state then
        local plr = game.Players.LocalPlayer
        hideWorkspaceObjects(plr)
        task.wait()

        task.spawn(function()
            while _G.test do
                task.wait()
                ensureGroundPart()
                local plr = game.Players.LocalPlayer
                local chr = plr.Character
                local seat = chr.Humanoid.SeatPart
                local car = seat.Parent
                getfenv().car = car
                car.PrimaryPart = car.Body:FindFirstChild("#Weight")

                local locations
                local maxdistance = math.huge
                for i, v in pairs(workspace:GetChildren()) do
                    if v.Name == "" and v:FindFirstChild("Highlight") then
                        local dist = (plr.Character.PrimaryPart.Position - v.WorldPivot.Position).magnitude
                        if dist < maxdistance then
                            maxdistance = dist
                            locations = v
                        end
                    end
                end

                if locations then
                    tweenToLocation(car, locations, plr)
                elseif not locations and workspace:FindFirstChild("GiftPickup") then
                    repeat
                        task.wait()
                        car.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
                        car:PivotTo(CFrame.new(workspace.GiftPickup.WorldPivot.Position) + Vector3.new(0, 5, 0))
                    until reachedMax(car)
                end
            end
        end)
    else
        if getfenv().tween then
            getfenv().tween:Cancel()
        end
        restoreWorkspaceObjects()
    end
end)

-- ═══════════════════════════════════════
--         TAB 3 — VISUEL
-- ═══════════════════════════════════════
local tab3 = DrRayLibrary.newTab("Visuel", "ImageIdHere")

tab3.newLabel("== Options Visuelles ==")

local blackScreen = nil
tab3.newToggle("Black Screen", "Rend l'écran noir pour farmer en fond", false, function(state)
    if state then
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

