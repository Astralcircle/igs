IGS.VIPGroups = {}

local function CreateVIP(printname, classname, time, price, discountfrom)
	local vip = IGS(printname, classname)
	vip:SetTerm(time)
	vip:SetPrice(price)
	vip:SetDiscountedFrom(discountfrom)
	vip:SetIcon("icons/fa32/user-plus.png")
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
		if IGS.PlayerHasOneOf(ply, IGS.VIPGroups) then
			return "У вас уже действует эта услуга"
		end
	end)

	table.insert(IGS.VIPGroups, vip)
end

CreateVIP("VIP на 30 дней", "vip_30", 30, 250)
CreateVIP("VIP на 60 дней", "vip_60", 60, 475, 500)
CreateVIP("VIP на 90 дней", "vip_90", 90, 715, 750)

if SERVER then
	local steamid_checks = {}

	hook.Add("CheckPassword", "ClassicBox_VIPReservedSlots", function(steamid, ip, server_password, client_password, nick)
		if player.GetCount() >= game.MaxPlayers() - 2 then
			if not steamid_checks[steamid] then
				if steamid_checks[steamid] == nil then
					steamid_checks[steamid] = false

					timer.Simple(30, function()
						steamid_checks[steamid] = nil
					end)

					IGS.GetPlayerPurchases(steamid, function(data)
						for _, item in ipairs(data) do
							if item.Item == "vip_30" or item.Item == "vip_60" or item.Item == "vip_90" then
								steamid_checks[steamid] = true
							end
						end
					end)
				end

				return false, "Зарезервированные два слота, простите\nЕсли вы VIP, то переподключитесь через пару секунд чтобы занять его"
			end
		end
	end)

	hook.Add("IGS.PlayerPurchasesLoaded", "ClassicBox_VIP", function(ply)
		ply:SetNW2Bool("CB_VIP", IGS.PlayerHasOneOf(ply, IGS.VIPGroups) and true or nil)
	end)
end
