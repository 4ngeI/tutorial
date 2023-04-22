--[[
THIS WILL NOT WORK IN KRNL, IF YOU USE KRNL DON'T USE KRNL INSTEAD USE FLUXUS, KRNL'S FUNCTIONS ARE SHIT
]]

local plrs = game:GetService("Players") 
local plr = plrs.LocalPlayer
local uis = game:GetService("UserInputService")
local camara = game:GetService("Workspace").CurrentCamera
local mouse  = plr:GetMouse()
local runService = game:GetService("RunService")
local aimbotting = false
local aimbotsettings = {
    enabled = true,
    smoothness = 1
}

local fov = Drawing.new("Circle") --from syn drawing lib, works on most exploits
fov.Filled = false
fov.Radius = 120
fov.Visible = true
fov.Thickness = .1

task.spawn(function() --aimbot function
    local function masccercano()
        local mas_cercano = nil
        local numeroIMportante = math.huge
        for i,v in pairs(plrs:GetPlayers()) do
            if v.Name ~= plr.Name then
                if v.Character then
                    if v.Character:FindFirstChild("Head") then
                        local wp = v.Character.Head.Position
                        local amogus,enpantalla = camara:WorldToScreenPoint(wp)
                        local XDXD = (Vector2.new(mouse.X,mouse.Y)- Vector2.new(amogus.X,amogus.Y)).Magnitude
                        if numeroIMportante>XDXD and XDXD < fov.Radius and enpantalla then
                            mas_cercano = v
                            numeroIMportante = XDXD
                        end
                    end
                end
            end
        end
        return mas_cercano
    end

    runService.RenderStepped:Connect(function()
        if aimbotting then
            if masccercano() then --if not nil
                local XDXD, onscreen = camara:WorldToScreenPoint(masccercano().Character.Head.Position)
                local magnitudX = ((mouse.X - XDXD.X)/aimbotsettings.smoothness)
                local magnitudy = ((mouse.Y - XDXD.Y)/aimbotsettings.smoothness)
                mousemoverel(-magnitudX,-magnitudy)
            end
        end
    end)

    uis.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then -- change MouseButton1 to MouseButton2 if want 1st person
            aimbotting = true
        end
    end)
    uis.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            aimbotting = false 
        end
    end)
end)
task.spawn(function() -- fov function
    local function getmousepos()
        local xd = uis:GetMouseLocation()
        return Vector2.new(xd.X, xd.Y)
    end
    runService.RenderStepped:Connect(function()
        fov.Position = getmousepos()
    end)
end)
