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

SirQuack.ParticleMaker.Add = function(ply, ang, pos, data)

    if not ply:CheckLimit("particle_makers") then return nil end

    local entity = ents.Create("gmod_particlemaker")
    if !IsValid(entity) then return false end

    entity:SetAngles(ang)
    entity:SetPos(pos)
    entity:Spawn()

    entity:SetPlayer(ply)
    -- TODO Wiremod support
    -- entity:GetWiremodSettings(data)

    -- Detect toggle yes/no and activation key
    local key
    for _, t in pairs(data) do
        if t.Name == 'Key' then
            key = t.Value
        end
    end

    SirQuack.ParticleMaker.Write(entity, data)

    if key then
        numpad.OnDown(ply, key, "Particles_On", entity)
        numpad.OnUp(ply, key, "Particles_Off", entity)
    end

    DoPropSpawnedEffect(entity)

    ply:AddCount("particle_makers", entity)
    ply:AddCleanup("particle_makers", entity)

    return entity

end
