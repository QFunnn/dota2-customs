--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 01883f2 
  ~ auto-generated — do not edit
]]


-- [A83] Возврат золота за отклонённый гем — безопасная версия.
--   Условия возврата: (1) за этот предмет ещё не возвращали, (2) у игрока есть свежая
--   метка СПИСАНИЯ за покупку из ModifyGoldFilter (libs/filters.lua) на сумму не меньше
--   стоимости предмета, (3) эта метка ещё не использована.
--   Без пункта (2) окно быстрой покупки давало бесплатные +5000: оно проводит предмет
--   в инвентарь мимо ExecuteOrderFilter, где покупка гема отклоняется, поэтому золото
--   не списывалось, а возврат всё равно начислялся.
--   Повторная проверка через 0.25 с — на случай, если списание доедет до фильтра золота
--   позже добавления предмета в инвентарь: иначе честная покупка съела бы золото игрока.
function RefundBlockedGem(item, playerID)
	if not item or item:IsNull() then
		return
	end
	if item._gem_refund_done then
		return
	end
	item._gem_refund_done = true

	if playerID == nil or playerID < 0 then
		return
	end
	local cost = item:GetCost()
	if not cost or cost <= 0 then
		return
	end

	local function TryRefund()
		local spend = GEM_PURCHASE_SPEND and GEM_PURCHASE_SPEND[playerID]
		if not spend or spend.used then
			return false
		end
		if (GameRules:GetGameTime() - spend.time) > 2.0 then
			return false
		end
		if spend.amount < cost then
			return false
		end
		spend.used = true
		PlayerResource:ModifyGold(playerID, cost, true, DOTA_ModifyGold_SellItem)
		return true
	end

	if TryRefund() then
		return
	end

	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("GemRefundRetry"), function()
		TryRefund()
		return nil
	end, 0.25)
end

item_filter_check = class({})

item_filter_check.direct_consumables = {
	["item_relearn_book_lua"] = true,
	["item_relearn_book_return"] = true,
	["item_relearn_book_sss"] = true,
	["item_relearn_torn_page_lua"] = true,
	["item_book_of_strength_custom"] = true,
	["item_book_of_agility_custom"] = true,
	["item_book_of_intelligence_custom"] = true,
	["item_moon_shard"] = true,
	["item_dark_moon_shard"] = true,
	["item_gem_shard"] = true,
	["item_gem_shard_2"] = true,
	["item_essence_of_speed"] = true,
}

function item_filter_check:ItemAddedToInventoryFilter(keys)
	if not keys.item_entindex_const then
		return true
	end
	if not keys.inventory_parent_entindex_const then
		return true
	end
	local item = EntIndexToHScript(keys.item_entindex_const)
	local inventory_owner = EntIndexToHScript(keys.inventory_parent_entindex_const)
	local slot = keys.suggested_slot
	if not item or not inventory_owner then
		return true
	end
	local item_name = item:GetAbilityName()
	local purchaser = item:GetPurchaser()
	local player_owner_id = inventory_owner:GetPlayerOwnerID()
	local player = PlayerResource:GetPlayer(player_owner_id)

	-- Гемы: квик-бай проводит покупку мимо проверки в OrderFilter, поэтому
	-- дублируем её здесь — при попадании в инвентарь любым путём.
	-- Gem Shard 2 требует активированный Gem Shard 1; повторная покупка запрещена.
	if (item_name == "item_gem_shard" or item_name == "item_gem_shard_2") and purchaser and not purchaser:IsNull() then
		local error_message = nil
		if item_name == "item_gem_shard" and purchaser:HasModifier("modifier_item_gem_shard") then
			error_message = "dota_hud_error_item_already_purchased"
		elseif item_name == "item_gem_shard_2" then
			if not purchaser:HasModifier("modifier_item_gem_shard") then
				error_message = "dota_hud_error_not_buyed_1_version"
			elseif purchaser:HasModifier("modifier_item_gem_shard_2") then
				error_message = "dota_hud_error_item_already_purchased"
			end
		end
		if error_message then
			local purchaser_player = PlayerResource:GetPlayer(purchaser:GetPlayerOwnerID())
			if purchaser_player then
				CustomGameEventManager:Send_ServerToPlayer(
					purchaser_player,
					"SendHudError",
					{ message = error_message }
				)
			end
			-- [A83] ЭКСПЛОЙТ: раньше золото возвращалось безусловно. Окно быстрой покупки
			-- проводит предмет в инвентарь мимо ExecuteOrderFilter, где покупка гема
			-- блокируется, — то есть предмет доезжал сюда БЕЗ списания, и игрок получал
			-- чистые +5000 сколько угодно раз. Теперь возврат только против реального
			-- списания (метка из ModifyGoldFilter) и не больше одного раза за предмет.
			RefundBlockedGem(item, purchaser:GetPlayerOwnerID())
			item:SetContextThink(DoUniqueString("GemShardRefund"), function(ent)
				if ent and not ent:IsNull() then
					UTIL_Remove(ent)
				end
			end, 0)
			return false
		end
	end

	if
		IsDirectlyConsumable(item_name)
		and (not purchaser or purchaser:GetPlayerOwnerID() == player_owner_id)
		and item._dont_auto_consume_alt == nil
	then
		if inventory_owner:GetClassname() == "npc_dota_lone_druid_bear" then
			return true
		end
		if not player_owner_id then
			return true
		end
		local has_stack = FindItemOfHero(inventory_owner, item_name) ~= nil
		if inventory_owner:IsInRangeOfShop(DOTA_SHOP_HOME, true) then
			if player and not player:IsNull() then
				CustomGameEventManager:Send_ServerToPlayer(player, "immediate_purchase:key_check", {
					item = item:entindex(),
					has_stack = has_stack,
					item_name = has_stack and item_name or nil,
				})
			end
		end
	end

	item:SetContextThink(DoUniqueString("Swap"), function(ent)
		if inventory_owner and not inventory_owner:IsNull() and ent and not ent:IsNull() then
			Items:UpdateItemBySlot(inventory_owner, ent)
		end
	end, 0)

	-- -- Запрет на размещение нейтральных предметов в слоты 7-8 для Techies
	-- if inventory_owner:HasAbility("techies_spoons_stash_custom") and KeyValues:IsNeutralItem(item_name) then
	-- 	-- Проверяем сразу suggested_slot
	-- 	if slot == DOTA_ITEM_SLOT_7 or slot == DOTA_ITEM_SLOT_8 then
	-- 		return false
	-- 	end

	-- 	-- Также проверяем через задержку финальный слот
	-- 	item:SetContextThink(DoUniqueString("TechiesNeutralCheck"), function(ent)
	-- 		if not ent or ent:IsNull() then return end
	-- 		local finalSlot = ent:GetItemSlot()
	-- 		if finalSlot == DOTA_ITEM_SLOT_7 or finalSlot == DOTA_ITEM_SLOT_8 then
	-- 			if inventory_owner and not inventory_owner:IsNull() then
	-- 				-- Перемещаем предмет в нейтральный слот
	-- 				inventory_owner:SwapItems(finalSlot, DOTA_ITEM_SLOT_9)
	-- 			end
	-- 		end
	-- 	end, 0)
	-- end

	return true
