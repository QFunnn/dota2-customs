--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Util == nil then 
    Util = class({}) 
end

function Util:MoveHeroToCenter( nPlayerID )
    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
    -- Fallback для disconnected hero (engine binding потерян, см. MoveHeroToLocation)
    if (not hHero or hHero:IsNull()) and Players and Players.Players and Players.Players[nPlayerID] then
        local fallback = Players.Players[nPlayerID].hero
        if fallback and not fallback:IsNull() then
            hHero = fallback
        end
    end
    if not hHero or hHero:IsNull() then return end
    local nTeamNumber =  hHero:GetTeamNumber()
    local vTargetLocation = GameMode.vTeamStartLocationMap[nTeamNumber]
    local PlayerInfo = Server:GetPlayerInfo(nPlayerID)
    if PlayerInfo then
        PlayerInfo.current_position = Vector(0,0,0)
    end
    Util:MoveHeroToLocation(nPlayerID,vTargetLocation)
end

function Util:MoveHeroToLocation( nPlayerID,vLocation)
    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
    -- Fallback для disconnected hero: PlayerResource:GetSelectedHeroEntity возвращает nil
    -- если engine-side player-hero binding потерян (как происходит при DC). Реальная
    -- hero-entity при этом обычно жива и сохранена в Players.Players[PID].hero --
    -- берём её, иначе телепортация на арены/дуэли никогда не отрабатывает для disc игроков
    -- (гера остаётся в дефолтной точке спавна вместо центра арены / left/right slot дуэли).
    if (not hHero or hHero:IsNull()) and Players and Players.Players and Players.Players[nPlayerID] then
        local fallback = Players.Players[nPlayerID].hero
        if fallback and not fallback:IsNull() then
            hHero = fallback
        end
    end
    if hHero then
        Util:RemoveMovemenModifier(hHero)
        local particle_start = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, hHero)
        ParticleManager:ReleaseParticleIndex(particle_start)

        local AllControllable = FindUnitsInRadius(
            hHero:GetTeamNumber(),
            Vector(0,0,0),
            nil,
            999999,
            DOTA_UNIT_TARGET_TEAM_FRIENDLY,
            DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
            DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
            FIND_ANY_ORDER,
            false
        )
        for _, unit in ipairs(AllControllable) do
            if unit:GetUnitName() ~= "npc_dota_hero_target_dummy" and Map:GetPositionArena(vLocation) ~= "MINIGAMES" then
                Util:RemoveMovemenModifier(unit)
                local particle_start_summon = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, unit)
                ParticleManager:ReleaseParticleIndex(particle_start_summon)
                FindClearSpaceForUnit(unit, vLocation, true)
                local particle_end_summon = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
                ParticleManager:ReleaseParticleIndex(particle_end_summon)
            end
        end

        FindClearSpaceForUnit(hHero, vLocation, true)
        ResolveNPCPositions(vLocation, 300)
        local particle_end = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, hHero)
        ParticleManager:ReleaseParticleIndex(particle_end)
        hHero:EmitSound("DOTA_Item.BlinkDagger.Activate") 
        if PlayerResource:GetConnectionState(nPlayerID) == DOTA_CONNECTION_STATE_CONNECTED then 
            PlayerResource:SetCameraTarget(nPlayerID, hHero)
            Timers:CreateTimer({ endTime = 0.3, callback = function()
                PlayerResource:SetCameraTarget(nPlayerID,nil) 
            end})
        end
    end
end

function Util:RefreshAbilityAndItem( hHero,exceptions)
    if exceptions==nil then
        exceptions={}
    end

    exceptions["ability_disruptor_aeon"] = true
    exceptions["ability_undying_reincarnate"] = true

    for i = 0, hHero:GetAbilityCount() - 1 do
        local hAbility = hHero:GetAbilityByIndex(i)
        if hAbility and hAbility:GetAbilityType() ~= ABILITY_TYPE_ATTRIBUTES and not exceptions[hAbility:GetAbilityName()] then
            hAbility:RefreshCharges()
            hAbility:EndCooldown()
        end
    end

    for i = 0, 20 do
        local hItem = hHero:GetItemInSlot(i)
        if hItem then
            hItem:EndCooldown()
            hItem:RefreshCharges()
        end
    end

    local hItem = hHero:GetItemInSlot(16)

    if hItem then
        hItem:EndCooldown()
    end

    if hHero.tempest_double_hClone ~= nil and not hHero.tempest_double_hClone:IsNull() and hHero.tempest_double_hClone:IsAlive() then
        for i = 0, hHero.tempest_double_hClone:GetAbilityCount() - 1 do
            local hAbility = hHero.tempest_double_hClone:GetAbilityByIndex(i)
            if hAbility and hAbility:GetAbilityType() ~= ABILITY_TYPE_ATTRIBUTES then
                if exceptions[hAbility:GetAbilityName()]==nil then
                    hAbility:RefreshCharges()
                    hAbility:EndCooldown()
                end
            end
        end
        for i = 0, 20 do
            local hItem = hHero.tempest_double_hClone:GetItemInSlot(i)
            if hItem then
                hItem:EndCooldown()
                hItem:RefreshCharges()
            end
        end
        local hItem = hHero.tempest_double_hClone:GetItemInSlot(16)
        if hItem then
            hItem:EndCooldown()
        end
    end
