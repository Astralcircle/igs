local function runAfterhooks() -- #todo перенести эти выполнения в модули или вызывать локально if CODEMOUNT
	if (not IGS_MOUNT) then return end

	IGS.dprint("Выполнение 'опоздавших' хуков и spawnmenu_reload")
	if CLIENT then -- костыль, но другого способа не вижу
		hook.GetTable()["InitPostEntity"]["IGS.nw.InitPostEntity"]()
		hook.GetTable()["DarkRPFinishedLoading"]["SupressDarkRPF1"]()
		RunConsoleCommand("spawnmenu_reload") -- npc_igs
	-- else
		-- hook.GetTable()["InitPostEntity"]["IGS.PermaSents"]()
		-- "InitPostEntity", "InitializePermaProps"
	end
end

-- IGS.Loaded выполняется при условии IGS.nw.InitPostEntity
hook.Add("IGS.Initialized", "afterhooks", function()
	timer.Simple(.1, runAfterhooks) -- энтити грузятся вроде шагом позже
end)
