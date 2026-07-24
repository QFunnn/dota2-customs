--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function WODAGameMode:ExecuteOrderFilter(filterTable)
	-- cache commonly used values
	local unit
	if filterTable.units and filterTable.units["0"] then
		unit = EntIndexToHScript(filterTable.units["0"])
	end
    if not unit then return true end

	local order = filterTable.order_type
	local entindex_ability = filterTable.entindex_ability or filterTable["entindex_ability"]
	local ability = (entindex_ability and entindex_ability ~= 0) and EntIndexToHScript(entindex_ability) or nil
	local target = (filterTable.entindex_target and filterTable.entindex_target ~= 0) and EntIndexToHScript(filterTable.entindex_target) or nil

	-- helpers
	local function isCastOrder(ot)
		return ot == DOTA_UNIT_ORDER_CAST_POSITION
			or ot == DOTA_UNIT_ORDER_CAST_TARGET
			or ot == DOTA_UNIT_ORDER_CAST_TARGET_TREE
			or ot == DOTA_UNIT_ORDER_CAST_NO_TARGET
	end

	local function abilityName(a)
		return a and a.GetAbilityName and a:GetAbilityName() or nil
	end

	local function targetHas(mod)
		return target and target.HasModifier and target:HasModifier(mod)
	end

	local function denyWithMessageIfSameItem(modifierName, itemName)
		if isCastOrder(order) and targetHas(modifierName) and abilityName(ability) == itemName then
			local player = PlayerResource:GetPlayer(ability:GetCaster():GetPlayerOwnerID())
			if player then
				CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", { message = "#dota_hud_error_cant_cast_twice" })
			end
			return true
		end
		return false
	end

    if unit then
        if (order == DOTA_UNIT_ORDER_PICKUP_ITEM or order == DOTA_UNIT_ORDER_ATTACK_TARGET ) and filterTable.queue == 0 then
            local item = target
            if item and (not item:IsNPC() and not item:IsBaseNPC()) and item:GetClassname() == "dota_item_drop" then
                local pickedItem = item:GetContainedItem()
                if not pickedItem then return true end
                if (pickedItem:GetPurchaser() and pickedItem:GetPurchaser():GetTeamNumber() ~= unit:GetTeamNumber()) then
                    return false
                end
            end
        end
    end

	-- Pangolier Rolling Thunder: разрешаем только движение/атаку/подбор
	if unit and unit:HasModifier("modifier_pangolier_gyroshell_custom") then
		if unit:HasModifier("modifier_wind_waker") then return true end

		local validMoveOrders = {
			[DOTA_UNIT_ORDER_ATTACK_TARGET] = true,
			[DOTA_UNIT_ORDER_MOVE_TO_TARGET] = true,
			[DOTA_UNIT_ORDER_MOVE_TO_POSITION] = true,
			[DOTA_UNIT_ORDER_ATTACK_MOVE] = true,
			[DOTA_UNIT_ORDER_PICKUP_ITEM] = true,
			[DOTA_UNIT_ORDER_PICKUP_RUNE] = true,
			[DOTA_UNIT_ORDER_MOVE_TO_DIRECTION] = true,
		}

		if validMoveOrders[order] then
			local mod = unit:FindModifierByName("modifier_pangolier_gyroshell_custom")
			if mod then
				mod:OnOrderCustom(Vector(filterTable.position_x, filterTable.position_y, filterTable.position_z), target)
			end
			if order == DOTA_UNIT_ORDER_PICKUP_RUNE then
				return true
			end
			return false
		end
	end

    local orders_list_func =
    {
        "modifier_aghanim_ray",
        "modifier_roshan_bash_custom_active",
        "modifier_roshan_bash_custom_active_cast",
        "modifier_abaddon_jousting_charge",
        "modifier_abaddon_jousting_cast",
        "modifier_custom_void_dissimilate",
        "modifier_phoenix_sun_ray_custom_caster_dummy",
        "modifier_pangolier_rollup_custom",
        "modifier_monkey_king_tree_dance_custom",
        "modifier_aghanim_ray",
        "modifier_keeper_of_the_light_obscure_motion",
        "modifier_dawnbreaker_fire_wreath_custom",
    }
    for _, mod_order in pairs(orders_list_func) do
        local mod_order_handle = unit:FindModifierByName(mod_order)
        if mod_order_handle and mod_order_handle.OnOrder then
            mod_order_handle:OnOrder({unit = unit, new_pos = Vector(filterTable.position_x, filterTable.position_y, filterTable.position_z), target = target, order_type = order})
        end
    end

	-- Варлок: потребление книги как активка без стандартного consume
	if order == DOTA_UNIT_ORDER_CONSUME_ITEM and unit and unit:GetUnitName() == "npc_dota_hero_warlock" then
		if ability and abilityName(ability) == "item_warlock_book_custom" then
			ability:OnSpellStart()
			return false
		end
	end

	-- Iron Talon не работает на элитных/древних/особых крипах
	if isCastOrder(order) and unit and target and target.GetUnitName then
		if (target:HasModifier("modifier_wodacreepchampion")
			or target:HasModifier("modifier_wodacreepchampionred")
			or target:HasModifier("modifier_wodafrog")
			or target:HasModifier("modifier_wodapig")
			or target:IsAncient())
		then
			if ability and abilityName(ability) == "item_iron_talon" then
				return false
			end
		end
	end

	-- Нельзя кастовать одинаковые «луны/томы/сыр» повторно на том же таргете
	do
		local rules = {
			{ mod = "modifier_item_moon_aghanim_buff",              item = "item_moon_aghanim" },
			{ mod = "modifier_item_moon_kaya_buff",                 item = "item_moon_kaya" },
			{ mod = "modifier_item_tome_of_aghanim_custom_consume", item = "item_tome_of_aghanim_custom" },
			{ mod = "modifier_item_royale_with_cheese",             item = "item_royale_with_cheese" },
			{ mod = "modifier_item_moon_yasha_buff",                item = "item_moon_yasha" },
			{ mod = "modifier_item_moon_sange_buff",                item = "item_moon_sange" },
		}
		for _, r in ipairs(rules) do
			if denyWithMessageIfSameItem(r.mod, r.item) then
				return false
			end
		end
	end

	-- Medusa 20 талант: запрещаем выключать щит если не кастабельно
	if unit and unit:HasModifier("modifier_medusa_20") and unit:HasModifier("modifier_medusa_mana_shield_custom_active") then
		if order == DOTA_UNIT_ORDER_CAST_TOGGLE then
			if ability and abilityName(ability) == "medusa_mana_shield_custom" and not ability:IsFullyCastable() then
				return false
			end
		end
	end

	-- Duel: запрет на стоп/холд/континью
	if unit and unit:HasModifier("modifier_legion_commander_duel_custom") then
		if order == DOTA_UNIT_ORDER_STOP or order == DOTA_UNIT_ORDER_CONTINUE or order == DOTA_UNIT_ORDER_HOLD_POSITION then
			return false
		end
	end

	-- Wisp: вместо pickup_rune — двигаться к руне
	if unit and unit:HasModifier("modifier_wodawisp") and order == DOTA_UNIT_ORDER_PICKUP_RUNE then
		if target then
			local p = target:GetAbsOrigin()
			filterTable.position_x, filterTable.position_y, filterTable.position_z = p.x, p.y, p.z
			filterTable.order_type = DOTA_UNIT_ORDER_MOVE_TO_POSITION
			return true
		else
			return false
		end
	end

	-- Anti-Mage 7: разрешаем только особые способности; предметы запрещены
	if unit and unit:HasModifier("modifier_antimage_7") and isCastOrder(order) then
		if ability then
			if WODAGameMode.antimage_abilities[abilityName(ability)] then
				return true
			end
			if ability:IsItem() then
				return false
			end
		end
	end

    -- Faceless void 15: разрешаем только особые способности; предметы запрещены
	if unit and unit:HasModifier("modifier_faceless_void_15") and isCastOrder(order) then
		if ability then
			if WODAGameMode.antimage_abilities[abilityName(ability)] then
				return true
			end
			if ability:IsItem() then
				return false
			end
		end
	end

	-- Relax: разрешаем только whitelisted умения
	if unit and unit:HasModifier("modifier_wodarelax") and isCastOrder(order) then
		if ability and WODAGameMode.relax_abilities[abilityName(ability)] then
			-- ok
		else
			return false
		end
	end

	-- Relax invul: касты запрещены
	if unit and unit:HasModifier("modifier_wodarelax_invul") and isCastOrder(order) then
		return false
	end

	-- Ограничения на «мешок золота» БХ — только 2 способности
	if unit and target and isCastOrder(order) and target.GetUnitName and target:GetUnitName() == "npc_dota_bounty_hunter_gold_bag" then
		if not ability then return true end  -- ранее было просто return; корректнее пропустить
		local an = abilityName(ability)
		if an ~= "bounty_hunter_shuriken_toss_custom" and an ~= "bounty_hunter_track_custom" then
			return false
		end
	end

	-- Запрет каста на бочках
	if unit and target and isCastOrder(order) and target.GetUnitName then
		local name = target:GetUnitName()
		if name == "npc_dota_creature_barrel" or name == "small_barrel" or name == "small_barrel_side" or name == "big_barrel" then
			return false
		end
	end

	-- Мёртвый герой не покупает книги
	if unit and not unit:IsAlive() and order == DOTA_UNIT_ORDER_PURCHASE_ITEM then
		local books = {
			item_talant_book = true,
			item_exp_book    = true,
			item_book_str    = true,
			item_book_agi    = true,
			item_book_int    = true,
		}
		if books[filterTable.shop_item_name] then
			local player = PlayerResource:GetPlayer(unit:GetPlayerOwnerID())
			if player then
				CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", { message = "#deathbook" })
			end
			return false
		end
	end

	-- Векторное наведение
	if not ability or not ability.GetBehaviorInt then return true end
	local behavior = ability:GetBehaviorInt()
	if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING) ~= 0 or abilityName(ability) == "marci_companion_run_custom" then
		-- вторая точка
		if order == DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION then
			ability.vectorTargetPosition2 = Vector(filterTable.position_x, filterTable.position_y, 0)
		end

		-- клик по позиции (кроме особого случая мёрты)
		if order == DOTA_UNIT_ORDER_CAST_POSITION and abilityName(ability) ~= "muerta_dead_shot_custom" then
			ability.vectorTargetPosition = Vector(filterTable.position_x, filterTable.position_y, 0)
			local p1 = ability.vectorTargetPosition
			local p2 = ability.vectorTargetPosition2
			local dir = ((p2 or p1) - p1):Normalized()
			if p1 == p2 then
				dir = (p1 - unit:GetAbsOrigin()):Normalized()
			end
			dir = Vector(dir.x, dir.y, 0)
			ability.vectorTargetDirection = dir

			local function OverrideSpellStart(self, position, direction)
				self:OnVectorCastStart(position, direction)
			end
			ability.OnSpellStart = function(self) return OverrideSpellStart(self, p1, dir) end
		end
        
		-- клик по цели/дереву для Muerta/Marci
		if (order == DOTA_UNIT_ORDER_CAST_TARGET or order == DOTA_UNIT_ORDER_CAST_TARGET_TREE)
			and (abilityName(ability) == "muerta_dead_shot_custom" or abilityName(ability) == "marci_companion_run_custom") then

			ability.vectorTargetPosition = Vector(filterTable.position_x, filterTable.position_y, 0)

			local pos = Vector(filterTable.position_x, filterTable.position_y, 0)
			if filterTable.entindex_target and EntIndexToHScript(filterTable.entindex_target) then
				pos = EntIndexToHScript(filterTable.entindex_target):GetAbsOrigin()
			end
			ability.vectorTargetPoisitioncheck = pos

			local p1 = ability.vectorTargetPosition
			local p2 = ability.vectorTargetPosition2
			local dir = ((p2 or p1) - p1):Normalized()
			if p1 == p2 then
				dir = (p1 - unit:GetAbsOrigin()):Normalized()
			end
			dir = Vector(dir.x, dir.y, 0)
			ability.vectorTargetDirection = dir

			local function OverrideSpellStart(self, position, direction)
				self:OnVectorCastStart(position, direction)
			end
			ability.OnSpellStart = function(self) return OverrideSpellStart(self, p1, dir) end
		end
	end

	return true
