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
    Initialises the numpad bindings
]]
if not SirQuack then SirQuack = {} end
if not SirQuack.ParticleMaker then SirQuack.ParticleMaker = {} end

local validClasses = {
    ["gmod_particlemaker"] = true,
    ["wire_particlemaker"] = true
}

local function validParticleMaker(Ent)
    if not Ent or Ent == nil or Ent == NULL then return false end
    if not Ent:IsValid() then return false end

    return validClasses[Ent:GetClass()] == true
end

local function ParticleMakerOn(Ply, Ent)
    if not validParticleMaker(Ent) then return end

    print("BORK!!! ParticleMakerOn")

    if Ent:GetToggle() then
        Ent:SetOn( 'key', Ent.Firing )
    else
        Ent:SetOn( 'key', true )
    end
end

local function ParticleMakerOff(Ply, Ent)
    if not validParticleMaker(Ent) then return end

    print("BORK!!! ParticleMakerOff")

    if not Ent:GetToggle() then
        Ent:SetOn( 'key', false )
    end
end

local registered = false
SirQuack.ParticleMaker.bindNumpad = function()
    if registered then return end
    registered = true

    -- Try to register the numpad, fail if you can't
    timer.Create('ParticleMaker_Timer_Numpad', 1, 5, function()
        if numpad and numpad.Register then
            numpad.Register("Particles_On", ParticleMakerOn)
            numpad.Register("Particles_Off", ParticleMakerOff)
            timer.Remove("ParticleMaker_Timer_Numpad")
        end
    end)
end

hook.Add(
    "InitPostEntity",
    "ParticleMaker_InitPostEntity_Numpad",
    SirQuack.ParticleMaker.bindNumpad
)

hook.Add(
    "Initialize",
    "ParticleMaker_Initialize_Numpad",
    SirQuack.ParticleMaker.bindNumpad
)