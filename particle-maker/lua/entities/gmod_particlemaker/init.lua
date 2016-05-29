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


AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_gmodentity" )

function ENT:Initialize()
	self:SetModel( "models/items/combine_rifle_ammo01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

    self:SetOverlayText( "#tool.particle_maker.name" )

	self.Firing = false
end

function ENT:SetToggle(b)
	self.Toggle = b or false
end

function ENT:GetToggle()
	return self.Toggle
end

function ENT:SetOn(source, on)

    if source != "key" then return end

	local onBefore = self:GetOn()

	self.Firing = util.tobool( on )

	self.Entity:SetNetworkedBool("Activated", self.Firing)

	local shouldFireShot = ( self.Firing ~= onBefore and self.Firing )

	if shouldFireShot then
		self:FireShot()
	end
end

function ENT:GetOn()
	return self.Firing
end

function ENT:SetDelay(f)
	self.Delay = f
	self.Entity:SetNetworkedFloat("Delay", f)
end

function ENT:GetDelay()
	return self.Delay
end

function ENT:FireShot()

	local Pos = self.Entity:GetPos()
	Pos = Pos + self.Entity:GetUp() * 4

	// Make the effects
	local Effect = EffectData()
		Effect:SetOrigin(Pos)
		Effect:SetEntity(self.Entity)
	util.Effect("particle_custom", Effect)

end

function ENT:CanTool( ply, trace, mode )
	if string.find( mode, "duplicator", nil, false ) != nil then
		net.Start( "ParticleMakerDupe" )
		net.Send( ply )
		return false
	end

	return true
end
