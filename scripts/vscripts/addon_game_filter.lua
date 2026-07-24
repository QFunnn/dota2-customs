--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function dota1x6:ExecuteOrderFilterCustom( ord )
local target = nil
local player = PlayerResource:GetPlayer(ord["issuer_player_id_const"])
local new_pos = Vector(ord.position_x, ord.position_y, ord.position_z)
local order = ord.order_type
local ability = nil
local unit
if ord.units and ord.units["0"] then
    unit = EntIndexToHScript(ord.units["0"])
end

if not unit then return true end

if ord.entindex_target and ord.entindex_target ~= 0 then
    target = EntIndexToHScript(ord.entindex_target)
end

if ord.entindex_ability and ord.entindex_ability ~= -1 then
    ability = EntIndexToHScript(ord.entindex_ability)
end

if unit:HasModifier("modifier_teleport_cast") then
    unit:RemoveModifierByName("modifier_teleport_cast")
end

if (order == DOTA_UNIT_ORDER_STOP or order == DOTA_UNIT_ORDER_HOLD_POSITION) and unit:HasModifier("modifier_life_stealer_unfettered_custom") then
    unit:RemoveModifierByName("modifier_life_stealer_unfettered_custom")
end
    
if unit:HasModifier("modifier_legion_commander_duel_custom_buff") then
    local mod = unit:FindModifierByName("modifier_legion_commander_duel_custom_buff")
    local allow =
    {
        [DOTA_UNIT_ORDER_CAST_TARGET] = true,
        [DOTA_UNIT_ORDER_CAST_NO_TARGET] = true,
        [DOTA_UNIT_ORDER_CAST_POSITION] = true,
        [DOTA_UNIT_ORDER_CAST_TOGGLE] = true,
    }
    if mod and not mod.is_enemy and not allow[order] then
        return false
    end
end

if order == DOTA_UNIT_ORDER_CAST_TARGET and ability and ability:IsItem() and (ability:GetName() == "item_cyclone_custom" or ability:GetName() == "item_wind_waker_custom") and target then
    if (unit.owner and unit.owner == target and unit:IsTempestDouble()) or (target.owner and target.owner == unit and target:IsTempestDouble()) then 
        CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message = "#cyclone_error"})
        return false
    end
end

local infest_mod = unit.infest_mod
local unit_controlled = unit:HasModifier("modifier_life_stealer_infest_custom_legendary_creep") or unit:HasModifier("modifier_enigma_demonic_conversion_custom_legendary_creep")

if unit.infest_creep and (order == DOTA_UNIT_ORDER_ATTACK_TARGET or order == DOTA_UNIT_ORDER_MOVE_TO_TARGET) and target and target == unit.infest_creep then
    return false
end

if (order == DOTA_UNIT_ORDER_ATTACK_TARGET or order == DOTA_UNIT_ORDER_MOVE_TO_TARGET) and (unit:IsRealHero() or unit_controlled)
    and target and not target:IsNull() and target:IsBaseNPC() and target:GetUnitName() == "npc_teleport" then

    if unit:HasModifier("modifier_mid_teleport_cast") or (target:GetTeamNumber() ~= unit:GetTeamNumber() and target:GetName() ~= "edge_teleport_1" and target:GetName() ~= "edge_teleport_2")
    or unit:IsChanneling() or unit:HasModifier("modifier_teleport_cast") then return false end

    local tower = towers[unit:GetTeamNumber()]

    if tower and tower:HasModifier("modifier_the_hunt_custom_tower") then 
        CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message = "#midteleport_hunt"})
        return false
    end
    local cast_unit = unit 
    if IsValid(infest_mod) and infest_mod.is_legendary and infest_mod.target then
        cast_unit = infest_mod.target
    end

    cast_unit:AddNewModifier(cast_unit, nil, "modifier_teleport_cast", {teleport = target:entindex()})
    return false
end

if order == DOTA_UNIT_ORDER_CAST_TARGET and target then
    if target:GetUnitName() == "npc_teleport" then 
        return false
    end
end

if target and order == DOTA_UNIT_ORDER_ATTACK_TARGET and unit:HasModifier("modifier_witch_doctor_death_ward_custom") then
    local ward_mod = unit:FindModifierByName("modifier_witch_doctor_death_ward_custom")
    ward_mod:SetTarget(target)
    return
end

if unit.marci_creep and order == DOTA_UNIT_ORDER_MOVE_TO_POSITION then
    local mod = unit:FindModifierByName("modifier_marci_guardian_custom_legendary_tether_wisp")
    if mod then
        mod:Destroy()
    end
end

if order == DOTA_UNIT_ORDER_CONSUME_ITEM and ability then
    local witch_doctor_innate = unit:FindModifierByName("modifier_witch_doctor_innate_custom_grisgris")
    if witch_doctor_innate and ability == witch_doctor_innate:GetAbility() then
        witch_doctor_innate:ConsumeGold()
    end
    return true
end

if unit_controlled then    
    local move_orders =
    {
        [DOTA_UNIT_ORDER_PICKUP_RUNE] = true,
        [DOTA_UNIT_ORDER_PICKUP_ITEM] = true,
    }

    if unit:IsChanneling() and order ~= DOTA_UNIT_ORDER_STOP and order ~= DOTA_UNIT_ORDER_HOLD_POSITION then
        return false
    end

    if move_orders[order] and target then
        local order_table = 
        {
            UnitIndex = unit:entindex(),
            OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
            Queue = false,
            Position = target:GetAbsOrigin(),
            TargetIndex = target and target:entindex() or nil,
        }
        ExecuteOrderFromTable(order_table)
        local owner = unit.owner
        if owner then
            local order_table = 
            {
                UnitIndex = owner:entindex(),
                OrderType = order,
                Queue = false,
                Position = target:GetAbsOrigin(),
                TargetIndex = target and target:entindex() or nil,
            }
            ExecuteOrderFromTable(order_table)
        end
        return false
    end
    return true 
