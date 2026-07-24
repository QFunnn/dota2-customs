--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GameMode:HealingFilter( params )
    if params.heal >= 100000 then
        params.heal = math.min(params.heal, 100000)
    end
	return true
end

function GameMode:OnItemPickUp( params )
    local item = EntIndexToHScript( params.ItemEntityIndex )
    local owner
    if params.HeroEntityIndex then
        owner = EntIndexToHScript(params.HeroEntityIndex)
    elseif params.UnitEntityIndex then
        owner = EntIndexToHScript(params.UnitEntityIndex)
    end 
    if owner == nil then return end

    if params.itemname == "item_bag_of_gold" then
        local gold = 300
        if Rounds:GetCurrentRound() > 10 then
            gold = math.min(1000, 300 + (math.floor(Rounds:GetCurrentRound() / 10) * 100) )
        end
        if self:CheckLastPlace(owner:GetTeamNumber()) then
            gold = gold * 2
        end
        Players:ModifyPlayerGold(owner:GetPlayerOwnerID(), gold, true, true, true)
        UTIL_Remove( item )
    end 
end

function GameMode:CheckLastPlace(teamcheck)
    local dataList = Players:GetSortedByGoldActiveTeams(true)
    if #dataList >= 2 then
        if dataList[1] == teamcheck then
            return true
        elseif dataList[2] == teamcheck then
            return true
        end
    end
    return false
end

function GameMode:BountyRunePickupFilter( params )
    local hero = PlayerResource:GetSelectedHeroEntity(params.player_id_const)
    if hero then
        local ability = hero:FindAbilityByName("bounty_drop_custom")
        if ability and ability:GetLevel() > 0 then
            local multiplier = ability:GetSpecialValueFor("bounty_multiplier")
            local min_gold = ability:GetSpecialValueFor("bounty_min_gold")
            local max_gold = ability:GetSpecialValueFor("bounty_max_gold")
            local game_minute = math.floor(GameRules:GetDOTATime(false, false) / 60)
            params["gold_bounty"] = math.max(min_gold, math.min(game_minute * multiplier, max_gold))
        end
    end
    return true
end

-- function GameMode:AbilityTuningValueFilter(event)
--     local iAbility = event.entindex_ability_const

--     if iAbility ~= nil then
--         local hAbility = EntIndexToHScript(iAbility)
--         if hAbility and hAbility:GetAbilityName() == "silencer_glaives_of_wisdom_custom" then
--             print(event.value_name_const, event.value)
--         end
--     end

--     return true
-- end

function GameMode:ModifyGoldFilter(event)
    -- Disc-fix v5 (13.05.2026): full xpcall trap. ModifyGoldFilter вызывается из engine
    -- через свой внутренний xpcall, который ПОДАВЛЯЕТ stack trace -- наш override
    -- debug.traceback тут НЕ виден. Поэтому оборачиваем тело явно.
    local ok, err = xpcall(function()
        if event.gold > 0 and event.reason_const ~= DOTA_ModifyGold_SellItem then
            event.gold = math.floor(event.gold * GetGameSetting("MULT_GOLD"))
        end

        -- Затраты на покупку вещей и потери при смерти не учитываются в итоговый нетворс
        if event.reason_const == DOTA_ModifyGold_PurchaseConsumable or
            event.reason_const == DOTA_ModifyGold_PurchaseItem or
            event.reason_const == DOTA_ModifyGold_Death or
            event.reason_const == DOTA_ModifyGold_SellItem then
            return true
        end

        GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("GoldFilter"), function()
            Players:ModifyPlayerNetworth(event.player_id_const, event.gold)
        end, 0.05)

        return true
    end, function(e)
        -- На любом error выводим stack trace явно (engine xpcall его глотает).
        local stack = debug.traceback(tostring(e), 2)
        print("[HeroBuilder/Disc] !!! ModifyGoldFilter ERROR:", e)
        print(stack)
        if ErrorTracking and ErrorTracking.Collect then
            pcall(function() ErrorTracking.Collect(stack) end)
        end
        return stack
    end)
    if not ok then return true end -- безопасный fallback: пропускаем gold change
    return true
end

function GameMode:ModifyExperienceFilter(event)
    event.experience = event.experience * GetGameSetting("MULT_EXP")

    return true
end

function GameMode:OnItemPurchased(params)
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(params.PlayerID), "UpdateBetInput", {})
end

function GameMode:OnHeroLevelUp(params)
    local hHero = PlayerResource:GetSelectedHeroEntity(params.player_id)
    local nLevel = hHero:GetLevel()
    if params.level == nLevel then
        if nLevel > 25 then
            hHero:SetAbilityPoints(hHero:GetAbilityPoints() + 1)
        end
    end
end

function GameMode:OnPlayerUsedAbility(params)
    HeroBuilder:RefreshAbilityOrder(params.PlayerID)

    local AbilityName = params.abilityname
    local AbilityInfo = HIDDEN_TABLE[AbilityName]
    if AbilityInfo == nil then return end

    local CasterIndex = params.caster_entindex

    local hCaster = EntIndexToHScript(CasterIndex)
    if not hCaster or hCaster:IsNull() then return end

    Timers:CreateTimer(0, function()
        local MainAbility = hCaster:FindAbilityByName(AbilityName)
        local LinkedAbility = hCaster:FindAbilityByName(AbilityInfo.linked)

        if MainAbility and LinkedAbility and MainAbility:IsHidden() and LinkedAbility:IsHidden() and MainAbility._bCustomDisabled == nil then
            LinkedAbility:SetHidden(false)

            if AbilityInfo.modifier ~= nil and AbilityInfo.parent ~= true then
                Map:AddModifierToChecker(AbilityInfo.modifier, hCaster, hCaster, MainAbility)
            end
        end
    end)
end

