hook.Add("IGS.PlayerPurchasedItem", "IGS.BroadcastPurchase", function(pl, ITEM)
	IGS.NotifyAll(pl:Nick() .. " купил " .. ITEM:Name())
end)

hook.Add("IGS.PlayerDonate", "ThanksForDonate", function(pl, rub)
	IGS.Notify(pl, "Спасибо вам за пополнение счета")
	IGS.NotifyAll(Format("%s пополнил счет на %s", pl:Nick(), PL_MONEY(rub)))
end)

hook.Add("IGS.PlayerPurchasesLoaded", "BalanceRemember", function(ply)
	local balance = ply:IGSFunds()

	if balance >= 10 then
		timer.Simple(10, function()
			if not IsValid(ply) then return end
			IGS.Notify(ply, "Вы можете потратить " .. IGS.SignPrice(balance) .. " через !donate")
		end)
	end
end)
