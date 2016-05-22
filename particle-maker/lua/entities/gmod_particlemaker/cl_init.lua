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

local lastReceivedDupeError = 0
net.Receive( "ParticleMakerDupe", function( length )
	if lastReceivedDupeError == nil or lastReceivedDupeError < RealTime() - 10 then
		lastReceivedDupeError = RealTime()
		chat.AddText( Color( 255, 255, 255 ), "[ParticleMaker]", Color( 255, 100, 100 ), " You can't currently duplicate particle makers. Sorry about that :/" )
	end
end )
