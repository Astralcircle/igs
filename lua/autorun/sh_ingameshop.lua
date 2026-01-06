--[[-------------------------------------------------------------------------
	Веб загрузчик IGS 13.03.2021
	https://blog.amd-nick.me/github-workshop-garrysmod/
	Изначально эта задача представлялась в 3 строки
---------------------------------------------------------------------------]]
IGS = IGS or {}

local i = {} -- lua files only
i.sv = SERVER and include or function() end
i.cl = SERVER and AddCSLuaFile or include
i.sh = function(f) return i.cl(f) or i.sv(f) end


local function include_mount(sRealm, sAbsolutePath)
	if (sRealm == "sh")
	or (sRealm == "sv" and SERVER)
	or (sRealm == "cl" and CLIENT) then
		-- Чистый RunString не воспринимает return внутри файлов
		-- Но CompileString 9 апреля 2021 теоретически был причиной ошибок
		-- Пока пусть будет RunString без ретурна
		-- Заметки: https://t.me/c/1353676159/55852

		-- local executer = CompileString(content, sAbsolutePath)
		-- return executer()

		local content  = IGS_MOUNT[sAbsolutePath]
		RunString(content, sAbsolutePath)
	end
end

-- "Костыль" для работы IGS.sh/sv/cl изнутри модульных _main.lua файлов и энтити
-- с указанием относительного пути
-- не работает с ../file (наверн. Не чекал)
local iam_inside

local function incl(sRealm, sPath)
	local fIncluder = i[sRealm]
	return fIncluder(isRelativePath and iam_inside .. "/" .. sPath or sPath)
end

function IGS.sh(sPath) return incl("sh", sPath) end
function IGS.sv(sPath) return incl("sv", sPath) end
function IGS.cl(sPath) return incl("cl", sPath) end

local function findKeys(arr, patt)
	local found = {}
	for key, val in pairs(arr) do
		local match = key:match(patt)
		if match then
			table.insert(found, match)
		end
	end
	return found
end

-- Тяжелая, но пока в оптимизации не нуждается
-- При выборке модулей и энтити элементы повторяются
local function unique(arr)
	local ret = {}
	for _, v in ipairs(arr) do
		if not table.HasValue(ret, v) then
			table.insert(ret, v)
		end
	end
	return ret
end

local function findInMount(patt)
	return IGS_MOUNT and findKeys(IGS_MOUNT, patt) or {}
end

function IGS.include_files(sPath, fIncluder) -- igs/extensions
	local data_files = findInMount("^" .. sPath:PatternSafe() .. "/(.*%.lua)$")
	local lua_files  = file.Find(sPath .. "/*.lua", "LUA")
	table.Add(data_files, lua_files)

	for _, fileName in ipairs(data_files) do
		fIncluder(sPath .. "/" .. fileName)
	end
end

function IGS.load_modules(sBasePath) -- igs/modules
	local data_modules  = findInMount("^" .. sBasePath .. "/([^/]*)/_main%.lua$")
	data_modules = unique(data_modules)
	local _, lua_modules = file.Find(sBasePath .. "/*", "LUA")
	table.Add(data_modules, lua_modules)

	for _, mod in ipairs(data_modules) do
		local sModPath = sBasePath .. "/" .. mod
		iam_inside = sModPath
		IGS.sh(sModPath .. "/_main.lua")
	end
	iam_inside = nil
end

IGS.sh("igs/launcher.lua")