end


if IsValid(infest_mod) and infest_mod.target and infest_mod.is_legendary == 1 and (not infest_mod.target:IsChanneling() or order == DOTA_UNIT_ORDER_STOP or order == DOTA_UNIT_ORDER_HOLD_POSITION) then

    local cast_mods = 
    {
        [DOTA_UNIT_ORDER_CAST_POSITION] = true,
        [DOTA_UNIT_ORDER_CAST_NO_TARGET] = true,
        [DOTA_UNIT_ORDER_CAST_TARGET] = true
    }

    if cast_mods[order] and ability then
        if (infest_mod.target:IsSilenced() and not ability:IsItem()) or infest_mod.target:IsHexed() or infest_mod.target:IsFeared() or
        ((infest_mod.target:IsStunned() or infest_mod.target:GetForceAttackTarget() ~= nil) and not dota1x6:ContainsValue(ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE)) then

            CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message = "#lifestealer_control"})
            return false
        end
    end

    local allowed_orders = 
    {
        [DOTA_UNIT_ORDER_MOVE_TO_POSITION] = true,
        [DOTA_UNIT_ORDER_ATTACK_MOVE] = true,
        [DOTA_UNIT_ORDER_STOP] = true,
        [DOTA_UNIT_ORDER_HOLD_POSITION] = true,
        [DOTA_UNIT_ORDER_MOVE_TO_TARGET] = true,
        [DOTA_UNIT_ORDER_ATTACK_TARGET] = true,
    }
    local move_orders =
    {
        [DOTA_UNIT_ORDER_PICKUP_RUNE] = true,
        [DOTA_UNIT_ORDER_PICKUP_ITEM] = true,
    }

    if allowed_orders[order] then
        local order_table = 
        {
            UnitIndex = infest_mod.target:entindex(),
            OrderType = order,
            Queue = false,
            Position = new_pos,
            TargetIndex = target and target:entindex() or nil,
        }
        ExecuteOrderFromTable(order_table)

        ord.units["0"] = nil
        return true
    elseif move_orders[order] and target then
        local order_table = 
        {
            UnitIndex = infest_mod.target:entindex(),
            OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
            Queue = false,
            Position = target:GetAbsOrigin(),
            TargetIndex = target and target:entindex() or nil,
        }
        ExecuteOrderFromTable(order_table)
    end
end

if unit:HasModifier("modifier_duel_hero_start") then 
    return false
end 

local id = ord["issuer_player_id_const"]

if order == DOTA_UNIT_ORDER_TRAIN_ABILITY and ability then
    local behavior = ability:GetAbilityKeyValues()
    local can_learn = true
    if behavior and behavior["AbilityBehavior"] then
        can_learn = not string.find(behavior["AbilityBehavior"], "DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE")
    end
    if not can_learn then
        CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message = "#ability_not_learnable"})
        return false
    end

    if ability.GetIntrinsicModifierName and ability:GetIntrinsicModifierName() then
        local mod = ability:GetCaster():FindModifierByName(ability:GetIntrinsicModifierName())
        Timers:CreateTimer(0.5, function()
            if IsValid(mod) and mod.OnRefresh then
                mod:OnRefresh({})
            end
        end)
    end
end

if unit.order_mods and unit:IsAlive() then
    local data_table = {}
    data_table.target = target
    data_table.pos = new_pos
    data_table.order_type = order
    data_table.ability = ability
    for mod,_ in pairs(unit.order_mods) do
        if mod and not mod:IsNull() and mod.OrderEvent ~= nil then 
            local result = mod:OrderEvent(data_table)
            if result and result == 0 then
                return false
            end
        else
            unit.order_mods[mod] = nil
        end
    end 
end

for _,index in pairs(ord.units) do
    local table_unit = EntIndexToHScript(index)
    if table_unit and table_unit:IsCourier() and ((table_unit.player_owner and table_unit.player_owner ~= id) or dota1x6.NO_FOW_TEAMS[table_unit:GetTeamNumber()]) then
        return false
    end
end

local orders = 
{
    [DOTA_UNIT_ORDER_CAST_POSITION] = true,
    [DOTA_UNIT_ORDER_CAST_TARGET] = true,
    [DOTA_UNIT_ORDER_CAST_TARGET_TREE] = true, 
    [DOTA_UNIT_ORDER_MOVE_TO_POSITION] = true,
    [DOTA_UNIT_ORDER_MOVE_TO_TARGET] = true,
    [DOTA_UNIT_ORDER_ATTACK_MOVE] = true,
    [DOTA_UNIT_ORDER_ATTACK_TARGET] = true,
    [DOTA_UNIT_ORDER_CAST_NO_TARGET] = true,
    [DOTA_UNIT_ORDER_PICKUP_ITEM] = true,
    [DOTA_UNIT_ORDER_PICKUP_RUNE] = true,
}

if unit and unit:HasModifier("modifier_centaur_hoof_stomp_custom_prepair") and ability and ability:GetName() == "centaur_hoof_stomp_custom" then
    return false
end

