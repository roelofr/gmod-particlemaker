AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--Wiremod
AddCSLuaFile("wm_cl_init.lua")
AddCSLuaFile("wm_shared.lua")
include("wm_shared.lua")
include("wm_init.lua")

if SERVER then
	util.AddNetworkString( "ParticleMakerDupe" )
end

function ENT:UpdateInputs()
	if not WireAddon or WireLib == nil then return end
	
	local WMD = self.Entity.wireModData
	
	if WMD == nil or not WMD.On then
		self.Inputs = WireLib.CreateSpecialInputs(self.Entity, {}, {})
		return
	end
	
	local wireInputs = {}
	table.insert( wireInputs, { "Fire", "NORMAL" } )
	
		-- Change Colors
	if WMD.Colour then
		table.insert( wireInputs, { "Color1", "COLOR" } )
		table.insert( wireInputs, { "Color2", "COLOR" } )
	end
		
		-- Main properties change
	if WMD.Basic then
		table.insert( wireInputs, { "Velocity", "NORMAL" } )
		table.insert( wireInputs, { "Delay", "NORMAL" } )
		table.insert( wireInputs, { "Spread", "NORMAL" } )
		table.insert( wireInputs, { "DieTime", "NORMAL" } )
	end
		-- Only when advanced
	if WMD.Effects then
		table.insert( wireInputs, { "StartAlpha", "NORMAL" } )
		table.insert( wireInputs, { "EndAlpha", "NORMAL" } )
		table.insert( wireInputs, { "StartSize", "NORMAL" } )
		table.insert( wireInputs, { "EndSize", "NORMAL" } )
		table.insert( wireInputs, { "StartLength", "NORMAL" } )
		table.insert( wireInputs, { "EndLength", "NORMAL" } )
	end
	
	if WMD.Advanced then
		table.insert( wireInputs, { "RollRand", "NORMAL" } )
		table.insert( wireInputs, { "RollDelta", "NORMAL" } )
		table.insert( wireInputs, { "AirResistance", "NORMAL" } )
		table.insert( wireInputs, { "Bounce", "NORMAL" } )
		table.insert( wireInputs, { "Gravity", "NORMAL" } )
		table.insert( wireInputs, { "Collide", "NORMAL" } )
		table.insert( wireInputs, { "Lighting", "NORMAL" } )
		table.insert( wireInputs, { "Sliding", "NORMAL" } )
		table.insert( wireInputs, { "Align", "NORMAL" } )
		table.insert( wireInputs, { "Stick", "NORMAL" } )
		table.insert( wireInputs, { "DoubleSided", "NORMAL" } )
		table.insert( wireInputs, { "AngleVelX", "NORMAL" } )
		table.insert( wireInputs, { "AngleVelY", "NORMAL" } )
		table.insert( wireInputs, { "AngleVelZ", "NORMAL" } )
		table.insert( wireInputs, { "StickLifeTime", "NORMAL" } )
		table.insert( wireInputs, { "StickStartSize", "NORMAL" } )
		table.insert( wireInputs, { "StickEndSize", "NORMAL" } )
		table.insert( wireInputs, { "StickStartAlpha", "NORMAL" } )
		table.insert( wireInputs, { "StickEndAlpha", "NORMAL" } )
	end
	
	local InA, InB = {}, {}
	
	for _,v in pairs(wireInputs) do
		table.insert( InA, v[1] )
		table.insert( InB, v[2] )
	end
	
	self.Inputs = WireLib.CreateSpecialInputs(self.Entity, InA, InB)
end

function ENT:GetWiremodSettings( Data )
	self.Entity.wireModData = { On = false, Colour = false, Basic = false, Effects = false, Advanced = false }
	
	local opts = self:KeyToNameValue( Data )	
	self.Entity.wireModData.On = Either( opts['wire_enabled'] ~= nil and opts['wire_enabled'], true, false )
	self.Entity.wireModData.Colour = Either( opts['wire_colour'] ~= nil and opts['wire_colour'], true, false )
	self.Entity.wireModData.Basic = Either( opts['wire_basic'] ~= nil and opts['wire_basic'], true, false )
	self.Entity.wireModData.Effects = Either( opts['wire_effects'] ~= nil and opts['wire_effects'], true, false )
	self.Entity.wireModData.Advanced = Either( opts['wire_advanced'] ~= nil and opts['wire_advanced'], true, false )
	
	self:UpdateInputs()
