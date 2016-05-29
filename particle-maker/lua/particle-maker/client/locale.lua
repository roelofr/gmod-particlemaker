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
    This file handles locale support. Since Garry's Mod only imports their own
    locales and there is no easy way to find out what language the user uses,
    we simply test it against a list of data we /know/ is correct.

    Afterwards, we manually add the file to the language database.
]]

local function parseProperiesFile(path)
    local data = file.Read(path, 'GAME')
    local dataLines = string.Split(data, "\n")

    local result = {}

    for _, line in pairs(dataLines) do
        line = string.Trim(line)
        if string.len(line) == 0 then continue end
        if string.sub(line, 0, 1) == '#' then continue end

        local _, _, key, value = string.find(
            line,
            '([%w%p_]+)=(.+)'
        )

        result[key] = value
    end

    return result
end

local localeConvar = GetConVar('gmod_language')
local currentLocal = localeConvar:GetString()
local languageFile = 'resource/localization/%s/particlemaker.properties'

-- Locales unavailable, abort.
if string.len(currentLocal) == '' then currentLocal = 'en' end

local baseLangPath = string.format(languageFile, 'en')
local userLangPath = string.format(languageFile, currentLocal)

if not file.Exists(baseLangPath, 'GAME') then return end

local strings = {}

-- Load the template string, the user language will override these but this
-- prevents ugly non-translated strings from showing up.
table.Merge(strings, parseProperiesFile(baseLangPath))

if currentLocal != 'en' and file.Exists(userLangPath, 'GAME') then
    table.Merge(strings, parseProperiesFile(userLangPath))
end

for key, val in pairs(strings) do
    language.Add(key, val)
end