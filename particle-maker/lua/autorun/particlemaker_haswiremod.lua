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

if not SirQuack then SirQuack = {} end
if not SirQuack.ParticleMaker then SirQuack.ParticleMaker = {} end

--
-- Checks if a wiremod install is present.
--
-- @returns Boolean
--
SirQuack.ParticleMaker.hasWiremod = function()
    if WireLib or WIRE_CLIENT_INSTALLED then
        return true
    else
        return false
    end
end
