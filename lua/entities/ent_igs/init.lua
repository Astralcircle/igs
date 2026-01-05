IGS.sh("shared.lua")
IGS.cl("cl_init.lua")

function ENT:Initialize()
	self:SetModel("models/items/cs_gift.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:PhysWake()
end

-- Чтобы нельзя было убить NPC
function ENT:OnTakeDamage()
	return 0
end

function ENT:Use(_, caller)
	if caller:IsPlayer() then
		self:PlayerUse(caller)
	end
end

function ENT:PlayerUse(pl)
	if IGS.IsInventoryOverloaded(pl) then
		IGS.Notify(pl, "У вас слишком много предметов в инвентаре")
		return
	end

	if self.Busy or self.Removed then -- хз нужно ли именно здесь, но я добавил
		-- https://vk.com/gim143836547?sel=383010676&msgid=90338
		if CurTime() - self.Busy > 5 then
			IGS.Notify(pl, "Предмет в процессе перемещения в инвентарь")
			IGS.Notify(pl, "Если процесс бесконечный, то поскорее сделайте доказательства и сообщите администратору")
		end
		return
	end
	self.Busy = CurTime()

	local UID = self:GetUID()
	IGS.AddToInventory(pl, UID, function(invDbID)
		self.Removed = true
		self:Remove()

		IGS.Notify(pl, "Предмет помещен в !donate инвентарь")

		-- вставлять новый ID не совсем корректно
		-- Думаю, надо кешировать тот ИД, что был при покупке
		hook.Run("IGS.PlayerPickedGift", self.Getowning_ent and self:Getowning_ent(), UID, invDbID, pl)
	end)
end

function IGS.SpawnGift(sUid, vPos)
	assert(sUid, "Item UID expected")

	local ent = ents.Create("ent_igs")
	ent:SetUID(sUid)

	if vPos then
		ent:SetPos(vPos)
		ent:Spawn()
	end

	return ent
end

-- Обратная совместимость
-- https://forum.gm-donate.net/t/spavn-donata-cherez-konsol/438/4?u=gmd
function IGS.CreateGift(sUid, plOwner, vPos)
	local ent = IGS.SpawnGift(sUid, vPos)
	cleanup.Add(plOwner, "sents", ent)

	return ent
end
