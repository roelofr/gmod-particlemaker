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

TOOL.Category		= "Construction"
TOOL.Name			= "#tool.particle_maker.name"
TOOL.Command		= nil
TOOL.ConfigName		= ""

-- The 'default' convars, will always be there
TOOL.ClientConVar["Weld"]	= "1"
TOOL.ClientConVar["Frozen"]	= "1"

TOOL.ClientConVar["wire_enabled"]	= "1"
TOOL.ClientConVar["wire_basic"]		= "1"
TOOL.ClientConVar["wire_colour"]	= "0"
TOOL.ClientConVar["wire_effects"]	= "0"
TOOL.ClientConVar["wire_advanced"]	= "0"

TOOL.ClientConVar["Key"]	= "5"
TOOL.ClientConVar["Toggle"]	= "0"
TOOL.ClientConVar["Toggle_Wire"] = "0"

ParticleOptions = SirQuack.ParticleMaker.getParticleOptions()
PresetOptions = SirQuack.ParticleMaker.getPresetOptions()

local _HasWiremod = SirQuack.ParticleMaker.hasWiremod()

local function CreateSegment(CPanel, title)
    local Panel = vgui.Create("DForm", CPanel)

    Panel:SetSizeX( false )
	Panel:Dock( TOP )
	Panel:DockPadding( 10, 10, 10, 0 );

    Panel:SetLabel(title)

    CPanel:AddPanel(Panel)

    Panel:InvalidateLayout(true)

    return Panel
end

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
			if not game.SinglePlayer() then
				-- Always clamp stuff in multiplayer.. because people are idiots T_T
				Value = math.Clamp(Value, v.Min, v.Max)
			end

			Data[k].Value = Value
		end

		Data[k].Type = v.Type
		Data[k].Name = v.Name
	end

	return Data
end

local function SetValues(Ent, Data, Toggle, ToggleWiremod)
	if (type(Data) == "table") then
		local PMTable = Ent:GetTable()

		PMTable:SetToggle(Toggle)
		PMTable:SetToggleWiremod(ToggleWiremod)
		PMTable:SetData(Data)

		PMTable:UpdateInputs()
	end

	-- duplicator.StoreEntityModifier(Ent, "particle_maker", Data)
end
-- duplicator.RegisterEntityModifier("particle_maker", SetValues)

