--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if neutrals_reward == nil then
    neutrals_reward = class({})
    neutrals_reward.RewardForPlayer = {}
    neutrals_reward.RewardCountForPlayer = {}
    neutrals_reward.CurrentArenaRewards = 1
    neutrals_reward.timer = nil
    neutrals_reward.ITEMS_LIST = LoadKeyValues("scripts/npc/npc_neutral_items_custom.txt")["neutral_tiers"]
    neutrals_reward.NEUTRALS_COST =  -- Тут теперь полная стоимость нейтралок ( она будет делится на 2)
    {
        [1] = 350,
        [2] = 700,
        [3] = 1050,
        [4] = 1400,
        [5] = 1750,
        [6] = 2100,
    }
    neutrals_reward.GET_ITEMS_TIERS = {}
    BASE_GOLD = 350
    BASE_EXP = 560
    BASE_GOLD_ARENA = 2450
end

function neutrals_reward:SetItemTiers()
    for i=1,6 do
        local neutral_list = neutrals_reward.ITEMS_LIST
        local current_random = neutral_list[tostring(i)]["items"]
        local enhancements = neutral_list[tostring(i)]["enhancements"]["global"]
        for name, level in pairs(current_random) do
            neutrals_reward.GET_ITEMS_TIERS[name.."_level_"..level] = i
        end
        for name, level in pairs(enhancements) do
            neutrals_reward.GET_ITEMS_TIERS[name.."_level_"..level] = i
        end
    end
    neutrals_reward.GET_ITEMS_TIERS["item_divine_regalia_broken_level_1"] = 5
end

function neutrals_reward:GetNeutralTier(item_name, level)
    if neutrals_reward.GET_ITEMS_TIERS[item_name.."_level_"..level] then
        return neutrals_reward.GET_ITEMS_TIERS[item_name.."_level_"..level]
    end
    return nil
end

function neutrals_reward:RegisterRerollCount(id)
    local reroll_count = 3
    --if player_system:HasSubscribePlus(id) then
    --    reroll_count = 3
    --end
    if IsInToolsMode() then
        reroll_count = 99
    end
    if GetMapName() == "arena" then
        reroll_count = reroll_count + player_system:GetArenaRuneBonusReroll(id)
    end
    neutrals_reward.RewardCountForPlayer[id] = reroll_count
end

function neutrals_reward:CreateNeutralList(tier)
    local random_items_list = {}
    local neutral_list = neutrals_reward.ITEMS_LIST
    if tier > 6 then
        for i=1,6 do
            local current_random = neutral_list[tostring(i)]["items"]
            local enhancements = neutral_list[tostring(i)]["enhancements"]["global"]
            for name, level in pairs(current_random) do
                table.insert(random_items_list, {
                    ["item_name"] = name,
                    ["item_level"] = level,
                })
            end
            for name, level in pairs(enhancements) do
                table.insert(random_items_list, {
                    ["item_name"] = name,
                    ["item_level"] = level,
                    ["item_enchant"] = true,
                })
            end
        end
    else
        local current_random = neutral_list[tostring(tier)]["items"]
        local enhancements = neutral_list[tostring(tier)]["enhancements"]["global"]
        for name, level in pairs(current_random) do
            table.insert(random_items_list, {
                ["item_name"] = name,
                ["item_level"] = level,
            })
        end
        for name, level in pairs(enhancements) do
            table.insert(random_items_list, {
                ["item_name"] = name,
                ["item_level"] = level,
                ["item_enchant"] = true,
            })
        end
    end
    return random_items_list
end

function neutrals_reward:SpawnRandomNeutrals(arena)
    neutrals_reward.CurrentArenaRewards = arena
    local event_names =
    {
        "event_woda_neutral_reward",
        "event_woda_timer_neutral_reward",
    }
    if GetMapName() == "arena" then
        event_names =
        {
            "event_woda_neutral_reward_arena",
            "event_woda_timer_neutral_reward_arena",
        }
    end
	local random_items_list = neutrals_reward:CreateNeutralList(arena)
	for i,player_info in pairs(PLAYERS) do
        if not player_system:IsLose(i) then
    		neutrals_reward.RewardForPlayer[i] = {}
    		local random_items_for_player = table.random_some(random_items_list, 4)
    		random_items_for_player[5] = BASE_GOLD * arena
            if arena > 6 then
                random_items_for_player[5] = BASE_GOLD_ARENA
            end
    		neutrals_reward.RewardForPlayer[i] = random_items_for_player
    		local player = PlayerResource:GetPlayer(i)
            if player then
                CustomGameEventManager:Send_ServerToPlayer(player, event_names[1], 
                {
                    reward_1 = neutrals_reward.RewardForPlayer[i][1], 
                    reward_2 = neutrals_reward.RewardForPlayer[i][2], 
                    reward_3 = neutrals_reward.RewardForPlayer[i][3], 
                    reward_4 = neutrals_reward.RewardForPlayer[i][4], 
                    reward_5 = neutrals_reward.RewardForPlayer[i][5], 
                    reroll = neutrals_reward.RewardCountForPlayer[i], 
                })
            end
        end
	end
    if neutrals_reward.timer then
        Timers:RemoveTimer(neutrals_reward.timer)
        neutrals_reward.timer = nil
    end
    if not neutrals_reward.timer then
        local time = 60
        CustomGameEventManager:Send_ServerToAllClients(event_names[2], {time = time, max = 60})
        neutrals_reward.timer = Timers:CreateTimer(1, function()
            if neutrals_reward.timer == nil then return end
            time = time - 1
            CustomGameEventManager:Send_ServerToAllClients(event_names[2], {time = time, max = 60})
            if time <= 0 then
                self:GiveRewardsTimeOut()
                return
            end
            return 1
        end)
    end
