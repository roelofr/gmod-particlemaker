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
    This file adds all available locales to the download list. It's not worth
    downloading a whole workshop addon for 10 files max.
]]

local localePath = "resources/localization/*"
local filePath = "resources/localization/*/particlemaker.properties"

local _, locales = file.Find(localePath, 'GAME')

-- Include shared files
for _, locale in pairs(locales) do
    local langFile = string.format(filePath, locale)

    if file.Exists(langFile, 'GAME') then
        resource.AddFile(langFile)
    end
end
