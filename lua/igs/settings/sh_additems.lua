local vip_groups = {}

local function CreateVIP(printname, classname, time, price, discountfrom)
	local vip = IGS(printname, classname)
	vip:SetTerm(time)
	vip:SetPrice(price)
	vip:SetDiscountedFrom(discountfrom)
	vip:SetIcon("icons/fa32/user-plus.png", "material")
	vip:SetCategory("Группы")
	vip:SetDescription([[
	Дает эксклюзивные возможности на сервере:

	Увеличенные вдвое лимиты на спавны (кроме пропов)
	Возможность спавнить запрещенное оружие и NPC
	Возможность установить пользовательский фон своему профилю в ТАБ-е
	Доступ к двум зарезервированным слотам на сервере
	Доступ к Starfall и PAC3 до 10 часов

	Список будет пополнятся]]
	)

	vip:SetOnActivate(function(ply)
		ply:SetNW2Bool("CB_VIP", true)
	end)

	vip:SetCanActivate(function(ply)
		if IGS.PlayerHasOneOf(ply, vip_groups) then
			return "У вас уже действует эта услуга"
		end
	end)

	table.insert(vip_groups, vip)
end

CreateVIP("VIP на 30 дней", "vip_30", 30, 250)
CreateVIP("VIP на 60 дней", "vip_60", 60, 475, 500)
CreateVIP("VIP на 90 дней", "vip_90", 90, 715, 750)

if SERVER then
	hook.Add("IGS.PlayerPurchasesLoaded", "ClassicVox_VIP", function(ply)
		ply:SetNW2Bool("CB_VIP", IGS.PlayerHasOneOf(ply, vip_groups) and true or nil)
	end, POST_HOOK)
end
