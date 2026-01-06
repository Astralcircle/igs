local PANEL = {}

function PANEL:Paint(w, h)
	if self.material then
		surface.SetDrawColor(IGS.col.ICON)
		surface.SetMaterial(self.material)
		surface.DrawTexturedRect(0, 0, w, h)
	end
end

function PANEL:SetMaterial(material)
	self.material = material and Material(material, "noclamp smooth")
end

vgui.Register("igs_wmat", PANEL, "Panel")
