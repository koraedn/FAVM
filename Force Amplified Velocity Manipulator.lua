--[[
Force Amplified Velocity Manipulator: FAVM.
A roblox script which flings parts when pressing E on contact with them.
FE not CS so don't you worry skids, call players see it.
Contact 'Koraedn' on Discord for help.
]]

local player = game.Players.LocalPlayer--               <───────────────────────┬── get localplayer object from the player service.
local character = player.Character or player.CharacterAdded:Wait()--  <─────────┼── wait for character to load in.
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")--  <────────┼── wait and then get the HRP of the player. (main part of movement)
--  Made by Koraedn, Dm me about issues. 'Koraedn' on Discord                   │
-- ─────────────────────────────────────────────────────────────────────────────┘

local strvelo = 10000
--                ^
--                └── strength of the Fling (feel free to adjust to your likings)

local function veloadd(part)--                 <──────────────────────────────────────────────────────────────┬── creates a function for the part.
    if part and part:IsA("BasePart") and not part.Anchored then--     <───────────────────────────────────────┼── checks a part if its anchored, if so: do not allow velocity to be added to it.
        local bodyVelocity = Instance.new("BodyVelocity")--   <───────────────────────────────────────────────┼── creates the bodyVelocity instance which allows you to set a parts velocity.
        bodyVelocity.Velocity = (humanoidRootPart.Position - part.Position).unit * strvelo--             <────┼── calculates the part's position to the players position, allowing the user to push it forwards at chosen value.
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)--  <─────────────────────────────┼── sets the max fore that can be applied to bodyVelocity in XYZ.
        bodyVelocity.Parent = part--                          <───────────────────────────────────────────────┼── bodyVelocity now affects movement of part (which causes the main flinging effect)
        game.Debris:AddItem(bodyVelocity, 0.1)--              <───────────────────────────────────────────────┼── adds bodyVelocity to debris for .1 sec. (moving body after .1 sec preventing it affecting part indef and causing unwanted behavior)
    end--                                                                                                     │
end--                                                                                                         │
--                                                                                                            │
-- ───────────────────────────────────────────────────────────────────────────────────────────────────────────┘

local function applystupidvelo()--      <───┼── function for applying fling.
    local mouse = player:GetMouse()--   <───┼── gets mouse.
    local targetPart = mouse.Target--   <───┼── gets part mouse is hovering over, else its nil.
    if targetPart then--   <────────────────┼── checks if part isn't nil, if so then run code in the if stat.
        veloadd(targetPart)--             <─┼── add velocity to the part.
    end--                                   │
end--                                       │
--                                          │
-- ─────────────────────────────────────────┘

local uis = game:GetService("UserInputService")--                  <────┬── imports usage of inputs.
--                                                                      │
uis.InputBegan:Connect(function(input, gameProcessed)--                 │
    if not gameProcessed then--                            <────────────┼── checks if it was processed by different elements.
        if input.KeyCode == Enum.KeyCode.E then--          <────────────┼── listen for E keybind.
            applystupidvelo()--                            <────────────┼── use the custom velocity.
        end--                                                           │
    end--                                                               │
end)--                                                                  │
--                                                                      │
-- ─────────────────────────────────────────────────────────────────────┘

warn("use E bind to fling unanchored parts. must be next/touching part.") -- js a message LMAOA
