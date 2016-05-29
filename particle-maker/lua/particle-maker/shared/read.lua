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

local function unvec(data)
    return data.x, data.y, data.z
end

--
-- Downloads the information of a Particle Maker into a table
--
SirQuack.ParticleMaker.Read = function(ent)
    if not SirQuack.ParticleMaker.IsValid(ent) then return {} end

    local opts = SirQuack.ParticleMaker.getOptions()

    local customGetter = {
        Velocity = 'GetParticleVelocity',
        Material = 'GetParticleMaterial',
        Number = 'GetParticleCount'
    };

    local data = {}

    -- Auto get as much as possible
    local val = {}
    for _, tab in pairs(opts) do
        if customGetter[tab.Name] then
            val = ent[customGetter[tab.Name]](ent)
            print(string.format('Using %s -> %s', customGetter, val))

        elseif ent['Get' .. tab.Name] then
            val = ent['Get' .. tab.Name](ent)
            print(string.format('Using %s -> %s', 'Get' .. tab.Name, val))

        else
            val = NULL
        end

        if val != NULL then
            if tab.Type == "Bool" then
                val = tobool(val)
            end
        end

        if val == NULL and not tab.Preset then
            print(string.format(
                'Applying default %s to %s',
                tab.Name, tab.Default
            ))
            val = tab.Default
        end

        data[tab.Name] = {
            Name = tab.Name,
            Type = tab.Type,
            Value = val
        }
    end

    local _tmp = {}

    _tmp.ColorR1, _tmp.ColorG1, _tmp.ColorB1 = unvec(ent:GetColor1())
    _tmp.ColorR2, _tmp.ColorG2, _tmp.ColorB2 = unvec(ent:GetColor2())
    _tmp.AngleVelX, _tmp.AngleVelY, _tmp.AngleVelZ = unvec(ent:GetAngleVel())

    local wm = ent:GetWireMode()

    _tmp.Wire = wm >= 1
    _tmp.WireAvanced = wm == 2

    -- Add _tmp to data
    for k,v in pairs(_tmp) do
        if data[k] then
            data[k].Value = v
        end
    end

    -- Check what we're missing
    local missing = {}
    for _, t in pairs(data) do
        if t.Value == NULL then
            table.insert(missing, t.Name)
        end
    end

    -- Warn if we're missing something.
    if table.Count(missing) > 0 then
        print(string.format(
            'Mising entries: %s',
            table.concat(missing, ', ')
        ))
        return nil
    end

    return data
end