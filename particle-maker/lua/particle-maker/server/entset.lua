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

--
-- Updates or installs a Particle Maker with the correct information
--
SirQuack.ParticleMaker.entitySet = function(ent, data)
    if not SirQuack.ParticleMaker.IsValid(ent) then return {} end

    ent:SetColor1(Vector(data.ColorR1, data.ColorG1, data.ColorB1))
    ent:SetColor2(Vector(data.ColorR2, data.ColorG2, data.ColorB2))
    ent:SetColorRand(data.ColorRand)

    ent:SetVelocity(data.Velocity)
    ent:SetSpread(data.Spread)
    ent:SetDelay(data.Delay)
    ent:SetNumber(data.Number)
    ent:SetDieTime(data.DieTime)
    ent:SetStartAlpha(data.StartAlpha)
    ent:SetEndAlpha(data.EndAlpha)
    ent:SetStartSize(data.StartSize)
    ent:SetEndSize(data.EndSize)
    ent:SetStartLength(data.StartLength)
    ent:SetEndLength(data.EndLength)
    ent:SetRollRand(data.RollRand)
    ent:SetRollDelta(data.RollDelta)
    ent:SetAirResistance(data.AirResistance)
    ent:SetBounce(data.Bounce)
    ent:SetGravity(data.Gravity)
    ent:SetCollide(data.Collide)
    ent:SetLighting(data.Lighting)
    ent:SetSliding(data.Sliding)

    ent:Set3D(data['3D'])
    ent:SetAlign(data.Align)
    ent:SetStick(data.Stick)
    ent:SetDoubleSided(data.DoubleSided)
    ent:SetAngleVel(Vector(data.AngleVelX, data.AngleVelY, data.AngleVelZ))
    ent:SetStickLifeTime(data.StickLifeTime)
    ent:SetStickStartSize(data.StickStartSize)
    ent:SetStickEndSize(data.StickEndSize)
    ent:SetStickStartAlpha(data.StickStartAlpha)
    ent:SetStickEndAlpha(data.StickEndAlpha)

    ent:SetWireEnabled(data.Wire)
    ent:SetWireAdvanced(data.Wire and data.WireAdvanced)
end