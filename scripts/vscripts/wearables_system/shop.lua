--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if shop == nil then
    shop = class({})
    shop.saved_players_chest_items = {}
    shop.HOW_MUCH_CHEST_RETURN_GOLD_PERCENT = 20
end

require("wearables_system/shop_configs")
require("wearables_system/chest_info")

CustomNetTables:SetTableValue("shop_items", "pets", pets_item_list)
CustomNetTables:SetTableValue("shop_items", "tips", tips_item_list)
CustomNetTables:SetTableValue("shop_items", "effects", shop_effects_list)
CustomNetTables:SetTableValue("shop_items", "high_five", high_five_item_list)
CustomNetTables:SetTableValue("shop_items", "chest", DOTA1X6_CHESTS_INFO)
CustomNetTables:SetTableValue("shop_items", "votes_cost", {cost = 100, hero_stat = 1})

function HasDonateItem(id, item_id)
	local player_table = CustomNetTables:GetTableValue("sub_data", tostring(id))
	if player_table then
		if player_table.items_ids then
			for _, item_id_data in pairs(player_table.items_ids) do
				if tostring(item_id_data) == tostring(item_id) then
					return true
				end
			end
		end
	end
	return false
end

function shop:shop_buy_item_player(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    local item_id = tonumber(data.item_id)
    local is_item_bundle = nil
    local cost = 0
    for _,chat_item in pairs(Sound_list.general_ru) do 
    	if chat_item[1] == item_id then 
    		cost = chat_item[3]
    	end
    end
    if cost == 0 then 
	    for _,chat_item in pairs(Sound_list.general_eng) do 
	    	if chat_item[1] == item_id then 
	    		cost = chat_item[3]
	    	end
	    end
    end
    if cost == 0 then 
	    for _,chat_item in pairs(Sound_list.general_other) do 
	    	if chat_item[1] == item_id then 
	    		cost = chat_item[3]
	    	end
	    end
    end
    if cost == 0 then 
    	for _,pet_item in pairs(pets_item_list) do 
    		if (pet_item[1] == item_id) then 
    			cost = pet_item[4]
    		end
    	end
    end
    if cost == 0 then 
    	for _,tip_item in pairs(tips_item_list) do 
    		if (tip_item[1] == item_id) then 
    			cost = tip_item[4]
                if tip_item[7] then
                    return
                end
    		end
    	end
    end
    if cost == 0 then 
    	for effect_type, effects_data in pairs(shop_effects_list) do
            for __, effect_item in pairs(effects_data) do
                if (effect_item[1] == item_id) then 
                    cost = effect_item[4]
                end
            end
    	end
    end
    if cost == 0 then 
    	for _,tip_item in pairs(high_five_item_list) do 
    		if (tip_item[1] == item_id) then 
    			cost = tip_item[4]
    		end
    	end
    end
	if cost == 0 then
        if data.hero ~= nil then
            if wearables_system.ITEMS_DATA[tostring(data.hero)] then
                for _, item_info in pairs(wearables_system.ITEMS_DATA[tostring(data.hero)]) do 
                    if (item_info["item_id"] == item_id) then 
                        cost = item_info["price"]

                        if item_info["sale_price"] and item_info["sale_price"] > 0 then 
                        	cost = item_info["sale_price"]
                        end 
 
                        if item_info["OtherItemsBundle"] ~= nil then
                            is_item_bundle = item_info["OtherItemsBundle"]
                        end
                        break
                    end
                end
            end
        end
    end
    if cost == 0 and item_id == -1 then 
    	cost = CustomNetTables:GetTableValue('shop_items', 'votes_cost').cost*data.votes
    end
    if cost == 0 then 
    	return
    end

    local player = PlayerResource:GetPlayer(id)
    local player_table = CustomNetTables:GetTableValue('sub_data', tostring(id))
    local player_items_table = {}

    if player_table then
    	if player_table.points < cost then return end
        if player_table.items_ids then
            for k, v in pairs(player_table.items_ids) do
                table.insert(player_items_table, v)
            end
        end
        player_table.points = player_table.points - cost
		if data.item_id == -1 then 
		    player_table.votes_count = player_table.votes_count + data.votes
		    HTTP.BuyItem( data.PlayerID, "vote", cost, data.votes )
		else
		    table.insert(player_items_table, item_id)
		    if is_item_bundle ~= nil then
		        for _, item_bundle in pairs(is_item_bundle) do
		            if item_id ~= item_bundle[1] then
		                table.insert(player_items_table, item_bundle[1])
		            end
		        end
		    end
            if shop.ITEMS_BUNDDLE_LIST[item_id] then
                for _, item_id_in_bundle in pairs(shop.ITEMS_BUNDDLE_LIST[item_id]) do
                    table.insert(player_items_table, item_id_in_bundle)
                    HTTP.BuyItem(data.PlayerID, item_id_in_bundle, 0)
                end
            end
		    player_table.items_ids = player_items_table
		    HTTP.BuyItem( data.PlayerID, item_id, math.abs( cost ) )
		end
        CustomNetTables:SetTableValue('sub_data', tostring(id), player_table)
    end
end

function shop:AddCourierParticle(particle, pet)
    pet.particle = ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN_FOLLOW, pet)	
    if particle == "particles/econ/courier/courier_doomling/courier_doomling_ambient.vpcf" then 
        ParticleManager:SetParticleControlEnt(pet.particle, 0, pet, PATTACH_POINT_FOLLOW, "attach_weapon", pet:GetAbsOrigin(), true)
    end
    if particle == "particles/econ/courier/courier_faceless_rex/cour_rex_flying.vpcf" then 
        ParticleManager:SetParticleControlEnt(pet.particle, 0, pet, PATTACH_POINT_FOLLOW, "attach_hitloc", pet:GetAbsOrigin(), true)
    end
