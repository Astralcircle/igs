__e2setcost(5)

e2function number entity:hasVIP()
	if not IsValid(this) then return self:throw("Invalid entity!", 0) end
	if not this:IsPlayer() then return self:throw("Expected a Player but got Entity", 0) end
	return this:GetNW2Bool("CB_VIP") and 1 or 0
end
