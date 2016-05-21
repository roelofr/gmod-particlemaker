
TOOL.Category		= "Construction"
TOOL.Name			= "#Particle Maker"
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

ParticleOptions = 
{
	{Name = "Material",			Type = "String",	Value = ""},
	
	{Name = "ColorR1",			Type = "Float",		Value = 255,	Min = 0,		Max = 255	},
	{Name = "ColorG1",			Type = "Float",		Value = 255,	Min = 0,		Max = 255	},
	{Name = "ColorB1",			Type = "Float",		Value = 255,	Min = 0,		Max = 255	},
	{Name = "ColorR2",			Type = "Float",		Value = 255,	Min = 0,		Max = 255	},
	{Name = "ColorG2",			Type = "Float",		Value = 255,	Min = 0,		Max = 255	},
	{Name = "ColorB2",			Type = "Float",		Value = 255,	Min = 0,		Max = 255	},
	{Name = "ColorRand",		Type = "Bool",		Value = 0,		Min = 0,		Max = 1		},
	{Name = "Velocity",			Type = "Float",		Value = 500.01,	Min = 0,		Max = 10000	},
	{Name = "Spread",			Type = "Float",		Value = 50,		Min = 0,		Max = 360	},
	{Name = "Delay",			Type = "Float",		Value = 0.2,	Min = 0.1,		Max = 10	},
	{Name = "Number",			Type = "Int",		Value = 1,		Min = 1,		Max = 10	},
	{Name = "DieTime",			Type = "Float",		Value = 3,		Min = 0,		Max = 10	},
	{Name = "StartAlpha",		Type = "Float",		Value = 255,	Min = 0,		Max = 255	},
	{Name = "EndAlpha",			Type = "Float",		Value = 0,		Min = 0,		Max = 255	},
	{Name = "StartSize",		Type = "Float",		Value = 10,		Min = 0,		Max = 100	},
	{Name = "EndSize",			Type = "Float",		Value = 20,		Min = 0,		Max = 100	},
	{Name = "StartLength",		Type = "Float",		Value = 0,		Min = 0,		Max = 100	},
	{Name = "EndLength",		Type = "Float",		Value = 0,		Min = 0,		Max = 100	},
	{Name = "RollRand",			Type = "Float",		Value = 0,		Min = 0,		Max = 10	},
	{Name = "RollDelta",		Type = "Float",		Value = 0,		Min = -10,		Max = 10	},
	{Name = "AirResistance",	Type = "Float",		Value = 5,		Min = 0,		Max = 1000	},
	{Name = "Bounce",			Type = "Float",		Value = 0.2,	Min = 0,		Max = 10	},
	{Name = "Gravity",			Type = "Float",		Value = -50,	Min = -1000,	Max = 1000	},
	{Name = "Collide",			Type = "Bool",		Value = 1,		Min = 0,		Max = 1		},
	{Name = "Lighting",			Type = "Bool",		Value = 0,		Min = 0,		Max = 1		},
	{Name = "Sliding",			Type = "Bool",		Value = 0,		Min = 0,		Max = 1		},
	
	{Name = "3D",				Type = "Bool",		Value = 0,		Min = 0,		Max = 1		},
	{Name = "Align",			Type = "Bool",		Value = 1,		Min = 0,		Max = 1		},
	{Name = "Stick",			Type = "Bool",		Value = 1,		Min = 0,		Max = 1		},
	{Name = "DoubleSided",		Type = "Bool",		Value = 1,		Min = 0,		Max = 1		},
	{Name = "AngleVelX",		Type = "Float",		Value = 50,		Min = -500,		Max = 500	},
	{Name = "AngleVelY",		Type = "Float",		Value = 50,		Min = -500,		Max = 500	},
	{Name = "AngleVelZ",		Type = "Float",		Value = 50,		Min = -500,		Max = 500	},
	{Name = "StickLifeTime",	Type = "Float",		Value = 2,		Min = 0.01,		Max = 10	},
	{Name = "StickStartSize",	Type = "Float",		Value = 20,		Min = 0,		Max = 100	},
	{Name = "StickEndSize",		Type = "Float",		Value = 0,		Min = 0,		Max = 100	},
	{Name = "StickStartAlpha",	Type = "Float",		Value = 255,	Min = 0,		Max = 255	},
	{Name = "StickEndAlpha",	Type = "Float",		Value = 0,		Min = 0,		Max = 255	},
	
	{Name = "wire_enabled",		Type = "Bool",		Value = 1,		Min = 0,		Max = 1	},
	{Name = "wire_basic",		Type = "Bool",		Value = 1,		Min = 0,		Max = 1	},
	{Name = "wire_colour",		Type = "Bool",		Value = 0,		Min = 0,		Max = 1	},
	{Name = "wire_effects",		Type = "Bool",		Value = 0,		Min = 0,		Max = 1	},
	{Name = "wire_advanced",	Type = "Bool",		Value = 0,		Min = 0,		Max = 1	},
}

