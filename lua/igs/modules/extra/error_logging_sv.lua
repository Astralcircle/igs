hook.Add("IGS.OnApiError", "LogError", function(sMethod, error_uid, tParams)
	if error_uid == "http_error" then
		IGS.prints(Color(255, 0, 0), "", "CEPBEPA GMD BPEMEHHO HE9OCTynHbI. y}{e PEWAEM nPO6JIEMy")
	end

	local sparams = "\n"

	for k, v in pairs(tParams) do
		sparams = sparams .. ("\t%s = %s\n"):format(k,v)
	end

	ErrorNoHaltWithStack(string.format("IGS API Error:\nMethod: %s\nError: %s\nParams: %s", sMethod, error_uid, sparams))
end)