end

function neutrals_reward:GiveRewardsTimeOut()
    neutrals_reward.timer = nil
    CustomGameEventManager:Send_ServerToAllClients("event_woda_close_neutral_reward", {})

    for id,player_info in pairs(PLAYERS) do
        if neutrals_reward.RewardForPlayer[id][5] ~= nil and not player_system:IsLose(id) then
            Timers:CreateTimer(FrameTime(), function()
                local out_gold = PlayerResource:ModifyGold(id, neutrals_reward.RewardForPlayer[id][5], true, DOTA_ModifyGold_GameTick)
                CreateEffectGold(player_info.hero,out_gold, player_info.hero)
                neutrals_reward.RewardForPlayer[id] = {}
            end)
        end
    end
end

function neutrals_reward:RerollNeutralReward(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    if neutrals_reward.RewardCountForPlayer[id] <= 0 then return end
    neutrals_reward.RewardCountForPlayer[id] = neutrals_reward.RewardCountForPlayer[id] - 1
    local old_table = neutrals_reward.RewardForPlayer[id]
    local random_items_list = neutrals_reward:CreateNeutralList(neutrals_reward.CurrentArenaRewards)
    for i=#random_items_list, 1, -1 do
        if random_items_list[i] then
            if random_items_list[i].item_name == old_table[1].item_name or random_items_list[i].item_name == old_table[2].item_name or random_items_list[i].item_name == old_table[3].item_name or random_items_list[i].item_name == old_table[4].item_name then
                table.remove(random_items_list, i)
            end
        end
    end
    local random_items_for_player = table.random_some(random_items_list, 4)
    random_items_for_player[5] = BASE_GOLD * neutrals_reward.CurrentArenaRewards
    if neutrals_reward.CurrentArenaRewards > 6 then
        random_items_for_player[5] = BASE_GOLD_ARENA
    end
    neutrals_reward.RewardForPlayer[id] = random_items_for_player
    local player = PlayerResource:GetPlayer(id)
    if player then
        local event_name = "event_woda_neutral_reward"
        if GetMapName() == "arena" then
            event_name = "event_woda_neutral_reward_arena"
        end
        CustomGameEventManager:Send_ServerToPlayer(player, event_name, 
        {
            reward_1 = neutrals_reward.RewardForPlayer[id][1], 
            reward_2 = neutrals_reward.RewardForPlayer[id][2], 
            reward_3 = neutrals_reward.RewardForPlayer[id][3], 
            reward_4 = neutrals_reward.RewardForPlayer[id][4], 
            reward_5 = neutrals_reward.RewardForPlayer[id][5], 
            reroll = neutrals_reward.RewardCountForPlayer[id]
        })
    end
end

function neutrals_reward:SelectNeutralReward(data)
	if data.PlayerID == nil then return end
	local id = data.PlayerID
	local choose = data.choose
	local hero = PlayerResource:GetSelectedHeroEntity(id)
    if neutrals_reward.RewardForPlayer[id][1] == nil then return end
    if neutrals_reward.RewardForPlayer[id][2] == nil then return end
    if neutrals_reward.RewardForPlayer[id][3] == nil then return end
    if neutrals_reward.RewardForPlayer[id][4] == nil then return end
    if neutrals_reward.RewardForPlayer[id][5] == nil then return end
	if choose <= 4 then
		local item_info = neutrals_reward.RewardForPlayer[id][choose]
		if hero and item_info then
            if item_info.item_enchant then
                local old_item = hero:GetItemInSlot(DOTA_ITEM_NEUTRAL_PASSIVE_SLOT)
                if old_item then
                    local item_tier = neutrals_reward:GetNeutralTier(old_item:GetAbilityName(), old_item:GetLevel())
                    if item_tier then
                        local items_cost = neutrals_reward.NEUTRALS_COST[tonumber(item_tier)]
                        local out_gold = hero:ModifyGold(items_cost / 2, false, DOTA_ModifyGold_SellItem)
                        CreateEffectGold(hero, out_gold, hero)
                    end
                    UTIL_Remove(old_item)
                end
            else
                local check_item_divine_regalia_broken = hero:GetItemInSlot(DOTA_ITEM_NEUTRAL_ACTIVE_SLOT)
                if check_item_divine_regalia_broken and check_item_divine_regalia_broken:GetAbilityName() == "item_divine_regalia_broken" then
                    hero.neutral_item_save = check_item_divine_regalia_broken
                end
                if hero.neutral_item_save and not hero.neutral_item_save:IsNull() then
                    local item_tier = neutrals_reward:GetNeutralTier(hero.neutral_item_save:GetAbilityName(), hero.neutral_item_save:GetLevel())
                    if item_tier then
                        local items_cost = neutrals_reward.NEUTRALS_COST[tonumber(item_tier)]
                        local out_gold = hero:ModifyGold(items_cost / 2, false, DOTA_ModifyGold_SellItem)
                        CreateEffectGold(hero, out_gold, hero)
                    end
                    local container = hero.neutral_item_save:GetContainer()
                    if container then
                        UTIL_Remove(container)
                    end
                    UTIL_Remove(hero.neutral_item_save)
                end
            end
            Timers:CreateTimer(0.1, function()
                local neutralItem = CreateItem(item_info.item_name, hero, hero)
                if neutralItem then
                    neutralItem:SetLevel(item_info.item_level)
                    neutralItem:SetDroppable(false)
        	        hero:AddItem(neutralItem)
                    if not item_info.item_enchant then
                        hero.neutral_item_save = neutralItem
                    end
                end
                local chaos_knight_fundamental_forging = hero:FindAbilityByName("chaos_knight_fundamental_forging")
                if chaos_knight_fundamental_forging and not item_info.item_enchant then
                    local get_last_neutral_item = hero:GetItemInSlot(18)
                    if get_last_neutral_item then
                        if get_last_neutral_item.modifier then
                            get_last_neutral_item.modifier:Destroy()
                        end
                        UTIL_Remove(get_last_neutral_item)
                    end
                    local item_tier = neutrals_reward:GetNeutralTier(item_info.item_name, item_info.item_level)
                    if item_tier then
                        neutrals_reward:GetChaosKnightRandomNeutralStone(hero, item_tier, neutralItem)
                    end
                    --neutrals_reward:GetChaosKnightRandomNeutralStone(hero, 5, neutralItem)
                end
            end)
		end
	elseif choose == 5 then
		if hero then
			local out_gold = PlayerResource:ModifyGold(data.PlayerID, neutrals_reward.RewardForPlayer[id][choose], true, DOTA_ModifyGold_GameTick)
            CreateEffectGold(hero,out_gold, hero)
		end
	end
    neutrals_reward.RewardForPlayer[id] = {}
end

function neutrals_reward:GetChaosKnightRandomNeutralStone(hero, item_tier, original_item)
    local random_items_list = {}
    local neutral_list = neutrals_reward.ITEMS_LIST
    local enhancements = neutral_list[tostring(item_tier)]["enhancements"]["global"]
    local old_item = hero:GetItemInSlot(DOTA_ITEM_NEUTRAL_PASSIVE_SLOT)
    local old_item_name = nil
    if old_item then
        old_item_name = old_item:GetAbilityName()
    end
    for name, level in pairs(enhancements) do
        if name ~= old_item_name then
            table.insert(random_items_list, {
                item_name = name,
                item_level = level,
                item_enchant = true,
            })
        end
    end
    if #random_items_list <= 0 then
        return
    end
    local item_info = random_items_list[RandomInt(1, #random_items_list)]
    local neutralItem = CreateItem(item_info.item_name, hero, hero)
    if neutralItem then
        neutralItem:SetLevel(item_info.item_level)
        neutralItem:SetDroppable(false)
        hero:AddItem(neutralItem)
        hero:SwapItems(neutralItem:GetItemSlot(), 18)
        if not hero:HasModifier(neutralItem:GetIntrinsicModifierName()) then
            neutralItem.modifier = hero:AddNewModifier(hero, neutralItem, neutralItem:GetIntrinsicModifierName(), {})
        end
        Timers:CreateTimer(0.1, function()
            if not IsValidCustom(neutralItem) then
                return
            end
            if not IsValidCustom(original_item) then
                if neutralItem.modifier then
                    neutralItem.modifier:Destroy()
                end
                UTIL_Remove(neutralItem)
                return
            end
            return 0.1
        end)
    end
end