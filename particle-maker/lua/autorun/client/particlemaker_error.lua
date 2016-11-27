--[[
Copyright 2016 Roelof Roos (SirQuack)
Part of Particle Maker Garry's Mod Tool

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
]]

local properCaps = function(phrase)
    local txt = language.GetPhrase(phrase)
    return string.upper(string.sub(txt, 1, 2)) .. string.sub(txt, 2)
end



net.Receive( "ParticleMakerError", function( length )
    local data = {}
    for i=1,length do
        local str = net.ReadString()
        if string.len( string.Trim( str ) ) > 1 then
            table.insert( data, str )
        end
    end

    Derma_Message(
        data[1] ,
        properCaps('notice') .. ' - Particle Maker',
        properCaps('continue')
        )
end )
