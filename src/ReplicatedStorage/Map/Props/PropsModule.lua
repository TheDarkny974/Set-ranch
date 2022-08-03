--[=[
    @class PropsModule

    This is the class storing every functions used to handle interactable props
]=]

local PropsModule = {}
local TweenService = game:GetService("TweenService")

--[=[
	Used to animate the opening of a gate (for gates in stables)
	@param Handle Part -- Important, it represents the lock of the gate
	@param Hinge Part-- Important, it represents the (often invisible) part the door is attached to (anything attached to it moves accordingly)
]=]

function PropsModule.GateOpenAnim(Handle, Hinge)
	Handle.Attachment.ProximityPrompt.Enabled = false
	local HandleCframe = Handle.CFrame
	local HingeCframe = Hinge.CFrame

	local tweenInfo = TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
	
	local UnlockingMovement = {} UnlockingMovement.CFrame = HandleCframe * CFrame.Angles(math.rad(90),0,0) -- Moves the lock
	local DoorOpenMovement = {} DoorOpenMovement.CFrame = HingeCframe * CFrame.Angles(math.rad(90),0,0) -- Opens the door itself

	local HandleTween = TweenService:Create(Handle, tweenInfo, UnlockingMovement)
	local HingeTween = TweenService:Create(Hinge, tweenInfo, DoorOpenMovement)
	Handle.WeldConstraint.Enabled = false
	Handle.Anchored = true
	
	HandleTween:Play()
	HandleTween.Completed:Connect(function()
		local HandleOpeningMovement = {} HandleOpeningMovement.CFrame = Handle.CFrame * CFrame.new(0.7,0,0)
		local HandleOpeningAnim = TweenService:Create(Handle, tweenInfo, HandleOpeningMovement)

		HandleOpeningAnim:Play()
		HandleOpeningAnim.Completed:Connect(function()
			Handle.WeldConstraint.Enabled = true
			Handle.Anchored = false

			HingeTween:Play()
			HingeTween.Completed:Connect(function()
				Handle.Attachment.ProximityPrompt.Enabled = true
				Handle.Attachment.ProximityPrompt.ActionText = "Close"
			end)
		end)
	end)

end

--[=[
	The same as [PropsModule.GateOpenAnim](/api/PropsModule#GateOpenAnim) except it closes the gate instead
	@param Handle Part -- Important, it represents the lock of the gate
	@param Hinge Part-- Important, it represents the (often invisible) part the door is attached to (anything attached to it moves accordingly)
]=]

function PropsModule.GateCloseAnim(Handle, Hinge)
	Handle.Attachment.ProximityPrompt.Enabled = false
	local HandleCframe = Handle.CFrame
	local HingeCframe = Hinge.CFrame

	local tweenInfo = TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)

	local DoorClose = {} DoorClose.CFrame = HingeCframe * CFrame.Angles(math.rad(0),0,0)
	local DoorCloseTween = TweenService:Create(Hinge, tweenInfo, DoorClose)

	DoorCloseTween:Play()
	DoorCloseTween.Completed:Connect(function()
		Handle.WeldConstraint.Enabled = false
		Handle.Anchored = true

		local HandleClosingMovement = {} HandleClosingMovement.CFrame = Handle.CFrame * CFrame.new(-0.7,0,0)
		local HandleClosingAnim = TweenService:Create(Handle, tweenInfo, HandleClosingMovement)

		HandleClosingAnim:Play()
		HandleClosingAnim.Completed:Connect(function()
			
			local HandleClosingMovement2 = {} HandleClosingMovement2.CFrame = HandleCframe * CFrame.Angles(math.rad(0),0,0)
			local HandleClosingAnim2 = TweenService:Create(Handle, tweenInfo, HandleClosingMovement2)

			HandleClosingAnim2:Play()
			HandleClosingAnim2.Completed:Connect(function()
				Handle.WeldConstraint.Enabled = true
				Handle.Anchored = false
				Handle.Attachment.ProximityPrompt.Enabled = true
				Handle.Attachment.ProximityPrompt.ActionText = "Open"
			end)
		end)
	end)
end

--[=[
	Used when players interact with a light switch (it animates it)
	@param IsLightOn Bool -- Important, used to know whether or not the light is on and therefore if the switch should be on `On` or `Off`
]=]

function PropsModule.LightSwitch(IsLightOn)
	if IsLightOn.Value then 
		IsLightOn.Parent.Part3.Attachment.ProximityPrompt.ActionText = "Turn On"
		IsLightOn.Parent.Part.CFrame = IsLightOn.Parent.Part.CFrame * CFrame.Angles(math.rad(-20),0,0)
	else
		IsLightOn.Parent.Part3.Attachment.ProximityPrompt.ActionText = "Turn Off"
		IsLightOn.Parent.Part.CFrame = IsLightOn.Parent.Part.CFrame * CFrame.Angles(math.rad(20),0,0)
	end
end

--[=[
	Used to animate a door
	@param Hinge Part-- Important, it represents the (often invisible) part the door is attached to (anything attached to it moves accordingly)
]=]

function PropsModule.OpenDoor(Hinge)
	local HingeCframe = Hinge.CFrame
	local tweenInfo = TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut)
	Hinge.Parent.PorteTest.Attachment.ProximityPrompt.Enabled = false

	local DoorMovement = {} DoorMovement.CFrame = HingeCframe * CFrame.Angles(0, math.rad(90),0)
	local DoorAnim = TweenService:Create(Hinge, tweenInfo, DoorMovement)

	DoorAnim:Play()
	DoorAnim.Completed:Connect(function()
		Hinge.Parent.PorteTest.Attachment.ProximityPrompt.Enabled = true
		Hinge.Parent.PorteTest.Attachment.ProximityPrompt.ActionText = "Close"
	end)
end

--[=[
	The same as [PropsModule.OpenDoor](/api/PropsModule#OpenDoor) except it closes the door instead
	@param Hinge Part-- Important, it represents the (often invisible) part the door is attached to (anything attached to it moves accordingly)
]=]

function PropsModule.CloseDoor(Hinge)
	local HingeCframe = Hinge.CFrame
	local tweenInfo = TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut)
	Hinge.Parent.PorteTest.Attachment.ProximityPrompt.Enabled = false

	local DoorMovement = {} DoorMovement.CFrame = HingeCframe * CFrame.Angles(0, math.rad(-90),0)
	local DoorAnim = TweenService:Create(Hinge, tweenInfo, DoorMovement)

	DoorAnim:Play()
	DoorAnim.Completed:Connect(function()
		Hinge.Parent.PorteTest.Attachment.ProximityPrompt.Enabled = true
		Hinge.Parent.PorteTest.Attachment.ProximityPrompt.ActionText = "Open"
	end)
end

return PropsModule