end

function item_filter_check:OnItemCombined(event)
	local ItemName = event.itemname
	local PlayerID = event.PlayerID
	local Player = PlayerResource:GetPlayer(PlayerID)
	if not Player then
		return
	end

	local PlayerHero = PlayerResource:GetSelectedHeroEntity(PlayerID)
	if not PlayerHero or PlayerHero:GetClassname() == "npc_dota_lone_druid_bear" then
		return
	end

	local Item = FindItemOfHero(PlayerHero, ItemName)
	if not Item then
		return
	end

	local Purchaser = Item:GetPurchaser()

	if
		IsDirectlyConsumable(ItemName)
		and (not Purchaser or Purchaser:GetPlayerOwnerID() == PlayerID)
		and Item._dont_auto_consume_alt == nil
	then
		if PlayerHero:IsInRangeOfShop(DOTA_SHOP_HOME, true) then
			CustomGameEventManager:Send_ServerToPlayer(Player, "immediate_purchase:key_check", {
				item = Item:entindex(),
				has_stack = false,
				item_name = nil,
			})
		end
	end

	Item:SetContextThink(DoUniqueString("Swap"), function(ent)
		if PlayerHero and not PlayerHero:IsNull() and ent and not ent:IsNull() then
			Items:UpdateItemBySlot(PlayerHero, ent)
		end
	end, 0)
end

function IsDirectlyConsumable(item_name)
	return (item_filter_check.direct_consumables[item_name] or EXTRA_CREATURES_LIST[item_name] ~= nil)
end

function FindItemOfHero(hero, item_name)
	for i = 0, 30 do
		local item = hero:GetItemInSlot(i)
		if item and not item:IsNull() and item:GetAbilityName() == item_name then
			return item
		end
	end
	return nil
end

CustomGameEventManager:RegisterListener("immediate_purchase:response", function(_, data)
	local player_id = data.PlayerID
	if not player_id then
		return
	end
	local result = data.result
	local has_stacked_items = data.has_stack == 1 -- event sending has bools as 0/1
	local player = PlayerResource:GetPlayer(player_id)
	if not player or player:IsNull() then
		return
	end
	local hero = player:GetAssignedHero()
	if not hero or hero:IsNull() then
		return
	end
	local item
	if not has_stacked_items then
		item = EntIndexToHScript(data.item)
	else
		if not data.item_name then
			return
		end
		item = FindItemOfHero(hero, data.item_name)
	end
	if not item or item:IsNull() or (item.GetContainer and item:GetContainer()) then
		return
	end
	if result == 1 then
		Timers:CreateTimer(0.07, function()
			if not item or item:IsNull() or item:GetContainer() then
				return
			end
			if
				item:IsCooldownReady()
				and (not item.CastFilterResult or (item.CastFilterResult and item:CastFilterResult() == UF_SUCCESS))
			then
				hero:SetCursorCastTarget(hero)
				item:OnSpellStart()
			end
		end)
	end
end)