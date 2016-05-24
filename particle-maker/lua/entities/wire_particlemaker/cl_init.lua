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

include('shared.lua')

ENT.Spawnable			= false
ENT.AdminSpawnable		= false
ENT.RenderGroup 		= RENDERGROUP_OPAQUE

function ENT:Initialize()
	self.Entity.NextShot = CurTime()
	self.Entity.Delay = CurTime() + 0.04
end

function ENT:Draw()

	if ( self.ShouldDraw == 0 ) then return end

	-- Don't draw the camera if we're taking pics
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()
	if ( wep:IsValid() ) then
		if ( wep:GetClass() == "gmod_camera" ) then return end
	end

	self:DrawModel()

end

function ENT:Think()

	if self.Entity:GetNetworkedBool("Activated") and not self.Entity.isActive then
		local Pos = self.Entity:GetPos() + self.Entity:GetUp() * 4
		local Effect = EffectData()
			Effect:SetOrigin( Pos )
			Effect:SetEntity( self.Entity )
		util.Effect( "particle_custom", Effect )

		self.Entity.isActive = true
	elseif not self.Entity:GetNetworkedBool("Activated") and self.Entity.isActive then
		self.Entity.isActive = false
	end

end