if unit and (unit:HasModifier("modifier_custom_ability_teleport") or unit:HasModifier("modifier_patrol_warp_amulet") or unit:HasModifier("modifier_tinker_rearm_custom")) then
    if orders[order] == true then 
        if order ~= DOTA_UNIT_ORDER_CAST_NO_TARGET then 
            return false
        else 
            if ability and not dota1x6:ContainsValue(ability:GetBehavior(), DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL) then
                return false
            end
        end
    end
end

if order == DOTA_UNIT_ORDER_PICKUP_ITEM and target then
    local pickedItem = target:GetContainedItem()
    if not pickedItem then return true end
    if players[unit:GetId()] == nil then return false end

    if dota1x6:IsSphere(pickedItem) and players[unit:GetId()]:HasModifier("modifier_end_choise") then 
        return false 
    end

    if unit:IsCourier() and pickedItem:GetPurchaser() ~= players[unit:GetId()] then
        CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message = "#wrong_sphere"})
        return false 
    end

    if (pickedItem:GetPurchaser() ~= unit) and (pickedItem:GetName() ~= "item_rapier") and not unit:IsCourier() then
        CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message = "#wrong_sphere"})
        return false
    end
end

if order == DOTA_UNIT_ORDER_BUYBACK and not unit:IsReincarnating() and not unit:IsAlive() and unit.no_buyback ~= 1 and players[unit:GetId()] then 
    if unit.died_on_duel then
        return false
    end

    unit.no_buyback = 1
    Timers:CreateTimer(0.2, function() 
        if IsValid(unit) and players[unit:GetId()] then
            if not unit:IsAlive() then 
                unit:RespawnHero(false, false)
            end
            dota1x6:RefreshCooldowns(unit, true)
            dota1x6:ResetOnRespawn(unit)
        end
    end)

    Timers:CreateTimer(1, function() 
        if unit and not unit:IsNull() then 
            unit:SetBuybackCooldownTime(99999)
        end
    end)
end

if order == DOTA_UNIT_ORDER_CAST_TARGET and unit:GetUnitName() == "npc_dota_hero_alchemist" then
    if ability and ability:GetName() == "item_ultimate_scepter" then 
        CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message = "#alch_scepter"})
        return false
    end
end


if unit:HasModifier("modifier_duel_hero_thinker") and 
    (order == DOTA_UNIT_ORDER_PURCHASE_ITEM
    or order == DOTA_UNIT_ORDER_EJECT_ITEM_FROM_STASH) then 

    return false
end


 if order == DOTA_UNIT_ORDER_CAST_TOGGLE and ability then 
    if ability:GetCooldownTimeRemaining() > 0 then
        return false
    end

    if ability:GetName() == "custom_pudge_rot" and (unit:IsSilenced() or unit:IsStunned() or unit:GetForceAttackTarget() ~= nil) and not unit:HasTalent("modifier_pudge_rot_6") then
        return false
    end
 end

if ability then
    if ability:GetName() == "terrorblade_demon_zeal_custom" and (unit:IsStunned() or unit:GetForceAttackTarget() ~= nil) and not unit:HasTalent("modifier_terror_meta_5") then
        return false
    end
end

if unit and order == DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO and ability and auto_cast_spells[ability:GetName()] ~= nil
    and bit.band(ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_AUTOCAST) ~= 0 then

    if not unit:IsAlive() then
        return false
    end

    local data = auto_cast_spells[ability:GetName()]
    local mod = data
    local stop_order = false
    if type(data) == "table" then
        stop_order = data[2]
        mod = data[1]
    end

    if ability.CheckToggle and not ability:CheckToggle() then
        return false
    end

    if ability:GetAutoCastState() == false then
        unit:AddNewModifier(unit, ability, mod, {})
    else
        unit:RemoveModifierByName(mod)
    end
    if stop_order then
        return false
    end
end

if unit and unit:HasModifier("modifier_pangolier_gyroshell_custom") then 
    local validMoveOrders =
    {
        [DOTA_UNIT_ORDER_ATTACK_TARGET] = true,
        [DOTA_UNIT_ORDER_MOVE_TO_TARGET] = true,
        [DOTA_UNIT_ORDER_MOVE_TO_POSITION] = true,
        [DOTA_UNIT_ORDER_ATTACK_MOVE] = true,
        [DOTA_UNIT_ORDER_PICKUP_ITEM] = true,
        [DOTA_UNIT_ORDER_PICKUP_RUNE] = true,
        [DOTA_UNIT_ORDER_MOVE_TO_DIRECTION] = true,
    }

    if validMoveOrders[order] then
        unit:FindModifierByName("modifier_pangolier_gyroshell_custom"):OnOrderCustom(Vector(ord.position_x, ord.position_y, ord.position_z), target)
        return false
    end
end

if order == DOTA_UNIT_ORDER_ATTACK_TARGET and target and target:IsBaseNPC() and not target:IsNull() and unit:IsAlive() and unit:IsRealHero() then
    if (target:GetUnitName() == "npc_dota_observer_wards" or target:GetUnitName() == "npc_dota_sentry_wards") then
        unit:AddNewModifier(unit, nil, "modifier_ward_attack_range", {})
    elseif unit:HasModifier("modifier_ward_attack_range") then
        unit:RemoveModifierByName("modifier_ward_attack_range")
    end

    if target:IsHero() and not unit:HasModifier("modifier_attacking_hero") then
        unit:AddNewModifier(unit, nil, "modifier_attacking_hero", {})
    end
    if not target:IsHero() and unit:HasModifier("modifier_attacking_hero") then
        unit:RemoveModifierByName("modifier_attacking_hero")
    end
