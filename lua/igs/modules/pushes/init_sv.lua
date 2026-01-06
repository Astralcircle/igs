local function handleUpdate(upd)
	if upd.ok then
		hook.Run("IGS.IncomingMessage", upd.data, upd.method, upd)
	end
end

hook.Add("IGS.Loaded", "polling", function()
	if IGS.POLLING then
		IGS.POLLING.stop()
	end

	local uid = string.format("gmd_%s_%s", IGS.C.ProjectID, IGS.C.ProjectKey) -- antinil
	IGS.POLLING = kupol.new("https://poll.gmod.app/", uid, 30).start(handleUpdate)
end)
