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

SirQuack.ParticleMaker.Write = function(ent, userData)
    if !SirQuack.ParticleMaker.IsValid(ent) then return false end
    if type(userData) != 'table' then return false end

    local customSetter = {
        ["Velocity"] = 'SetParticleVelocity',
        ["Material"] = 'SetParticleMaterial',
        ['Number'] = 'SetParticleCount'
    };

    local data, val, method = {}, nil, nil

    -- Auto set as much as possible
    for _, tab in pairs(userData) do
        if tab.Value == nil or tab.Value == NULL then
            val = 0
        elseif tab.Type == 'Bool' then
            val = tab.Value and 1 or 0
        else
            val = tab.Value
        end

        if customSetter[tab.Name] then
            method = customSetter[tab.Name]
        elseif ent['Set' .. tab.Name] then
            method = 'Set' .. tab.Name
        else
            data[tab.Name] = val
            continue
        end

        ent[method](ent, val)
        print(string.format(
            'Setting %s with %s(%s) -> %s',
            tab.Name, method, val,
            ent[string.gsub(method, '^Set', 'Get')](ent)
        ))
    end

    ent:SetColor1(Vector(data.ColorR1, data.ColorG1, data.ColorB1))
    ent:SetColor2(Vector(data.ColorR2, data.ColorG2, data.ColorB2))
    ent:SetAngleVel(Vector(data.AngleVelX, data.AngleVelY, data.AngleVelZ))

    if data.Wire and data.WireAdvanced then
        ent:SetWireMode(2)
    elseif data.Wire then
        ent:SetWireMode(1)
    else
        ent:SetWireMode(0)
    end

    duplicator.StoreEntityModifier(ent, "particle_maker", userData)

    -- All done :D
    return true

end

duplicator.RegisterEntityModifier(
    "particle_maker",
    SirQuack.ParticleMaker.Write
)