PresetOptions = {
	Label = "#tool.presets",
	MenuButton = 1,
	Folder = "particle",
	Options = {
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
	CVars = {
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

if SERVER then
	util.AddNetworkString( "ParticleMakerError" )
end

local function hasWiremod()
	if not WireAddon and WireLib == nil and not WIRE_CLIENT_INSTALLED then
		return false
	end
	return true
end

local function randomText( what )
	local opts = {}
	if what == "title" then opts = { "Oh snap!", "Oh bummer!", "Whoops", "That wasn't supposed to happen", "D'oh!", "F*CK!", "NOOOOOOOOOOOOO" } end
	if what == "ok" then opts = { "Alrighty", "Mmmkay", "Meh", "Ok", "Got it!", "To the batmobile!", "Will do", "Righto!" } end
	return table.Random( opts )
end

local function Header( CPanel, text )
	local panel = CPanel:AddControl( "Label", { Text = text } )
	panel:SetFont( "DermaDefaultBold" )
	panel:SetTextColor( derma.GetDefaultSkin().Colours.Category.Header )
	panel.Paint = function( p, w, h )
		DisableClipping( true )
			surface.SetDrawColor( derma.GetDefaultSkin().Colours.Button.Hover )
			surface.DrawRect( - 2, - 2, w + 4, h + 4 )
		DisableClipping( false )
	end
	panel:DockMargin( 2, 0, 2, 2 )
	panel:DockPadding( 6, 0, 6, 6 )
	panel:InvalidateLayout( true )
	
	panel:SetText( "  " .. panel:GetText() )
end
local function shouldLockCheckbox( panel )
	if not hasWiremod() then
		panel.OnChange = function( pnl, newval )
			if pnl == true or newval == true then
				panel:SetValue( false )
				panel:SetChecked( false )
			end
		end
		panel:SetValue( false )
		panel:SetChecked( false )
		
		if panel.Button ~= nil then
			panel.Button:SetDisabled( true )
		end
	end
end

// Add all settings
for _,v in pairs(ParticleOptions) do
	TOOL.ClientConVar[v.Name] = v.Value
end
cleanup.Register("particle_makers")
CreateConVar("sbox_maxparticle_makers", 1, FCVAR_NOTIFY)
CreateConVar("particle_maker_Clamp", 1, FCVAR_NOTIFY)

if (CLIENT) then

	language.Add("tool.particle_maker.name", "Particle Maker" )
	language.Add("tool.particle_maker.desc", "Original code by Robbis_1. Modifications by Roelof")
	language.Add("tool.particle_maker.0", "Left click: Spawn/update particle maker     Right click: Get settings")
	
	language.Add("Undone_particle_maker", "Undone Particle Maker.")
	
	language.Add("Cleanup_particle_makers", "Particle Maker")
	language.Add("Cleaned_particle_makers", "Cleaned up all Particle Makers.")
	language.Add("SBoxLimit_particle_makers", "You've reached the Particle Makers limit!")

end

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
			net.WriteString( "No material defined.\n\nSolve this:\n - Pick a material from the material picker." )
			net.WriteString( "Oh bummer!" )
		net.Send( Ply )
		return false
	end

	local keyAsNum = tonumber( Key )
	if ( Key == nil or Key == NULL or not Key or keyAsNum <= 0 ) and ( UseWiremod ~= 1 or not hasWiremod() ) then
		net.Start( "ParticleMakerError" )
			if hasWiremod() then
				net.WriteString( "No input method defined.\n\nSolve this:\n - Specify a key you want to bind the spawner to.\n - Enable wiremod inputs." )
			else
				net.WriteString( "No input method defined.\n\nSolve this:\n - Specify a key you want to bind the spawner to." )
			end
			net.WriteString( "Oh bummer!" )
		net.Send( Ply )
		return false
	end
	
	// We shot an existing particle maker - just change its values
	if (Trace.Entity:IsValid()) and (Trace.Entity:GetClass() == "gmod_particlemaker") and (Trace.Entity:GetPlayer() == Ply) then
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
	-- Make clients download the materials file
	resource.AddFile("data/Particle Materials.txt")
	
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

	// MAIN HEADER
	CPanel:AddControl( "Label", { Text	= "Create a particle emitter to your liking.\nMade by HAHA (Robbis_1)\nGarry's Mod 13 compatibility: Roelof (roelof@tmg-clan.com)" }  )
	
	//Wiremod message
	if not hasWiremod() then
		local p = CPanel:AddControl("Label", { Text = "You don't have Wiremod installed. Some settings will be greyed out since they rely on wiremod. See www.wiremod.com to download wiremod." })
		p:SetTextColor( derma.GetDefaultSkin().combobox_selected )
	end
	
	// Presets
	Header( CPanel, "Presets" )
	CPanel:AddControl( "ComboBox", PresetOptions )
	
	// Numpad
	Header( CPanel, "Bindings" )
	CPanel:AddControl("Numpad", { Label = "Make particles key", Command = "particle_maker_Key" })
	
	Header( CPanel, "Material and colour settings" )
	// Color 1
	local clr = CPanel:AddControl("Color", {
		Label = "Color 1", 
		Red = "particle_maker_ColorR1", 
		Green = "particle_maker_ColorG1", 
		Blue = "particle_maker_ColorB1", 
		ShowAlpha = 0, 
		ShowHSV = 1, 
		ShowRGB = 1, 
		Multiplier = 255
	})
	if clr.Mixer then clr.Mixer:SetPalette( false ) end
	
	// Color 2
	local clr = CPanel:AddControl("Color", {
		Label = "Color 2", 
		Red = "particle_maker_ColorR2", 
		Green = "particle_maker_ColorG2", 
		Blue = "particle_maker_ColorB2", 
		ShowAlpha = 0, 
		ShowHSV = 1, 
		ShowRGB = 1, 
		Multiplier = 255
	})
	if clr.Mixer then clr.Mixer:SetPalette( false ) end
	
	
	// Material textbox
	CPanel:AddControl("TextBox", {
		Label	= "Material",
		Command = "particle_maker_Material"
	})
	
	// Material gallery
	local params = { Label = "Material Gallery", Height = 96, Width = 96, Rows = 2, Stretch = 1, Options = {}, CVars = {} }
	
	if file.Exists( "particle_maker_materials.txt", "DATA" ) then
		local File = file.Read("particle_maker_materials.txt")
		local Mats = util.JSONToTable( File )
		for k,v in pairs(Mats) do
			table.insert( params.Options, { Material = v, particle_maker_Material = v } )
		end
	else
		table.insert( params.Options, { Material = "effects/fire_cloud1", particle_maker_Material = "effects/fire_cloud1" } )
		table.insert( params.Options, { Material = "effects/fire_cloud2", particle_maker_Material = "effects/fire_cloud2" } )
		table.insert( params.Options, { Material = "effects/blood_core", particle_maker_Material = "effects/blood_core" } )
		table.insert( params.Options, { Material = "effects/blueflare1", particle_maker_Material = "effects/blueflare1" } )
		table.insert( params.Options, { Material = "effects/bluemuzzle", particle_maker_Material = "effects/bluemuzzle" } )
		table.insert( params.Options, { Material = "effects/fleck_glass1", particle_maker_Material = "effects/fleck_glass1" } )
		table.insert( params.Options, { Material = "effects/fleck_glass2", particle_maker_Material = "effects/fleck_glass2" } )
		table.insert( params.Options, { Material = "effects/fleck_glass3", particle_maker_Material = "effects/fleck_glass3" } )
		table.insert( params.Options, { Material = "effects/rollerglow", particle_maker_Material = "effects/rollerglow" } )
		table.insert( params.Options, { Material = "effects/spark", particle_maker_Material = "effects/spark" } )
		table.insert( params.Options, { Material = "sprites/strider_blackball", particle_maker_Material = "sprites/strider_blackball" } )
		table.insert( params.Options, { Material = "shadertest/eyeball", particle_maker_Material = "shadertest/eyeball" } )
		
		
		local write = {}
		for _, p in pairs( params.Options ) do
			table.insert( write, p.particle_maker_Material )
		end
		file.Write( "particle_maker_materials.txt", util.TableToJSON( write ) )
	end
	
	table.insert(params.CVars, "particle_maker_Material")
	CPanel:AddControl("MaterialGallery", params)
	
	// Physics settings
	Header( CPanel, "Generic settings" )
	
	//  Weld to props?
	CPanel:AddControl("Checkbox", { Label = "Weld", Command = "particle_maker_Weld" })
	
	// Spawn frozen?
	CPanel:AddControl("Checkbox", { Label = "Frozen", Command = "particle_maker_Frozen" })
	
	// Random color
	CPanel:AddControl("Checkbox", { Label = "Random color between 1 and 2", Command = "particle_maker_ColorRand" })
	
	// Toggle
	CPanel:AddControl("Checkbox", { Label = "Toggle", Command = "particle_maker_Toggle" })
	
	// Toggle for Wiremod
	shouldLockCheckbox( CPanel:AddControl("Checkbox", { Label = "Toggle wiremod", Command = "particle_maker_Toggle_Wire" }) )
	CPanel:AddControl("Label", {Text = "This will make the emitter toggle between on and off everytime the \"Fire\" input is not 0"} )
	
	// Effects Header
	Header( CPanel, "Effect settings" )
	
	// Fire delay
	CPanel:AddControl("Slider", {
		Label	= "Fire Delay",
		Type	= "Float",
		Min		= 0.001,
		Max		= 10,
		Command = "particle_maker_Delay"
	})
		
	// Number particles
	CPanel:AddControl("Slider", {
		Label	= "Number Particles",
		Type	= "Integer",
		Min		= 1,
		Max		= 10,
		Command = "particle_maker_Number"
	})

	// Velocity
	CPanel:AddControl("Slider", {
		Label	= "Velocity",
		Type	= "Float",
		Min		= 1,
		Max		= 10000,
		Command = "particle_maker_Velocity"
	})

	// Spread
	CPanel:AddControl("Slider", {
		Label	= "Spread",
		Type	= "Float",
		Min		= 0,
		Max		= 360,
		Command = "particle_maker_Spread"
	})

	// Die time
	CPanel:AddControl("Slider", {
		Label	= "Die Time",
		Type	= "Float",
		Min		= 1,
		Max		= 10,
		Command = "particle_maker_DieTime"
	})

	// Start alpha
	CPanel:AddControl("Slider", {
		Label	= "Start Alpha",
		Type	= "Float",
		Min		= 0,
		Max		= 255,
		Command = "particle_maker_StartAlpha"
	})

	// End alpha
	CPanel:AddControl("Slider", {
		Label	= "End Alpha",
		Type	= "Float",
		Min		= 0,
		Max		= 255,
		Command = "particle_maker_EndAlpha"
	})

	// Start size
	CPanel:AddControl("Slider", {
		Label	= "Start Size",
		Type	= "Float",
		Min		= 0,
		Max		= 100,
		Command = "particle_maker_StartSize"
	})

	// End size
	CPanel:AddControl("Slider", {
		Label	= "End Size",
		Type	= "Float",
		Min		= 0,
		Max		= 100,
		Command = "particle_maker_EndSize"
	})

	// Start length
	CPanel:AddControl("Slider", {
		Label	= "Start Length",
		Type	= "Float",
		Min		= 0,
		Max		= 100,
		Command = "particle_maker_StartLength"
	})

	// End length
	CPanel:AddControl("Slider", {
		Label	= "End Length",
		Type	= "Float",
		Min		= 0,
		Max		= 100,
		Command = "particle_maker_EndLength"
	})

	// Roll
	CPanel:AddControl("Slider", {
		Label	= "Random Roll Speed",
		Type	= "Float",
		Min		= 0,
		Max		= 10,
		Command = "particle_maker_RollRand"
	})

	// Roll delta
	CPanel:AddControl("Slider", {
		Label	= "Roll Delta",
		Type	= "Float",
		Min		= -10,
		Max		= 10,
		Command = "particle_maker_RollDelta"
	})

	// Air resistance
	CPanel:AddControl("Slider", {
		Label	= "Air Resistance",
		Type	= "Float",
		Min		= 0,
		Max		= 1000,
		Command = "particle_maker_AirResistance"
	})

	// Bounce
	CPanel:AddControl("Slider", {
		Label	= "Bounce",
		Type	= "Float",
		Min		= 0,
		Max		= 10,
		Command = "particle_maker_Bounce"
	})

	// Gravity
	CPanel:AddControl("Slider", {
		Label	= "Gravity Z",
		Type	= "Float",
		Min		= -1000,
		Max		= 1000,
		Command = "particle_maker_Gravity"
	})

	// Collision
	CPanel:AddControl("Checkbox", {
		Label = "Collide",
		Command = "particle_maker_Collide"
	})

	// Lighting
	CPanel:AddControl("Checkbox", {
		Label = "Lighting",
		Command = "particle_maker_Lighting"
	})

	// Slide
	CPanel:AddControl("Checkbox", {
		Label = "Sliding",
		Command = "particle_maker_Sliding",
		Description = "Disables stick and align, Collision must be enabled."
	})


	// 3D HEADER
	

	// Toggle 3D
	CPanel:AddControl("Checkbox", {
		Label = "3D",
		Command = "particle_maker_3D"
	})

	// Align
	CPanel:AddControl("Checkbox", {
		Label = "Align to surface",
		Command = "particle_maker_Align",
		Description = "Stick to surface & 3D must be enabled."
	})

	// Stick
	CPanel:AddControl("Checkbox", {
		Label = "Stick to surface",
		Command = "particle_maker_Stick",
		Description = "3D must be enabled."
	})

	// Double sided
	CPanel:AddControl("Checkbox", {
		Label = "Double sided (2 faces)",
		Command = "particle_maker_DoubleSided",
		Description = "3D must be enabled."
	})

	// Angle velocity X
	CPanel:AddControl("Slider",  {
		Label	= "Angle Velocity X",
		Type	= "Float",
		Min		= -500,
		Max		= 500,
		Command = "particle_maker_AngleVelX"
	})

	// Angle velocity Y
	CPanel:AddControl("Slider", {
		Label	= "Angle Velocity Y",
		Type	= "Float",
		Min		= -500,
		Max		= 500,
		Command = "particle_maker_AngleVelY"
	})

	// Angle velocity Z
	CPanel:AddControl("Slider",  {
		Label	= "Angle Velocity Z",
		Type	= "Float",
		Min		= -500,
		Max		= 500,
		Command = "particle_maker_AngleVelZ"
	})

	// Stick lifetime
	CPanel:AddControl("Slider", {
		Label	= "Stick Lifetime",
		Type	= "Float",
		Min		= 0.01,
		Max		= 10,
		Command = "particle_maker_StickLifeTime"
	})

	// Stick start size
	CPanel:AddControl("Slider", {
		Label	= "Stick Start Size",
		Type	= "Float",
		Min		= 0,
		Max		= 100,
		Command = "particle_maker_StickStartSize"
	})

	// Stick end size
	CPanel:AddControl("Slider", {
		Label	= "Stick End Size",
		Type	= "Float",
		Min		= 0,
		Max		= 100,
		Command = "particle_maker_StickEndSize"
	})

	// Stick start alpha
	CPanel:AddControl("Slider", {
		Label	= "Stick Start Alpha",
		Type	= "Float",
		Min		= 0,
		Max		= 255,
		Command = "particle_maker_StickStartAlpha"
	})

	// Stick end alpha
	CPanel:AddControl("Slider", {
		Label	= "Stick End Alpha",
		Type	= "Float",
		Min		= 0,
		Max		= 255,
		Command = "particle_maker_StickEndAlpha"
	})

	// Check if wire exists
	
	// WIRE HEADER
	Header( CPanel, "Wiremod settings" )
	CPanel:AddControl("Label", { Text = "If you want to control your emitter with Wiremod, check the box below. Most users will have sufficient control with Basic" })
		
	//Add enable wire checkbox
	shouldLockCheckbox( CPanel:AddControl("Checkbox", { Label = "Enable wire inputs", Command = "particle_maker_wire_enable" }) )
	CPanel:AddControl( "Label", { Text = "A \"Fire\" output is automatically added when the box above is checked.\nCheckboxes below will only have effect if you've enabled the checkbox above." } )
		
		// Add all checkboxes
	shouldLockCheckbox( CPanel:AddControl("Checkbox", { Label = "Basic particle controls", Command = "particle_maker_wire_basic" }) )
	shouldLockCheckbox( CPanel:AddControl("Checkbox", { Label = "Colour controls", Command = "particle_maker_wire_colour" }) )
	shouldLockCheckbox( CPanel:AddControl("Checkbox", { Label = "Effect controls", Command = "particle_maker_wire_effects" }) )
	shouldLockCheckbox( CPanel:AddControl("Checkbox", { Label = "Advanced particle controls", Command = "particle_maker_wire_advanced" }) )
end

if CLIENT then
	net.Receive( "ParticleMakerError", function( length )
		local data = {}
		for i=1,length do
			local str = net.ReadString()
			if string.len( string.Trim( str ) ) > 1 then
				table.insert( data, str )
			end
		end
		data[2] = randomText( 'title' )
		data[3] = randomText( 'ok' )
		Derma_Message( unpack( data ) )
	end )
end