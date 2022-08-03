--[=[
    @class WeatherModule

    This is the class storing every functions used to handle the weather
]=]

local WeatherModule = {}

local Clouds = game.Workspace.Terrain:WaitForChild("Clouds")
local Wind = game.ReplicatedStorage.Ambiance.Wheather.Wind.WindShake
local TweenService = game:GetService("TweenService")

--[=[
    Used to change clouds (cover, density and color).

    @param CloudsCover Number -- Changes how cloudy the sky is (between 0 and 1)
    @param CloudsDensity Number -- Changes how strong or thick the clouds are (between 0 and 1)
    @param CloudsColor Color3 -- Changes the color of the clouds
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
    Will clear the weather of everything.  
    :::info
    Does not take any parameters.
    :::
]=]
function WeatherModule.Clear()
    WeatherModule.SetClouds(0.5,0.7, Color3.fromRGB(255,255,255))  
end

--[=[
    Changes the weather to storm. 
    Activates rain.  
    Changes clouds' cover, density and color.  
    Changes Wind's power and speed. 
    :::info
    Does not take any parameters.
    :::
]=]

function WeatherModule.Storm()
    WeatherModule.SetClouds(1,1,Color3.fromRGB(45, 45, 45))
    Wind:SetAttribute("WindPower", 2)
    Wind:SetAttribute("WindSpeed", 7)
    game.ReplicatedStorage.Ambiance.Wheather.Wind.ReloadWindShake:FireAllClients()
    WeatherModule.Windy()
end

--- @deprecated V2 -- Use `WeatherModule.Clear` instead.
function WeatherModule.Sunny()
    
end


--[=[
    Plays a wind sound
    :::info
    Does not take any parameters.
    :::
]=]

function WeatherModule.Windy()
    local WindSound = game.ReplicatedStorage.Ambiance.Wheather.Wind.Wind3
    WindSound:Play()
end

--[=[
    Makes the sky more covered
    :::info
    Does not take any parameters.
    :::
]=]

function WeatherModule.Cloudy()
    WeatherModule.SetClouds(0.8, 0.9, Color3.fromRGB(56, 54, 54))
end

--[=[
    :::caution
    Unfinished
    :::

    Activates or deactivates the rain

    :::info
    It is used only for the rain.    
    It does not modify anything related to the sky/clouds
    :::
]=]
function WeatherModule.Rainy()
  
end


return WeatherModule
