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

local function Unvec(data)
    return data.x, data.y, data.z
end

--
-- Downloads the information of a Particle Maker into a table
--
SirQuack.ParticleMaker.entitySet = function(ent)
    if not SirQuack.ParticleMaker.IsValid(ent) then return {} end

    local res = {}

    data.ColorR1, data.ColorG1, data.ColorB1 = Unvec(ent:GetColor1())
    data.ColorR2, data.ColorG2, data.ColorB2 = Unvec(ent:GetColor2())
    res.ColorRand = ent:GetColorRand()

    res.Velocity = ent:GetVelocity()
    res.Spread = ent:GetSpread()
    res.Delay = ent:GetDelay()
    res.Number = ent:GetNumber()
    res.DieTime = ent:GetDieTime()
    res.StartAlpha = ent:GetStartAlpha()
    res.EndAlpha = ent:GetEndAlpha()
    res.StartSize = ent:GetStartSize()
    res.EndSize = ent:GetEndSize()
    res.StartLength = ent:GetStartLength()
    res.EndLength = ent:GetEndLength()
    res.RollRand = ent:GetRollRand()
    res.RollDelta = ent:GetRollDelta()
    res.AirResistance = ent:GetAirResistance()
    res.Bounce = ent:GetBounce()
    res.Gravity = ent:GetGravity()
    res.Collide = ent:GetCollide()
    res.Lighting = ent:GetLighting()
    res.Sliding = ent:GetSliding()

    res['3D'] = ent:Get3D()
    res.Align = ent:GetAlign()
    res.Stick = ent:GetStick()
    res.DoubleSided = ent:GetDoubleSided()
    data.AngleVelX, data.AngleVelY, data.AngleVelZ = Unvec(ent:GetAngleVel())
    res.StickLifeTime = ent:GetStickLifeTime()
    res.StickStartSize = ent:GetStickStartSize()
    res.StickEndSize = ent:GetStickEndSize()
    res.StickStartAlpha = ent:GetStickStartAlpha()
    res.StickEndAlpha = ent:GetStickEndAlpha()

    res.Wire = ent:GetWireEnabled()
    res.WireAdvanced = ent:GetWireAdvanced()

    return data
end