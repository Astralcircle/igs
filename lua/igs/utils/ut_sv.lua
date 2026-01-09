util.AddNetworkString("IGS.Notify")

function IGS.Notify(ply, text)
	net.Start("IGS.Notify")
	net.WriteString(text)

	if ply then
		net.Send(ply)
	else
		net.Broadcast()
	end
end

function IGS.GetPlayerTransactionsBypassingLimit(cb, s64, am_, _tmp_)
	_tmp_ = _tmp_ or {}
	am_   =   am_ or math.huge
	local left = am_ - #_tmp_

	IGS.GetTransactions(function(data)
		for _,tr in ipairs(data) do
			local i = table.insert(_tmp_,tr)
			if am_ and i == am_ then cb(_tmp_) return end
		end

		if #data < 255 then cb(_tmp_)
		else getTxsNoLimit(cb, s64, am_, _tmp_)
		end
	end, s64, true, math.min(255, left), #_tmp_)
end