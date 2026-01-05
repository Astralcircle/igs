-- Вот так просто! :)

-- ID проекта в системе
local project_id = CreateConVar("igs_project_id", "0", FCVAR_ARCHIVE + FCVAR_PROTECTED)
local project_key = CreateConVar("igs_project_key", "", FCVAR_ARCHIVE + FCVAR_PROTECTED)

IGS.C.ProjectID  = project_id:GetInt()
IGS.C.ProjectKey = project_key:GetString()