end

function Util:RemoveMovemenModifier(hHero)
    hHero:Stop()
    hHero:RemoveModifierByName("modifier_magnataur_skewer_movement")
    hHero:RemoveModifierByName("modifier_phoenix_icarus_dive")
    hHero:RemoveModifierByName("modifier_mirana_leap")
    hHero:RemoveModifierByName("modifier_kunkka_x_marks_the_spot")
    hHero:RemoveModifierByName("modifier_kunkka_x_marks_the_spot_thinker")
    hHero:RemoveModifierByName("modifier_riki_tricks_of_the_trade_phase")
    hHero:RemoveModifierByName("modifier_riki_tricks_of_the_trade_custom")
    hHero:RemoveModifierByName("modifier_monkey_king_bounce_perch")
    hHero:RemoveModifierByName("modifier_void_spirit_dissimilate_phase")
    hHero:RemoveModifierByName("modifier_monkey_king_bounce_leap")
    hHero:RemoveModifierByName("modifier_monkey_king_tree_dance_activity")
    hHero:RemoveModifierByName("modifier_sandking_burrowstrike")
    hHero:RemoveModifierByName("modifier_phantomlancer_dopplewalk_phase")
    hHero:RemoveModifierByName("modifier_life_stealer_infest")
    hHero:RemoveModifierByName("modifier_phoenix_sun_ray")
    hHero:RemoveModifierByName("modifier_ember_spirit_sleight_of_fist_in_progress")
    hHero:RemoveModifierByName("modifier_ember_spirit_sleight_of_fist_caster")
    hHero:RemoveModifierByName("modifier_ember_spirit_sleight_of_fist_caster_invulnerability")
    hHero:RemoveModifierByName("modifier_witch_doctor_voodoo_switcheroo")
    if hHero:HasModifier("modifier_oracle_false_promise_custom") then
        Timers:CreateTimer(1, function()
            hHero:RemoveModifierByName("modifier_oracle_false_promise_custom")
        end)
    end
    hHero:RemoveModifierByName("modifier_brewmaster_primal_split")
    hHero:RemoveModifierByName("modifier_invoker_tornado_lua")
    if hHero:HasAbility("puck_ethereal_jaunt") then
       hHero:FindAbilityByName("puck_ethereal_jaunt"):SetActivated(false)
       Timers:CreateTimer({ endTime = 3, callback = function()
            if hHero:HasAbility("puck_ethereal_jaunt") then
                hHero:FindAbilityByName("puck_ethereal_jaunt"):SetActivated(true)
            end
        end})
    end
    if hHero:HasModifier("modifier_ember_spirit_fire_remnant_remnant_tracker") then
        hHero:RemoveModifierByName("modifier_ember_spirit_fire_remnant_timer")
        hHero:RemoveModifierByName("modifier_ember_spirit_fire_remnant_remnant_tracker")
        hHero:AddNewModifier(hHero, hHero:FindAbilityByName("ember_spirit_fire_remnant"), "modifier_ember_spirit_fire_remnant_remnant_tracker", {})
    end
    if hHero:HasModifier("modifier_weaver_timelapse") then
        hHero:RemoveModifierByName("modifier_weaver_timelapse")
        hHero:AddNewModifier(hHero, hHero:FindAbilityByName("weaver_time_lapse"), "modifier_weaver_timelapse", {})
    end
end

