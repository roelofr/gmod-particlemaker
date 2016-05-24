/**
 * Copyright 2016 Roelof Roos (SirQuack)
 * Part of Particle Maker Garry's Mod Tool
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

--[[
    Loads files and adds requirements
]]

local sharedPath = "particle-maker/shared/%s"
local clientPath = "particle-maker/client/%s"
local serverPath = "particle-maker/server/%s"

local sharedFiles = file.Find(string.format(sharedPath, '*.lua'), 'LUA')
local clientFiles = file.Find(string.format(clientPath, '*.lua'), 'LUA')
local serverFiles = file.Find(string.format(serverPath, '*.lua'), 'LUA')

-- Include shared files
for _, file in pairs(sharedFiles) do
    include(string.format(sharedPath, file))
end

if CLIENT then
    -- Include client files
    for _, file in pairs(clientFiles) do
        include(string.format(clientPath, file))
    end
else
    local serverFiles,_ = file.Find("particle-maker/server/*.lua", "LUA")

    -- Include server files
    for _, file in pairs(serverFiles) do
        include(string.format(serverPath, file))
    end

    -- Add as download
    for _, file in pairs(sharedFiles) do
        AddCSLuaFile(string.format(sharedPath, file))
    end
    for _, file in pairs(clientFiles) do
        AddCSLuaFile(string.format(clientPath, file))
    end
end