end


if not ability or not ability.GetBehaviorInt then return true end
local behavior = ability:GetBehaviorInt()

if (bit.band(behavior, DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING) ~= 0 or ability:GetAbilityName() == "broodmother_shard_ability_custom")
    and (order == DOTA_UNIT_ORDER_CAST_POSITION or order == DOTA_UNIT_ORDER_CAST_TARGET or order == DOTA_UNIT_ORDER_CAST_TARGET_TREE or order == DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION) then

    if order == DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION then
        ability.vectorTargetPosition2 = Vector(ord.position_x, ord.position_y, 0)
       -- CustomGameEventManager:Send_ServerToPlayer(player, "get_vector_point", {ability = ability:entindex()}) 
        ability.vectorTargetPosition = ability.vectorTargetPosition2
        if IsValid(target) then
            ability.vectorTargetPosition = target:GetAbsOrigin()
            ability.vectorTargetPosition.z = 0
        end
        return true
    end

    if order == DOTA_UNIT_ORDER_CAST_POSITION then
        ability.vectorTargetPosition = Vector(ord.position_x, ord.position_y, 0)
    end

    local position_start = ability.vectorTargetPosition
    local position_end = ability.vectorTargetPosition2
    local vec = position_end - position_start

    if position_start == position_end then
        vec = position_start + Vector(10, 0, 0)
    end

    local direction = vec:Normalized()
    ability.vectorTargetDirection = direction

    local function OverrideSpellStart(self, position, direction)
        self:OnVectorCastStart(position_start, direction)
    end
    ability.OnSpellStart = function(self) return OverrideSpellStart(self, position_start, direction) end
end

return true
end

function dota1x6:send_vector_point(params)
if params.PlayerID == nil then return end
local res = Vector(params.x, params.y, 0)
local ability = EntIndexToHScript(params.ability)
if not ability then return end

ability.vectorTargetPosition2 = res
end




function dota1x6:OnRuneActivated(params)
local id = params.PlayerID

if not players[id] then return end
if params.rune ~= DOTA_RUNE_BOUNTY then return end

local unit = players[id]
local team = unit:GetTeamNumber()
local net_k = bounty_net_min
local teams_net = dota1x6:GetTeamsNet()
local bonus = 1 

if #teams_net > 1 then 
    table.sort( teams_net, function(x,y) return y.gold < x.gold end )
end 

for index,data in pairs(teams_net) do
    if data.team == team then
        net_k = bounty_net_min + (bounty_net_max - bounty_net_min)*((index - 1)/(max_teams - 1))
    end
end

local heroes = dota1x6:FindPlayers(team, false, true)

if params.banana_k then
    heroes = {unit}
else
    start_quest:CheckQuest({id = id, quest_name = "Quest_8"})

    players[id].bounty_runes_picked = players[id].bounty_runes_picked + 1

    if (unit:GetQuest() == "General.Quest_6") then 
        unit:UpdateQuest(1)
    end

    if unit:HasModifier("modifier_templar_assassin_innate_custom") then
        local mod = unit:FindModifierByName("modifier_templar_assassin_innate_custom")
        mod:UseSmoke()
    end

    if unit:HasAbility("alchemist_goblins_greed_custom") then
        unit:AddNewModifier(unit, nil, "modifier_alchemist_goblins_greed_custom_runes", {})
    end

    if unit:HasAbility("arc_warden_innate_custom") then
        unit:AddNewModifier(unit, unit:FindAbilityByName("arc_warden_innate_custom"), "modifier_arc_warden_ancients_ally_custom_runes", {})
    end
end

