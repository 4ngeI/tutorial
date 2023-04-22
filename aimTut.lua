--[[
THIS WILL NOT WORK IN KRNL, IF YOU USE KRNL DON'T USE KRNL INSTEAD USE FLUXUS, KRNL FUNCTIONS ARE SHIT +
they banned me for asking why mousemoverel function doesn't work in krnl)
]]

local plrs = game:GetService("Players") 
local plr = plrs.LocalPlayer
local uis = game:GetService("UserInputService")
local camara = game:GetService("Workspace").CurrentCamera
local mouse  = plr:GetMouse()
local runService = game:GetService("RunService")
local aimbotting = false
local aimbotsettings = {
    enabled = true, --you can integrate this aimbot to a gui idk 
    smoothness = 1 --you can integrate this aimbot to a gui idk x2 (linoria ui lib is the best)
}

local fov = Drawing.new("Circle") --from syn drawing lib, works on most exploits (including jjsploit lmao)
fov.Filled = false
fov.Radius = 120
fov.Visible = true
fov.Thickness = .1

task.spawn(function() --aimbot function
    local function masccercano()
        local mas_cercano = nil
        local numeroIMportante = math.huge --prevent cursor from bugging
        for i,v in pairs(plrs:GetPlayers()) do
            if v.Name ~= plr.Name then --check if it is not your player
                if v.Character then --this is to prevent error
                    if v.Character:FindFirstChild("Head") then --this prevents errors
                        local wp = v.Character.Head.Position --this gets the position of each head
                        local amogus,enpantalla = camara:WorldToScreenPoint(wp) --convert vector3 of the head to vector2, since the cursor is vector2 and for obvious reasons you can't move the cursor to vector3
                        local XDXD = (Vector2.new(mouse.X,mouse.Y)- Vector2.new(amogus.X,amogus.Y)).Magnitude --this calculates the distance between the cursor and wp
                        if numeroIMportante>XDXD and XDXD < fov.Radius and enpantalla then --enpantalla basically is onscreen
                            mas_cercano = v
                            numeroIMportante = XDXD
                        end
                    end
                end
            end
        end
        return mas_cercano --this returns to the nearest player to the cursor
    end

    runService.RenderStepped:Connect(function()
        if aimbotting and aimbotsettings.enabled then
            if masccercano() then --if not nil
                local XDXD, onscreen = camara:WorldToScreenPoint(masccercano().Character.Head.Position) --you can change head to HumanoidRootPart, for example; masccercano().Character.HumanoidRootPart.Position
                local magnitudX = ((mouse.X - XDXD.X)/aimbotsettings.smoothness) --XDXD is a number
                local magnitudy = ((mouse.Y - XDXD.Y)/aimbotsettings.smoothness) --the same as the other but in the y axis
                mousemoverel(-magnitudX,-magnitudy) --works correctly in most exploits, except krnl (don't use krnl, they banned me for asking why this function doesn't work in krnl)
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
    runService.RenderStepped:Connect(function() --updates the fov position for each frame, more frames = more smoothness
        fov.Position = getmousepos() ----sometimes it breaks if you use getmouselocation() instead of vector2
    end)
end)
