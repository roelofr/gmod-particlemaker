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

if not SirQuack then SirQuack = {} end
if not SirQuack.ParticleMaker then SirQuack.ParticleMaker = {} end

SirQuack.ParticleMaker.getPresetOptions = function()
    local opts = SirQuack.ParticleMaker.getOptions()
    local convarTemplate = 'particle_maker_%s'

    local cvars = {}
    local defaults = {}

    local cvarName
    for _, v in pairs(opts) do
        if not v.Preset then continue end

        cvarName = string.format(convarTemplate, v.Name)
        table.insert(cvars, cvarName)

        if v.Type == "Bool" and v.Default then
            defaults[cvarName] = tostring(1)
        elseif v.Type == "Bool" then
            defaults[cvarName] = tostring(0)
        else
            defaults[cvarName] = tostring(v.Default)
        end
    end

    return {
    	label = "#tool.presets",
    	menubutton = 1,
    	folder = "particle",
    	options = {Default = defaults},
    	cvars = cvars
    }
end