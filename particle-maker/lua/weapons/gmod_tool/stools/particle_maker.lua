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

DEFINE_BASECLASS( "base_gmodentity" )

TOOL.Category		= "Construction"
TOOL.Name			= "#tool.particle_maker.name"
TOOL.Command		= nil
TOOL.ConfigName		= ""

-- These convars are not part of any preset, so are defined here.
TOOL.GhostEntities = {}

-- Register numpad
SirQuack.ParticleMaker.bindNumpad()

-- Get all options
local particleOptions = SirQuack.ParticleMaker.getOptions()

-- Add all settings
for _,v in pairs(particleOptions) do
    if v.Type == "Bool" then
        TOOL.ClientConVar[v.Name] = v.Value and 1 or 0
    else
        TOOL.ClientConVar[v.Name] = v.Default
    end
end

cleanup.Register("particle_makers")
CreateConVar("sbox_maxparticle_makers", 1, FCVAR_NOTIFY)
CreateConVar("particle_maker_Clamp", 1, FCVAR_NOTIFY)

function TOOL:BoolToNum(Data)
	local newdata = data
	for k,v in pairs(newdata) do
		if type(v) == "boolean" then
			newdata[k] = v and 1 or 0
		end
	end

	return newdata
end

function TOOL:GetNetworkedValues(ent)
	local data = SirQuack.ParticleMaker.Read(ent)
	return self:BoolToNum(data)
end

function TOOL:GetUserValues()
	local data, value, valueS = {}, nil, nil

	for k,v in pairs(particleOptions) do
		if (v.Type == "String") then
			value = self:GetClientInfo(v.Name)
		elseif (v.Type == "Bool") then
			value = self:GetClientNumber(v.Name) == 1
		else
			value = self:GetClientNumber(v.Name)

            -- Always clamp in multiplayer
			if not game.SinglePlayer() and v.Min and v.Max then
				value = math.Clamp(value, v.Min, v.Max)
			end
        end

        print(string.format(
            'For %s\t%s -> %s', v.Name, self:GetClientInfo(v.Name), value
        ))

        table.insert(data, {
    		Type = v.Type,
    		Name = v.Name,
            Value = value
        })
	end

	return data
end

function TOOL:LeftClick(trace)
	if trace.Entity and trace.Entity:IsPlayer() then return false end

    -- The creation is done server-side, prediction is complete
	if CLIENT then return true end

    -- Make sure we're doing something legal
    if not util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) then
        return false
    end

    -- Get config
	local ply = self:GetOwner()
	local data = self:GetUserValues()

    -- Retrieve a couple of useful keys
	local material = self:GetClientInfo('Material')
    local wireOn = self:GetClientInfo('Wire') == 1

    -- We really do need a material
	if material == nil or material == NULL or string.len( material ) == 0 then
		net.Start( "ParticleMakerError" )
			net.WriteString( "#tool.particle_maker.error.material" )
		net.Send( ply )
		return false
	end

	-- We shot an existing particle maker - just change its values
	if
        trace.Entity:IsValid() and
        trace.Entity:GetClass() == "gmod_particlemaker" and
        trace.Entity:GetPlayer() == ply
    then
		SirQuack.ParticleMaker.Write(trace.Entity, data)
		DoPropSpawnedEffect(trace.Entity)
		return true
	end

    -- Check if the user idn't hit the limit
	if not self:GetSWEP():CheckLimit("particle_makers") then return false end

    -- Get position and angles
    local pos = trace.HitPos
	local angle = trace.HitNormal:Angle()
	angle:RotateAroundAxis( angle:Right(), -90 )

    -- Create the object
	local entity = SirQuack.ParticleMaker.Add( ply, angle, pos, data )

    -- Do we want to build a snowman?
    if self:GetClientNumber("Frozen") == 1 then
        entity:GetPhysicsObject():EnableMotion(false)
    end

    -- Weld if requested, weld to world too
	local weld
	if self:GetClientNumber("Weld") == 1 then
        if trace.Entity:IsValid() or trace.Entity:IsWorld() then
			weld = constraint.Weld(entity, trace.Entity, 0, trace.PhysicsBone, 0, 0, true)
		end
	end

    -- Register as undo-able
	undo.Create("particle_maker")
		undo.AddEntity(entity)
		undo.AddEntity(weld)
		undo.SetPlayer(ply)
	undo.Finish()

	return true

end

function TOOL:RightClick(trace)

    -- You shot a player!
	if trace.Entity and trace.Entity:IsPlayer() then return false end

    -- Check if we hit a particle maker
    if  not trace.Entity:IsValid() or
        trace.Entity:GetClass() != "gmod_particlemaker"
    then return false end

    -- End of prediction
	if CLIENT then return true end

        -- Check if the physics are sound
    if !util.IsValidPhysicsObject(trace.Entity, trace.PhysicsBone) then
        return false
    end

	local data = SirQuack.ParticleMaker.Read(trace.Entity)

    if not data then
        return false
    end

    local convarData = {}

	for _,v in pairs(data) do
        if self.ClientConVar[v.Name] then
            table.insert(convarData, v)
        end
	end

    //print(string.rep('=', 64))
    //print('[[ convarData ]]')
    //PrintTable(convarData)
    //print(string.rep('-', 64))

    net.Start("ParticleMakerData")
        net.WriteInt(RealTime(), 32)
        net.WriteTable(convarData)
    net.Send( self:GetOwner() )

    return true
end

function TOOL:UpdateGhost(ent, ply)

	if not IsValid( ent ) then return end

	local trace = util.TraceLine( util.GetPlayerTrace( ply ) )
	if !trace.Hit then return end

    -- Hide ghost when pointing at a player
	if trace.Entity and (
        trace.Entity:IsPlayer() or
        trace.Entity:GetClass() == "gmod_particlemaker")
    then
        ent:SetNoDraw( true )
        return
    end

    local angle = trace.HitNormal:Angle()
    angle.pitch = angle.pitch + 90

    ent:SetNoDraw( false )
    ent:SetPos( trace.HitPos )
    ent:SetAngles( angle )

end

function TOOL:Think()

    if not SERVER or game.SinglePlayer() then
        if !IsValid( self.GhostEntity ) then
    		self:MakeGhostEntity(
                'models/items/combine_rifle_ammo01.mdl',
                Vector(0, 0, 0), Angle(0, 0, 0)
            )
        else
            self:UpdateGhost( self.GhostEntity, self:GetOwner() )
    	end
	end

end

function TOOL.BuildCPanel(CPanel)
    SirQuack.ParticleMaker.controlPanel(CPanel)
end
