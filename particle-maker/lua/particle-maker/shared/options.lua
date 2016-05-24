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

SirQuack.ParticleMaker.getParticleOptions = function()
    return {
	{
        Name = "Material",
        Type = "String",
        Value = ""
    },
	{
        Name = "ColorR1",
        Type = "Float",
        Value = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "ColorG1",
        Type = "Float",
        Value = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "ColorB1",
        Type = "Float",
        Value = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "ColorR2",
        Type = "Float",
        Value = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "ColorG2",
        Type = "Float",
        Value = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "ColorB2",
        Type = "Float",
        Value = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "ColorRand",
        Type = "Bool",
        Value = 0,
        Min = 0,
        Max = 1
    },
	{
        Name = "Velocity",
        Type = "Float",
        Value = 500.01,
        Min = 0,
        Max = 10000
    },
	{
        Name = "Spread",
        Type = "Float",
        Value = 50,
        Min = 0,
        Max = 360
    },
	{
        Name = "Delay",
        Type = "Float",
        Value = 0.2,
        Min = 0.1,
        Max = 10
    },
	{
        Name = "Number",
        Type = "Int",
        Value = 1,
        Min = 1,
        Max = 10
    },
	{
        Name = "DieTime",
        Type = "Float",
        Value = 3,
        Min = 0,
        Max = 10
    },
	{
        Name = "StartAlpha",
        Type = "Float",
        Value = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "EndAlpha",
        Type = "Float",
        Value = 0,
        Min = 0,
        Max = 255
    },
	{
        Name = "StartSize",
        Type = "Float",
        Value = 10,
        Min = 0,
        Max = 100
    },
	{
        Name = "EndSize",
        Type = "Float",
        Value = 20,
        Min = 0,
        Max = 100
    },
	{
        Name = "StartLength",
        Type = "Float",
        Value = 0,
        Min = 0,
        Max = 100
    },
	{
        Name = "EndLength",
        Type = "Float",
        Value = 0,
        Min = 0,
        Max = 100
    },
	{
        Name = "RollRand",
        Type = "Float",
        Value = 0,
        Min = 0,
        Max = 10
    },
	{
        Name = "RollDelta",
        Type = "Float",
        Value = 0,
        Min = -10,
        Max = 10
    },
	{
        Name = "AirResistance",
        Type = "Float",
        Value = 5,
        Min = 0,
        Max = 1000
    },
	{
        Name = "Bounce",
        Type = "Float",
        Value = 0.2,
        Min = 0,
        Max = 10
    },
	{
        Name = "Gravity",
        Type = "Float",
        Value = -50,
        Min = -1000,
        Max = 1000
    },
	{
        Name = "Collide",
        Type = "Bool",
        Value = 1,
        Min = 0,
        Max = 1
    },
	{
        Name = "Lighting",
        Type = "Bool",
        Value = 0,
        Min = 0,
        Max = 1
    },
	{
        Name = "Sliding",
        Type = "Bool",
        Value = 0,
        Min = 0,
        Max = 1
    },

	{
        Name = "3D",
        Type = "Bool",
        Value = 0,
        Min = 0,
        Max = 1
    },
	{
        Name = "Align",
        Type = "Bool",
        Value = 1,
        Min = 0,
        Max = 1
    },
	{
        Name = "Stick",
        Type = "Bool",
        Value = 1,
        Min = 0,
        Max = 1
    },
	{
        Name = "DoubleSided",
        Type = "Bool",
        Value = 1,
        Min = 0,
        Max = 1
    },
	{
        Name = "AngleVelX",
        Type = "Float",
        Value = 50,
        Min = -500,
        Max = 500
    },
	{
        Name = "AngleVelY",
        Type = "Float",
        Value = 50,
        Min = -500,
        Max = 500
    },
	{
        Name = "AngleVelZ",
        Type = "Float",
        Value = 50,
        Min = -500,
        Max = 500
    },
	{
        Name = "StickLifeTime",
        Type = "Float",
        Value = 2,
        Min = 0.01,
        Max = 10
    },
	{
        Name = "StickStartSize",
        Type = "Float",
        Value = 20,
        Min = 0,
        Max = 100
    },
	{
        Name = "StickEndSize",
        Type = "Float",
        Value = 0,
        Min = 0,
        Max = 100
    },
	{
        Name = "StickStartAlpha",
        Type = "Float",
        Value = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "StickEndAlpha",
        Type = "Float",
        Value = 0,
        Min = 0,
        Max = 255
    },
	{
        Name = "Wire",
        Type = "Bool",
        Value = 0,
        Min = 0,
        Max = 1
    },
	{
        Name = "WireAvanced",
        Type = "Bool",
        Value = 0,
        Min = 0,
        Max = 1
    }
}
end