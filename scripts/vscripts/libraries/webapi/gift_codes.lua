--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GiftCodes = GiftCodes or {}
-- status: WIP, untested
GC_USED_SUCCESSFUL = 0
GC_USED_INCORRECT = 1
GC_USED_DUPLICATE = 2

function GiftCodes:Init()
	EventStream:Listen("GiftCodes:get_data", GiftCodes.SendGiftCodes, GiftCodes)
	EventStream:Listen("GiftCodes:redeem", GiftCodes.RedeemGiftCode, GiftCodes)
	EventStream:Listen("GiftCodes:send", GiftCodes.SendGiftCode, GiftCodes)

	GiftCodes._fetched = {}
	GiftCodes.gift_codes = {}
end


function GiftCodes:SendGiftCodes(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	-- since gift codes panel is not used oftenly (from chc data), their data is not supplied with before-match
	-- instead, it is fetched for player when they access the window first time
	if not GiftCodes._fetched[player_id] then
		GiftCodes:FetchGiftCodes(player_id)
		GiftCodes._fetched[player_id] = true
	end

	GiftCodes:UpdateClient(player_id)
end


function GiftCodes:FetchGiftCodes(player_id)
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	local steam_id = tostring(PlayerResource:GetSteamID(player_id))

	WebApi:Send(
		"api/lua/gift_codes/get",
		{
			steam_id = steam_id
		},
		function(response)
			GiftCodes.gift_codes[player_id] = response
			print("[Gift Codes] fetched gift codes of player", player_id)
			DeepPrintTable(response)
			GiftCodes:UpdateClient(player_id)
		end,
		function(err)
			print("[Gift Codes] failed to fetch gift codes of player", player_id)
		end
	)
end


function GiftCodes:SendGiftCode(event)
	if not event.target_id then return end

	GiftCodes:RedeemGiftCode({
		PlayerID = event.target_id,
		gift_code = event.gift_code,
		is_send = true,
	})
end


function GiftCodes:GetRedeemResult(player_id, response)
	local products = {}

	if response.items then
		products.items = {}
		for _, item_data in pairs(response.items) do
			table.insert(products.items, {
				name = item_data.name,
				count = item_data.count - WebInventory:GetItemCount(player_id, item_data.name);
			})
		end
	end

	if response.currency then
		products.currency = response.currency - WebPlayer:GetCurrency(player_id)
	end

	if response.subscription then
		products.subscription = response.subscription.tier
	end

	return products
end


function GiftCodes:RedeemGiftCode(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	if not event.gift_code then return end

	local steam_id = tostring(PlayerResource:GetSteamID(player_id))

	WebApi:Send(
		"api/lua/gift_codes/redeem",
		{
			steam_id = steam_id,
			gift_code = event.gift_code,
		},
		function(response)
			local redeemed_rewards = GiftCodes:GetRedeemResult(player_id, response)

			WebApi:ProcessMetadata(player_id, response)
			print("[Gift Codes] successfully redeemed gift code for", player_id)
			DeepPrintTable(response)

			-- scan in-match players gift code to mark redeemed gift code as redeemed
			-- this ensures state consistency if one player redeems gift code of another within same match
			for owner_player_id, gift_codes in pairs(GiftCodes.gift_codes or {}) do
				if gift_codes[event.gift_code] then
					gift_codes[event.gift_code].is_redeemed = true
					gift_codes[event.gift_code].redeemer = steam_id
					GiftCodes:UpdateClient(owner_player_id)
				end
			end

			if event.is_external_code then
				CustomGameEventManager:Send_ServerToPlayer(player, "GiftCodes:code_used", {
					type = GC_USED_SUCCESSFUL, redeemed_rewards = redeemed_rewards
				})
			end

			if event.is_send then
				Toasts:NewForPlayer(player_id, "gift_code_sent", {
					gifter = player_id,
					gift_code = response,
				})
			end
		end,
		function (err)
			print("[Gift Codes] failed to redeem gift code for", player_id)

			local error_type = GC_USED_INCORRECT

			if err.error and err.error == "code_already_redeemed" then
				error_type = GC_USED_DUPLICATE;
			end

			CustomGameEventManager:Send_ServerToPlayer(player, "GiftCodes:code_used", {
				type = error_type
			})
		end
	)
end


function GiftCodes:AddGiftCode(player_id, code_data)
	GiftCodes.gift_codes[player_id] = GiftCodes.gift_codes[player_id] or {}
	GiftCodes.gift_codes[player_id][code_data.code] = code_data
end


function GiftCodes:UpdateClient(player_id)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "GiftCodes:set_data", {
		gift_codes = GiftCodes.gift_codes[player_id] or {}
	})
end


GiftCodes:Init()