--[=[
    @class Weather

    This is the class storing everything used to handle the weather
    
]=]

local Weather = {}

local Clouds = game.Workspace.Terrain:WaitForChild("Clouds")
local Wind = game.ReplicatedStorage.Ambiance.Wheather.Wind.WindShake
local WindSound = workspace.AmbientSounds.Wind3
local TweenService = game:GetService("TweenService")

--[=[
    Used to change clouds (cover, density and color).

    @param CloudsCover number -- Changes how cloudy the sky is (between 0 and 1)
    @param CloudsDensity number -- Changes how strong or thick the clouds are (between 0 and 1)
    @param CloudsColor Color3? -- Changes the color of the clouds (optional)

    ```lua
    Weather:SetClouds(0.5, 0.7, Color3.fromRGB(255,255,255))
    --OR
    Weather:SetClouds(0.5,0.7) -- setting the color is optional
    ```
    :::info
    * 'CloudsCover' and 'CloudsDensity' can have values above 1, but it will not be different than setting it to 1.
    * Right now it takes 5s for the game to complete the modification, to change that just change the value in 'TweenInfo.new(5)'
    :::

]=]

function Weather:SetClouds(CloudsCover: number, CloudsDensity: number, CloudsColor: Color3?)

    local CloudsGoal = {}
        CloudsGoal.Cover = CloudsCover
        CloudsGoal.Density = CloudsDensity
        CloudsGoal.Color = CloudsColor

    local CloudsTween = TweenService:Create(Clouds, TweenInfo.new(5), CloudsGoal)

    CloudsTween:Play()
end

--[=[
    Used to change the speed and power of the wind by changing the attributes of the 'WindShake' module. 
    @param WindPower number --Changes how strong the wind is. 
    @param WindSpeed number --Changes how rapidly objects hit by the wind move
    :::caution
    Changing the wind repeatedly and too fast might make the objects hit by the wind glitch out or not move.
    :::

    ```lua
    Weather:SetWind(0.5, 2, Vector3.new(0.5,0.5,0.5))
    --OR
    Weather:SetWind(0.5,2) -- Setting the direction is optional
    ```

    :::info
    For the moodifications to take effect, the game disables the Wind completely and reenables it, this is the only way 
    I found to actually change the Wind's settings, although I did not look for too long in the WindShake module.
    :::
]=]

function Weather:SetWind(WindPower: number, WindSpeed: number, WindDirection: Vector3?)
    Wind:SetAttribute("WindPower", WindPower)
    Wind:SetAttribute("WindSpeed", WindSpeed)  
    Wind:SetAttribute("WindDirection", WindDirection)
    game.ReplicatedStorage.Ambiance.Wheather.Wind.ReloadWindShake:FireAllClients() 
end

--[=[
    Will clear the weather of everything.  
]=]
function Weather:Clear()
    Weather:SetClouds(0.5,0.7, Color3.fromRGB(255,255,255))  
	Weather:Rain(false)
    Weather:SetWind(0.5,2)
	WindSound:Stop()
end

--[=[
    Activates rain.  
    Changes clouds' cover, density and color.  
    Changes Wind's power and speed. 
]=]

function Weather:Storm()
    Weather:SetClouds(1,1,Color3.fromRGB(45, 45, 45))
    Weather:Windy()
    Weather:SetWind(2,7)
    Weather:Rain(true)
end

--[=[
    Plays a wind sound
    Changes wind's power and speed
]=]

function Weather:Windy()
    Weather:SetWind(0.5,20)
    WindSound:Play()
end

--[=[
    Makes the sky more covered
]=]

function Weather:Cloudy()
    Weather:SetClouds(0.8, 0.9, Color3.fromRGB(56, 54, 54))
end

--[=[
    Activates or deactivates the rain
    @param TurnOn boolean --- If true, the rain will be activated, if false it will be deactivated

    :::info 
    It does not modify anything related to the sky.          
    Which means you can use the function while the sky is completely clear, it will stay clear.
    :::
]=]
function Weather:Rain(TurnOn: boolean)
    script.Parent.RainEvent:FireAllClients(TurnOn)
end


return Weather
