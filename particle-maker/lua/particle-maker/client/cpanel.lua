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

SirQuack.ParticleMaker.controlPanel = function(CPanel)
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
        WIREMOD SETTINGS
    ]]

    local frm = vgui.Create("DForm", CPanel)
    frm:SetLabel("#tool.particle_maker.hdr.wiremod")

    CPanel:AddPanel(frm)

    -- Show that Wiremod is required for this section
    frm:ControlHelp("#tool.particle_maker.wire.required")

    -- Allow wire inputs?
    local chkWire = frm:CheckBox(
        "#tool.particle_maker.wire",
        "particle_maker_Wire"
    )

    -- Allow advanced wire inputs
    local chkWireAdvanced = frm:CheckBox(
        "#tool.particle_maker.wireAdvanced",
        "particle_maker_WireAdvanced"
    )
    frm:ControlHelp("#tool.particle_maker.wireAdvanced.help")

    frm:SizeToContentsY()
    frm:InvalidateLayout()

    -- Disable if wiremod is not installed
    if SirQuack.ParticleMaker.hasWiremod() then
        frm:SetExpanded(false)
        chkWire:SetChecked(false)
        chkWire:SetEnabled(false)
        chkWireAdvanced:SetChecked(false)
        chkWireAdvanced:SetEnabled(false)
    end

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
            _sld:SetChecked( false )
        end
    end

    _3da.OnChange = function()
        if _3da:GetChecked() then
            _3d:SetChecked( true )
            _3ds:SetChecked( true )
            _sld:SetChecked( false )
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
