local cbdraw = classicbox.cbdraw
local basepanel = vgui.Create("Panel")
basepanel:Dock(FILL)

function basepanel:Paint(w, h)
	cbdraw.SimpleText("Автодонат временно недоступен", w / 2, h / 2, color_white, "CBFont", "CBFont_Shadow", 3, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

timer.Simple(0, function()
	if basepanel:IsValid() then
		local parent = basepanel:GetParent()
		local cbmenu = parent:GetParent()

		for _, item in ipairs(parent.Items) do
			if item.Panel == basepanel then
				local do_click = item.Tab.DoClick

				function item.Tab:DoClick()
					local donate = IGS.UI(cbmenu:GetX(), cbmenu:GetY(), cbmenu:GetWide(), cbmenu:GetTall())

					if IsValid(donate) then
						cbmenu:SetVisible(false)

						function donate:Close()
							cbmenu:SetVisible(true)
							cbmenu:SetPos(self:GetPos())
							self:Remove()
						end
					else
						return do_click(self)
					end
				end
			end
		end
	end
end)

return "Донат", basepanel
