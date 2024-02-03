repeat wait() until game:IsLoaded()

wait(1)

Ranks = require(game.ReplicatedStorage.Library.Types.Ranks)
Data = require(game.ReplicatedStorage.Library.Client.Save)
Zones = require(game.ReplicatedStorage.Library.Directory.Zones)
Eggs = require(game.ReplicatedStorage.Library.Directory.Eggs)


local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()

function FetchData(name)
    return Data:GetSaves()[game.Players.LocalPlayer][name]
end 

wait(1)

function GetLastZone()
    List = {}
    for i,v in pairs(FetchData("UnlockedZones")) do
        table.insert(List , tonumber(Zones[tostring(i)].ZoneNumber))
    end

    max = 0
    for i,v in pairs(List) do
        if v > max then
            max = v
        end
    end

    for i,v in pairs(Zones) do
        if v.ZoneNumber == max then
            return v.ZoneName , v.ZoneNumber
        end
    end

    return nil
end

function GetZones_Num()
    _ , a = GetLastZone()
    return a
end

function Match_Zone(zone)
    for i,v in pairs(FetchData("UnlockedZones")) do
        if tostring(i) == zone then
            return true
        end
    end
    return false
end

function GetZones_Num()
    _ , a = GetLastZone()
    return a
end

function GetRandomZone()
    List = {}
    for i,v in pairs(Zones) do
        if Match_Zone(tostring(i)) then
            table.insert(List , tostring(i))
        end
    end
    return List[math.random(1 , #List)]
end



function GUI()
	local GUI = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")

	--Properties:

	GUI.Name = "GUI"
	GUI.Parent = game.CoreGui
	GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Frame.Parent = GUI
	Frame.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
    Frame.BackgroundTransparency = 0.6
	Frame.Position = UDim2.new(0.178394452, 0, 0.113924049, 0)
	Frame.Size = UDim2.new(0.643211126, 0, 0.132911399, 0)

	TextLabel.Parent = Frame
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.101694912, 0, 0.202380955, 0)
	TextLabel.Size = UDim2.new(0.795069337, 0, 0.59523803, 0)
	TextLabel.Font = Enum.Font.SourceSans
	TextLabel.Text = "Doing Quest Task : 10"
	TextLabel.TextColor3 = Color3.fromRGB(53, 53, 53)
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14.000
	TextLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextWrapped = true
	
	return TextLabel.Text
end

--


function GetZoneName_ByNum(num)
    for i,v in pairs(Zones) do
        if v.ZoneNumber == num then
            return v.ZoneName
        end
    end
    return nil
end


_G.Task = "RankUp"

function GoToBestZone()
    Last_Zone = GetLastZone()

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 2, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)
end

function GoToZone(name)

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[name].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[name].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 2, Zones[name].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)
end


--



spawn(function()
    pcall(function()
        while wait(.2) do
            Number = 0
            for i,v in pairs(FetchData("RedeemedRankRewards")) do
                Number = Number + 1
            end

            local args = {
                [1] = Number + 1
            }
            
            game:GetService("ReplicatedStorage").Network.Ranks_ClaimReward:FireServer(unpack(args))
        end
    end)
end)
--




spawn(function()
    pcall(function()
        while wait(.2) do
            if FetchData("Rank") == 5 and FetchData("Rebirths") == 0 then
                    local args = {
                        [1] = "1"
                    }

                    game:GetService("ReplicatedStorage").Network.Rebirth_Request:InvokeServer(unpack(args))
                else
                    _G.Task = "RankUp"
            end
            if FetchData("Rank") == 5 and FetchData("Rebirths") == 1 then
                local args = {
                    [1] = "2"
                }

                game:GetService("ReplicatedStorage").Network.Rebirth_Request:InvokeServer(unpack(args))
                else
                    _G.Task = "RankUp"
            end
            if FetchData("Rank") == 5 and FetchData("Rebirths") == 2 then
                local args = {
                    [1] = "3"
                }

                game:GetService("ReplicatedStorage").Network.Rebirth_Request:InvokeServer(unpack(args))
                else
                    _G.Task = "RankUp"
            end
            if FetchData("Rank") == 5 and FetchData("Rebirths") == 3 then
                local args = {
                    [1] = "4"
                }

                game:GetService("ReplicatedStorage").Network.Rebirth_Request:InvokeServer(unpack(args))
                else
                    _G.Task = "RankUp"
            end
            if (FetchData("Rank") == 1 and GetZones_Num() < 6) or (FetchData("Rank") == 2 and GetZones_Num() < 16) or (FetchData("Rank") == 4 and GetZones_Num() < 24) or (FetchData("Rank") == 5 and GetZones_Num() < 100) then
                    _G.Task = "Zone"

                    local args = {
                        [1] = GetZoneName_ByNum(GetZones_Num() + 1)
                    }

                    game:GetService("ReplicatedStorage").Network.Zones_RequestPurchase:InvokeServer(unpack(args))
                    
                    Last_Zone = GetLastZone()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 3, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)
                    for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                        if vv:GetAttribute("ParentID") == Last_Zone then

                            local args = {
                                [1] = vv:GetAttribute("BreakableUID")
                            }
                            
                            game:GetService("ReplicatedStorage").Network.Breakables_PlayerDealDamage:FireServer(unpack(args))  
                            break
                        end
                    end
                
                
            else
                _G.Task = "RankUp"
            end
        end
    end)
