local basepanel = vgui.Create("Panel")
basepanel:Dock(FILL)

-- Very hacky way to support our donate menu in our menu
timer.Simple(0, function()
	if basepanel:IsValid() then
		local parent = basepanel:GetParent()
		local cbmenu = parent:GetParent()

		for _, item in ipairs(parent.Items) do
			if item.Panel == basepanel then
				function item.Tab:DoClick()
					local donate = IGS.UI(cbmenu:GetX(), cbmenu:GetY(), cbmenu:GetWide(), cbmenu:GetTall())
					cbmenu:SetVisible(false)

					function donate:Close()
						cbmenu:SetVisible(true)
						self:Remove()
					end
				end
			end
		end
	end
end)

return "Донат", basepanel