function Util:RemoveAbilityClean(hHero,sAbilityName)
    if sAbilityName=="slark_shadow_dance" then
        Util:CleanSlark(hHero)
    end
    if sAbilityName=="slark_depth_shroud" then
        Util:CleanSlark(hHero)
    end
    if sAbilityName=="broodmother_spin_web" then
        Util:CleanWeb(hHero)
    end
    if sAbilityName=="witch_doctor_death_ward" then
        Util:CleanDeathWard(hHero)
    end
    if sAbilityName=="visage_summon_familiars" then
        Util:CleanFamiliar(hHero)
    end
    if sAbilityName=="furion_sprout" then
        Util:CleanFurion(hHero)
    end
    if sAbilityName=="rubick_spell_steal_custom" then
        Util:CleanRubick(hHero)
    end
    if sAbilityName=="pudge_meat_hook" or sAbilityName=="marci_grapple" or sAbilityName=="rattletrap_hookshot" or sAbilityName=="bane_nightmare" then
        Util:CleanBugAbilities(hHero)
    end
end

function Util:CleanRubick(hHero)
    local rubick_skill = hHero:FindAbilityByName("rubick_spell_steal_custom")
    if rubick_skill then
        if rubick_skill.currentSpell ~= nil then
            HeroBuilder:RemoveAbility(hHero:GetPlayerOwnerID(), rubick_skill.currentSpell:GetAbilityName())
        end
    end
end

function Util:CleanBugAbilities(hHero)
    local thinkers = Entities:FindAllByClassname("npc_dota_thinker")

    local modifiers_table = 
    {
        "modifier_marci_grapple_victim_motion",
        "modifier_followthrough",
        "modifier_pudge_meat_hook",
        "modifier_pudge_meat_hook_pathingfix",
        "modifier_rattletrap_hookshot",
        "modifier_bane_nightmare",
        "modifier_bane_nightmare_invulnerable",
    }

    for _,thinker in pairs(thinkers) do 
        for id, mod_name in pairs(modifiers_table) do
            if thinker and not thinker:IsNull() and thinker:GetTeamNumber() == hHero:GetTeamNumber() and thinker:HasModifier(mod_name) then 
                print("удаляется thinker", mod_name)
                UTIL_Remove(thinker)
            end
        end
    end

    local allHeroes = HeroList:GetAllHeroes()

    for _, hero in pairs(allHeroes) do
        if hero and not hero:IsNull() then
            for id, mod_name in pairs(modifiers_table) do
                local modifier_find = hero:FindModifierByName(mod_name)
                if modifier_find then
                    modifier_find:Destroy()
                end
            end
        end
    end

    local units = Entities:FindAllInSphere(hHero:GetAbsOrigin(), 5000)

    for _, unit in pairs(units) do
        if unit and not unit:IsNull() then
            for id, mod_name in pairs(modifiers_table) do
                if unit.FindModifierByName then
                    local modifier_find = unit:FindModifierByName(mod_name)
                    if modifier_find then
                        modifier_find:Destroy()
                        if not unit:IsHero() then
                            unit:Destroy()
                        end
                    end
                end
            end
        end
    end
end

function Util:CleanFurion(hHero)
    local thinkers = Entities:FindAllByClassname("npc_dota_thinker")
    for _,thinker in pairs(thinkers) do 
        if thinker and not thinker:IsNull() and thinker:GetTeamNumber() == hHero:GetTeamNumber() and thinker:HasModifier("modifier_furion_sprout_blind") then 
            GridNav:DestroyTreesAroundPoint(thinker:GetAbsOrigin(), 320, true)
            UTIL_Remove(thinker)
        elseif thinker and not thinker:IsNull() and thinker:GetTeamNumber() == hHero:GetTeamNumber() and thinker:HasModifier("modifier_furion_sprout_blind_aura") then 
            GridNav:DestroyTreesAroundPoint(thinker:GetAbsOrigin(), 320, true)
            UTIL_Remove(thinker)
        elseif thinker and not thinker:IsNull() and thinker:GetTeamNumber() == hHero:GetTeamNumber() and thinker:HasModifier("modifier_furion_sprout_entangle") then 
            GridNav:DestroyTreesAroundPoint(thinker:GetAbsOrigin(), 320, true)
            UTIL_Remove(thinker)
        elseif thinker and not thinker:IsNull() and thinker:GetTeamNumber() == hHero:GetTeamNumber() and thinker:HasModifier("modifier_furion_sprout_marker") then 
            GridNav:DestroyTreesAroundPoint(thinker:GetAbsOrigin(), 320, true)
            UTIL_Remove(thinker)
        elseif thinker and not thinker:IsNull() and thinker:GetTeamNumber() == hHero:GetTeamNumber() and thinker:HasModifier("modifier_furion_sprout_shard") then 
            GridNav:DestroyTreesAroundPoint(thinker:GetAbsOrigin(), 320, true)
            UTIL_Remove(thinker)
        elseif thinker and not thinker:IsNull() and thinker:GetTeamNumber() == hHero:GetTeamNumber() and thinker:HasModifier("modifier_furion_sprout_tether") then 
            GridNav:DestroyTreesAroundPoint(thinker:GetAbsOrigin(), 320, true)
            UTIL_Remove(thinker)
        elseif thinker and not thinker:IsNull() and thinker:GetTeamNumber() == hHero:GetTeamNumber() and thinker:HasModifier("modifier_furion_sprout_tether_aura") then 
            GridNav:DestroyTreesAroundPoint(thinker:GetAbsOrigin(), 320, true)
            UTIL_Remove(thinker)
        end
    end