function GameMode:ModifierGainedFilter(params)
    local modifier = params.name_const
    local hero = EntIndexToHScript(params.entindex_parent_const)
    if hero == nil then return end
    if modifier == nil then return end

    local iGlobalCaster = params.entindex_caster_const
    local iGlobalParent = params.entindex_parent_const
    local iGlobalAbility = params.entindex_ability_const
    if iGlobalCaster ~= nil and iGlobalParent ~= nil then
        local hGlobalCaster = EntIndexToHScript(iGlobalCaster)
        local hGlobalParent = EntIndexToHScript(iGlobalParent)
        if hGlobalCaster and hGlobalParent and not Players:IsUnitCanAttackOrCastOnThis(hGlobalCaster, hGlobalParent) then
            local Block = true
            if iGlobalAbility ~= nil then
                local hGlobalAbility = EntIndexToHScript(iGlobalAbility)
                if hGlobalAbility and not hGlobalAbility:IsNull() and GetAbilitySetting(hGlobalAbility:GetName(), "bWorkOnOtherArena") then
                    Block = false
                end
            end

            if Players:GetSecondaryUnitHeroPlayer(hGlobalParent) == hGlobalCaster then
                Block = false
            end

            if Block then
                return false
            end
        end
        -- if Players:IsSecondaryUnit(hGlobalParent) and iGlobalAbility ~= nil then
        --     local hGlobalAbility = EntIndexToHScript(iGlobalAbility)
        --     if hGlobalAbility and hGlobalAbility:GetName() == "crystal_maiden_brilliance_aura" then
        --         return false
        --     end
        -- end
        if iGlobalAbility ~= nil then
            local hGlobalAbility = EntIndexToHScript(iGlobalAbility)
            if hGlobalCaster and hGlobalParent and hGlobalAbility then
                local AbilityInfo = HIDDEN_TABLE[hGlobalAbility:GetAbilityName()]
                if AbilityInfo and hGlobalAbility and AbilityInfo.modifier ~= nil and AbilityInfo.modifier == modifier then
                    Map:AddModifierToChecker(AbilityInfo.modifier, hGlobalParent, hGlobalCaster, hGlobalAbility)
                end
            end
        end
    end

    if modifier == "modifier_tiny_craggy_exterior_debuff" and not hero:IsHero() then
        return false
    elseif modifier == "modifier_item_hydras_breath_poison" then
        -- Задача #46: Hydra's Breath не должна работать на Roshan/Nian.
        -- Блокируем сам debuff здесь чтобы НЕ было визуального эффекта яда
        -- и мерцания damage-чисел до того как DamageFilter обнулит урон.
        -- В damage_filter_util.lua оставлен дублирующий нулевой фильтр на
        -- случай если debuff всё же успеет проскочить (defense in depth).
        local name = hero.GetUnitName and hero:GetUnitName() or ""
        if name == "npc_dota_roshan" or name == "npc_dota_nian" then
            return false
        end
    elseif modifier == "modifier_muerta_pierce_the_veil" then
        -- Блокируем пассивный intrinsic-модификатор Pierce the Veil (возможность атаковать в госте).
        -- Разрешаем только когда мы сами накладываем его на время активной ульты (см. ниже).
        if hero._pierce_veil_intrinsic_bypass then
            return true
        end
        return false
    elseif modifier == "modifier_muerta_pierce_the_veil_buff" then
        -- Ульт активирован: синхронно возвращаем базовый модификатор (даёт возможность бить в госте)
        -- на длительность ульты из KV. По окончании оба истекут.
        local duration = 6
        if params.entindex_ability_const and params.entindex_ability_const ~= 0 then
            local ability = EntIndexToHScript(params.entindex_ability_const)
            if ability and not ability:IsNull() and ability.GetSpecialValueFor then
                local d = ability:GetSpecialValueFor("duration")
                if d and d > 0 then duration = d end
            end
        end
        hero._pierce_veil_intrinsic_bypass = true
        hero:AddNewModifier(hero, nil, "modifier_muerta_pierce_the_veil", {duration = duration})
        hero._pierce_veil_intrinsic_bypass = nil
    elseif (modifier == "modifier_knockback" or modifier == "modifier_spiritbreaker_greater_bash_knockback" or modifier == "modifier_spiritbreaker_greater_bash_stun" or modifier == "modifier_spirit_breaker_greater_bash_stun") and params.entindex_ability_const ~= nil then
        local ability = EntIndexToHScript(params.entindex_ability_const)
        if ability then
            local ability_name = ability:GetAbilityName()
            local caster = ability:GetCaster()
            local is_bara_bash = ability_name == "spirit_breaker_greater_bash"
                or (caster and not caster:IsNull() and caster:GetUnitName() == "npc_dota_hero_spirit_breaker")
            if is_bara_bash then
                if hero:HasModifier("modifier_minigames_pudge_shift")
                    or hero:HasModifier("modifier_riki_tricks_of_the_trade_custom") then
                    return false
                end
                if not hero:IsHero() and (modifier == "modifier_knockback" or modifier == "modifier_spiritbreaker_greater_bash_knockback") then
                    local duration = 1.2
                    if ability.GetSpecialValueFor then
                        local d = ability:GetSpecialValueFor("duration")
                        if d and d > 0 then duration = d end
                    end
                    hero:AddNewModifier(caster, ability, "modifier_stunned", {duration = duration})
                    return false
                end
            end
        end
    elseif modifier == "modifier_grimstroke_soul_chain" and params.entindex_ability_const ~= nil then
        local ability = EntIndexToHScript(params.entindex_ability_const)
        -- hero:AddNewModifier(ability:GetCaster(), ability, "modifier_disarmed", {duration = ability:GetSpecialValueFor("chain_duration")})
        local target_modifier = hero:FindModifierByName("modifier_grimstroke_soul_chain")
        if target_modifier and hero:IsHero() then
            local hCaster = target_modifier:GetCaster()
            local hAbility = target_modifier:GetAbility()
            local flDuration = target_modifier:GetRemainingTime()

            hero:AddNewModifier(hCaster, hAbility, "modifier_grimstroke_soul_chain_debuff_custom", {duration=flDuration})
        end
        if target_modifier and not hero:IsHero() then
            local hCaster = target_modifier:GetCaster()
            local hAbility = target_modifier:GetAbility()
            local flDuration = target_modifier:GetDuration()
            if hCaster and hAbility then
                hero:AddNewModifier(hCaster, hAbility, "modifier_grimstroke_soul_chain_creep", {duration = flDuration, primary = true})
                if target_modifier then
                    target_modifier:Destroy()
                end
            end
        end
    elseif modifier == "modifier_item_ultimate_scepter" or modifier == "modifier_item_ultimate_scepter_consumed" then
        HeroBuilder:AddScepterAbility(hero)
        HeroBuilder:AddScepterLinkAbilities(hero)
        HeroBuilder:RegisterScepterOwner(hero)
        EventDriver:Dispatch("Hero:ScepterReceived", {hero = hero})
    elseif modifier == "modifier_item_aghanims_shard" then
        HeroBuilder:AddShardLinkAbilities(hero)
        HeroBuilder:AddScepterShardAbility(params.entindex_parent_const)
    elseif modifier == "modifier_item_moon_shard_consumed" then
        local target = EntIndexToHScript(params.entindex_parent_const)
        if target then
            local target_modifier = target:FindModifierByName("modifier_item_moon_shard_consumed")
            if target_modifier then
                target:AddNewModifier(target, nil, "modifier_item_moon_shard_buff_custom", {})
                if target_modifier then
                    target_modifier:Destroy()
                end
            end
        end
    elseif modifier == "modifier_skywrath_mage_shard" then
        local target_modifier = hero:FindModifierByName("modifier_skywrath_mage_shard")
        if target_modifier and not target_modifier:IsNull() then
            hero:RemoveModifierByName("modifier_skywrath_mage_shard")
            hero:AddNewModifier(hero, nil, "modifier_skywrath_mage_shard_lua", {})
        end
    elseif modifier == "modifier_necrolyte_reapers_scythe" then
        local target = EntIndexToHScript(params.entindex_parent_const)
        local target_modifier = target:FindModifierByName("modifier_necrolyte_reapers_scythe")
        if target_modifier and not target:IsHero() then
            local hCaster = target_modifier:GetCaster()
            local hAbility = target_modifier:GetAbility()
            local flDuration = target_modifier:GetDuration()
            if hCaster and hAbility then
                target:RemoveModifierByName("modifier_necrolyte_reapers_scythe")
                target:AddNewModifier(hCaster, hAbility, "modifier_necrophos_scythe_creep", {duration = flDuration})
            end
        end
    elseif modifier == "modifier_lycan_summon_wolves_crit_maim" then
        local target = EntIndexToHScript(params.entindex_parent_const)
        if target then
            local modifier_lycan_summon_wolves_crit_maim_modifiers = target:FindAllModifiersByName("modifier_lycan_summon_wolves_crit_maim")
            local last_modifier = modifier_lycan_summon_wolves_crit_maim_modifiers[#modifier_lycan_summon_wolves_crit_maim_modifiers]
            for _, modifier in pairs (modifier_lycan_summon_wolves_crit_maim_modifiers) do
                if modifier ~= last_modifier then
                   modifier:Destroy()
                end
            end
        end
    elseif modifier == "modifier_bounty_hunter_track" then
        local target = EntIndexToHScript(params.entindex_parent_const)
        local target_modifier = target:FindModifierByName("modifier_bounty_hunter_track")
        if target_modifier and not target:IsHero() then
            local hCaster = target_modifier:GetCaster()
            local hAbility = target_modifier:GetAbility()
            local flDuration = target_modifier:GetDuration()
            if hCaster and hAbility then
                target:AddNewModifier(hCaster, hAbility, "modifier_bounty_hunter_track_creep", {duration = flDuration})
                if target_modifier then
                    target_modifier:Destroy()
                end
            end
        end
    elseif modifier == "modifier_faceless_void_time_walk" then
        if hero then
            local target_modifier = hero:FindModifierByName("modifier_faceless_void_time_walk")
            if target_modifier and not target_modifier:IsNull() then
                if hero:HasScepter() then
                    if target_modifier:GetAbility():GetAbilityName() == "faceless_void_time_walk" then
                        local faceless_void_time_lock_custom = hero:FindAbilityByName("faceless_void_time_lock_custom")
                        if faceless_void_time_lock_custom and faceless_void_time_lock_custom:GetLevel() > 0 then
                            hero:AddNewModifier(hero, faceless_void_time_lock_custom, "modifier_faceless_void_time_lock_custom_scepter", {})
                        end
                    end
                end
            end
        end
    elseif IsModifierChangesAttackCap(modifier) and params.entindex_parent_const then
        local target = EntIndexToHScript(params.entindex_parent_const)
    	if target then
    		HeroBuilder:RegisterAttackCapabilityChanged(target)
    	end
    elseif modifier == "modifier_warlock_rain_of_chaos_golem" and iGlobalCaster ~= nil then
        local caster = EntIndexToHScript(iGlobalCaster)
        if hero and caster and caster:GetUnitName() == "npc_dota_hero_warlock" and caster:GetHeroFacetID() == 1 then
            hero:AddNewModifier(caster, nil, "modifier_hero_unique_warlock_golem", {})
        end
    elseif modifier == "modifier_tusk_snowball_movement" then
        local unit = hero
        if unit then
            Timers:CreateTimer(0, function()
                if not unit or unit:IsNull() then return nil end
                if unit:HasModifier("modifier_tusk_snowball_movement") then
                    return 0.03
                end
                unit:Stop()
                return nil
            end)
        end
    end
    return true
end

function GameMode:DamageFilter(event)
    if event.entindex_attacker_const == nil then return true end
    local attacker = EntIndexToHScript(event.entindex_attacker_const)
    local target = EntIndexToHScript(event.entindex_victim_const)
    if not attacker or attacker:IsNull() or not target or target:IsNull() then return false end

    -- Защита от краша: если берсерк-крип получает летальный урон от цели которую сейчас атакует
    -- (Blade Mail reflect), откладываем смерть на следующий кадр чтобы не крашить С++ движок
    if event.damage > 0 and target:IsAlive() and not target._deferred_berserk_kill and target:HasModifier("modifier_creep_controll") then
        local modif = target:FindModifierByName("modifier_creep_controll")
        if modif and modif:GetStackCount() > 0 and event.damage >= target:GetHealth() and target:GetAttackTarget() == attacker then
            event.damage = target:GetHealth() - 1
            if event.damage < 0 then event.damage = 0 end
            local target_ref = target
            local attacker_ref = attacker
            Timers:CreateTimer(0, function()
                if target_ref and not target_ref:IsNull() and target_ref:IsAlive() then
                    target_ref._deferred_berserk_kill = true
                    ApplyDamage({
                        attacker = attacker_ref,
                        victim = target_ref,
                        damage = target_ref:GetMaxHealth(),
                        damage_type = DAMAGE_TYPE_PURE,
                        damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_BYPASSES_INVULNERABILITY,
                    })
                end
            end)
        end
    end

    event.damage = damage_filter_util:GetNewDamageFromAbilities(event, attacker, target)
    Players:OnDamageEvent(attacker, target, event)


    if target and (target:HasModifier("modifier_hero_refreshing") or (IsRealHero(target) and Players:PlayerArenaIs(target:GetPlayerOwnerID(), "MAIN"))) then
        if not IsCheatsEnabled() then
            return false
        end
    end
    
    -- Призванные юниты и иллюзии не получают урон на основной арене (MAIN)
    if target and (target:IsSummoned() or target:IsIllusion()) then
        local arena = Players:GetUnitArena(target)
        if arena == "MAIN" then
            return false
        end
    end
    
    if attacker and target and not Players:IsUnitCanAttackOrCastOnThis(attacker, target) then
        -- [NP3-4] Рефлект (Blade Mail и пр.) идёт обратно кастеру в другую арену и режется
        -- этим гейтом. У отражённого урона инфликтор — сам item_blade_mail / способность рефлекта;
        -- даём им bWorkOnOtherArena (abilities_settings) → существующий чек ниже их пропустит.
        if event.entindex_inflictor_const ~= nil then
            local Ability = EntIndexToHScript(event.entindex_inflictor_const)
            if Ability and not Ability:IsNull() and GetAbilitySetting(Ability:GetName(), "bWorkOnOtherArena") then
                return true
            end
        end

        return false
    end

    if attacker and attacker:GetUnitName() == "npc_dota_techies_land_mine" and target then
        local RealAttacker = GetRealUnit(attacker)
        if RealAttacker and IsRealHero(RealAttacker) then
            local Ability = RealAttacker:FindAbilityByName("techies_land_mines")
            if Ability then
                ApplyDamage({
                    victim = target,
                    attacker = RealAttacker,
                    damage = Ability:GetSpecialValueFor("damage") or 0,
                    damage_type = event.damagetype_const,
                    damage_flags = DOTA_DAMAGE_FLAG_NO_REFLECTION + DOTA_DAMAGE_FLAG_FORCE_SPELL_AMPLIFICATION,
                    ability = Ability,
                })

                return false
            end
        end
    end

    return true
end

function GameMode:OrderFilter(params)
    -- Disc-fix v5 (13.05.2026): обёртка xpcall. OrderFilter работает в engine xpcall'е
    -- который ПОДАВЛЯЕТ stack trace. Без этой обёртки "Script Runtime Error: error in
    -- error handling" не имеет stack -- невозможно найти точку краша при SELL_ITEM.
    local ok, result = xpcall(function()
        return GameMode:_OrderFilterImpl(params)
    end, function(e)
        local stack = debug.traceback(tostring(e), 2)
        print("[HeroBuilder/Disc] !!! OrderFilter ERROR:", e)
        print(stack)
        if ErrorTracking and ErrorTracking.Collect then
            pcall(function() ErrorTracking.Collect(stack) end)
        end
        return stack
    end)
    if not ok then return true end -- safe fallback при ошибке: разрешаем order, не блокируем игру
    -- result -- то что вернул _OrderFilterImpl (true/false для allow/block).
    if result == false then return false end
    return true
end

function GameMode:_OrderFilterImpl(params)
    local nPlayerID = params.issuer_player_id_const
    local unit
	if params.units and params.units["0"] then
		unit = EntIndexToHScript(params.units["0"])
	end
	local target = params.entindex_target ~= 0 and EntIndexToHScript(params.entindex_target) or nil
	local orderType = params["order_type"]
    if unit == nil then return true end
    if not unit:IsHero() then return true end
    if nPlayerID == nil then return true end
    if nPlayerID == -1 then return true end

    local item = params.entindex_ability ~= 0 and EntIndexToHScript(params.entindex_ability) or nil

    -- [NP-35] Eul (item_cyclone) нельзя кастовать НА СЕБЯ в зоне подготовки и во время телепорта
    -- на боевую арену. Гейт: раунд ещё НЕ начался для игрока (begined команды флипается в
    -- BeginTeamArena, ПОСЛЕ телепорта -> закрывает гонку, когда позиция уже не "MAIN") ИЛИ игрок
    -- на "MAIN". Каст по другим целям и перекладывание предмета (MOVE_ITEM) не трогаем.
    if item and not item:IsNull() and item:GetName() == "item_cyclone"
        and orderType == DOTA_UNIT_ORDER_CAST_TARGET
        and target ~= nil and target == unit then
        -- Разрешаем self-cast Eul ТОЛЬКО если бой идёт уже >1с И игрок не на "MAIN".
        -- Грейс-секунда после старта раунда закрывает спам приказов ровно в момент телепорта,
        -- когда begined только что стал true, а позиция уже сменилась с MAIN (узкое окно гонки).
        local allowEul = false
        local controller = Rounds.CurrentRoundInfo and Rounds.CurrentRoundInfo.controller
        local pInfo = Players:GetPlayer(nPlayerID)
        local td = (controller and pInfo and controller.TeamsData) and controller.TeamsData[pInfo.team] or nil
        if td and td.begined == true and td.start_time ~= nil
            and (GameRules:GetGameTime() - td.start_time) >= 0.25
            and Map:GetPositionArena(unit) ~= "MAIN" then
            allowEul = true
        end
        if not allowEul then
            local player = PlayerResource:GetPlayer(nPlayerID)
            if player then
                CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_eul_disabled_on_arena"})
            end
            return false
        end
    end

    -- if unit then
    --     for _, modif in ipairs(unit:FindAllModifiers()) do
    --         if modif.OnOrderFully then
    --             modif:OnOrderFully(params)
    --         end
    --     end
    -- end

    local NapalmModif = unit:FindModifierByName("modifier_ability_batrider_sticky_napalm_cast")
    if NapalmModif and NapalmModif.OnOrderCast then
        NapalmModif:OnOrderCast({
            unit = unit, 
            order_type = orderType,
            ability = item,
            new_pos = Vector(params.position_x, params.position_y, params.position_z)
        })
    end

    -- if orderType == DOTA_UNIT_ORDER_SELL_ITEM and item and not item:IsNull() then
    --     local OriginalCost = GetItemCost(item:GetName())
    --     local ItemCost = item:GetCost()
    --     print(ItemCost, OriginalCost)
    --     if ItemCost ~= OriginalCost then 
    --         local Diff = ItemCost - OriginalCost
    --         print(Diff)
    --         Players:ModifyPlayerNetworth(nPlayerID, Diff)
    --     end
    -- end

    -- Запрет на атаку юнитов на других аренах
    if (orderType == DOTA_UNIT_ORDER_ATTACK_MOVE or orderType == DOTA_UNIT_ORDER_ATTACK_TARGET or orderType == DOTA_UNIT_ORDER_CAST_TARGET) and target and target:IsBaseNPC() then
        local bResult, PID = Players:IsUnitCanAttackOrCastOnThis(unit, target)
        if not bResult then
            if PID ~= nil then
                local player = PlayerResource:GetPlayer(PID)
                if player then
                    CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_cant_attack_on_other_arena"})
                end
            end
            return false
        end
    end

    -- Запрет на каст способностей на других аренах.
    -- Исключение — способности с bCanCastOnOtherArena (abilities_settings): их РАЗРЕШЕНО
    -- кастовать на чужую арену. ВАЖНО: это отдельный флаг от bWorkOnOtherArena (тот — только
    -- про прохождение УРОНА). Напр. zuus_lightning_bolt_custom урон болтов Nimbus пропускает
    -- (bWorkOnOtherArena), но кастовать сам Lightning Bolt кросс-арена нельзя (нет cast-флага).
    if (orderType == DOTA_UNIT_ORDER_CAST_POSITION or orderType == DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION) and item and not GetAbilitySetting(item:GetName(), "bCanCastOnOtherArena") then
        local Position = Vector(params.position_x, params.position_y, params.position_z)
        local bResult, PID = Players:IsUnitCanAttackOrCastOnThis(unit, Position)
        if not bResult then
            -- [A20] Блинки РАЗРЕШАЕМ кликать на чужую арену: вместо блока зажимаем
            -- точку назначения в границы СВОЕЙ арены игрока. Сам герой на чужую арену
            -- физически не попадёт — это и так гарантирует Map:FixUnitsPositions
            -- (AdjustPosition), здесь же мы заранее коректируем целевую точку каста,
            -- чтобы клик не отменялся. Зажим по осям повторяет Map:AdjustPosition.
            local AbilityName = item:GetName()
            if string.find(AbilityName, "blink") ~= nil then
                local UnitArena = Players:GetUnitArena(unit)
                local ArenaInfo = UnitArena ~= nil and Map:GetArenaInfo(UnitArena) or nil
                if ArenaInfo ~= nil then
                    local Mins = ArenaInfo.mins
                    local Maxs = ArenaInfo.maxs
                    if not unit:HasFlyMovementCapability() and ArenaInfo.ground_mins ~= nil and ArenaInfo.ground_maxs ~= nil then
                        Mins = ArenaInfo.ground_mins
                        Maxs = ArenaInfo.ground_maxs
                    end

                    local NewPos = Vector(Position.x, Position.y, Position.z)
                    if NewPos.x >= Maxs.x then NewPos.x = Maxs.x end
                    if NewPos.x <= Mins.x then NewPos.x = Mins.x end
                    if NewPos.y >= Maxs.y then NewPos.y = Maxs.y end
                    if NewPos.y <= Mins.y then NewPos.y = Mins.y end

                    params.position_x = NewPos.x
                    params.position_y = NewPos.y
                    params.position_z = NewPos.z

                    -- Каст разрешаем (не блокируем) — точка уже зажата в свою арену.
                else
                    -- Арену игрока определить не удалось — ведём себя как раньше (блок).
                    if PID ~= nil then
                        local player = PlayerResource:GetPlayer(PID)
                        if player then
                            CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_cant_cast_on_other_arena"})
                        end
                    end
                    return false
                end
            else
                if PID ~= nil then
                    local player = PlayerResource:GetPlayer(PID)
                    if player then
                        CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_cant_cast_on_other_arena"})
                    end
                end
                return false
            end
        end
    end

    --Запрет на каст на деревья на других аренах
    if orderType == DOTA_UNIT_ORDER_CAST_TARGET_TREE and params.entindex_target ~= nil then
        local tree = GetEntityIndexForTreeId(params.entindex_target)
        if tree ~= nil and tree ~= 0 then
            local hTree = EntIndexToHScript(tree)
            if hTree then
                local bResult, PID = Players:IsUnitCanAttackOrCastOnThis(unit, hTree:GetAbsOrigin())
                if not bResult then
                    if PID ~= nil then
                        local player = PlayerResource:GetPlayer(PID)
                        if player then
                            CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_cant_cast_on_other_arena"})
                        end
                    end
                    return false
                end
            end
        end
    end

    --Вызов OnSpellStart при съедении предмета
    if orderType == DOTA_UNIT_ORDER_CONSUME_ITEM and item and item:GetName() == "item_black_grimoire_custom" then
        item:OnSpellStart()
    end
    
    --Запрет на перемещение нейтральных предметов в основной инвентарь
    if orderType == DOTA_UNIT_ORDER_MOVE_ITEM and item then
        local currentSlot = item:GetItemSlot()

        -- Fix: смок — TP-override стакаемый предмет. Движок всегда мерджит его в слот 15.
        -- Для перемещений в тайнике используем SwapItems (без мержа).
        -- Из TP-слота (15) перемещение полностью заблокировано.
        if item:GetName() == "item_smoke_of_deceit_custom" then
            local targetSlot = params.entindex_target

            -- Блокируем перемещение из TP-слота
            if currentSlot == 15 then
                return false
            end

            -- [NP-12] Тайник → тайник: свап без мержа (ручная расстановка в тайнике).
            -- Тайник → основной инвентарь (в т.ч. кнопка «взять всё»): смок идёт в свой
            -- TP-слот (15) с мержем зарядов в существующий стак, а не в обычный слот.
            if currentSlot >= DOTA_STASH_SLOT_1 and currentSlot <= DOTA_STASH_SLOT_6 and targetSlot ~= 15 then
                local cs = currentSlot
                local ts = targetSlot
                local bToStash = (ts ~= nil and ts >= DOTA_STASH_SLOT_1 and ts <= DOTA_STASH_SLOT_6)
                local hSmoke = item
                unit:SetContextThink(DoUniqueString("SmokeStashFix"), function()
                    if not unit or unit:IsNull() then return end
                    if bToStash then
                        -- В пределах тайника — просто меняем местами (как раньше).
                        unit:SwapItems(cs, ts)
                        return
                    end
                    -- В основной инвентарь — кладём смок в TP-слот (15).
                    if not hSmoke or hSmoke:IsNull() then return end
                    local existing = unit:GetItemInSlot(15)
                    if existing and not existing:IsNull() and existing ~= hSmoke
                        and existing:GetAbilityName() == "item_smoke_of_deceit_custom" then
                        -- В слоте 15 уже есть стак смока — мержим заряды и удаляем лишний.
                        existing:SetCurrentCharges(existing:GetCurrentCharges() + hSmoke:GetCurrentCharges())
                        UTIL_Remove(hSmoke)
                    else
                        -- Слот 15 пуст — переносим смок туда.
                        local fromSlot = hSmoke:GetItemSlot()
                        if fromSlot ~= 15 then
                            unit:SwapItems(fromSlot, 15)
                        end
                    end
                end, 0)
                return false
            end
        end

        local NeutralItemsList = KeyValues:GetActiveNeutrals()

        item:SetContextThink(DoUniqueString("Swap"), function(ent)
            local fSlot = unit:GetItemInSlot(currentSlot)
            local sSlot = unit:GetItemInSlot(ent:GetItemSlot())
            local IsNeutral = (fSlot and table.contains(NeutralItemsList, fSlot:GetName())) or (sSlot and table.contains(NeutralItemsList, sSlot:GetName()))

            local SlotsToCheck = 6
            if unit:HasAbility("techies_spoons_stash_custom") then
                SlotsToCheck = 8
            end
            
            -- -- Запрет на перемещение нейтральных предметов в слоты 7-8 для Techies (ПОСЛЕ перемещения)
            -- if unit:HasAbility("techies_spoons_stash_custom") then
            --     local finalSlot = ent:GetItemSlot()
            --     if finalSlot == DOTA_ITEM_SLOT_7 or finalSlot == DOTA_ITEM_SLOT_8 then
            --         -- Возвращаем предмет обратно
            --         unit:SwapItems(finalSlot, currentSlot)
            --         local player = PlayerResource:GetPlayer(nPlayerID)
            --         if player then
            --             CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_cant_use_neutral"})
            --         end
            --         return
            --     end
            -- end
            
            if IsNeutral then
                local NeutralItem = fSlot
                local ToSlot = ent:GetItemSlot()
                if sSlot and table.contains(NeutralItemsList, sSlot:GetName()) then
                    NeutralItem = sSlot
                    ToSlot = currentSlot
                end
                
                if ent:GetItemSlot() ~= currentSlot then
                    if NeutralItem:GetItemSlot() < SlotsToCheck then
                        unit:SwapItems(NeutralItem:GetItemSlot(), ToSlot)

                        local player = PlayerResource:GetPlayer(nPlayerID)
                        if player then
                            CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_neutral_item_slot_swap"})
                        end
                    elseif currentSlot == DOTA_ITEM_NEUTRAL_ACTIVE_SLOT or ent:GetItemSlot() == DOTA_ITEM_NEUTRAL_ACTIVE_SLOT then
                        NeutralItems:FixEnchant(nPlayerID)
                    end
                else
                    local player = PlayerResource:GetPlayer(nPlayerID)
                    if player then
                        CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_neutral_item_slot_swap"})
                    end
                end
            end

            Items:UpdateItemBySlot(unit, ent)
            if ent:GetItemSlot() ~= currentSlot then
                local OtherItem = unit:GetItemInSlot(currentSlot)
                if OtherItem and not OtherItem:IsNull() then
                    Items:UpdateItemBySlot(unit, OtherItem)
                end
            end
        end, 0)
    end

    --Запрет на выбрасывание или передачу нейтральных предметов
    if (orderType == DOTA_UNIT_ORDER_DROP_ITEM or orderType == DOTA_UNIT_ORDER_GIVE_ITEM or orderType == DOTA_UNIT_ORDER_EJECT_ITEM_FROM_STASH) and item then
        local NeutralItems = KeyValues:GetActiveNeutrals()

        if table.contains(NeutralItems, item:GetName()) then
            local player = PlayerResource:GetPlayer(nPlayerID)
            if player then
                CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_cant_drop"})
            end

            return false
        end

        item._dont_auto_consume_alt = true
    end

    -- Если игрок проиграл, то нельзя покупать предметы
    if orderType == DOTA_UNIT_ORDER_PURCHASE_ITEM then
        if nPlayerID then
            local PlayerInfo = Server:GetPlayerInfo(nPlayerID)
            if PlayerInfo and PlayerInfo.player_die_round ~= nil then
                local player = PlayerResource:GetPlayer(nPlayerID)
                if player then
                    CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_you_died"})
                end
                return false
            end
        end

        -- return false
    end

    -- Сломать чужую шмотку нельзя
    if (orderType == DOTA_UNIT_ORDER_PICKUP_ITEM or orderType == DOTA_UNIT_ORDER_ATTACK_TARGET ) and params.queue == 0 then
        if nPlayerID and target and target.GetContainedItem ~= nil then
            local ContainedItem = target:GetContainedItem()
            if ContainedItem then
                local Purchaser = ContainedItem:GetPurchaser()
                local RealPurchaser = GetRealUnit(Purchaser)
                if RealPurchaser and RealPurchaser ~= unit then
                    local player = PlayerResource:GetPlayer(nPlayerID)
                    if player then
                        CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_cant_destroy_other_items"})
                    end
                    return false
                end
            end
        end
    end

    -- Подбор чужого предмета
    if orderType == DOTA_UNIT_ORDER_PICKUP_ITEM then

        local item = EntIndexToHScript(params["entindex_target"])
        if item then
            local pickedItem = item:GetContainedItem()
            if not pickedItem then return true end

            local NeutralItems = KeyValues:GetActiveNeutrals()

            if table.contains(NeutralItems, pickedItem:GetName()) then
                local freeSlots = false
                for _, slot in ipairs({6, 7, 8, 16}) do
                    if unit:GetItemInSlot(slot) == nil then
                        freeSlots = true
                        break
                    end
                end
                
                if not freeSlots then
                    local player = PlayerResource:GetPlayer(unit:GetPlayerOwnerID())
                    if player then
                        CustomGameEventManager:Send_ServerToPlayer(player, "PauseNotification", {message="#no_free_slots", time=""})
                    end
                    return false
                end
            end

            if pickedItem:IsActiveNeutral() then
                if (pickedItem.owner ~= nil and pickedItem.owner ~= unit) then
                    local player = PlayerResource:GetPlayer(unit:GetPlayerOwnerID())
                    if player then
                        CustomGameEventManager:Send_ServerToPlayer(player, "PauseNotification", {message="#wrong_item", time=""})
                    end
                    return false
                end
            else
                if (pickedItem:GetPurchaser() ~= nil and pickedItem:GetPurchaser() ~= unit) then
                    local player = PlayerResource:GetPlayer(unit:GetPlayerOwnerID())
                    if player then
                        CustomGameEventManager:Send_ServerToPlayer(player, "PauseNotification", {message="#wrong_item", time=""})
                    end
                    return false
                end
            end
        end
    end

    -- Повторная покупка гема
    if orderType == DOTA_UNIT_ORDER_PURCHASE_ITEM then 
        if params.shop_item_name == "item_gem_shard" then 
            if unit:HasModifier("modifier_item_gem_shard") then
                local player = PlayerResource:GetPlayer(unit:GetPlayerOwnerID())
                if player then
                    CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_item_already_purchased"})
                end
                return false
            end
        end

        if params.shop_item_name == "item_gem_shard_2" then 
            if not unit:HasModifier("modifier_item_gem_shard") or unit:HasModifier("modifier_item_gem_shard_2") then
                local player = PlayerResource:GetPlayer(unit:GetPlayerOwnerID())
                if player then
                    local Error = not unit:HasModifier("modifier_item_gem_shard") and "dota_hud_error_not_buyed_1_version" or "dota_hud_error_item_already_purchased"
                    CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message=Error})
                end
                return false
            end
        end

        if params.shop_item_name == "item_paragon_book" then 
            if unit.bUsedParagon then
                local player = PlayerResource:GetPlayer(unit:GetPlayerOwnerID())
                if player then
                    CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_item_already_purchased"})
                end
                return false
            end
        end

        if params.shop_item_name == "item_paragon_book_2" then 
            if unit.bUsedParagon_2 then
                local player = PlayerResource:GetPlayer(unit:GetPlayerOwnerID())
                if player then
                    CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_item_already_purchased"})
                end
                return false
            end
        end
    end

    -- Использование скиллов на базе
    if (orderType == DOTA_UNIT_ORDER_CAST_TARGET) and params.queue == 0 then
        if target then
            local hAbility = EntIndexToHScript(params.entindex_ability)
            if hAbility and hAbility.IsItem and hAbility:IsItem() then
                if hAbility:GetName() and "item_moon_shard" == hAbility:GetName() then
                    if unit:IsTempestDouble() then
                        local hPlayer = PlayerResource:GetPlayer(nPlayerID)
                        if hPlayer then 
                            CustomGameEventManager:Send_ServerToPlayer(hPlayer,"SendHudError",{message="dota_hud_error_ability_inactive"} )   
                        end
                        return false
                    end
                end
            end
            if unit:GetTeamNumber() ~= target:GetTeamNumber() and target:HasModifier("modifier_hero_refreshing") and not IsCheatsEnabled() then
                local hAbility = EntIndexToHScript(params.entindex_ability)
                if hAbility and hAbility.GetAbilityName then
                    if "item_nullifier" ~= hAbility:GetAbilityName() and "rubick_spell_steal_custom" ~= hAbility:GetAbilityName() then
                        return false
                    end
                end
            end
        end
    end

    -- if params.queue == 0 then
    --     if nPlayerID then
    --         local hPlayer = PlayerResource:GetPlayer(nPlayerID)
    --         if hPlayer then
    --             CustomGameEventManager:Send_ServerToPlayer(hPlayer,"ReorderInterrupt",{state=false} )   
    --         end
    --     end
    -- end

    if (orderType == DOTA_UNIT_ORDER_CAST_TARGET) and params.queue == 0 then     
        local hAbility = EntIndexToHScript(params.entindex_ability)
        if hAbility and hAbility.GetAbilityName then
            local ability_name = hAbility:GetAbilityName()
            if "life_stealer_infest" == ability_name or "doom_bringer_devour_custom" == ability_name or "night_stalker_hunter_in_the_night_custom" == ability_name or "item_iron_talon" == ability_name or "snapfire_gobble_up_custom" == ability_name or "item_hand_of_midas_custom" == ability_name then
                if target then
                    if target and target.GetUnitName and (target:GetUnitName()=="npc_dota_roshan" or target:GetUnitName()=="npc_dota_nian" or target:HasModifier("modifier_skill_call_of_the_ancient_buff"))  then
                        if nPlayerID then
                            local hPlayer = PlayerResource:GetPlayer(nPlayerID)
                            if hPlayer then
                                CustomGameEventManager:Send_ServerToPlayer(hPlayer,"SendHudError",{message="dota_hud_error_cant_cast_on_roshan"} )
                            end
                        end
                        return false
                    end
                end
            end
            if "ability_phoenix_supernova" == ability_name then
                if target then
                    if unit and (target:IsTempestDouble() or unit:IsTempestDouble()) then
                        if nPlayerID then
                            local hPlayer = PlayerResource:GetPlayer(nPlayerID)
                            if hPlayer then
                                CustomGameEventManager:Send_ServerToPlayer(hPlayer,"SendHudError",{message="dota_hud_error_cant_cast_on_ally"} )
                            end
                        end
                        return false
                    end
                end
            end
            if "pudge_dismember" == ability_name then
                if target then
                    if unit and unit:GetTeamNumber()==target:GetTeamNumber() and target:IsTempestDouble() then
                        if nPlayerID then
                            local hPlayer = PlayerResource:GetPlayer(nPlayerID)
                            if hPlayer then
                                CustomGameEventManager:Send_ServerToPlayer(hPlayer,"SendHudError",{message="dota_hud_error_cant_cast_on_ally"} )
                            end
                        end
                        return false
                    end
                end          
            end
        end
    end

    -- Блок каста tusk_snowball во время sleight of fist — иначе снежок сбивается и уходит на КД
    if unit and item and item.GetAbilityName and item:GetAbilityName() == "tusk_snowball" and
        (orderType == DOTA_UNIT_ORDER_CAST_NO_TARGET or orderType == DOTA_UNIT_ORDER_CAST_POSITION) then
        if unit:HasModifier("modifier_ember_spirit_sleight_of_fist_caster") or unit:HasModifier("modifier_ember_spirit_sleight_of_fist_in_progress") then
            return false
        end
    end

    -- A5: каст Shadow Realm (Dark Willow) должен сбивать канал Trick of Trade. У shadow_realm
    -- IGNORE_CHANNEL → раньше он кастовался, НЕ прерывая Trick. Прерываем канал, сам каст разрешаем.
    if unit and item and item.GetAbilityName and item:GetAbilityName() == "dark_willow_shadow_realm" and
        (orderType == DOTA_UNIT_ORDER_CAST_NO_TARGET or orderType == DOTA_UNIT_ORDER_CAST_POSITION or orderType == DOTA_UNIT_ORDER_CAST_TARGET) then
        if unit:HasModifier("modifier_riki_tricks_of_the_trade_custom") then
            unit:InterruptChannel()
        end
    end

    -- A6: нельзя кастовать юнит-таргет способности на варды (как на обычный вард) — напр. Infest.
    -- Серпент-варды на BaseClass npc_dota_creep → клиент пускает каст; блокируем серверно (IsWardUnit по имени).
    if unit and item and target and not target:IsNull() and orderType == DOTA_UNIT_ORDER_CAST_TARGET
        and IsWardUnit(target) then
        local player = PlayerResource:GetPlayer(nPlayerID)
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_cant_cast_on_ward"})
        end
        return false
    end

    if unit and unit:HasModifier("modifier_duel_buff") and item and
        (orderType == DOTA_UNIT_ORDER_CAST_POSITION or orderType == DOTA_UNIT_ORDER_CAST_TARGET or orderType == DOTA_UNIT_ORDER_CAST_NO_TARGET or orderType == DOTA_UNIT_ORDER_CAST_TOGGLE) then
        local modif = unit:FindModifierByName("modifier_duel_buff")
        if modif then
            local caster = modif:GetCaster()
            if caster == unit then
                if item:GetName() ~= "ability_legion_commander_overwhelming_odds" then
                    return false
                end
            else
                return false
            end
        else
            return false
        end
    end

    -- if unit and item and item:GetName() == "largo_amphibian_rhapsody" and orderType == DOTA_UNIT_ORDER_CAST_TOGGLE then
    --     Map:AddAbilityToChecker(item, unit)

    --     local a1 = unit:FindAbilityByName("largo_song_fight_song")
    --     local a2 = unit:FindAbilityByName("largo_song_double_time")
    --     local a3 = unit:FindAbilityByName("largo_song_good_vibrations")
    --     if a1 and a2 and a3 and item:GetToggleState() == false then
    --         a1:SetHidden(true)
    --         a2:SetHidden(true)
    --         a3:SetHidden(true)
    --     end
    -- end

    return true
end