local AmbianceModule = {}


function AmbianceModule.ChangeClouds(NewVal, Increment) --Changes the density and coverage of clouds.
	local Clouds = game.Workspace.Terrain.Clouds
	local Increment2 = Increment
	if Clouds.Cover > NewVal then
		Increment2 = -Increment
	end
	for i = Clouds.Cover, NewVal, Increment2 do
		Clouds.Cover = i
		Clouds.Density = i
		wait(0.05)
	end
end

function AmbianceModule.ClearWeather() --Clears the weather completely (doesn't affect clouds)
	game.Workspace.Ambiance.IsInStorm.Value = false
	game.ReplicatedStorage.Events.RainEvent:FireAllClients(false)
	--[[
	RainModule:Enable() can not be activated from a server side script, so instead an Event is fired on all clients
	and the ClientEventsHandler script handles the event and does it.
	The bool value is used to either activate (true) or deactivate (false) rain
	]]
	game.Workspace.Ambiance.WIND_POWER.Value = 0.5
	game.Workspace.Ambiance.WIND_SPEED.Value = 6
	game.Workspace.Ambiance.Wind3.Looped = false
	game.Workspace.Ambiance.Wind3:Stop()
end

function AmbianceModule.Storm(v) --Makes the weather stormy (V value is used to calculate how long it takes for clouds to change)
	AmbianceModule.ClearWeather()
	AmbianceModule.ChangeClouds(1,v)
	game.Workspace.Ambiance.WIND_POWER.Value = 2
	game.Workspace.Ambiance.WIND_SPEED.Value = 7
	game.Workspace.Ambiance.Wind3.Looped = true
	game.Workspace.Ambiance.Wind3:Play()
	game.ReplicatedStorage.Events.RainEvent:FireAllClients(true)
	game.Workspace.Ambiance.IsInStorm.Value = true
end

function AmbianceModule.Sunny(v) --Makes the weather sunny (V value is used to calculate how long it takes for clouds to change)
	AmbianceModule.ClearWeather()
	AmbianceModule.ChangeClouds(0.5,v)
end

function AmbianceModule.Cloudy(v) --Makes the weather cloudy (V value is used to calculate how long it takes for clouds to change)
	AmbianceModule.ClearWeather()
	AmbianceModule.ChangeClouds(0.7,v)
end

function AmbianceModule.Windy(v) --Makes the weather Windy (V value is used to calculate how long it takes for clouds to change)
	AmbianceModule.ClearWeather()
	game.Workspace.Ambiance.WIND_POWER.Value = 1
	game.Workspace.Ambiance.WIND_SPEED.Value = 7
	game.Workspace.Ambiance.Wind3.Looped = true
	game.Workspace.Ambiance.Wind3:Play()
end

function AmbianceModule.Rainy(v) --Makes the weather Rainy (V value is used to calculate how long it takes for clouds to change)
	AmbianceModule.ClearWeather()
	AmbianceModule.ChangeClouds(0.85,v)
	game.ReplicatedStorage.Events.RainEvent:FireAllClients(true)
end


return AmbianceModule
