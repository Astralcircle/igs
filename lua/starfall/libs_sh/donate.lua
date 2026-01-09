return function(instance)
local player_methods, player_meta = instance.Types.Player.Methods, instance.Types.Player

local getply
instance:AddHook("initialize", function()
	getply = player_meta.GetPlayer
end)

--- Returns whether the player has VIP
-- @shared
-- @return boolean True if player has VIP
function player_methods:hasVIP()
	return getply(self):HasVIP()
end

end