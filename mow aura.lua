_G.CutGrass = true --set this to false after running script if you want to stop using this

--[[
    code was written to just mow some grass faster in cut the grass
]]

--// Vars

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RS = game:GetService("RunService")

--// Have it so raycast only hits terrain instead of other objects such as a tree

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Whitelist
raycastParams.FilterDescendantsInstances = {workspace.Terrain}

--// cut grass aura loop

while _G.CutGrass do
   local char = LocalPlayer.Character
   if char then
       local hrp = char:FindFirstChild("HumanoidRootPart")
       local tool = char:FindFirstChildOfClass("Tool")
       if hrp and tool then
           for radius = 1, 10, 1 do
               for theta = 0, 360, 30 do
                   local x1 = hrp.Position.X + (radius * math.cos(theta))
                   local y1 = hrp.Position.Y + 10
                   local z1 = hrp.Position.Z + (radius * math.sin(theta))

                   local rayOrigin = Vector3.new(x1, y1, z1)
                   local rayDirection = Vector3.new(rayOrigin.X, -100, rayOrigin.Z)
                   local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

                   if raycastResult and raycastResult.Instance.Name == "Terrain" then
                       local arg = CFrame.new(raycastResult.Position, Vector3.new(-0, -0, -1)) --honestly i don't know why -0, -0, -1 is there
                       game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.MowingService.GrantGrass:FireServer(arg)
                   end
               end
           end
       end
   end
   RS.Heartbeat:Wait()
end
