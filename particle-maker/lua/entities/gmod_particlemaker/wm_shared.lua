ENT.IsWire = true
ENT.OverlayText = ""

function ENT:GetOverlayText()
	return self.OverlayText
end

function ENT:SetOverlayText( txt )
	self.OverlayText = txt
end
