--[=[
    @class WeatherModule

    This is the class storing every functions used to handle the weather
]=]

local WeatherModule = {}

local Clouds = game.Workspace.Terrain:WaitForChild("Clouds")
local Wind = game.ReplicatedStorage.Ambiance.Wheather.Wind.WindShake
local WindSound = workspace.AmbientSounds.Wind3
local TweenService = game:GetService("TweenService")

--[=[
    Used to change clouds (cover, density and color).

    @param CloudsCover Float -- Changes how cloudy the sky is (between 0 and 1)
    @param CloudsDensity Float -- Changes how strong or thick the clouds are (between 0 and 1)
    @param CloudsColor Color3 -- Changes the color of the clouds

    ```lua
    local WeatherModule = [Location Of The Module]

    WeatherModule.SetClouds(0.5, 0.7, Color3.fromRGB(255,255,255))
    ```
    :::info
    * 'CloudsCover' and 'CloudsDensity' can have values above 1, but it will not be different than setting it to 1.
    * Right now it takes 5s for the game to complete the modification, to change that just change the value in 'TweenInfo.new(5)'
    :::

]=]

function WeatherModule.SetClouds(CloudsCover,CloudsDensity, CloudsColor)

    local CloudsGoal = {}
        CloudsGoal.Cover = CloudsCover
        CloudsGoal.Density = CloudsDensity
        CloudsGoal.Color = CloudsColor

    local CloudsTween = TweenService:Create(Clouds, TweenInfo.new(5), CloudsGoal)

    CloudsTween:Play()
end

--[=[
    Used to change the speed and power of the wind by changing the attributes of the 'WindShake' module. 
    @param WindPower Float --Changes how strong the wind is. 
    @param WindSpeed Float --Changes how rapidly objects hit by the wind move
    :::caution
    Changing the wind way too fast may result in the game lagging and objects supposedly hit by the 'WindShake' module to not move
    as they do not have enough time to adapt to the new settings
    :::

    ```lua
    local WeatherModule = [Location Of The Module]

    WeatherModule.SetWind(0.5, 2)
    ```
]=]

function WeatherModule.SetWind(WindPower, WindSpeed)
    Wind:SetAttribute("WindPower", WindPower)
    Wind:SetAttribute("WindSpeed", WindSpeed)  
    game.ReplicatedStorage.Ambiance.Wheather.Wind.ReloadWindShake:FireAllClients() 
end

--[=[
    Will clear the weather of everything.  
]=]
function WeatherModule.Clear()
    WeatherModule.SetClouds(0.5,0.7, Color3.fromRGB(255,255,255))  
	script.Parent.RainEvent:FireAllClients(false)
    WeatherModule.SetWind(0.5,2)
	WindSound:Stop()
end

--[=[
    Activates rain.  
    Changes clouds' cover, density and color.  
    Changes Wind's power and speed. 
]=]

function WeatherModule.Storm()
    WeatherModule.SetClouds(1,1,Color3.fromRGB(45, 45, 45))
    WeatherModule.Windy()
    WeatherModule.SetWind(2,7)
    WeatherModule.Rain()
    WeatherModule.Rain()
end

--[=[
    Plays a wind sound
    Changes wind's power and speed
]=]

function WeatherModule.Windy()
    WeatherModule.SetWind(0.5,20)
    WindSound:Play()
end

--[=[
    Makes the sky more covered
]=]

function WeatherModule.Cloudy()
    WeatherModule.SetClouds(0.8, 0.9, Color3.fromRGB(56, 54, 54))
end

--[=[
    Activates or deactivates the rain

    :::info 
    It does not modify anything related to the sky/clouds.          
    Which means you can use the function while the sky is completely clear, it will not change that. 
    :::
]=]
function WeatherModule.Rain()
    script.Parent.RainEvent:FireAllClients(true)
end


return WeatherModule