end)

spawn(function()
    pcall(function()
        while task.wait() do
  
         
                for i,v in pairs(game:GetService("Workspace").__THINGS.Orbs:GetChildren()) do
                    if v.Center then
                        v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        v.Center.Item.Texture = ""
                    end
                end
                for _, v in pairs(workspace.__THINGS.Lootbags:GetChildren()) do
                    v:setPrimaryPartCFrame(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)

                    spawn(function()
                        wait(1.2)
                        v:Destroy()
                    end)
                
                end
            
        end
    end)
end)

spawn(function()
    pcall(function()
        while wait(240) do
            for i = 1,29 do task.wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(695.9906005859375, 16.557292938232422, -251.91146850585938)
                spawn(function()
                    local args = {
                        [1] = i
                    }
            
                    game:GetService("ReplicatedStorage").Network.EquipSlotsMachine_RequestPurchase:InvokeServer(unpack(args))
                end)
            end
            
            for i = 1,5 do task.wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(536.9876708984375, 16.557262420654297, 76.57199096679688)
                spawn(function()
                    local args = {
                        [1] = i
                    }
            
                    game:GetService("ReplicatedStorage").Network.EggHatchSlotsMachine_RequestPurchase:InvokeServer(unpack(args))
                end)
            end

        end
    end)
end)

spawn(function()
    pcall(function()
        while task.wait() do
            if _G.ID then
                local args = {
                    [1] = _G.ID
                }
                
                game:GetService("ReplicatedStorage").Network.Breakables_PlayerDealDamage:FireServer(unpack(args))  
            end
        end
    end)
end)

spawn(function()
    pcall(function()
        while wait(.2) do
            for i,v in pairs(FetchData("Inventory")["Misc"]) do
                if v.id == "Gift Bag" then

                    local args = {
                        [1] = "Gift Bag"
                    }

                    game:GetService("ReplicatedStorage").Network.GiftBag_Open:InvokeServer(unpack(args))

                elseif v.id == "Toy Ball" then

                    game:GetService("ReplicatedStorage").Network.ToyBall_Consume:InvokeServer()

                end
            end      
        end
    end)
end)

_G.AutoRankUp = true

local GUI = GUI()

