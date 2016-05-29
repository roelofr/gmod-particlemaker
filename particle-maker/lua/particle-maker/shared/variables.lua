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

SirQuack.ParticleMaker.getOptions = function()
    return {
	{
        Name = "Material",
        Type = "String",
        Preset = true,
        Default = "",
    },
	{
        Name = "ColorR1",
        Type = "Float",
        Preset = true,
        Default = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "ColorG1",
        Type = "Float",
        Preset = true,
        Default = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "ColorB1",
        Type = "Float",
        Preset = true,
        Default = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "ColorR2",
        Type = "Float",
        Preset = true,
        Default = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "ColorG2",
        Type = "Float",
        Preset = true,
        Default = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "ColorB2",
        Type = "Float",
        Preset = true,
        Default = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "ColorRand",
        Type = "Bool",
        Preset = true,
        Default = false
    },
	{
        Name = "Velocity",
        Type = "Float",
        Preset = true,
        Default = 500.01,
        Min = 0,
        Max = 10000
    },
	{
        Name = "Spread",
        Type = "Float",
        Preset = true,
        Default = 50,
        Min = 0,
        Max = 360
    },
	{
        Name = "Delay",
        Type = "Float",
        Preset = true,
        Default = 0.2,
        Min = 0.1,
        Max = 10
    },
	{
        Name = "Number",
        Type = "Int",
        Preset = true,
        Default = 1,
        Min = 1,
        Max = 10
    },
	{
        Name = "DieTime",
        Type = "Float",
        Preset = true,
        Default = 3,
        Min = 0,
        Max = 10
    },
	{
        Name = "StartAlpha",
        Type = "Float",
        Preset = true,
        Default = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "EndAlpha",
        Type = "Float",
        Preset = true,
        Default = 0,
        Min = 0,
        Max = 255
    },
	{
        Name = "StartSize",
        Type = "Float",
        Preset = true,
        Default = 10,
        Min = 0,
        Max = 100
    },
	{
        Name = "EndSize",
        Type = "Float",
        Preset = true,
        Default = 20,
        Min = 0,
        Max = 100
    },
	{
        Name = "StartLength",
        Type = "Float",
        Preset = true,
        Default = 0,
        Min = 0,
        Max = 100
    },
	{
        Name = "EndLength",
        Type = "Float",
        Preset = true,
        Default = 0,
        Min = 0,
        Max = 100
    },
	{
        Name = "RollRand",
        Type = "Float",
        Preset = true,
        Default = 0,
        Min = 0,
        Max = 10
    },
	{
        Name = "RollDelta",
        Type = "Float",
        Preset = true,
        Default = 0,
        Min = -10,
        Max = 10
    },
	{
        Name = "AirResistance",
        Type = "Float",
        Preset = true,
        Default = 5,
        Min = 0,
        Max = 1000
    },
	{
        Name = "Bounce",
        Type = "Float",
        Preset = true,
        Default = 0.2,
        Min = 0,
        Max = 10
    },
	{
        Name = "Gravity",
        Type = "Float",
        Preset = true,
        Default = -50,
        Min = -1000,
        Max = 1000
    },
	{
        Name = "Collide",
        Type = "Bool",
        Preset = true,
        Default = true
    },
	{
        Name = "Lighting",
        Type = "Bool",
        Preset = true,
        Default = false
    },
	{
        Name = "Sliding",
        Type = "Bool",
        Preset = true,
        Default = false
    },

	{
        Name = "3D",
        Type = "Bool",
        Preset = true,
        Default = false
    },
	{
        Name = "Align",
        Type = "Bool",
        Preset = true,
        Default = true
    },
	{
        Name = "Stick",
        Type = "Bool",
        Preset = true,
        Default = true
    },
	{
        Name = "DoubleSided",
        Type = "Bool",
        Preset = true,
        Default = true
    },
	{
        Name = "AngleVelX",
        Type = "Float",
        Preset = true,
        Default = 50,
        Min = -500,
        Max = 500
    },
	{
        Name = "AngleVelY",
        Type = "Float",
        Preset = true,
        Default = 50,
        Min = -500,
        Max = 500
    },
	{
        Name = "AngleVelZ",
        Type = "Float",
        Preset = true,
        Default = 50,
        Min = -500,
        Max = 500
    },
	{
        Name = "StickLifeTime",
        Type = "Float",
        Preset = true,
        Default = 2,
        Min = 0.01,
        Max = 10
    },
	{
        Name = "StickStartSize",
        Type = "Float",
        Preset = true,
        Default = 20,
        Min = 0,
        Max = 100
    },
	{
        Name = "StickEndSize",
        Type = "Float",
        Preset = true,
        Default = 0,
        Min = 0,
        Max = 100
    },
	{
        Name = "StickStartAlpha",
        Type = "Float",
        Preset = true,
        Default = 255,
        Min = 0,
        Max = 255
    },
	{
        Name = "StickEndAlpha",
        Type = "Float",
        Preset = true,
        Default = 0,
        Min = 0,
        Max = 255
    },
	{
        Name = "Toggle",
        Type = "Bool",
        Preset = false,
        Default = false
    },
	{
        Name = "Weld",
        Type = "Bool",
        Preset = false,
        Default = false
    },
	{
        Name = "Frozen",
        Type = "Bool",
        Preset = false,
        Default = false
    },
	{
        Name = "Key",
        Type = "Int",
        Preset = false,
        Default = 5
    },
	{
        Name = "Wire",
        Type = "Bool",
        Preset = false,
        Default = false
    },
	{
        Name = "WireAvanced",
        Type = "Bool",
        Preset = false,
        Default = false
    }
}
end