end

function shop:ChangePetPremium(data)
	if data.PlayerID == nil then return end
	local id = data.PlayerID
	local pet_id = tonumber(data.pet_id)				
	local player = players[id]
	local player_table = CustomNetTables:GetTableValue('sub_data', tostring(id))
	if player_table then
		player_table.pet_id = pet_id
		CustomNetTables:SetTableValue('sub_data', tostring(id), player_table)
	end
	if not PETS_DATA_LIST[pet_id] and pet_id ~= 0 then return end
	if player then
		local hero = player
		if hero:GetUnitName() ~= "npc_dota_hero_wisp" then
			if player.pet and player.pet ~= nil and data.delete_pet == 0 then
				player.pet:SetModel(PETS_DATA_LIST[pet_id].model)
				player.pet:SetOriginalModel(PETS_DATA_LIST[pet_id].model)
				player.pet:AddNewModifier( hero, nil, "modifier_donate_pet", {scale = PETS_DATA_LIST[pet_id].scale } )
				if player.pet.particle then
					ParticleManager:DestroyParticle(player.pet.particle, true)
					player.pet.particle = nil
				end
				if PETS_DATA_LIST[pet_id].particle ~= nil then
					shop:AddCourierParticle(PETS_DATA_LIST[pet_id].particle, player.pet)
				end		
				if PETS_DATA_LIST[pet_id].style ~= nil then
					player.pet:SetMaterialGroup(PETS_DATA_LIST[pet_id].style)
				else
					player.pet:SetMaterialGroup("default")
				end	
			elseif player.pet and player.pet ~= nil and data.delete_pet == 1 then
				UTIL_Remove(player.pet)
				player.pet = nil
			else
				player.pet = CreateUnitByName("npc_dota_donate_pet", hero:GetAbsOrigin() + RandomVector(RandomFloat(0,100)), true, hero, nil, hero:GetTeamNumber())
                player.pet:SetOwner(hero)
				local ability = player.pet:FindAbilityByName("donate_pet_ability")
				if ability then 
					ability:SetLevel(1)
				end 
				player.pet:AddNewModifier( hero, nil, "modifier_donate_pet", {scale = PETS_DATA_LIST[pet_id].scale } )
				player.pet:SetModel(PETS_DATA_LIST[pet_id].model)
				player.pet:SetOriginalModel(PETS_DATA_LIST[pet_id].model)
				if PETS_DATA_LIST[pet_id].particle ~= nil then
					shop:AddCourierParticle(PETS_DATA_LIST[pet_id].particle, player.pet)
				end
				if PETS_DATA_LIST[pet_id].style ~= nil then
					player.pet:SetMaterialGroup(PETS_DATA_LIST[pet_id].style)
				else
					player.pet:SetMaterialGroup("default")
				end
			end
		end
	end
end