end

function WODAGameMode:OnRuneActivated(keys)
	local rune = keys.rune
	if rune == DOTA_RUNE_WATER then
		WodaTalents:AddPoint(keys.PlayerID,1)
		local hero = PlayerResource:GetSelectedHeroEntity(keys.PlayerID)
		if hero then
			local health = (hero:GetMaxHealth() / 100 * 20) - 40
			hero:Heal(health, nil)
			SendOverheadEventMessage(hero, OVERHEAD_ALERT_HEAL, hero, health, nil)
			local mana = (hero:GetMaxMana() / 100 * 20) - 80
			hero:GiveMana(mana)
			SendOverheadEventMessage(hero, OVERHEAD_ALERT_MANA_ADD, hero, mana, nil)
		end
	end
end

function WODAGameMode:BountyRunePickupFilter(params)
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(params.player_id_const), "delete_bounty", {})
	local arena = arena_system:GetCurrentArena()
	local golds = {75,100,125,150,175,200}
	params["gold_bounty"] = golds[arena] 
	return true
end

function WODAGameMode:DamageFilter(damageTable)
	if damageTable.entindex_attacker_const == nil then return true end
	local hAttacker = EntIndexToHScript(damageTable.entindex_attacker_const)
	local hVictim = EntIndexToHScript(damageTable.entindex_victim_const)
    local hAbility = damageTable.entindex_inflictor_const and EntIndexToHScript(damageTable.entindex_inflictor_const) or nil
	if damageTable.entindex_inflictor_const ~= nil then
		if hAbility and hAbility.GetAbilityName and "item_blade_mail" == hAbility:GetAbilityName() then
			damageTable.damage = math.min(damageTable.damage, 1000)
		end
		if hAbility and hAbility.GetAbilityName and "item_madness_blade_mail" == hAbility:GetAbilityName() then
			damageTable.damage = math.min(damageTable.damage, 1000)
		end
		if hAbility and hAbility.GetAbilityName and ("item_dagon" == hAbility:GetAbilityName() or "item_dagon_2" == hAbility:GetAbilityName() or "item_dagon_3" == hAbility:GetAbilityName() or "item_dagon_4" == hAbility:GetAbilityName() or "item_dagon_5" == hAbility:GetAbilityName()) then
            if not IsInToolsMode() then
                if GetMapName() == "overthrow" and (math.floor(math.floor(GameRules:GetDOTATime(false, false))/60)) < 10 then
                    damageTable.damage = 0
                end
            end
		end
	end
    if hAttacker and ((hAttacker:IsHero() or hAttacker:GetUnitName() == "npc_dota_lone_druid_bear_custom") or GetMapName() == "arena") then
        if hVictim and ((hVictim:IsHero() or hVictim:GetUnitName() == "npc_dota_lone_druid_bear_custom") or GetMapName() == "arena") then
            if hVictim ~= hAttacker then
                damage_system:UpdatePlayerDamage(hAttacker:GetPlayerOwnerID(), hVictim:GetPlayerOwnerID(), damageTable.damage, damageTable.damagetype_const)
            end
        end
    end
    if hAttacker and hAttacker:HasModifier("modifier_earthshaker_enchant_totem_custom") and not hAbility then
        return false
    end
	return true
