local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local lp = game.Players.LocalPlayer
local cam = workspace.CurrentCamera

local state = {
active = false,
bv = nil,
bg = nil,
renderConn = nil,
}

local ctrlMod
pcall(function()
ctrlMod = require(lp.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
end)

local control = {F=0,B=0,L=0,R=0,Q=0,E=0}

local function startFly()
if state.active then return end
state.active = true
local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
if not root then return end
state.bv = Instance.new("BodyVelocity")
state.bv.MaxForce = Vector3.new(1e5,1e5,1e5)
state.bv.Velocity = Vector3.zero
state.bv.Parent = root
state.bg = Instance.new("BodyGyro")
state.bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
state.bg.P = 1e5
state.bg.CFrame = cam.CFrame
state.bg.Parent = root
state.renderConn = RunService.RenderStepped:Connect(function()
if not state.active then return end
local moveVec = Vector3.zero
if ctrlMod then moveVec = ctrlMod:GetMoveVector() end
local joyDir = Vector3.zero
if moveVec.Magnitude > 0 then
joyDir = cam.CFrame.RightVector*moveVec.X + cam.CFrame.LookVector*-moveVec.Z
end
local keyDir = Vector3.zero
keyDir = keyDir + cam.CFrame.LookVector * (control.F + control.B)
keyDir = keyDir + cam.CFrame.RightVector * (control.L + control.R)
keyDir = keyDir + cam.CFrame.UpVector * ((control.Q + control.E) * 0.5)
local dir = joyDir + keyDir
local mag = dir.Magnitude
local flySpeed = (mag > 0) and 50 or 0
if mag > 0 then dir = dir.Unit end
state.bv.Velocity = dir * flySpeed
state.bg.CFrame = cam.CFrame
local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
if hum then hum.PlatformStand = state.active end
end)
end

local function stopFly()
if not state.active then return end
state.active = false
if state.bv then state.bv:Destroy() state.bv = nil end
if state.bg then state.bg:Destroy() state.bg = nil end
if state.renderConn then state.renderConn:Disconnect() state.renderConn = nil end
local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
if hum then hum.PlatformStand = false end
end

local debounce = false

local function toggleFly()
if debounce then return end
debounce = true
task.delay(0.3,function() debounce = false end)
if state.active then stopFly() else startFly() end
end

local function bindJumpDetection()
UserInputService.JumpRequest:Connect(function()
toggleFly()
end)
end

if lp.Character then
bindJumpDetection()
end

lp.CharacterAdded:Connect(function()
task.wait(1)
bindJumpDetection()
end)

lp.CharacterRemoving:Connect(function()
stopFly()
end)

game:GetService("StarterGui"):SetCore("SendNotification",{
Title="JUMP TO FLY",
Text="Tap Space to toggle Fly",
Duration=15
})
