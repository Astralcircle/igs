local cbdraw = classicbox.cbdraw
local basepanel = vgui.Create("Panel")
basepanel:Dock(FILL)

function basepanel:Paint(w, h)
	cbdraw.SimpleText("Автодонат временно недоступен", w / 2, h / 2, color_white, "CBFont", "CBFont_Shadow", 3, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

-- Very hacky way to support our donate menu in our menu
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

							local x, y = self:GetX() + (self:GetWide() - cbmenu:GetWide()) / 2, self:GetY() + (self:GetTall() - cbmenu:GetTall()) / 2
							cbmenu:SetPos(math.Clamp(x, 0, ScrW() - cbmenu:GetWide()), math.Clamp(y, 0, ScrH() - cbmenu:GetTall()))

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