spawn(function()
    pcall(function()
        while wait() do
            if _G.AutoRankUp and FetchData("Rank") < 5 then
                    if _G.Task == "RankUp" then

                        for i,v in pairs(FetchData("Goals")) do
                            game.CoreGui.GUI.Frame.TextLabel.Text = "Do Quest Type ("..tostring(v.Type)..") : "..tostring(v.Stars).." Stars"
                            if v.Type == 14 then
                                if FetchData("VendingStocks").PotionVendingMachine1 > 0 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(913.2861938476562, 28.859811782836914, -10.250344276428223)
                                    local args = {
                                        [1] = "PotionVendingMachine1",
                                        [2] = 1
                                    }

                                    game:GetService("ReplicatedStorage").Network.VendingMachines_Purchase:InvokeServer(unpack(args))
                                    break
                                end
                            
                            elseif v.Type == 8 then
                                Last_Zone = GetLastZone()
                            
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 2, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)
                                
                                for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                        
                                    if vv:GetAttribute("ParentID") == Last_Zone then
                                        
                                        _G.ID = vv:GetAttribute("BreakableUID")
                                        break
                                    
                                    end
                                end
                                break
                            elseif v.Type == 15 then
                                if FetchData("VendingStocks").EnchantVendingMachine1 > 0 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(367.94183349609375, 29.352033615112305, 94.59992218017578)
                                    local args = {
                                        [1] = "EnchantVendingMachine1",
                                        [2] = 1
                                    }

                                    game:GetService("ReplicatedStorage").Network.VendingMachines_Purchase:InvokeServer(unpack(args))
                                    break
                                end
                            elseif v.Type == 34 then
                                for ii,vv in pairs(FetchData("Inventory")["Potion"]) do
                                    if vv.tn == v.PotionTier then

                                        local args = {
                                            [1] = tostring(ii)
                                        }

                                        game:GetService("ReplicatedStorage").Network:FindFirstChild("Potions: Consume"):FireServer(unpack(args))

                                    end
                                end
                            elseif v.Type == 35 then
                                for ii,vv in pairs(FetchData("Inventory")["Fruit"]) do
                                    local args = {
                                        [1] = tostring(ii),
                                        [2] = 1
                                    }

                                    game:GetService("ReplicatedStorage").Network:FindFirstChild("Fruits: Consume"):FireServer(unpack(args))

                                end
                            elseif v.Type == 6 then
                                local args = {
                                    [1] = GetZoneName_ByNum(GetZones_Num() + 1)
                                }

                                game:GetService("ReplicatedStorage").Network.Zones_RequestPurchase:InvokeServer(unpack(args))

                                Last_Zone = GetLastZone()
                            
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 2, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)
                                
                                for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                        
                                    if vv:GetAttribute("ParentID") == Last_Zone then

                                        _G.ID = vv:GetAttribute("BreakableUID")
                                        break
                                    
                                    end
                                end

                                break
                            elseif v.Type == 7 then
                                if v.CurrencyID == "Coins" then
                                GoToZone("Spawn")

                                for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                    if vv:GetAttribute("ParentID") == "Spawn" then
                                        
                                        _G.ID = vv:GetAttribute("BreakableUID")
                                        break
                                    end
                                end
                                break
                                else
                                    ZoneSafe = GetRandomZone()
                                    HaveDiamond = nil
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[ZoneSafe].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[ZoneSafe].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 2, Zones[ZoneSafe].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)

                                    for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                        if Match_Zone(vv:GetAttribute("ParentID")) and string.find(tostring(vv:GetAttribute("BreakableID")) , "Diamond") and not vv:GetAttribute("VIPBreakable") then
                                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = vv:GetPivot()

                                            local args = {
                                                [1] = vv:GetAttribute("BreakableUID")
                                            }

                                            game:GetService("ReplicatedStorage").Network.Breakables_PlayerDealDamage:FireServer(unpack(args))
                                            HaveDiamond = true
                                            break

                                        end
                                    end

                                    if HaveDiamond == nil then
                                        module:Teleport(game.PlaceId)
                                    end 
                                end
                                break
                            
                            elseif v.Type == 9 then
                                ZoneSafe = GetRandomZone()
                                HaveDiamond = nil
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[ZoneSafe].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[ZoneSafe].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 2, Zones[ZoneSafe].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)

                                for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                    if Match_Zone(vv:GetAttribute("ParentID")) and string.find(tostring(vv:GetAttribute("BreakableID")) , "Diamond") and not vv:GetAttribute("VIPBreakable") then
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = vv:GetPivot()

                                        local args = {
                                            [1] = vv:GetAttribute("BreakableUID")
                                        }

                                        game:GetService("ReplicatedStorage").Network.Breakables_PlayerDealDamage:FireServer(unpack(args))
                                        HaveDiamond = true
                                        break

                                    end
                                end

                                if HaveDiamond == nil then
                                    module:Teleport(game.PlaceId)
                                end 
                                break
                            elseif v.Type == 33 then
                        
                                for ii,vv in pairs(FetchData("Inventory").Misc) do
                                    if vv.id:find("Flag") then
                                            Last_Zone = GetRandomZone()
                                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 2, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)
                                            wait(.1)
                                            local args = {
                                                [1] =  vv.id,
                                                [2] = tostring(ii)
                                            }
                                            game:GetService("ReplicatedStorage").Network:FindFirstChild("Flags: Consume"):InvokeServer(unpack(args))
                                            
                                        break
                                    end
                                end          
                            elseif v.Type == 21 then
                            
                                Last_Zone = GetLastZone()
                            
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 2, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)
                                
                                for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                        
                                    if vv:GetAttribute("ParentID") == Last_Zone then
                                        
                                        _G.ID = vv:GetAttribute("BreakableUID")
                                        break
                                    
                                    end
                                end
                                break
                            elseif v.Type == 1 then
                                if v.BreakableType then
                                    if v.BreakableType == "Present" then
                                        Last_Zone = "Cherry Blossom"
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 2, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)
                                
                                        for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                                
                                            if vv:GetAttribute("ParentID") == Last_Zone then
                    
                                                _G.ID = vv:GetAttribute("BreakableUID")
                                                break
                                            
                                            end
                                        end
                                    elseif v.BreakableType == "Safe" then
                                        D = nil
                                    
                                            table.foreach(Zones , function(i,v)
                                                if v.Breakables.Main then
                                                    table.foreach(v.Breakables.Main.Data , function(ii,vv)
                                                        if string.find(vv.Type , "Safe") then
                                                            Last_Zone = tostring(i)

                                                            if Match_Zone(Last_Zone) then
                                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 2, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)
                                                            end
                                                        end
                                                    end)
                                                end
                                            end)

                                        for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                                
                                            if Match_Zone(vv:GetAttribute("ParentID")) and string.find(tostring(vv:GetAttribute("BreakableID")) , "Safe") then
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = vv:GetPivot()

                                                _G.ID = vv:GetAttribute("BreakableUID")
                                                D = true
                                                break
                                                
                                            end
                                        end
                                        
                                        if D then
                                            break
                                        end

                                        Last_Zone = GetZoneName_ByNum(16)
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 2, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)
                                
                                        for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                                
                                            if vv:GetAttribute("ParentID") == Last_Zone then
                    
                                                _G.ID = vv:GetAttribute("BreakableUID")
                                                break
                                            
                                            end
                                        end

                                        break
                                    else
                                        table.foreach(Zones , function(i,v)
                                            if v.Breakables.Main then
                                                table.foreach(v.Breakables.Main.Data , function(ii,vv)
                                                    if string.find(vv.Type , "Coins") then
                                                        Last_Zone = tostring(i)
                
                                                        if Match_Zone(Last_Zone) then
                                                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 2, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)
                                                        end
                                                    end
                                                end)
                                            end
                                        end)
                
                                        for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                            if Match_Zone(vv:GetAttribute("ParentID")) and string.find(tostring(vv:GetAttribute("BreakableID")) , "Coins") then
                                                
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = vv:GetPivot()
                
                                                _G.ID = vv:GetAttribute("BreakableUID")
                                                break
                                            end
                                        end
                                    end
                                else
                                    Last_Zone = GetZoneName_ByNum(1)

                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)

                                    for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                        if vv:GetAttribute("ParentID") == Last_Zone then
                                            
                                            _G.ID = vv:GetAttribute("BreakableUID")
                                            break
                                        end
                                    end
                                end

                            elseif v.Type == 31 then

                                
                                havecoinjarin = nil

                                if game:GetService("Workspace")["__THINGS"].RandomEvents:FindFirstChild("Jar") then
                                    havecoinjarin = true
                                end

                                havecoinjar = nil
            
                                for ii,vv in pairs(FetchData("Inventory").Misc) do
                                    if vv.id:find("Basic Coin Jar") then

                                        havecoinjar = true
                                        if havecoinjarin == nil then
                                            local args = {
                                                [1] = tostring(ii)
                                            }
                        
                                            game:GetService("ReplicatedStorage").Network.CoinJar_Spawn:InvokeServer(unpack(args))
                                        end
                                    end
                                end
                                
                                if havecoinjar == true then
                                    Zone = GetZoneName_ByNum(5)
                                    GoToZone(Zone)
            
                                    for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                                    
                                        if vv:GetAttribute("ParentID") == Zone then
                                            
                                            _G.ID = vv:GetAttribute("BreakableUID")
                                            break
                                        
                                        end
                                    end
                                    break
                                end
                                break
                            elseif v.Type == 37 then
                                havecoinjarin = nil

                                if game:GetService("Workspace")["__THINGS"].RandomEvents:FindFirstChild("Jar") then
                                    havecoinjarin = true
                                end
                                havecoinjar = nil
            
                                for ii,vv in pairs(FetchData("Inventory").Misc) do
                                    if vv.id:find("Basic Coin Jar") then
                                    
                                        havecoinjar = true
                                        if havecoinjarin == nil then
                                            local args = {
                                                [1] = tostring(ii)
                                            }
                        
                                            game:GetService("ReplicatedStorage").Network.CoinJar_Spawn:InvokeServer(unpack(args))
                                        end
                                    end
                                end
                                
                                if havecoinjar == true then
                                    Last_Zone = GetLastZone()
            
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y + 2, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)
            
                                    for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                                    
                                        if vv:GetAttribute("ParentID") == Last_Zone then
                                            
                                            _G.ID = vv:GetAttribute("BreakableUID")
                                            break
                                        
                                        end
                                    end
                                    break
                                end
                                break
                            elseif v.Type == 32 then

                                haveiscomet = nil

                                for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                                    
                                    if vv:GetAttribute("BreakableID") == "Comet" then
                                        
                                        haveiscomet = true
                                        
                                        break
                                    
                                    end
                                end
                                havecomet = nil
            
                                for ii,vv in pairs(FetchData("Inventory").Misc) do
                                    if vv.id == "Comet" then
                                        havecomet = true
                                        if not haveiscomet then
                                            local args = {
                                                [1] = tostring(ii)
                                            }
                        
                                            game:GetService("ReplicatedStorage").Network.Comet_Spawn:InvokeServer(unpack(args))
                                        end
                                    end
                                end
                                
                                if havecomet == true then
                                    Zone = GetZoneName_ByNum(5)
                                    GoToZone(Zone)
                    
                                    for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                                    
                                        if vv:GetAttribute("BreakableID") == "Comet" then
                                            
                                            _G.ID = vv:GetAttribute("BreakableUID")
                                            break
                                        
                                        end
                                    end
            
                                    break
                                end
                                
                                break
                            elseif v.Type == 38 then
                                havecomet = nil
                                haveiscomet = nil

                                for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                                    
                                    if vv:GetAttribute("BreakableID") == "Comet" then
                                        
                                        haveiscomet = true
                                        
                                        break
                                    
                                    end
                                end
                                for ii,vv in pairs(FetchData("Inventory").Misc) do
                                    if vv.id == "Comet" then
            
                                        havecomet = true
                                        if not haveiscomet then
                                            local args = {
                                                [1] = tostring(ii)
                                            }
                        
                                            game:GetService("ReplicatedStorage").Network.Comet_Spawn:InvokeServer(unpack(args))
                                        end
                                    end
                                end
                                
                                if havecomet == true then
                                    GoToBestZone()
            
                                    for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                                    
                                        if vv:GetAttribute("BreakableID") == "Comet" then
                                            
                                            _G.ID = vv:GetAttribute("BreakableUID")
                                            break
                                        
                                        end
                                    end
                                    break
                                end

                                break
                            elseif v.Type == 3 or v.Type == 20 then
                            

                                
                                
                                for i = 1,50 do wait(.1)
                                    Last_Zone = GetLastZone()

                                    EggName = ""
                                    EggT = Zones[Last_Zone].MaximumAvailableEgg - math.random(0 , 1)
                                    for ii,vv in pairs(Eggs) do
                                        if vv.eggNumber == EggT then
                                            EggName = tostring(ii)
                                        end
                                    end
                                    
                                        spawn(function()
                                            for iii,vvv in pairs(workspace.__THINGS.Eggs.Main:GetChildren()) do
                                                if tonumber(string.match(vvv.Name , "%d+")) == EggT then
                                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = vvv.Center.CFrame
                                                end
                                            end
                                        
                                            local args = {
                                                [1] = EggName,
                                                [2] = FetchData("EggHatchCount")
                                            }
                                            
                                            game:GetService("ReplicatedStorage").Network.Eggs_RequestPurchase:InvokeServer(unpack(args))

                                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(200, 200, 0, true, game, 1)
                                            wait(.1)
                                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(200, 200, 0, false, game, 1)
                                        end)
                                    end
                                

                                for i = 1,120 do wait(.1)
                                    Last_Zone = GetLastZone()

                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)

                                    for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                        if vv:GetAttribute("ParentID") == Last_Zone then
                                            
                                            _G.ID = vv:GetAttribute("BreakableUID")
                                            break
                                        end
                                    end
                                end
                                
                                break
                            else
                                Last_Zone = GetLastZone()

                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.X , Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Y, Zones[Last_Zone].ZoneFolder.INTERACT.BREAK_ZONES.BREAK_ZONE.CFrame.Z)

                                    for ii,vv in pairs(game.workspace.__THINGS.Breakables:GetChildren()) do
                                        if vv:GetAttribute("ParentID") == Last_Zone then
                                            
                                            _G.ID = vv:GetAttribute("BreakableUID")
                                            break
                                        end
                                    end
                            end

                          


                        end
                    end
            end
        end
    end)
end)
