--Shadowcalen1's Day/Night Cycle script

--time changer
local CycleHandler = {}
local mam = 60*6--minutes after midnight
local timeShift = 2 --how many minutes you shift every "tick"
local waitTime = 1/30 --legnth of the tick
local pi = math.pi

CycleHandler.amplitudeB = 1
--brightness
local amplitudeB = 1
local offsetB = 2
--outdoor ambieant
local amplitudeO = 20
local offsetO = 100
--shadow softness
local amplitudeS = .2
local offsetS = .8

--color shift top
				--	1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16  17  18  19  20  21  22  23  24/0
local rColorList = {000,000,000,000,000,255,255,255,255,255,255,255,255,255,255,255,255,255,255,000,000,000,000,000}
local gColorList = {165,165,165,165,255,255,215,230,255,255,255,255,255,255,255,245,180,180,255,165,165,165,165,165}
local bColorList = {255,255,255,255,255,255,110,135,255,255,255,255,255,255,255,215,086,086,255,255,255,255,255,255}

while true do
	--time changer
	mam = game.Lighting:GetMinutesAfterMidnight() + timeShift
	if mam > 60*24 then --Resets counter at midnight
		mam = 0
	end
	
	game.Lighting:SetMinutesAfterMidnight(mam)
	mam = mam/60
	
	--brightness
	game.Lighting.Brightness = amplitudeB*math.cos(mam*(pi/12)+pi)+offsetB

	--outdoor ambient
	--local var = amplitudeO*math.cos(mam*(pi/12)+pi)+offsetO
	--game.Lighting.OutdoorAmbient = Color3.fromRGB(var,var,var)

	--shadow softness
	game.Lighting.ShadowSoftness = amplitudeS*math.cos(mam*(pi/6))+offsetS

	--color shift top
	local pointer = math.clamp(math.ceil(mam), 1, 24)
	local r=((rColorList[pointer%24+1]-rColorList[pointer])*(mam-pointer+1))+rColorList[pointer]
	local g=((gColorList[pointer%24+1]-gColorList[pointer])*(mam-pointer+1))+gColorList[pointer]
	local b=((bColorList[pointer%24+1]-bColorList[pointer])*(mam-pointer+1))+bColorList[pointer]	
	game.Lighting.ColorShift_Top = Color3.fromRGB(r,g,b)
	game.Lighting.Atmosphere.Color = Color3.fromRGB(r,g,b)
	--tick
	wait(waitTime)

    if game.Lighting:GetMinutesAfterMidnight() >= 60 * 6 and game.Lighting:GetMinutesAfterMidnight() < 60 * 18 then --Between 6am and 6pm (day)
        for i, v in pairs(game.Workspace.NightLights:GetChildren()) do -- Day, turn off the lights
            if v:IsA("Model") and v.Name == "LanternPost" then -- Do the same, but for models
				v.LightPart.PointLight.Enabled = false
				v.Union.Color = Color3.fromRGB(0,0,0)				
            end
        end
    else
        for i, v in pairs(game.Workspace.NightLights:GetChildren()) do -- Night, turn on the lights
			if v:IsA("Model") and v.Name == "LanternPost" then
				v.LightPart.PointLight.Enabled = true
				v.Union.Color = Color3.fromRGB(253, 234, 141)
            end
        end 
    end
end