local minute = math.floor(GameRules:GetDOTATime(false, false) / 60)
local gold = ((bounty_gold_init + minute * bounty_gold_per_minute)/#heroes)*net_k
local blue = ((bounty_blue_init + minute * bounty_blue_per_minute)/#heroes)*net_k
local exp = ((bounty_exp_init + minute * bounty_exp_per_minute)/#heroes)*net_k

if params.banana_k then
    gold = gold*params.banana_k
    blue = blue*params.banana_k
    exp = exp*params.banana_k
end

local names = {}
for _,hero in pairs(heroes) do
    table.insert(names, hero:GetUnitName())
end

for _,hero in pairs(heroes) do
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(hero:GetId()), "mini_alert_event",  {heroes = names, net_k = math.floor(net_k*100), event_type = "bounty"})

    local bonus_gold = gold
    local hero_blue = blue
    local hero_exp = exp

    if hero:HasModifier("modifier_templar_assassin_innate_custom") then
        local mod = hero:FindModifierByName("modifier_templar_assassin_innate_custom")
        if mod then
            hero_blue = hero_blue*mod.bonus
            hero_exp = hero_exp*mod.bonus
            bonus_gold = bonus_gold + gold*(mod.bonus - 1)
        end
    end

    if hero:HasModifier("modifier_alchemist_goblins_greed_custom") then 
        local ability = hero:FindAbilityByName("alchemist_goblins_greed_custom")
        bonus_gold = bonus_gold + gold*(ability:GetSpecialValueFor("bounty_multiplier") - 1)
    end

    hero:AddExperience(hero_exp, 5, false, false)
    dota1x6:AddBluePoints(hero, hero_blue)
    hero:ModifyGoldFiltered(bonus_gold, true, DOTA_ModifyGold_BountyRune)
    hero:SendNumber(0, bonus_gold)
end

local mod = unit:FindModifierByName("modifier_voice_module") 
if mod then 
    mod:BountyEvent()
end

end


function dota1x6:BountyRunePickupFilter(params)

CustomGameEventManager:Send_ServerToAllClients('delete_bounty',  {})
params["gold_bounty"] = 0 
return true
end



function dota1x6:OnItemPickUp( event )
local item = EntIndexToHScript( event.ItemEntityIndex )

local owner
if event.HeroEntityIndex then
    owner = EntIndexToHScript(event.HeroEntityIndex)
elseif event.UnitEntityIndex then
    owner = EntIndexToHScript(event.UnitEntityIndex)
end

if not owner:IsRealHero() then return end
local id = owner:GetId()

if event.itemname == "item_aegis" then
    UTIL_Remove( item )
    owner:AddNewModifier(owner, nil, "modifier_aegis_custom", {duration = 300})
end

local hero = players[id]

if not hero:HasModifier("modifier_end_choise") then 
   
    local after_legen = false
    if item.after_legen == true then 
        after_legen = true
    end

    if event.itemname == "item_gray_upgrade" then
        upgrade:init_upgrade(owner,1,nil,after_legen)
        UTIL_Remove( item )
    end

    if event.itemname == "item_blue_upgrade" then
        upgrade:init_upgrade(owner,2,nil,after_legen)
        UTIL_Remove( item )
    end
    if event.itemname == "item_purple_upgrade" then
        upgrade:init_upgrade(owner,3,nil,after_legen)
        UTIL_Remove( item )

    end
    if event.itemname == "item_purple_upgrade_shop" then
        upgrade:init_upgrade(owner,3,nil,true)
        UTIL_Remove( item )

    end
    if event.itemname == "item_legendary_upgrade" then
        upgrade:init_upgrade(owner,4,nil,after_legen)       
        UTIL_Remove( item ) 
    end

    if event.itemname == "item_alchemist_recipe" then
        upgrade:init_upgrade(owner,13,nil,nil)      
        UTIL_Remove( item ) 
    end
end 


end




function dota1x6:OnGlyphUsed( params )

local team = params.teamnumber
GameRules:SetGlyphCooldown( team, glyph_cd )

local heroes = dota1x6:FindPlayers(team, true)
CustomGameEventManager:Send_ServerToAllClients( 'glyph_used', {heroes = heroes} )

local towers = FindUnitsInRadius( team, Vector(0, 0, 0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
for _,tower in pairs(towers) do
    if tower:FindModifierByName("modifier_fountain_glyph") then 
        tower:FindModifierByName("modifier_fountain_glyph"):SetDuration(glyph_duration, true)
    end
end

end


function dota1x6:ExpFilter(params)
if params.reason_const == DOTA_ModifyXP_HeroKill then 
    return false
end 
return true
end 


function dota1x6:CountKill()
dota1x6.KillCount = dota1x6.KillCount + 1
end 


function dota1x6:OnPlayerLevelUp(data)

local hero = EntIndexToHScript(data.hero_entindex)

if hero then 
    local mod = hero:FindModifierByName("modifier_voice_module")
    if mod then 
        mod:LevelEvent()
    end 
end 

end 



function dota1x6:OnEntityKilled(param)
if param.entindex_attacker == nil then return end

local hero = EntIndexToHScript(param.entindex_attacker)
local unit = EntIndexToHScript(param.entindex_killed)

if unit:IsTempestDouble() then return end

local hero_id = hero:GetId()
local unit_id = unit:GetId()
local hero_player = players[hero_id]
local unit_player = players[unit_id]
local max_dist = 1200

if hero_player and unit:IsValidKill(hero) then 
    hero_player:GiveKillExp(unit)
end 

local no_purple_for_hero = false

if hero.owner ~= nil then
    hero = hero.owner
end


if (hero:GetQuest() ~= nil) and hero:GetUnitName() ~= unit:GetUnitName() then 

    if (hero:GetQuest() == "General.Quest_1") and unit:GetTeamNumber() == DOTA_TEAM_NEUTRALS and not unit:IsPatrolCreep() then 
        hero:UpdateQuest(1)
    end

    if (hero:GetQuest() == "General.Quest_2") and unit:IsPatrolCreep() then 
        hero:UpdateQuest(1)
    end

    if (hero:GetQuest() == "General.Quest_17") and unit:GetTeamNumber() == DOTA_TEAM_NEUTRALS and unit:IsAncient() then 
        hero:UpdateQuest(1)
    end

    if (hero:GetQuest() == "General.Quest_3") and unit:GetTeamNumber() ~= hero:GetTeamNumber() and (unit:GetUnitName() == "npc_dota_observer_wards" or unit:GetUnitName() == "npc_dota_sentry_wards") then 
        hero:UpdateQuest(1)
    end

    if (hero:GetQuest() == "General.Quest_4") and unit:IsRealHero() and not unit:IsReincarnating() then 
        hero:UpdateQuest(1)
    end

    if (hero:GetQuest() == "Mars.Quest_8") and unit:IsRealHero() and not unit:IsReincarnating() and unit:HasModifier("modifier_mars_arena_of_blood_custom_projectile_aura") then 
        hero:UpdateQuest(1)
    end

    if (hero:GetQuest() == "Never.Quest_6" or hero:GetQuest() == "Blood.Quest_7") and unit:IsRealHero() and not unit:IsReincarnating() then 

        if hero.quest.extra_data == nil then 
            hero.quest.extra_data = {}
        end

        if not hero.quest.extra_data[unit:GetUnitName()] then 

            hero.quest.extra_data[unit:GetUnitName()] = true
            hero:UpdateQuest(1)
        end
    end

    if (hero:GetQuest() == "Terr.Quest_6") and EntIndexToHScript(param.entindex_attacker):IsIllusion() and unit:GetTeamNumber() == DOTA_TEAM_NEUTRALS and not unit:IsPatrolCreep() then 
        hero:UpdateQuest(1)
    end


    if (hero:GetQuest() == "General.Quest_16") and unit:IsRealHero() and hero:HasModifier("modifier_item_custom_smoke_quest_kill") then 
        hero:UpdateQuest(1)
    end
end



if unit:IsRealHero() and not unit:IsCreepHero() and unit:IsReincarnating() == false then
    
    if hero and hero_player then 
        hero_player.kills_done = hero_player.kills_done + 1
    end

    if not unit.died_on_duel then
        if unit_player then

            if hero_player and hero ~= unit and hero:IsHero() and unit:HasModifier("modifier_player_main_custom") then

                local target_array = unit_player
                local killer_array = hero_player
                local mod = unit:FindModifierByName("modifier_player_main_custom")
                if mod then 
                    if mod:GetStackCount() >= Player_damage_max then 
                        no_purple_for_hero = true
                    end 
                    if mod:GetStackCount() < Player_damage_max then 
                        mod:IncrementStackCount()
                    end
                end 

                mod = hero:FindModifierByName("modifier_player_main_custom")
                if mod then 
                    mod:SetStackCount(0)
                end 
            end

            if hero_player ~= nil and hero ~= unit and hero:IsHero() then
                local target_array = unit_player
                local killer_array = hero_player

                if killer_array.hero_kills[unit:GetTeamNumber()] == nil then 
                    killer_array.hero_kills[unit:GetTeamNumber()] = 0
                end

                killer_array.hero_kills[unit:GetTeamNumber()] = killer_array.hero_kills[unit:GetTeamNumber()] + 1

                if target_array then 
                    target_array.hero_kills[hero:GetTeamNumber()] = 0
                end
            end

            if hero:IsHero() then
                local net_killer = 0
                local net_victim = 0

                local heroes = {}

                for id,player in pairs(players) do 
                    if player:GetTeamNumber() == unit:GetTeamNumber() then
                        net_victim = net_victim + players[id].networth-- PlayerResource:GetNetWorth(id)
                    elseif player:GetTeamNumber() == hero:GetTeamNumber() then
                        if player == hero or (player:GetAbsOrigin() - unit:GetAbsOrigin()):Length2D() <= max_dist then
                            heroes[#heroes + 1] = player
                        end
                        net_killer = net_killer + players[id].networth --PlayerResource:GetNetWorth(id)
                    end
                end

                if net_victim > net_killer and #heroes > 0 then
                    local more_gold = ((net_victim - net_killer) * Streak_k)/#heroes
                    for _,player in pairs(heroes) do
                        player:ModifyGoldFiltered(more_gold, true, DOTA_ModifyGold_HeroKill)
                        player:SendNumber(0, more_gold)
                    end
                end
            end

            local target = unit:FindModifierByName("modifier_the_hunt_custom_hero")
            local respawn_mod = unit:FindModifierByName("modifier_patrol_reward_2_respawn")

            local tower = towers[unit:GetTeamNumber()]

            local killed_by_hero = false
            if hero:IsRealHero() or (hero.owner ~= nil and hero:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_5) then 
                killed_by_hero = true
            end 

            local new_respawn = StartDeathTimer + dota1x6.current_wave*DeathTimer_PerWave
            local ids = dota1x6:FindPlayers(unit:GetTeamNumber())
            if ids and #ids == 2 then
                new_respawn = new_respawn*(1 + DeathTimerDuo)
            end

            local respawn_k = 1

            if tower and tower:HasModifier("modifier_tower_armor_aura") then 
                respawn_k = respawn_k - tower:FindModifierByName("modifier_tower_armor_aura").respawn
            end

            respawn_k = math.max(0, respawn_k)
            new_respawn = new_respawn * respawn_k

            if (killed_by_hero and target) then 
                new_respawn = Short_Respawn_target
                target:Destroy()
            end

            if respawn_mod and respawn_mod.respawn_time then 
                new_respawn = respawn_mod.respawn_time
                respawn_mod:Proc()
            end 
            unit:SetTimeUntilRespawn(new_respawn)

            if unit.is_bot then 
                unit:SetTimeUntilRespawn(5)
            end 
            
            unit_player.death = unit_player.death + 1
        else
            unit:SetTimeUntilRespawn(5)
        end
    end
end


if not hero:IsHero() and not hero:IsBuilding() then
    return
end

local drop = true

if (unit:GetTeam() == DOTA_TEAM_CUSTOM_5) and unit.ally and not unit.is_necro_creep then
    local count_mob = 0

    for i = 1, #unit.ally do
        if not unit.ally[i]:IsNull() and unit.ally[i] ~= unit then

            if unit.ally[i]:IsAlive() then
                drop = false
                count_mob = count_mob + 1
            end
        end

        if unit.ally[i].dropped then 
            drop = false
            break
        end
    end

    if drop == true then 
        unit.dropped = true 
    end

    if unit.host_team then
        local ids = dota1x6:FindPlayers(unit.host_team)
        if ids then
            for _,id in pairs(ids) do
                local player = players[id]
                if player then
                    local distance = (player:GetAbsOrigin() - hero:GetAbsOrigin()):Length2D()

                    if not hero:IsBuilding() and hero ~= player and distance <= max_dist and player:IsAlive() then
                        local gold = unit:GetMaximumGoldBounty()
                        player:ModifyGoldFiltered(gold, true, DOTA_ModifyGold_CreepKill)
                        player:SendNumber(0, gold)
                    end

                    local reward = dota1x6:GetReward(unit.current_wave_number, player)

                    if dota1x6:FinalDuel() == false then
                        player.ActiveWave = {units = count_mob, units_max = unit.max, name = dota1x6:GetWave(unit.wave_number, unit.isboss), skills = dota1x6:GetSkills(unit.wave_number, unit.isboss), mkb = dota1x6:GetMkb(unit.wave_number, unit.isboss), reward = reward, gold = unit.more_gold, show_gold = unit.show_gold, number = dota1x6.current_wave} 
                    end
                    if drop then
                        if unit.lownet == 1 then
                            dota1x6:InitLowNet(player)
                        end
                        player.ActiveWave = nil

                        local get_drop = false

                        if hero == player then
                            get_drop = true
                        else
                            if reward == 4 or reward == 3 then
                                get_drop = true
                            end

                            if reward == 1 and player:IsAlive() and distance <= max_dist then
                                get_drop = true
                            end
                        end

                        if get_drop and not DontUpgradeCreeps then
                            dota1x6:CreateUpgradeOrb(player, reward)
                            if reward == 4 and pro_mod and pro_mod_data.double_legendary then
                                dota1x6:CreateUpgradeOrb(player, reward)    
                            end
                        end
                    end
                end
            end
        end
    end
end

if (unit:GetTeam() == DOTA_TEAM_NEUTRALS or unit:IsBuilding()) and hero_player and not hero:HasModifier("modifier_duel_hero_thinker") and not hero:HasModifier("modifier_item_midas_noblue") 
    and BluePoints[unit:GetUnitName()] or Shared_Bounty[unit:GetUnitName()] then
        
    local points 
    if BluePoints[unit:GetUnitName()] then
        points = BluePoints[unit:GetUnitName()]
        dota1x6:AddBluePoints(hero, points, true)
    end
    if Shared_Bounty[unit:GetUnitName()] then
        points = Shared_Bounty[unit:GetUnitName()].blue
        local gold = Shared_Bounty[unit:GetUnitName()].gold

        local ids = dota1x6:FindPlayers(hero:GetTeamNumber())
        if ids and gold then
            points = points/#ids
            gold = gold/#ids
            for _,id in pairs(ids) do
                local player = players[id]
                if player then
                    dota1x6:AddBluePoints(player, points, true)
                    player:ModifyGoldFiltered(gold, true, DOTA_ModifyGold_CreepKill)
                    player:SendNumber(0, gold)
                end
            end
        end
    end
end



if unit:IsRealHero() and not unit:IsCreepHero() and unit_player and (not no_purple_for_hero or test) and hero:GetTeamNumber() ~= unit:GetTeamNumber() 
    and (not dota1x6:FinalDuel() or duel_data[#duel_data].rounds == 0) and not unit:IsReincarnating() then

    local more_heroes = dota1x6:FindPlayers(hero:GetTeamNumber(), false, true)
    local near_heroes = {}

    for _,ally in pairs(more_heroes) do
        if (ally:GetAbsOrigin() - unit:GetAbsOrigin()):Length2D() <= max_dist or ally == hero then
            near_heroes[#near_heroes + 1] = ally
        end
    end

    local reward_for = nil
    if #near_heroes == 1 then
        reward_for = near_heroes[1]
    elseif #near_heroes == 2 then
        local tower = towers[hero:GetTeamNumber()]
        for _,near_hero in pairs(near_heroes) do
            if near_hero ~= tower.last_reward_for then
                tower.last_reward_for = near_hero
                reward_for = near_hero
                near_hero:GenericParticle("particles/ui/purple_orb_point.vpcf")
                break
            end
        end
    end

    if reward_for then
        dota1x6:AddPurplePoints(reward_for, 1)
    end
end

end




function dota1x6:ReconnectFilter(pid)

local player = PlayerResource:GetPlayer(pid)
local team = PlayerResource:GetTeam(pid)
local hero = GlobalHeroes[pid]
local player_table = players[pid]

if player == nil then return end
if hero == nil then return end
if player_table == nil then return end

CustomGameEventManager:Send_ServerToPlayer(player, "pick_end", {})

Timers:CreateTimer(FrameTime(), function()
    wearables_system:UpdateClientData()
end)

Timers:CreateTimer(3, function()
    for _, player_unit in pairs(players) do 
        FireGameEvent("event_init_unit", 
        {
            hero_name = player_unit:GetUnitName(),
        })
        wearables_system:UpdateFullParticleForPlayer(player_unit:GetPlayerOwnerID(), player_unit, pid)
        if player_unit.current_emblem then
            if player_unit.current_emblem and _G.EmblemsListPFX and _G.EmblemsListPFX[player_unit.current_emblem] then
                if not player_unit.reconnects_emblems then
                    player_unit.reconnects_emblems = {}
                end
                table.insert(player_unit.reconnects_emblems, ParticleManager:CreateParticleForPlayer(_G.EmblemsListPFX[player_unit.current_emblem], PATTACH_ABSORIGIN_FOLLOW, player_unit, player))
            end
        end
    end
end)

for _,player in pairs(players) do
    FireGameEvent("save_talents", 
    {
        hero_name = player:GetUnitName(),
    })
end

Timers:CreateTimer(1.5,  function()
    CustomGameEventManager:Send_ServerToPlayer(player, "init_chat", {tools = IsInToolsMode(), cheat = GameRules:IsCheatMode(), valid = HTTP.IsValidGame(PlayerCount)})

    for _,player in pairs(players) do
        FireGameEvent("save_abilities", 
        {
            ent_index = player:entindex(),
        })
    end

    hero:UpdateQuest(0)

    local tempest_ability = hero:FindAbilityByName("arc_warden_tempest_double_custom")
    if tempest_ability then
        tempest_ability:ReconnectProc()
    end

    dota1x6:GiveVisionForAll(2, hero:GetTeamNumber())

    Timers:CreateTimer(1, function()
        hero:UpdateTalentsClient()
    end)

    if sale_alert and not test then
        CustomGameEventManager:Send_ServerToPlayer(player, 'show_sale_alert', {} ) 
    end

    CustomGameEventManager:Send_ServerToPlayer(player, "set_test_mode",  {state = _G.TestMode})
    CustomGameEventManager:Send_ServerToAllClients( 'lua_wtf_mode', {wtf = _G.WtfMode} )
    CustomGameEventManager:Send_ServerToAllClients( 'lua_timer_stop', {stop = _G.TimerStop})

    CustomGameEventManager:Send_ServerToPlayer(player, 'init_hero_level', {} ) 
    CustomGameEventManager:Send_ServerToPlayer(player, 'end_loading', {} )
    CustomGameEventManager:Send_ServerToPlayer(player, 'PreGameEnd_top', {} )

    CustomGameEventManager:Send_ServerToPlayer(player, 'init_damage_table', {subscribed = player_table.subscribed} ) 
    CustomGameEventManager:Send_ServerToPlayer(player, 'reconnect_hero_image', { } ) 

    for target_pid, player_unit in pairs(players) do
        CustomGameEventManager:Send_ServerToPlayer(player, 'reconnect_hero_levels', {hero = player_unit:GetUnitName()} ) 
        if player_unit and player_unit.pet and IsValid(player_unit.pet) then
            CustomGameEventManager:Send_ServerToAllClients('event_update_pets_index', {index = player_unit.pet:GetEntityIndex()})
        end
    end

    if hero:HasAbility("invoker_invoke_custom") then
        CustomGameEventManager:Send_ServerToPlayer(player, "initInvokerPanel",  {})
        if hero:HasTalent("modifier_invoker_invoke_7") then
            CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(hero:GetPlayerOwnerID()), 'invoker_hide_neutral', {} ) 
        end
    end

    if player_table.goodwin_quest and (test or pro_mod) and false then
        CustomGameEventManager:Send_ServerToPlayer(player, 'goodwin_quest_icon', {id = player_table.goodwin_quest} ) 
    end

    CustomGameEventManager:Send_ServerToPlayer(player, 'init_custom_item_build', {}) 

    CustomGameEventManager:Send_ServerToPlayer(player, "kill_progress",
    {
        blue = math.floor(player_table.bluepoints),
        purple = player_table.purplepoints,
        max = player_table.bluemax,
        max_p = math.floor(player_table.purplemax)
    })

    if player_table:HasModifier("modifier_end_choise") then
        CustomGameEventManager:Send_ServerToPlayer( player,
        "show_choise",
        {
            choise = player_table.choise_table[1],
            mods = player_table.choise_table[4],
            hasup = player_table.choise_table[3],
            alert = player_table.choise_table[2],
            refresh = player_table.choise_table[5]
        })
    end
end)

end



function dota1x6:ItemPurchased(data)
local player = players[data.PlayerID]
if not player then return end
if data.itemname ~= "item_purple_upgrade_shop" then return end
if player.got_purple then

    for i = 0,20 do
        local item = player:GetItemInSlot(i)
        local stop = false
        if item and item:GetName() == data.itemname then
            UTIL_Remove(item)
            player:ModifyGoldFiltered(data.itemcost, true, DOTA_ModifyGold_SellItem)
            stop = true
        end

        if player.player_courier and not stop then
            item = player.player_courier:GetItemInSlot(i)
            if item and item:GetName() == data.itemname then
                UTIL_Remove(item)
                player:ModifyGoldFiltered(data.itemcost, true, DOTA_ModifyGold_SellItem)
                stop = true
            end
        end

        if stop then
            break
        end
    end

    return
end

player.purple = player.purple + 1
player.got_purple = true
end




function dota1x6:ItemAddedFilter( keys )

local unit = EntIndexToHScript(keys.inventory_parent_entindex_const)
if unit == nil then return true end
local item = EntIndexToHScript(keys.item_entindex_const)
if item == nil then return true end
if unit:GetUnitName() == "npc_dota_hero_invoker" and unit:HasTalent("modifier_invoker_invoke_7") then
    if item:IsActiveNeutral() and item:GetName() ~= "item_invoker_custom_legendary" then
        local item = CreateItem("item_invoker_custom_legendary", unit, unit)
        unit:AddItem(item)
        return false
    end
end
return true
end


function dota1x6:ModifyGoldFilter(params)

local gold = params.gold
local player = players[params.player_id_const]
local reason = params.reason_const

if player and gold > 0 and reason ~= DOTA_ModifyGold_AbandonedRedistribute and reason ~= DOTA_ModifyGold_SellItem then
    player.networth = player.networth + gold
end

return true
end