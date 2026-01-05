hook.Add("PlayerButtonDown", "IGS.UI", function(ply, button)
	if button == IGS.C.MENUBUTTON then
		IGS.UI()
	end
end)
