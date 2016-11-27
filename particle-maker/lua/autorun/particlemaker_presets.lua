--[[
Copyright 2016 Roelof Roos (SirQuack)
Part of Particle Maker Garry's Mod Tool

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
]]

if not SirQuack then SirQuack = {} end
if not SirQuack.ParticleMaker then SirQuack.ParticleMaker = {} end

SirQuack.ParticleMaker.getPresetOptions = function()
    return {
    	label = "#tool.presets",
    	menubutton = 1,
    	folder = "particle",
    	options = {
    		Default = {
    			particle_maker_ColorR1 = '255',
    			particle_maker_ColorG1 = '255',
    			particle_maker_ColorB1 = '255',
    			particle_maker_ColorR2 = '255',
    			particle_maker_ColorG2 = '255',
    			particle_maker_ColorB2 = '255',
    			particle_maker_ColorRand = '0',
    			particle_maker_Velocity = '500.01',
    			particle_maker_Spread = '50',
    			particle_maker_Delay = '0.2.001',
    			particle_maker_Number = '1',
    			Particle_DieTime = '3',
    			particle_maker_StartAlpha = '255',
    			particle_maker_EndAlpha = '0',
    			particle_maker_StartSize = '10',
    			particle_maker_EndSize = '20',
    			particle_maker_StartLength = '0',
    			particle_maker_EndLength = '0',
    			particle_maker_RollRand = '0',
    			particle_maker_RollDelta = '0',
    			particle_maker_AirResistance = '5',
    			particle_maker_Bounce = '0.2',
    			particle_maker_Gravity = '-50',
    			particle_maker_Collide = '1',
    			particle_maker_Lighting = '0',
    			particle_maker_Sliding = '0',
    			particle_maker_3D = '0',
    			particle_maker_Align = '1',
    			particle_maker_Stick = '1',
    			particle_maker_DoubleSided = '1',
    			particle_maker_AngleVelX = '50',
    			particle_maker_AngleVelY = '50',
    			particle_maker_AngleVelZ = '50',
    			particle_maker_StickLifeTime = '2',
    			particle_maker_StickStartSize = '20',
    			particle_maker_StickEndSize = '0',
    			particle_maker_StickStartAlpha = '255',
    			particle_maker_StickEndAlpha = '0',

    			particle_maker_wire_enabled = '1',
    			particle_maker_wire_colour = '0',
    			particle_maker_wire_basic = '1',
    			particle_maker_wire_effects = '0',
    			particle_maker_wire_advanced = '0'
    		}
    	},
    	cvars = {
    		"particle_maker_ColorR1",
    		"particle_maker_ColorG1",
    		"particle_maker_ColorB1",
    		"particle_maker_ColorR2",
    		"particle_maker_ColorG2",
    		"particle_maker_ColorB2",
    		"particle_maker_ColorRand",
    		"particle_maker_Velocity",
    		"particle_maker_Spread",
    		"particle_maker_Delay",
    		"particle_maker_Number",
    		"particle_maker_DieTime",
    		"particle_maker_StartAlpha",
    		"particle_maker_EndAlpha",
    		"particle_maker_StartSize",
    		"particle_maker_EndSize",
    		"particle_maker_StartLength",
    		"particle_maker_EndLength",
    		"particle_maker_RollRand",
    		"particle_maker_RollDelta",
    		"particle_maker_AirResistance",
    		"particle_maker_Bounce",
    		"particle_maker_Gravity",
    		"particle_maker_Collide",
    		"particle_maker_Lighting",
    		"particle_maker_Sliding",
    		"particle_maker_3D",
    		"particle_maker_Align",
    		"particle_maker_Stick",
    		"particle_maker_DoubleSided",
    		"particle_maker_AngleVelX",
    		"particle_maker_AngleVelY",
    		"particle_maker_AngleVelZ",
    		"particle_maker_StickLifeTime",
    		"particle_maker_StickStartSize",
    		"particle_maker_StickEndSize",
    		"particle_maker_StickStartAlpha",
    		"particle_maker_StickEndAlpha",

    		"particle_maker_wire_enabled",
    		"particle_maker_wire_colour",
    		"particle_maker_wire_basic",
    		"particle_maker_wire_effects",
    		"particle_maker_wire_advanced"
    	}
    }
end