function TOOL:LeftClick( Trace )
	if Trace.Entity and Trace.Entity:IsPlayer() then return false end
	if SERVER and not util.IsValidPhysicsObject( Trace.Entity, Trace.PhysicsBone ) then return false end
	if CLIENT then return true end

	local Ply = self:GetOwner()
	local _3D = self:GetClientNumber("3D") == 1
	local Toggle = self:GetClientNumber("Toggle") == 1
	local ToggleWiremod = self:GetClientNumber("Toggle_Wire") == 1
	local UseWiremod = self:GetClientNumber("wire_enable")
	local Key = self:GetClientNumber("Key")
	local Data = self:GetValues()

	local Material = self:GetClientInfo("Material")

	if Material == nil or Material == NULL or string.len( Material ) == 0 then
		net.Start( "ParticleMakerError" )
			net.WriteString( "#tool.particle_maker.error.no_material" )
		net.Send( Ply )
		return false
	end

	local keyAsNum = tonumber( Key )
	if ( Key == nil or Key == NULL or not Key or keyAsNum <= 0 ) and ( UseWiremod ~= 1 or not _HasWiremod ) then
		net.Start( "ParticleMakerError" )
			net.WriteString( "#tool.particle_maker.error.input" )
		net.Send( Ply )
		return false
	end

	-- We shot an existing particle maker - just change its values
	if (
        Trace.Entity:IsValid() and
        (Trace.Entity:GetClass() == "gmod_particlemaker" or
        Trace.Entity:GetClass() == "wire_particlemaker") and
        Trace.Entity:GetPlayer() == Ply
    ) then
		SetValues(Trace.Entity, Data, Toggle, ToggleWiremod)
		Trace.Entity:GetWiremodSettings( Data )
		DoPropSpawnedEffect(Trace.Entity)
		return true
	end

	if not self:GetSWEP():CheckLimit("particle_makers") then return false end

	local ParticleMaker = MakeParticle( Ply, Trace.HitPos, Data, Toggle, ToggleWiremod, Key, _3D )
	local Angle = Trace.HitNormal:Angle()
		Angle:RotateAroundAxis( Angle:Right(), -90 )
	ParticleMaker:SetAngles( Angle )

	local Weld
	if Trace.Entity:IsValid() then
		if self:GetClientNumber("Weld") == 1 then
			Weld = constraint.Weld(ParticleMaker, Trace.Entity, 0, Trace.PhysicsBone, 0, 0, true)
		end
	end

	undo.Create("particle_maker")
		undo.AddEntity(ParticleMaker)
		undo.AddEntity(Weld)
		undo.SetPlayer(Ply)
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

	-- MAIN HEADER
	CPanel:Help("#tool.particle_maker.desc")

    SirQuack.ParticleMaker.runOnce(CPanel)

    --[[
        PRESETS
    ]]

    local frm = vgui.Create("DForm", CPanel)
    frm:SetLabel("#tool.particle_maker.hdr.presets")

    CPanel:AddPanel(frm)

    local ctrl = vgui.Create("ControlPresets", frm)

    ctrl:SetPreset( PresetOptions.folder )

    for k, v in pairs( PresetOptions.options ) do ctrl:AddOption( k, v ) end
    for k, v in pairs( PresetOptions.cvars ) do ctrl:AddConVar( k, v ) end

    frm:AddItem(ctrl)

    frm:SizeToContentsY()
    frm:InvalidateLayout()

    --[[
        GENERIC SETTINGS
    ]]

    local frm = vgui.Create("DForm", CPanel)
    frm:SetLabel("#tool.particle_maker.hdr.generic")

    CPanel:AddPanel(frm)

    --  Weld to props?
    frm:CheckBox("#tool.particle_maker.weld", "particle_maker_Weld")

    -- Spawn frozen?
    frm:CheckBox("#tool.particle_maker.frozen", "particle_maker_Frozen")

    -- Toggle
    frm:CheckBox("#tool.particle_maker.toggle", "particle_maker_Toggle")

	-- Activation button
    local ctrl = vgui.Create("CtrlNumPad", frm)
    ctrl:SetConVar1("particle_maker_Key")
    ctrl:SetLabel1("#tool.particle_maker.key")
    frm:AddItem(ctrl)

    frm:SizeToContentsY()
    frm:InvalidateLayout()

    --[[
        COLOUR SETTINGS
    ]]

    local frm = vgui.Create("DForm", CPanel)
    frm:SetLabel("#tool.particle_maker.hdr.color")

    CPanel:AddPanel(frm)

    -- Color 1
	local ctrl = vgui.Create("DColorMixer", frm)

    ctrl:SetLabel("#tool.particle_maker.color.1")
	ctrl:SetConVarR("particle_maker_ColorR1")
    ctrl:SetConVarG("particle_maker_ColorG1")
	ctrl:SetConVarB("particle_maker_ColorB1")

    ctrl:SetAlphaBar(false)
    ctrl:SetPalette(true)

    frm:AddItem(ctrl, nil)

	-- Color 2
	local ctrl = vgui.Create("DColorMixer", frm)

    ctrl:SetLabel("#tool.particle_maker.color.2")
	ctrl:SetConVarR("particle_maker_ColorR2")
    ctrl:SetConVarG("particle_maker_ColorG2")
	ctrl:SetConVarB("particle_maker_ColorB2")

    ctrl:SetAlphaBar(false)
    ctrl:SetPalette(true)

    frm:AddItem(ctrl, nil)

    -- Random color
    frm:CheckBox(
        "#tool.particle_maker.color.mix",
        "particle_maker_ColorRand"
    )

    frm:SizeToContentsY()
    frm:InvalidateLayout()

    --[[
        MATERIAL SETTINGS
    ]]

    local frm = vgui.Create("DForm", CPanel)
    frm:SetLabel("#tool.particle_maker.hdr.material")
    CPanel:AddPanel(frm)

    local ctrl = vgui.Create( "MatSelect", frm )
    ctrl:SetItemWidth( 64 )
    ctrl:SetItemHeight( 64 )
    ctrl:SetNumRows( 3 )
    ctrl:SetConVar( "particle_maker_Material" )

    Derma_Hook( ctrl.List, "Paint", "Paint", "Panel" )

	for name, value in pairs(SirQuack.ParticleMaker.getParticles()) do
        ctrl:AddMaterialEx( name, value, nil, {
            particle_maker_Material = value
        })
	end

    frm:AddItem(ctrl, nil)

	-- Material textbox
	frm:TextEntry("#tool.particle_maker.material", "particle_maker_Material")

    frm:SizeToContentsY()
    frm:InvalidateLayout()

    --[[
        EFFECT SETTINGS
    ]]

    local frm = vgui.Create("DForm", CPanel)
    frm:SetLabel("#tool.particle_maker.hdr.effect")
    CPanel:AddPanel(frm)

	-- Fire delay
	frm:NumSlider(
        "#tool.particle_maker.fire_delay",
        "particle_maker_Delay",
        0.001, 10, 2
    )

	-- Number particles
	frm:NumSlider(
        "#tool.particle_maker.partice_count",
        "particle_maker_Number",
		1, 10, 0
	)

	-- Velocity
	frm:NumSlider(
        "#tool.particle_maker.velocity",
        "particle_maker_Velocity",
		1, 10000, 0
	)

	-- Spread
	frm:NumSlider(
        "#tool.particle_maker.spread",
        "particle_maker_Spread",
		0, 360, 0
	)

	-- Die time
	frm:NumSlider(
        "#tool.particle_maker.die_time",
        "particle_maker_DieTime",
		1, 10, 1
	)

	-- Start alpha
	frm:NumSlider(
        "#tool.particle_maker.alpha.start",
        "particle_maker_StartAlpha",
		0, 255, 0
	)

	-- End alpha
	frm:NumSlider(
        "#tool.particle_maker.alpha.end",
        "particle_maker_EndAlpha",
		0, 255, 0
	)

	-- Start size
	frm:NumSlider(
        "#tool.particle_maker.size.start",
        "particle_maker_StartSize",
		0, 100, 0
	)

	-- End size
	frm:NumSlider(
        "#tool.particle_maker.size.end",
        "particle_maker_EndSize",
		0, 100, 0
	)

	-- Start length
	frm:NumSlider(
        "#tool.particle_maker.length.start",
        "particle_maker_StartLength",
		0, 100, 0
	)

	-- End length
	frm:NumSlider(
        "#tool.particle_maker.length.end",
        "particle_maker_EndLength",
		0, 100, 0
	)

	-- Roll
	frm:NumSlider(
        "#tool.particle_maker.roll_speed",
        "particle_maker_RollRand",
		0, 10, 2
	)

	-- Roll delta
	frm:NumSlider(
        "#tool.particle_maker.roll_delta",
        "particle_maker_RollDelta",
		-10, 10, 2
	)

	-- Air resistance
	frm:NumSlider(
        "#tool.particle_maker.air_resistance",
        "particle_maker_AirResistance",
		0, 1000, 0
	)

	-- Bounce
	frm:NumSlider(
        "#tool.particle_maker.bounce",
        "particle_maker_Bounce",
		0, 10, 2
	)

	-- Gravity
	frm:NumSlider(
        "#tool.particle_maker.gravity",
        "particle_maker_Gravity",
		-1000, 1000, 0
	)

	-- Collision
	local _cld = frm:CheckBox("#tool.particle_maker.collide", "particle_maker_Collide")

	-- Lighting
	frm:CheckBox("#tool.particle_maker.lighting", "particle_maker_Lighting")

	-- Slide
	local _sld = frm:CheckBox("#tool.particle_maker.sliding", "particle_maker_Sliding")
	frm:ControlHelp("#tool.particle_maker.sliding.help")

    frm:SizeToContentsY()
    frm:InvalidateLayout()

    --[[
        3D SETTINGS
    ]]
    local frm = vgui.Create("DForm", CPanel)
    frm:SetLabel("#tool.particle_maker.hdr.3d")
    CPanel:AddPanel(frm)

	-- Toggle 3D
	local _3d = frm:CheckBox("#tool.particle_maker.3d", "particle_maker_3D")

	-- Double sided
	local _3dt = frm:CheckBox(
        "#tool.particle_maker.doublesided", "particle_maker_DoubleSided")
    frm:ControlHelp("#tool.particle_maker.doublesided.help")

	-- Stick
	local _3ds = frm:CheckBox(
        "#tool.particle_maker.stick", "particle_maker_Stick")
    frm:ControlHelp("#tool.particle_maker.stick.help")

	-- Align
	local _3da = frm:CheckBox(
        "#tool.particle_maker.align", "particle_maker_Align")
    frm:ControlHelp("#tool.particle_maker.align.help")

	-- Angle velocity X
	frm:NumSlider(
		"#tool.particle_maker.angvel.x",
        "particle_maker_AngleVelX",
		-500, 500, 2
	)

	-- Angle velocity Y
	frm:NumSlider(
		"#tool.particle_maker.angvel.y",
        "particle_maker_AngleVelY",
		-500, 500, 2
	)

	-- Angle velocity Z
	frm:NumSlider(
		"#tool.particle_maker.angvel.z",
        "particle_maker_AngleVelZ",
		-500, 500, 2
	)

	-- Stick lifetime
	frm:NumSlider(
		"#tool.particle_maker.sticklifetime",
        "particle_maker_StickLifeTime",
		0.01, 10, 2
	)

	-- Stick start size
	frm:NumSlider(
        "#tool.particle_maker.stickstartsize", "particle_maker_StickStartSize",
        0, 100, 2
	)

	-- Stick end size
	frm:NumSlider(
        "#tool.particle_maker.stickendsize", "particle_maker_StickEndSize",
        0, 100, 2
	)

	-- Stick start alpha
	frm:NumSlider(
        "#tool.particle_maker.stickstartalpha",
        "particle_maker_StickStartAlpha",
        0, 255, 2
	)

	-- Stick end alpha
	frm:NumSlider(
        "#tool.particle_maker.stickendalpha", "particle_maker_StickEndAlpha",
        0, 255, 2
	)

    frm:SizeToContentsY()
    frm:InvalidateLayout()

	-- Check if wire exists

	-- WIRE HEADER
	-- Header( CPanel, "Wiremod settings" )
	-- CPanel:AddControl("Label", { Text = "If you want to control your emitter with Wiremod, check the box below. Most users will have sufficient control with Basic" })
    --
	-- -- Add enable wire checkbox
	-- CPanel:AddControl("Checkbox", {
    --    Label = "Enable wire inputs",
    --    Command = "particle_maker_wire_enable"
    -- })
	-- CPanel:AddControl("Label", {
    --    Text = "A \"Fire\" output is automatically added when the box above is checked.\nCheckboxes below will only have effect if you've enabled the checkbox above."
    -- })
    --
	-- -- Add all checkboxes
	-- CPanel:AddControl("Checkbox", {
    --    Label = "Basic particle controls",
    --    Command = "particle_maker_wire_basic"
    -- })
	-- CPanel:AddControl("Checkbox", {
    --    Label = "Colour controls",
    --    Command = "particle_maker_wire_colour"
    -- })
	-- CPanel:AddControl("Checkbox", {
    --    Label = "Effect controls",
    --    Command = "particle_maker_wire_effects"
    -- })
	-- CPanel:AddControl("Checkbox", {
    --    Label = "Advanced particle controls",
    --    Command = "particle_maker_wire_advanced"
    -- })

    --[[
        Helper methods
    ]]

    -- Enforce valid rules
    _cld.OnChange = function()
        if not _cld:GetChecked() then
            _sld:SetChecked( false )
        end
    end;

    _sld.OnChange = function()
        if _sld:GetChecked() then
            _cld:SetChecked( true )
            _3ds:SetChecked( false )
            _3da:SetChecked( false )
        end
    end

    _3d.OnChange = function()
        if not _3d:GetChecked() then
            _3dt:SetChecked( false )
            _3ds:SetChecked( false )
            _3da:SetChecked( false )
        end
    end

    _3dt.OnChange = function()
        if _3dt:GetChecked() then
            _3d:SetChecked( true )
        end
    end

    _3ds.OnChange = function()
        if _3ds:GetChecked() then
            _3d:SetChecked( true )
        end
    end

    _3da.OnChange = function()
        if _3da:GetChecked() then
            _3d:SetChecked( true )
            _3ds:SetChecked( true )
        end
    end

    if not _3d:GetChecked() then
        _3dt:SetChecked( false )
        _3ds:SetChecked( false )
        _3da:SetChecked( false )
    end

    if not _cld:GetChecked() then
        _sld:SetChecked( false )
    end

    if _sld:GetChecked() then
        _3ds:SetChecked( false )
        _3da:SetChecked( false )
    end
end
