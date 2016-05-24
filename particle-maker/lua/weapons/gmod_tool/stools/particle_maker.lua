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

TOOL.Category		= "Construction"
TOOL.Name			= "#tool.particle_maker.name"
TOOL.Command		= nil
TOOL.ConfigName		= ""

-- These convars are not part of any preset, so are defined here.
TOOL.ClientConVar["Weld"]	= "1"
TOOL.ClientConVar["Frozen"]	= "1"

TOOL.ClientConVar["Key"]	= "5"
TOOL.ClientConVar["Toggle"]	= "0"

ParticleOptions = SirQuack.ParticleMaker.getParticleOptions()
PresetOptions = SirQuack.ParticleMaker.getPresetOptions()

local _HasWiremod = SirQuack.ParticleMaker.hasWiremod()

-- Add all settings
for _,v in pairs(ParticleOptions) do
	TOOL.ClientConVar[v.Name] = v.Value
end

cleanup.Register("particle_makers")
CreateConVar("sbox_maxparticle_makers", 1, FCVAR_NOTIFY)
CreateConVar("particle_maker_Clamp", 1, FCVAR_NOTIFY)

function TOOL:BoolToNum(Data)
	local NewData = Data
	for k,v in pairs(NewData) do
		if (type(v) == "boolean") then
			if (v) then
				NewData[k] = 1
			else
				NewData[k] = 0
			end
		end
	end

	return NewData
end

function TOOL:GetNetworkedValues(Ent)
	local Data = Ent:GetData(ParticleOptions)
	Data = Ent:BoolToNum(Data)

	return Data
end

function TOOL:GetValues()
	local Data = {}

	for k,v in pairs(ParticleOptions) do
		Data[k] = {}

		if (v.Type == "String") then
			Data[k].Value = self:GetClientInfo(v.Name)
		elseif (v.Type == "Bool") then
			Data[k].Value = util.tobool(self:GetClientNumber(v.Name))
		else
			local Value = self:GetClientNumber(v.Name)
			if not game.SinglePlayer() and util.tobool(GetConVarNumber("particle_maker_Clamp")) then
				-- Clamp stuff in multiplayer.. because people are idiots T_T
				Value = math.Clamp(Value, v.Min, v.Max)
			end

			Data[k].Value = Value
		end

		Data[k].Type = v.Type
		Data[k].Name = v.Name
	end

	return Data
end

local function SetValues(Ent, Data, Toggle)
	if (type(Data) == "table") then
		local PMTable = Ent:GetTable()

		PMTable:SetToggle(Toggle)

        SirQuack.ParticleMaker.entitySet(Ent, Data)

		PMTable:UpdateInputs()
	end

	-- duplicator.StoreEntityModifier(Ent, "particle_maker", Data)
end
-- duplicator.RegisterEntityModifier("particle_maker", SetValues)

function TOOL:LeftClick( trace )
	if trace.Entity and trace.Entity:IsPlayer() then return false end

	if SERVER and !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone )
    then return false end

	if CLIENT then return true end

	local ply = self:GetOwner()
	local _3d = self:GetClientNumber("3D") == 1
	local toggle = self:GetClientNumber("Toggle") == 1
	local key = self:GetClientNumber("Key")
	local data = self:GetValues()

    PrintTable(data)

	local material = self:GetClientInfo("Material")

	if material == nil or material == NULL or string.len( material ) == 0 then
		net.Start( "ParticleMakerError" )
			net.WriteString( "#tool.particle_maker.error.no_material" )
		net.Send( ply )
		return false
	end

	local keyAsNum = tonumber( key )

    if key == nil or key == NULL or keyAsNum <= 0 then
        key = false
    end

    if not key and not _HasWiremod then
		net.Start( "ParticleMakerError" )
			net.WriteString( "#tool.particle_maker.error.input" )
		net.Send( ply )
		return false
	end

	-- We shot an existing particle maker - just change its values
	if
        SirQuack.ParticleMaker.IsValid(trace.Entity) and
        trace.Entity:GetPlayer() == ply
    then
		SetValues(trace.Entity, data, toggle)
		//trace.Entity:GetWiremodSettings(data)
		DoPropSpawnedEffect(trace.Entity)
		return true
	end

	if not self:GetSWEP():CheckLimit("particle_makers") then return false end

	local _entity = MakeParticle( ply, trace.HitPos, data, toggle, key, _3d )

	local angle = trace.HitNormal:Angle()
	angle:RotateAroundAxis( angle:Right(), -90 )

	_entity:SetAngles( angle )

	local weld
	if Trace.Entity:IsValid() then
		if self:GetClientNumber("Weld") == 1 then
			weld = constraint.Weld(_entity, trace.Entity, 0, trace.PhysicsBone, 0, 0, true)
		end
	end

	undo.Create("particle_maker")
		undo.AddEntity(particlemaker)
		undo.AddEntity(weld)
		undo.SetPlayer(ply)
	undo.Finish()

	return true

end

function TOOL:RightClick(Trace)
	if Trace.Entity and Trace.Entity:IsPlayer() then return false end
	if SERVER and not util.IsValidPhysicsObject(Trace.Entity, Trace.PhysicsBone) then return false end

	if Trace.Entity:IsValid() and Trace.Entity:GetClass() == "gmod_particlemaker" then
		if CLIENT then return true end

		local Data = self:GetNetworkedValues(Trace.Entity)

		for _,v in pairs(Data) do
			local Command = "particle_maker_" .. v.Name
			if ConVarExists( Command ) then
				self:GetOwner():ConCommand(Command .. " " .. v.Value)
			end
		end

		return true
	end
end

if (SERVER) then

	function TOOL:Think()
		-- Nothing to see here
	end

	function MakeParticle(Ply, Pos, Data, Toggle, ToggleWiremod, Key, _3D)

		if not Ply:CheckLimit("particle_makers") then return nil end

		local ParticleMaker = ents.Create("gmod_particlemaker")
		if not ParticleMaker:IsValid() then return false end

		ParticleMaker:SetPos(Pos)
		ParticleMaker:SetPlayer(Ply)
		ParticleMaker:Spawn()
		ParticleMaker:Activate()

		ParticleMaker:SetOwner(Ply)
		ParticleMaker:GetWiremodSettings( Data )

		SetValues(ParticleMaker, Data, Toggle, ToggleWiremod)

		if (Key) then
			numpad.OnDown(Ply, Key, "Particles_On", ParticleMaker)
			numpad.OnUp(Ply, Key, "Particles_Off", ParticleMaker)
		end

		if (Pos != Vector(0, 0, 0)) then
			DoPropSpawnedEffect(ParticleMaker)
		end

		Ply:AddCount("particle_makers", ParticleMaker)
		Ply:AddCleanup("particle_makers", ParticleMaker)

		return ParticleMaker

	end

end

function TOOL.BuildCPanel(CPanel)
    SirQuack.ParticleMaker.controlPanel(CPanel)
end