end

function WODAGameMode:ModifierGainedFilter(params)
    local hHero = params.entindex_parent_const and EntIndexToHScript(params.entindex_parent_const)
    local caster = params.entindex_caster_const and EntIndexToHScript(params.entindex_caster_const)
    if params and params.name_const and params.name_const == "modifier_item_solar_crest_armor_addition" then
        if hHero then
            local hModifier = hHero:FindModifierByName("modifier_item_solar_crest_armor_addition")
            if hModifier and not hModifier:IsNull() then
                local ab = hModifier:GetAbility()
                local dur = hModifier:GetRemainingTime()
                hHero:RemoveModifierByName("modifier_item_solar_crest_armor_addition")
                hHero:AddNewModifier(hHero, ab, "modifier_item_solar_crest_armor_addition_custom", {duration = dur})
            end
        end
    end
    return true
end

function WODAGameMode:OnPlayerChat(data)
	local player_id = data.playerid
	local player = PlayerResource:GetPlayer(data.playerid)
	local text = data.text
    local hero = PlayerResource:GetSelectedHeroEntity(player_id)
    if not IsInToolsMode() then return end
    if text == "tp" then
        hero:AddNewModifier(hero, nil, "modifier_teleport_fx_client", {duration = 3})
    end
    if text == "pve" then
        hero:AddNewModifier(hero, nil, "modifier_pve_test_woda", {})
    end
    if text == "die" then
        ApplyDamage({attacker = PlayerResource:GetSelectedHeroEntity(0), victim = PlayerResource:GetSelectedHeroEntity(0), damage = 999999, damage_type = DAMAGE_TYPE_PURE})
        ApplyDamage({attacker = PlayerResource:GetSelectedHeroEntity(1), victim = PlayerResource:GetSelectedHeroEntity(1), damage = 999999, damage_type = DAMAGE_TYPE_PURE})
    end
    if text == "11" then
        local fillers = FindUnitsInRadius(2, Vector(0,0,0), nil, -1, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
        for _,filler in pairs(fillers) do 
            if filler:GetUnitName() == "npc_filler_woda" then
                if filler.modifier_capture then
                    filler.modifier_capture:UpdateParticleForPlayer(player_id)
                end
            end
        end
    end
    if text == "aoe" then
        local out_gold = hero:ModifyGold(100, false, 0)
        print("out_gold", out_gold)
        SendOverheadEventMessage(hero, 0, hero, out_gold, nil)
    end

    if text == "test" then
        local mods = hero:FindAllModifiers()
        for _, mod in pairs(mods) do
            for i=1, 10000 do
                mod:SetStackCount(i)
                print(mod:GetStackCount(), mod:GetName())
            end
        end
    end

    if text == "declr" then
        for _, mod in pairs(hero:FindAllModifiers()) do
            print("======================================")     
            print(mod:GetName())   
            local tables = {}
            for i=0, 400 do
                if mod:HasFunction(i) then
                    table.insert(tables, i)
                end
            end
            print(table.concat(tables, ", "))
            print("======================================")      
        end
    end

    if text == "state" then
        local states_info = 
        {
            ["0"] = "MODIFIER_STATE_ROOTED",
            ["1"] = "MODIFIER_STATE_DISARMED",
            ["2"] = "MODIFIER_STATE_ATTACK_IMMUNE",
            ["3"] = "MODIFIER_STATE_SILENCED",
            ["4"] = "MODIFIER_STATE_MUTED",
            ["5"] = "MODIFIER_STATE_STUNNED",
            ["6"] = "MODIFIER_STATE_HEXED",
            ["7"] = "MODIFIER_STATE_INVISIBLE",
            ["8"] = "MODIFIER_STATE_INVULNERABLE",
            ["9"] = "MODIFIER_STATE_MAGIC_IMMUNE",
            ["10"] = "MODIFIER_STATE_PROVIDES_VISION",
            ["11"] = "MODIFIER_STATE_NIGHTMARED",
            ["12"] = "MODIFIER_STATE_BLOCK_DISABLED",
            ["13"] = "MODIFIER_STATE_EVADE_DISABLED",
            ["14"] = "MODIFIER_STATE_UNSELECTABLE",
            ["15"] = "MODIFIER_STATE_CANNOT_TARGET_ENEMIES",
            ["16"] = "MODIFIER_STATE_CANNOT_TARGET_BUILDINGS",
            ["17"] = "MODIFIER_STATE_CANNOT_MISS",
            ["18"] = "MODIFIER_STATE_SPECIALLY_DENIABLE",
            ["19"] = "MODIFIER_STATE_FROZEN",
            ["20"] = "MODIFIER_STATE_COMMAND_RESTRICTED",
            ["21"] = "MODIFIER_STATE_NOT_ON_MINIMAP",
            ["22"] = "MODIFIER_STATE_LOW_ATTACK_PRIORITY",
            ["23"] = "MODIFIER_STATE_NO_HEALTH_BAR",
            ["24"] = "MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES",
            ["25"] = "MODIFIER_STATE_NO_HEALTH_BAR_FOR_OTHER_PLAYERS",
            ["26"] = "MODIFIER_STATE_FLYING",
            ["27"] = "MODIFIER_STATE_NO_UNIT_COLLISION",
            ["28"] = "MODIFIER_STATE_NO_TEAM_MOVE_TO",
            ["29"] = "MODIFIER_STATE_NO_TEAM_SELECT",
            ["30"] = "MODIFIER_STATE_PASSIVES_DISABLED",
            ["31"] = "MODIFIER_STATE_DOMINATED",
            ["32"] = "MODIFIER_STATE_BLIND",
            ["33"] = "MODIFIER_STATE_OUT_OF_GAME",
            ["34"] = "MODIFIER_STATE_FAKE_ALLY",
            ["35"] = "MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY",
            ["36"] = "MODIFIER_STATE_TRUESIGHT_IMMUNE",
            ["37"] = "MODIFIER_STATE_UNTARGETABLE",
            ["38"] = "MODIFIER_STATE_UNTARGETABLE_ALLIED",
            ["39"] = "MODIFIER_STATE_UNTARGETABLE_ENEMY",
            ["40"] = "MODIFIER_STATE_UNTARGETABLE_SELF",
            ["41"] = "MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS",
            ["42"] = "MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES",
            ["43"] = "MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES",
            ["44"] = "MODIFIER_STATE_UNSLOWABLE",
            ["45"] = "MODIFIER_STATE_TETHERED",
            ["46"] = "MODIFIER_STATE_IGNORING_STOP_ORDERS",
            ["47"] = "MODIFIER_STATE_FEARED",
            ["48"] = "MODIFIER_STATE_TAUNTED",
            ["49"] = "MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED",
            ["50"] = "MODIFIER_STATE_FORCED_FLYING_VISION",
            ["51"] = "MODIFIER_STATE_ATTACK_ALLIES",
            ["52"] = "MODIFIER_STATE_ALLOW_PATHING_THROUGH_CLIFFS",
            ["53"] = "MODIFIER_STATE_ALLOW_PATHING_THROUGH_FISSURE",
            ["54"] = "MODIFIER_STATE_SPECIALLY_UNDENIABLE",
            ["55"] = "MODIFIER_STATE_ALLOW_PATHING_THROUGH_OBSTRUCTIONS",
            ["56"] = "MODIFIER_STATE_DEBUFF_IMMUNE",
            ["57"] = "MODIFIER_STATE_NO_INVISIBILITY_VISUALS",
            ["58"] = "MODIFIER_STATE_ALLOW_PATHING_THROUGH_BASE_BLOCKER",
            ["59"] = "MODIFIER_STATE_IGNORING_MOVE_ORDERS",
            ["60"] = "MODIFIER_STATE_ATTACKS_ARE_MELEE",
            ["61"] = "MODIFIER_STATE_CAN_USE_BACKPACK_ITEMS",
            ["62"] = "MODIFIER_STATE_CASTS_IGNORE_CHANNELING",
            ["63"] = "MODIFIER_STATE_ATTACKS_DONT_REVEAL",
            ["64"] = "MODIFIER_STATE_LAST",
        }
        for _, mod in pairs(hero:FindAllModifiers()) do
            print("======================================")     
            print(mod:GetName())   
            local tables = {}
            mod:CheckStateToTable(tables)
            for state_name, mod_table in pairs(tables) do
                print(states_info[tostring(state_name)])
            end
            print("======================================")      
        end
    end
    if text == "imba" then
        WodaTalents:AddPointTalent(hero:GetPlayerID(),150)
    end
    if text == "neutral" then
        neutrals_reward:SpawnRandomNeutrals(5)
    end
    if text == "mods" then
        local illusions = FindUnitsInRadius( hero:GetTeamNumber(), hero:GetOrigin(), nil, 500, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
        for _, unit in pairs(illusions) do
            print(unit:GetName())
            print(unit:GetModelName())
            print("----------------------------")
            for ___, mod in pairs(unit:FindAllModifiers()) do
                print(mod:GetName())
            end
            print("----------------------------")
        end
    end
    if text == "abilities" then
        for i=0,24 do
            local ability = hero:GetAbilityByIndex(i)
            if ability then
                print(ability:GetAbilityName())
            end
        end
    end
    if text == "buff" then
        hero:RemoveModifierByName("modifier_wodaduel2")
        hero:AddNewModifier(hero, nil, "modifier_wodaduel2", {enemy=hero:entindex()})
    end
    if text == "server" then
        player_system:SendDataToServer()
    end
    if text == "win" then
        arena_system:CloseAndEndGameOverthrow(2)
    end
    if text == "win1" then
        arena_system:CloseAndEndGame()
    end
    if text == "111" then
        hero:ResetCooldown(false)
    end
    if text == "day" then
        SetCustomTimeOfDay(0.5)
    end
    if text == "night" then
        SetCustomTimeOfDay(0.25)
    end
end