end

function Util:ThinkerClean(hHero)
    local thinkers = Entities:FindAllByClassname("npc_dota_thinker")
    local exepstions = 
    {
        ["elder_titan_echo_stomp"] = true,
        ["shredder_chakram_lua"] = true,
        ["shredder_chakram_lua_return"] = true,
        ["shredder_chakram_2_lua"] = true,
        ["shredder_chakram_lua_2_return"] = true,
    }

    for _,thinker in pairs(thinkers) do
        if not thinker:HasModifier("modifier_abilities_optimization_thinker") then
            local is_exception = false
            for _, mod in pairs(thinker:FindAllModifiers()) do
                if mod and mod:GetAbility() ~= nil and exepstions[mod:GetAbility():GetAbilityName()] then
                    is_exception = true
                end
            end
            if not is_exception then
                UTIL_Remove(thinker)
            end
        end
    end
end

function Util:CleanSlark(hHero)
    local thinkers = Entities:FindAllByClassname("npc_dota_thinker")
    for _,thinker in pairs(thinkers) do 
        if thinker:GetTeamNumber() == hHero:GetTeamNumber() and thinker:GetOwner() == hHero and thinker:HasModifier("modifier_slark_depth_shroud") then 
            UTIL_Remove(thinker)
        elseif thinker:GetTeamNumber() == hHero:GetTeamNumber() and thinker:GetOwner() == hHero and thinker:HasModifier("modifier_slark_depth_shroud_thinker") then 
            UTIL_Remove(thinker)
        end
    end
end

function Util:CleanWeb(hHero)
    local vWebs = Entities:FindAllByName("npc_dota_broodmother_web")
    for _, hWeb in pairs(vWebs) do
        if hWeb:GetOwner() == hHero then
            UTIL_Remove(hWeb)
        end
    end
end

function Util:CleanDeathWard(hHero)
    local vWards = Entities:FindAllByName("npc_dota_witch_doctor_death_ward")
    for _, vWard in pairs(vWards) do
        if vWard:GetOwner() == hHero then
            UTIL_Remove(vWard)
        end
    end
end

function Util:CleanFamiliar(hHero)
    local vFamiliars = Entities:FindAllByName("npc_dota_visage_familiar")
    for _, hFamiliar in pairs(vFamiliars) do
        if hFamiliar:GetOwner() == hHero then
            hFamiliar:ForceKill(false)
        end
    end
end

function CDOTA_BaseNPC:AddEndChannelListener(listener)
    local endChannelListeners = self.EndChannelListeners or {}
    self.EndChannelListeners = endChannelListeners
    local index = #endChannelListeners + 1
    endChannelListeners[index] = listener
end

function Util:CleanFurArmySoldier()
    Timers:CreateTimer({ endTime = 0.5, callback = function()
        local units = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, Vector(0,0,0), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_DEAD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)
        for _,hUnit in ipairs(units) do
            if hUnit and not hUnit:IsNull() and (hUnit:HasModifier("modifier_monkey_king_fur_army_soldier") or hUnit:HasModifier("modifier_monkey_king_fur_army_soldier_hidden")) then
                hUnit:ForceKill(false)
                UTIL_Remove(hUnit)
            end
        end
    end})
end

function Util:RecordConsumableItem(nPlayerID,sItemName)
    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
    if hHero then
        if hHero.sConsumedItems==nil then
            hHero.sConsumedItems=""
        end
        hHero.sConsumedItems = hHero.sConsumedItems..sItemName..","
    end
end

function Util:RecordCreepLaunch(nPlayerID,sItemName)
    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
    if hHero then
        if hHero.CreepInformation == nil then
            hHero.CreepInformation = {}
        end
        if hHero.CreepInformation[sItemName] == nil then
            hHero.CreepInformation[sItemName] = 1
        else
            hHero.CreepInformation[sItemName] = hHero.CreepInformation[sItemName] + 1
        end
        CustomNetTables:SetTableValue("creep_launch", tostring(nPlayerID), hHero.CreepInformation)
    end
end