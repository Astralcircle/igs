IGS.VIPGroups = {}

local PLAYER = FindMetaTable("Player")

function PLAYER:HasVIP()
	return self:GetNW2Bool("CB_VIP")
end

local function CreateVIP(printname, classname, time, price, discountfrom)
	local vip = IGS(printname, classname)
	vip:SetTerm(time)
	vip:SetPrice(price)
	vip:SetDiscountedFrom(discountfrom)
	vip:SetIcon("icons/fa32/user-plus.png")
	vip:SetCategory("Группы")
	vip:SetDescription([[
	Дает эксклюзивные возможности на сервере:

	Увеличенные вдвое лимиты на спавны
	Возможность спавнить запрещенное оружие и NPC
	Возможность установить пользовательский фон своему профилю в ТАБ-е
	Доступ к Starfall и PAC3 до 10 часов

	Список будет пополнятся]]
	)

	vip:SetOnActivate(function(ply)
		ply:SetNW2Bool("CB_VIP", true)
	end)

	vip:SetCanActivate(function(ply)
		if IGS.PlayerHasOneOf(ply, IGS.VIPGroups) then
			return "У вас уже действует эта услуга"
		end
	end)

	table.insert(IGS.VIPGroups, vip)
end

CreateVIP("VIP на 30 дней", "vip_30", 30, 275)
CreateVIP("VIP на 60 дней", "vip_60", 60, 525, 550)
CreateVIP("VIP на 90 дней", "vip_90", 90, 750, 825)

if SERVER then
	hook.Add("IGS.PlayerPurchasesLoaded", "ClassicBox_VIP", function(ply)
		ply:SetNW2Bool("CB_VIP", IGS.PlayerHasOneOf(ply, IGS.VIPGroups) and true or nil)
	end)
end
