"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[899],{10848:e=>{e.exports=JSON.parse('{"functions":[{"name":"SetClouds","desc":"Used to change clouds (cover, density and color).\\n\\n\\n```lua\\nWeather:SetClouds(0.5, 0.7, Color3.fromRGB(255,255,255))\\n--OR\\nWeather:SetClouds(0.5,0.7) -- setting the color is optional\\n```\\n:::info\\n* \'CloudsCover\' and \'CloudsDensity\' can have values above 1, but it will not be different than setting it to 1.\\n* Right now it takes 5s for the game to complete the modification, to change that just change the value in \'TweenInfo.new(5)\'\\n:::","params":[{"name":"CloudsCover","desc":"Changes how cloudy the sky is (between 0 and 1)","lua_type":"Float"},{"name":"CloudsDensity","desc":"Changes how strong or thick the clouds are (between 0 and 1)","lua_type":"Float"},{"name":"CloudsColor","desc":"Changes the color of the clouds (optional)","lua_type":"Color3"}],"returns":[],"function_type":"method","source":{"line":33,"path":"src/ReplicatedStorage/Ambiance/Wheather/Weather.lua"}},{"name":"SetWind","desc":"Used to change the speed and power of the wind by changing the attributes of the \'WindShake\' module. \\n:::caution\\nChanging the wind way too fast may result in the game lagging and objects supposedly hit by the \'WindShake\' module to not move\\nas they do not have enough time to adapt to the new settings\\n:::\\n\\n```lua\\nWeather:SetWind(0.5, 2, Vector3.new(0.5,0.5,0.5))\\n--OR\\nWeather:SetWind(0.5,2) -- Setting the direction is optional\\n```","params":[{"name":"WindPower","desc":"Changes how strong the wind is.","lua_type":"Float"},{"name":"WindSpeed","desc":"Changes how rapidly objects hit by the wind move","lua_type":"Float"},{"name":"WindDirection","desc":"","lua_type":"Vector3?"}],"returns":[],"function_type":"method","source":{"line":61,"path":"src/ReplicatedStorage/Ambiance/Wheather/Weather.lua"}},{"name":"Clear","desc":"Will clear the weather of everything.  ","params":[],"returns":[],"function_type":"method","source":{"line":72,"path":"src/ReplicatedStorage/Ambiance/Wheather/Weather.lua"}},{"name":"Storm","desc":"Activates rain.  \\nChanges clouds\' cover, density and color.  \\nChanges Wind\'s power and speed. ","params":[],"returns":[],"function_type":"method","source":{"line":84,"path":"src/ReplicatedStorage/Ambiance/Wheather/Weather.lua"}},{"name":"Windy","desc":"Plays a wind sound\\nChanges wind\'s power and speed","params":[],"returns":[],"function_type":"method","source":{"line":96,"path":"src/ReplicatedStorage/Ambiance/Wheather/Weather.lua"}},{"name":"Cloudy","desc":"Makes the sky more covered","params":[],"returns":[],"function_type":"method","source":{"line":105,"path":"src/ReplicatedStorage/Ambiance/Wheather/Weather.lua"}},{"name":"Rain","desc":"Activates or deactivates the rain\\n\\n:::info \\nIt does not modify anything related to the sky/clouds.          \\nWhich means you can use the function while the sky is completely clear, it will not change that. \\n:::","params":[{"name":"TurnOn","desc":"- If true, the rain will be activated, if false it will be turned off","lua_type":"boolean"}],"returns":[],"function_type":"method","source":{"line":119,"path":"src/ReplicatedStorage/Ambiance/Wheather/Weather.lua"}}],"properties":[],"types":[],"name":"Weather","desc":"This is the class storing every functions used to handle the weather","source":{"line":7,"path":"src/ReplicatedStorage/Ambiance/Wheather/Weather.lua"}}')}}]);