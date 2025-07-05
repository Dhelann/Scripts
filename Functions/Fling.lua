local function dhelanfling(dhelanTarget)
local speaker=game.Players.LocalPlayer
local dhelanChar=speaker.Character
local dhelanHum=dhelanChar and dhelanChar:FindFirstChildOfClass("Humanoid")
local dhelanRoot=dhelanHum and dhelanHum.RootPart
local dhelanOldPos
local dhelanFPDH
local dhelanTChar=dhelanTarget.Character
local dhelanTHum
local dhelanTRoot
local dhelanTHead
local dhelanAcc
local dhelanHandle
if dhelanTChar:FindFirstChildOfClass("Humanoid") then
dhelanTHum=dhelanTChar:FindFirstChildOfClass("Humanoid")
end
if dhelanTHum and dhelanTHum.RootPart then
dhelanTRoot=dhelanTHum.RootPart
end
if dhelanTChar:FindFirstChild("Head") then
dhelanTHead=dhelanTChar.Head
end
if dhelanTChar:FindFirstChildOfClass("Accessory") then
dhelanAcc=dhelanTChar:FindFirstChildOfClass("Accessory")
end
if dhelanAcc and dhelanAcc:FindFirstChild("Handle") then
dhelanHandle=dhelanAcc.Handle
end
if dhelanChar and dhelanHum and dhelanRoot then
if dhelanRoot.Velocity.Magnitude<50 then
dhelanOldPos=dhelanRoot.CFrame
end
if dhelanTRoot and dhelanTRoot:IsGrounded() then return end
if dhelanTHead then
workspace.CurrentCamera.CameraSubject=dhelanTHead
elseif not dhelanTHead and dhelanHandle then
workspace.CurrentCamera.CameraSubject=dhelanHandle
elseif dhelanTHum and dhelanTRoot then
workspace.CurrentCamera.CameraSubject=dhelanTHum
end
if not dhelanTChar:FindFirstChildWhichIsA("BasePart") then return end
local function dhelanFPos(part,offset,ang)
dhelanRoot.CFrame=CFrame.new(part.Position)*offset*ang
dhelanChar:SetPrimaryPartCFrame(CFrame.new(part.Position)*offset*ang)
dhelanRoot.Velocity=Vector3.new(9e7,9e7*10,9e7)
dhelanRoot.RotVelocity=Vector3.new(9e8,9e8,9e8)
end
local function dhelanDoFling(part)
local dhelanTime=tick()
local angle=0
local maxT=3
repeat
if dhelanRoot and dhelanTHum then
if part.Velocity.Magnitude<50 then
angle+=100
dhelanFPos(part,CFrame.new(0,1.5,0)+dhelanTHum.MoveDirection*part.Velocity.Magnitude/1.25,CFrame.Angles(math.rad(angle),0,0))
task.wait()
dhelanFPos(part,CFrame.new(0,-1.5,0)+dhelanTHum.MoveDirection*part.Velocity.Magnitude/1.25,CFrame.Angles(math.rad(angle),0,0))
task.wait()
dhelanFPos(part,CFrame.new(2.25,1.5,-2.25)+dhelanTHum.MoveDirection*part.Velocity.Magnitude/1.25,CFrame.Angles(math.rad(angle),0,0))
task.wait()
dhelanFPos(part,CFrame.new(-2.25,-1.5,2.25)+dhelanTHum.MoveDirection*part.Velocity.Magnitude/1.25,CFrame.Angles(math.rad(angle),0,0))
task.wait()
dhelanFPos(part,CFrame.new(0,1.5,0)+dhelanTHum.MoveDirection,CFrame.Angles(math.rad(angle),0,0))
task.wait()
dhelanFPos(part,CFrame.new(0,-1.5,0)+dhelanTHum.MoveDirection,CFrame.Angles(math.rad(angle),0,0))
task.wait()
else
dhelanFPos(part,CFrame.new(0,1.5,dhelanTHum.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
task.wait()
dhelanFPos(part,CFrame.new(0,-1.5,-dhelanTHum.WalkSpeed),CFrame.Angles(0,0,0))
task.wait()
dhelanFPos(part,CFrame.new(0,1.5,dhelanTHum.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
task.wait()
dhelanFPos(part,CFrame.new(0,1.5,dhelanTRoot.Velocity.Magnitude/1.25),CFrame.Angles(math.rad(90),0,0))
task.wait()
dhelanFPos(part,CFrame.new(0,-1.5,-dhelanTRoot.Velocity.Magnitude/1.25),CFrame.Angles(0,0,0))
task.wait()
dhelanFPos(part,CFrame.new(0,1.5,dhelanTRoot.Velocity.Magnitude/1.25),CFrame.Angles(math.rad(90),0,0))
task.wait()
dhelanFPos(part,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(90),0,0))
task.wait()
dhelanFPos(part,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
task.wait()
dhelanFPos(part,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(-90),0,0))
task.wait()
dhelanFPos(part,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
task.wait()
end
else break end
until part.Velocity.Magnitude>500 or part.Parent~=dhelanTarget.Character or dhelanTarget.Parent~=game.Players or not dhelanTarget.Character==dhelanTChar or dhelanTRoot:IsGrounded() or dhelanHum.Health<=0 or tick()>dhelanTime+maxT
end
dhelanFPDH=workspace.FallenPartsDestroyHeight
workspace.FallenPartsDestroyHeight=0/0
local dhelanBV=Instance.new("BodyVelocity",dhelanRoot)
dhelanBV.Name="DhelanVel"
dhelanBV.Velocity=Vector3.new(9e8,9e8,9e8)
dhelanBV.MaxForce=Vector3.new(1/0,1/0,1/0)
dhelanHum:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
if dhelanTRoot and dhelanTHead then
if (dhelanTRoot.Position-dhelanTHead.Position).Magnitude>5 then
dhelanDoFling(dhelanTHead)
else
dhelanDoFling(dhelanTRoot)
end
elseif dhelanTRoot and not dhelanTHead then
dhelanDoFling(dhelanTRoot)
elseif not dhelanTRoot and dhelanTHead then
dhelanDoFling(dhelanTHead)
end
workspace.FallenPartsDestroyHeight=dhelanFPDH
dhelanBV:Destroy()
if dhelanOldPos then
dhelanRoot.CFrame=dhelanOldPos
end
end
end

dhelanfling(targetPlayer)