end

function ENT:Initialize()
	self:SetModel( "models/items/combine_rifle_ammo01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
		
	local phys = self:GetPhysicsObject()
	
	self.PhysgunDisabled = false
	
	self.Entity.wireModData = { On = false, Colour = false, Basic = false, Effects = false, Advanced = false }
	
	self.Firing = false
	self.FiringWire = false
	
	self:SetOverlayText( "Particle Emitter" )
	
	self:UpdateInputs()
end

function ENT:OnRemove()
	if WireAddon then 
		Wire_Remove(self.Entity)
	end
end

function ENT:TriggerInput(Name, Value)
	if (Name == "Fire") then
		local Ent = self:GetTable()
		
		if self:GetToggleWiremod() then
			if Value ~= 0 and not self.hasToggledWM then
				self:SetOn( 'wire', not self.FiringWire )
				self.hasToggledWM = true
			elseif Value == 0 and self.hasToggledWM then
				self.hasToggledWM = false
			end
		else
			if Value ~= 0 then
				self:SetOn( 'wire', true )
			elseif Value == 0 then
				self:SetOn( 'wire', false )
			end
		end
	elseif Name == "Color1" then
		self:TriggerInput( "ColorR1", Value[1] )
		self:TriggerInput( "ColorG1", Value[2] )
		self:TriggerInput( "ColorB1", Value[3] )
	elseif Name == "Color2" then
		self:TriggerInput( "ColorR2", Value[1] )
		self:TriggerInput( "ColorG2", Value[2] )
		self:TriggerInput( "ColorB2", Value[3] )	
	else
		for _,v in pairs(ParticleOptions) do
			if (Name == v.Name) then
				if not SinglePlayer() then
					-- ALWAYS Clamp stuff in multiplayer.. because people are idiots T_T
					Value = math.Clamp(Value, v.Min, v.Max)
				end
				
				if (v.Type == "Bool") then
					Value = util.tobool(Value)
				end
				
				self:SetData({{Name = v.Name, Type = v.Type, Value = Value}})
			end
		end
	end
end


function ENT:SetToggle(b)
	self.Toggle = b or false
end

function ENT:GetToggle()
	return self.Toggle
end
function ENT:SetToggleWiremod(b)
	self.ToggleWiremod = b or false
end

function ENT:GetToggleWiremod()
	return self.ToggleWiremod
end

function ENT:SetOn(source, on)
	on = util.tobool( on )
	local onBefore = self:GetOn()
	if source == "key" then
		self.Firing = on
	elseif source == "wire" then
		self.FiringWire = on
	end
	local isOn = ( self.Firing or self.FiringWire )
	
	self.Entity:SetNetworkedBool("Activated", isOn)
	
	local shouldFireShot = ( isOn ~= onBefore and isOn )
	if shouldFireShot then
		self:FireShot()
	end
end

function ENT:GetOn()
	return self.Firing or self.FiringWire
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


/*---------------------------------------------------------
   Name: OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage(Dmginfo)
	self.Entity:TakePhysicsDamage(Dmginfo)
end
/*---------------------------------------------------------
   Name: CanTool
   Allow all tools
---------------------------------------------------------*/
function ENT:CanTool( ply, trace, mode )
	if string.find( mode, "duplicator", nil, false ) != nil then
		net.Start( "ParticleMakerDupe" )
		net.Send( ply )
		return false
	end
	return true

end

/*---------------------------------------------------------
   Numpad control functions
   These are layed out like this so it'll all get saved properly
---------------------------------------------------------*/

local function On(Ply, Ent)
	if not Ent or Ent == nil or Ent == NULL then return end
	if Ent:GetClass() != "gmod_particlemaker" then return end
	
	if Ent:GetToggle() then
		Ent:SetOn( 'key', not Ent.Firing )
	else
		Ent:SetOn( 'key', true )
	end
end

local function Off(Ply, Ent)
	if not Ent or Ent == nil or Ent == NULL then return end
	if Ent:GetClass() != "gmod_particlemaker" then return end
	
	if not Ent:GetToggle() then
		Ent:SetOn( 'key', false )
	end
end


numpad.Register("Particles_On", On)
numpad.Register("Particles_Off", Off)