-- Функция спавна курьера если у игрока в данных есть его айди сервера. Можно вызывать при спавне героя
function shop:AddPetFromStart(id)
	local pet_id = nil
	local player = players[id]
	local player_table = CustomNetTables:GetTableValue('sub_data', tostring(id))
	if player_table and player_table.pet_id then
		pet_id = player_table.pet_id
	end
	if player then
		local hero = player
		if hero:GetUnitName() ~= "npc_dota_hero_wisp" and pet_id ~= 0 and pet_id ~= nil and pet_id ~= "0" then
			player.pet = CreateUnitByName("npc_dota_donate_pet", hero:GetAbsOrigin() + RandomVector(RandomFloat(0,100)), true, hero, nil, hero:GetTeamNumber())
            player.pet:SetOwner(hero)
			local ability = player.pet:FindAbilityByName("donate_pet_ability")
			if ability then 
				ability:SetLevel(1)
			end 
			player.pet:AddNewModifier( hero, nil, "modifier_donate_pet", {scale = PETS_DATA_LIST[pet_id].scale} )
			player.pet:SetModel(PETS_DATA_LIST[pet_id].model)
			player.pet:SetOriginalModel(PETS_DATA_LIST[pet_id].model)
			if PETS_DATA_LIST[pet_id].particle ~= nil then
				shop:AddCourierParticle(PETS_DATA_LIST[pet_id].particle, player.pet)
			end
			if PETS_DATA_LIST[pet_id].style ~= nil then
				player.pet:SetMaterialGroup(PETS_DATA_LIST[pet_id].style)
			else
				player.pet:SetMaterialGroup("default")
			end
		end
	end
end

function shop:heroes_vote_change(kv)
    local player =	PlayerResource:GetPlayer(kv.PlayerID)
    if not player then return end
    if not kv.count then return end
    if not kv.name then return end
    local heroes_vote = CustomNetTables:GetTableValue("sub_data", "heroes_vote")
    for i = 1,3 do 
        if (heroes_vote.vote_table[tostring(i)]) then 
            if heroes_vote.vote_table[tostring(i)]['1'] == kv.name then 
                heroes_vote.vote_table[tostring(i)]['2'] = heroes_vote.vote_table[tostring(i)]['2'] + kv.count
                heroes_vote.vote_table[tostring(i)]['3'] = heroes_vote.vote_table[tostring(i)]['3'] + kv.count
            end
        end
    end
    CustomNetTables:SetTableValue("sub_data", "heroes_vote", heroes_vote)
    local sub_data = CustomNetTables:GetTableValue('sub_data', tostring(kv.PlayerID))
    if not sub_data then return end 
    local count = sub_data.votes_count
    sub_data.votes_count = math.max(0, sub_data.votes_count - kv.count)
    HTTP.Vote( kv.PlayerID, kv.name, kv.count )
    CustomNetTables:SetTableValue('sub_data', tostring(kv.PlayerID), sub_data)
end

function shop:heroes_vote_free(kv)
	local player =	PlayerResource:GetPlayer(kv.PlayerID)
	if not player then return end
	local sub_data = CustomNetTables:GetTableValue('sub_data', tostring(kv.PlayerID))
	sub_data.votes_count = sub_data.votes_count + 1
	sub_data.free_vote_cd = shop_free_vote_cd
	HTTP.BonusVotes( kv.PlayerID, 1, sub_data.free_vote_cd * 1000 )
	CustomNetTables:SetTableValue('sub_data', tostring(kv.PlayerID), sub_data)
end

function shop:get_bonus_shards(kv)
	local player =	PlayerResource:GetPlayer(kv.PlayerID)
	if not player then return end
	local sub_data = CustomNetTables:GetTableValue('sub_data', tostring(kv.PlayerID))
	if sub_data.bonus_shards_cd > 0 then return end
	local count = RandomInt(shop_daily_shards_min, shop_daily_shards_max)
	local limit = 0
	local change = count
	if sub_data.subscribed == 0 then 
		if sub_points_max - sub_data.points <= count then
			limit = 1
		end 
		change = math.min(math.max(sub_points_max - sub_data.points, 0), count)
		sub_data.points = sub_data.points + change
	else 
		sub_data.points = sub_data.points + count
	end
	sub_data.bonus_shards_cd = shop_daily_shards_cd
	HTTP.BonusShards( kv.PlayerID, math.abs( change ), sub_data.bonus_shards_cd * 1000 )
	CustomNetTables:SetTableValue('sub_data', tostring(kv.PlayerID), sub_data)
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(kv.PlayerID), 'give_bonus_shards', {count = count, limit = limit} ) 
end

function shop:browser_subscribe(kv)
    if not IsServer() then return end
    local player =	PlayerResource:GetPlayer(kv.PlayerID)
    if not player then return end
    HTTP.Login(kv.PlayerID, kv.item_name, kv.player_id) 
end

function shop:SelectQuest(kv)
    if not IsServer() then return end
    local player =	PlayerResource:GetPlayer(kv.PlayerID)
    if not player then return end
    local sub_data = CustomNetTables:GetTableValue('sub_data', tostring(kv.PlayerID))
    if not sub_data or sub_data.subscribed == 0 then return end
    if SelectedQuests[kv.PlayerID] ~= nil then return end
    SelectedQuests[kv.PlayerID] = kv.name
end

-- Function Update Tip Wheel
function shop:update_tip_list(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    local tip_id = tonumber(data.tip_id)	
    local delete = data.delete			
    local player =	PlayerResource:GetPlayer(id)
    local player_table = CustomNetTables:GetTableValue('sub_data', tostring(id))
    if not player_table or not player_table.player_tips or not player_table.selected_tip then return end
    local selected = player_table.selected_tip
    local player_tips_wheel_change = {}
    for i,id in pairs(player_table.player_tips) do 
        player_tips_wheel_change[tostring(i)] = id
    end 
    local max = 0
    for i,id in pairs(player_tips_wheel_change) do 
        if tonumber(i) >= max then 
            max = tonumber(i)
        end 
    end
    if delete == 1 then
        for i = 1,max do 
            if player_tips_wheel_change[tostring(i)] == tip_id then 
                player_tips_wheel_change[tostring(i)] = 0
                break
            end 
        end
    else
        local has_null = false
        for i,id in pairs(player_tips_wheel_change) do 
            if id == tip_id then 
                return
            end 
        end
        for i = 1,max do 
            if player_tips_wheel_change[tostring(i)] == 0 then 
                player_tips_wheel_change[tostring(i)] = tip_id
                selected = tostring(i)
                has_null = true
                break
            end 
        end 
        if not has_null then
            player_tips_wheel_change["1"] = tip_id
            selected = "1"
        end
        player_table.selected_tip = selected
    end
    for i,id in pairs(player_tips_wheel_change) do 
        player_table.player_tips[tostring(i)] = id
    end 
    if delete == 1 then 
        if selected and selected ~= "0" and (not player_table.player_tips[selected] or player_table.player_tips[selected] == 0) then 
            player_table.selected_tip = "0"
            for i = 1,max do
                if player_table.player_tips[tostring(i)] ~= 0 then 
                    player_table.selected_tip = tostring(i)
                    break
                end
            end 
        end
    end 
    CustomNetTables:SetTableValue('sub_data', tostring(id), player_table)
    CustomGameEventManager:Send_ServerToPlayer(player, "shop_update_tips_and_fives", {sub_data = player_table})
end

-- function Select Current Tip
function shop:select_current_tip(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    local tip_id = tostring(data.tip_id)
    local player = PlayerResource:GetPlayer(id)
    local sub_data = CustomNetTables:GetTableValue('sub_data', tostring(id))
    if sub_data and sub_data.player_tips and ((sub_data.player_tips[tip_id] ~= nil and sub_data.player_tips[tip_id] ~= 0) or tip_id == '0') then 
        sub_data.selected_tip = tip_id
        CustomNetTables:SetTableValue("sub_data", tostring(id), sub_data)
    end
    CustomGameEventManager:Send_ServerToPlayer(player, "shop_update_tips_and_fives", {sub_data = sub_data})
end 

function shop:select_current_high_five(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    local high_five_id = data.high_five_id
    local player = PlayerResource:GetPlayer(id)
    local sub_data = CustomNetTables:GetTableValue('sub_data', tostring(id))
    if sub_data then 
        sub_data.selected_high_five = high_five_id
        CustomNetTables:SetTableValue("sub_data", tostring(id), sub_data)
    end
    CustomGameEventManager:Send_ServerToPlayer(player, "shop_update_tips_and_fives", {sub_data = sub_data})
end

function shop:select_current_emblem(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    local emblem_id = data.emblem_id
    local player = PlayerResource:GetPlayer(id)
    local sub_data = CustomNetTables:GetTableValue('sub_data', tostring(id))
    if sub_data then 
        sub_data.selected_emblem = emblem_id
        CustomNetTables:SetTableValue("sub_data", tostring(id), sub_data)
    end
    CustomGameEventManager:Send_ServerToPlayer(player, "shop_update_tips_and_fives", {sub_data = sub_data})
    local hero = PlayerResource:GetSelectedHeroEntity(id)
    if hero then
        shop:UpdateEmblemForHero(hero, id, emblem_id)
    end
end

function shop:IsCustomEffectItem(effect_type, effect_id, player_id)
    if not effect_type or not effect_id then return false end
    if not _G.shop_effects_list or not _G.shop_effects_list[effect_type] then return false end
    for _, effect_item in pairs(_G.shop_effects_list[effect_type]) do
        if tonumber(effect_item[2]) == tonumber(effect_id) then
            if player_id == nil then return true end
            return HasDonateItem(player_id, effect_item[1])
        end
    end
    return false
end

function shop:select_current_effect(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    local effect_type = data.effect_type
    local effect_id = tonumber(data.effect_id) or 0
    if not effect_type or effect_type == "emblems" then return end
    local player = PlayerResource:GetPlayer(id)
    local sub_data = CustomNetTables:GetTableValue('sub_data', tostring(id))
    if sub_data then
        sub_data.selected_effects = sub_data.selected_effects or {}
        if effect_id == 0 then
            sub_data.selected_effects[effect_type] = 0
        elseif shop:IsCustomEffectItem(effect_type, effect_id, id) then
            sub_data.selected_effects[effect_type] = effect_id
        else
            return
        end
        CustomNetTables:SetTableValue("sub_data", tostring(id), sub_data)

        if effect_type == "effect_attack" then
            local hero = PlayerResource:GetSelectedHeroEntity(id)
            if hero and not hero:IsNull() then
                local main_mod = hero:FindModifierByName("modifier_player_main_custom")
                if main_mod and main_mod.UpdateProjectileAttack then
                    main_mod:UpdateProjectileAttack()
                end
            end
        end
    end
    CustomGameEventManager:Send_ServerToPlayer(player, "shop_update_tips_and_fives", {sub_data = sub_data})
end

function shop:UpdateEmblemForHero(hero, player_id, emblem_id)
    if hero and IsValid(hero) and (hero:IsRealHero() or hero:IsIllusion()) then 
        if hero:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
        if not emblem_id then
            local sub_data = CustomNetTables:GetTableValue('sub_data', tostring(player_id))
            if sub_data then 
                emblem_id = sub_data.selected_emblem
            end
        end
        if hero.current_emblem and hero.current_emblem == emblem_id then return end
        if hero.emblem_pfx then
            ParticleManager:DestroyParticle(hero.emblem_pfx, true)
            ParticleManager:ReleaseParticleIndex(hero.emblem_pfx)
            hero.emblem_pfx = nil
            hero.current_emblem = nil
            if hero.reconnects_emblems then
                for _, pfx in pairs(hero.reconnects_emblems) do
                    ParticleManager:DestroyParticle(pfx, true)
                    ParticleManager:ReleaseParticleIndex(pfx)
                end
            end
        end
        if emblem_id and _G.EmblemsListPFX[emblem_id] then
            hero.current_emblem = emblem_id
            hero.emblem_pfx = ParticleManager:CreateParticle(_G.EmblemsListPFX[emblem_id], PATTACH_ABSORIGIN_FOLLOW, hero)
        end
    end
end

function shop:GetHighFiveData(id)
    for _, data in pairs(high_five_item_list) do
        if data[2] == id then
            return {data[7], data[8], data[9]}
        end
    end
end

function shop:send_promo_code(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    local text = data.text
    if not text or text == "" then return end
    local player =	PlayerResource:GetPlayer(id)
    if not player then return end 
    local player_table = players[id]
    if not player_table then return end 
    if player_table.promo_cd > 0 then 
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "panorama_cooldown_error", {message="#dota_item_change_error", time = player_table.promo_cd})
        return
    end 
    local send_data = 
    {
        matchId = tostring(GameRules:Script_GetMatchID()), 
        matchKey = HTTP.MATCH_KEY,
        code = data.text, 
        playerId = tostring( PlayerResource:GetSteamAccountID( id ))	
    }

    HTTP.Request( "/promo", send_data, function( data )
        local status = -1
        local eng = ""
        local ru = ""
        local amount = 0
        local name = ""
        if data then
            status = data.status
            ru = data.ruResponse
            eng = data.engResponse
            if data.awardsAmount then 
                amount = data.awardsAmount
            end
            if data.awardsName then 
                name = data.awardsName
            end
            if status == 0 then 
                local steamIDs = {}
                table.insert( steamIDs, tostring( PlayerResource:GetSteamAccountID( id )))

                dota1x6:SendState(steamIDs)
            end 
        end
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "answer_promo_code", {status = status, ru = ru, eng = eng, amount = amount, name = name})	
    end, nil, false )

    player_table.promo_cd = 3
end



function shop:CheckGifts(for_id)
    if not IsServer() then return end
    local steamIDs = {}
    for id = 0, 24 do
        if ValidId(id) and (not for_id or for_id == id) then
            table.insert( steamIDs, tostring( PlayerResource:GetSteamAccountID( id ) ) )
        end
    end

    HTTP.Request("/gifts", {
        Players = steamIDs,
    }, function(data)

        if not data then 
            return
        end
        shop:UpdateGifts(data)
    end)
end



function shop:UpdateGifts(table)
    if not IsServer() then return end 
    local new_data = {}
    for id = 0, 24 do
        if ValidId(id) then
            new_data[id] = {}
        end
    end
    for _,data in pairs(table) do
        if data.count and data.count > 0 and data.gifts and #data.gifts > 0 then 
            local id = HTTP.GetPlayerBySteamID( data.playerId )	
            new_data[id] = data.gifts
        end 	
    end 
    for id,data in pairs(new_data) do 
        CustomNetTables:SetTableValue('gifts_data', tostring(id), data)
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "gift_alert", {})
    end
end 


function shop:accept_gift(js_data) 
    if js_data.PlayerID == nil then return end
    if js_data.giftId == nil then return end
    local id = js_data.PlayerID
    local giftId = js_data.giftId
    local gifts_data = CustomNetTables:GetTableValue("gifts_data", tostring(id))
    for _,data in pairs(gifts_data) do 
        if data.giftId == giftId then 
            HTTP.Request( "/accept_gift", 
                {
                    matchId = tostring(GameRules:Script_GetMatchID()),
                    matchKey = HTTP.MATCH_KEY,
                    playerId = tostring( PlayerResource:GetSteamAccountID( id ) ),
                    giftId = giftId
                }, 
                function(data)
                    if not data then return end
                    local gifts_data = {}
                    for _,player_data in pairs(data) do 
                        if player_data.gifts and #player_data.gifts > 0 then 
                            gifts_data = player_data.gifts
                        end 
                        break
                    end
                    CustomNetTables:SetTableValue('gifts_data', tostring(id), gifts_data)
                    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "gift_alert", {})	
                    local steamIDs = {}
                    table.insert( steamIDs, tostring( PlayerResource:GetSteamAccountID( id )))
                    dota1x6:SendState(steamIDs)
                end
            )
        end
    end
end 

function shop:shop_dota1x6_open_chest_get_items_list(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    local chest_id = tonumber(data.chest_id)
    if DOTA1X6_CHESTS_INFO[chest_id] == nil then return end
    local chest_info = 
    {
        ["chest_name"] = DOTA1X6_CHESTS_INFO[chest_id].chest_name,
        ["chest_items"] = DOTA1X6_CHESTS_INFO[chest_id].chest_items,
        ["chest_id"] = chest_id,
        ["chest_cost"] = DOTA1X6_CHESTS_INFO[chest_id].chest_cost,
        ["chance"] = DOTA1X6_CHESTS_INFO[chest_id].chance,
        ["is_no_buy"] = DOTA1X6_CHESTS_INFO[chest_id].is_no_buy,
        ["is_only_one_open"] = DOTA1X6_CHESTS_INFO[chest_id].is_only_one_open,
        ["is_reroll"] = DOTA1X6_CHESTS_INFO[chest_id].is_reroll,
        ["chest_item_id"] = DOTA1X6_CHESTS_INFO[chest_id].chest_item_id,
    }
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), 'shop_dota1x6_open_chest_information', {chest_info = chest_info} ) 
end

function shop:shop_dota1x6_close_chest_checked_reward(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    if shop.saved_players_chest_items[id] == nil then return end
    local chest_id = shop.saved_players_chest_items[id].chest_id
    local cost = shop.saved_players_chest_items[id].cost
    local item_id = shop.saved_players_chest_items[id].item_id
    local player_table = CustomNetTables:GetTableValue('sub_data', tostring(id))
    local player_items_table = {}
    if player_table then
        if player_table.items_ids then
            for k, v in pairs(player_table.items_ids) do
                table.insert(player_items_table, v)
            end
        end
        player_table.points = player_table.points - cost
        table.insert(player_items_table, item_id)
        HTTP.BuyItem( id, item_id, math.abs( cost ) )
        if shop.ITEMS_BUNDDLE_LIST[item_id] then
            for _, item_id_in_bundle in pairs(shop.ITEMS_BUNDDLE_LIST[item_id]) do
                table.insert(player_items_table, item_id_in_bundle)
                HTTP.BuyItem(data.PlayerID, item_id_in_bundle, 0)
            end
        end
        player_table.items_ids = player_items_table
        CustomNetTables:SetTableValue('sub_data', tostring(id), player_table)
    end
    shop.saved_players_chest_items[id] = nil
end

function shop:shop_dota1x6_open_chest_get_reward(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    local chest_id = data.chest_id
    local is_rerolled = data.rerolled
    local drop_id = nil
    if DOTA1X6_CHESTS_INFO[chest_id] == nil then return end
    local items_in_chest = DOTA1X6_CHESTS_INFO[chest_id].chest_items
    if shop.saved_players_chest_items[id] then
        drop_id = shop:GetRandomRewardFromChest(id, items_in_chest, shop.saved_players_chest_items[id].item_id)
    else
        drop_id = shop:GetRandomRewardFromChest(id, items_in_chest)
    end
    if is_rerolled and not shop.saved_players_chest_items[id] then return end
    shop.saved_players_chest_items[id] = nil
    if drop_id == nil then return end
    local is_retry_drop = false
    local shard_counter = 0
    local cost = DOTA1X6_CHESTS_INFO[chest_id].chest_cost
    local player = PlayerResource:GetPlayer(id)
    local player_table = CustomNetTables:GetTableValue('sub_data', tostring(id))
    local player_items_table = {}
    local is_reroll = false
    if player_table then
        if player_table.points < cost then return end
        if DOTA1X6_CHESTS_INFO[chest_id].is_only_one_open and not is_rerolled then

            local chest_opened_table = {}
            for k, v in pairs(player_table.chest_opened) do
                table.insert(chest_opened_table, v)
            end
            table.insert(chest_opened_table, chest_id)
            player_table.chest_opened = chest_opened_table

			HTTP.BuyItem(id, DOTA1X6_CHESTS_INFO[chest_id].chest_item_id, 0)
        end
        if player_table.items_ids then
            for k, v in pairs(player_table.items_ids) do
                table.insert(player_items_table, v)
            end
        end
        if HasDonateItem(id, drop_id.item_id) then
            player_table.points = player_table.points - (cost * (1 - shop.HOW_MUCH_CHEST_RETURN_GOLD_PERCENT / 100))
            is_retry_drop = true
            shard_counter = cost * (shop.HOW_MUCH_CHEST_RETURN_GOLD_PERCENT / 100)
			HTTP.BuyItem( id, drop_id.item_id, math.abs( (cost * (1 - shop.HOW_MUCH_CHEST_RETURN_GOLD_PERCENT / 100)) ) )
        else
            if DOTA1X6_CHESTS_INFO[chest_id].is_reroll and not is_rerolled then
                shop.saved_players_chest_items[id] = 
                {
                    ["cost"] = cost,
                    ["item_id"] = drop_id.item_id,
                    ["chest_id"] = chest_id,
                }
                is_reroll = true
            else
                player_table.points = player_table.points - cost
                table.insert(player_items_table, drop_id.item_id)
                HTTP.BuyItem( id, drop_id.item_id, math.abs( cost ) )
                if shop.ITEMS_BUNDDLE_LIST[drop_id.item_id] then
                    for _, item_id_in_bundle in pairs(shop.ITEMS_BUNDDLE_LIST[drop_id.item_id]) do
                        table.insert(player_items_table, item_id_in_bundle)
                        HTTP.BuyItem(data.PlayerID, item_id_in_bundle, 0)
                    end
                end
                shop.saved_players_chest_items[id] = nil
            end
        end
        if is_rerolled then
            is_reroll = false
        end
        player_table.items_ids = player_items_table
        CustomNetTables:SetTableValue('sub_data', tostring(id), player_table)
    end

    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), 'shop_dota1x6_open_chest_active', {drop_id = drop_id.item_id, items = items_in_chest, is_retry_drop = is_retry_drop, shard_counter = shard_counter, is_reroll = is_reroll} ) 
end

function shop:GetRandomRewardFromChest(id, items_in_chest, remove_item_id)
    local get_drop = nil
    local has_items_with_chance = {}
    local no_items_list = {}
    local items_no_rare = {}
    for _, item in pairs(items_in_chest) do
        if not HasDonateItem(id, item.item_id) and item.chance ~= nil then
            table.insert(has_items_with_chance, item)
        end
        if not HasDonateItem(id, item.item_id) and item.chance == nil then
            table.insert(no_items_list, item)
        end
        if item.chance == nil then
            table.insert(items_no_rare, item)
        end
    end

    if remove_item_id ~= nil then
        if #has_items_with_chance > 1 then
            for i=#has_items_with_chance, 1, -1 do
                if has_items_with_chance[i] and tonumber(has_items_with_chance[i].item_id) == tonumber(remove_item_id) then
                    table.remove(has_items_with_chance, i)
                end
            end
        end
        if #no_items_list > 1 then
            for i=#no_items_list, 1, -1 do
                if no_items_list[i] and tonumber(no_items_list[i].item_id) == tonumber(remove_item_id) then
                    table.remove(no_items_list, i)
                end
            end
        end
        if #items_no_rare > 1 then
            for i=#items_no_rare, 1, -1 do
                if items_no_rare[i] and tonumber(items_no_rare[i].item_id) == tonumber(remove_item_id) then
                    table.remove(items_no_rare, i)
                end
            end
        end
        if #items_in_chest > 1 then
            for i=#items_in_chest, 1, -1 do
                if items_in_chest[i] and tonumber(items_in_chest[i].item_id) == tonumber(remove_item_id) then
                    table.remove(items_in_chest, i)
                end
            end
        end
        print("Из сундука больше не выпадет", remove_item_id)
    end

    if #has_items_with_chance > 0 then
        for _, item in pairs(has_items_with_chance) do
            if RollPercentage(item.chance) then
                get_drop = item
                break
            end
        end
        if get_drop == nil then
            if #no_items_list <= 0 then
                return items_no_rare[RandomInt(1, #items_no_rare)]
            else
                repeat
                    local random = RandomInt(1, #no_items_list)
                    get_drop = no_items_list[random]
                until not HasDonateItem(id, get_drop.item_id)
            end
        end
    else
        repeat
            local random = RandomInt(1, #items_in_chest)
            get_drop = items_in_chest[random]
        until not HasDonateItem(id, get_drop.item_id)
    end
    return get_drop
end

function shop:IsChestOpened(player_id, chest_id)
    local player_table = CustomNetTables:GetTableValue('sub_data', tostring(player_id))
    local chest_opened_table = {}
    for k, v in pairs(player_table.chest_opened) do
        chest_opened_table[tostring(v)] = true
    end
    if chest_opened_table[tostring(chest_id)] then
        return true
    end
    return false
end

function shop:GiveArcanaChestForPlayer(player_id)
    local player_table = CustomNetTables:GetTableValue('sub_data', tostring(player_id))
    local server_data = CustomNetTables:GetTableValue('server_data', tostring(player_id))
    if not server_data or not player_table then return -1 end
    local game_count = server_data.total_games
    if player_table and player_table.subscribed == 1 and not HasDonateItem(player_id, 100000) then
        local player_items_table = {}
        if player_table.items_ids then
            for k, v in pairs(player_table.items_ids) do
                table.insert(player_items_table, v)
            end
        end
        table.insert(player_items_table, 100000)
        player_table.items_ids = player_items_table
        CustomNetTables:SetTableValue('sub_data', tostring(player_id), player_table)
    end
    local result = -1
    if not shop:IsChestOpened(player_id, 2) then
        result = 1
        if not HasDonateItem(player_id, 100000) then 
            result = 0
            if game_count <= 5 then
                result = -1
            end
        end
    end
    return result
end

function shop:IsChest(id)
    for chest_id,chest_data in pairs(DOTA1X6_CHESTS_INFO) do
        if chest_data.chest_item_id then
            if chest_data.chest_item_id == id then
                return chest_id
            end
        end
    end
    return false
end

function shop:send_courier_name(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    local text = data.text
    local player =	PlayerResource:GetPlayer(id)
    if not player then return end 
    local player_table = players[id]
    if not player_table then return end
    local player_table = CustomNetTables:GetTableValue('sub_data', tostring(id))
    player_table.pet_overhead_name = text
    CustomNetTables:SetTableValue('sub_data', tostring(id), player_table)
end

function shop:GetEffectData(effect_type, effect_id)
    if not effect_type or not effect_id then return end
    if _G.CustomEffectsListPFX and _G.CustomEffectsListPFX[effect_type] then
        return _G.CustomEffectsListPFX[effect_type][tonumber(effect_id)]
    end
end

function shop:GetCurrentEffectData(player_id, effect_type)
    local sub_data = CustomNetTables:GetTableValue('sub_data', tostring(player_id))
    if not sub_data or not sub_data.selected_effects then return end
    local effect_id = sub_data.selected_effects[effect_type]
    if not effect_id or tonumber(effect_id) == 0 then return end
    if not shop:IsCustomEffectItem(effect_type, effect_id, player_id) then return end
    return shop:GetEffectData(effect_type, effect_id)
end