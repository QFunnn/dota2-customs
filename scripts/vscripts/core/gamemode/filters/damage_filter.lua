--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


DOTA_DAMAGE_FLAG_NO_DOT = (DOTA_DAMAGE_FLAG_BYPASSES_ALL_BLOCK or 524288) * 2

---@param event DamageFilterEvent
---@return boolean
function GameMode:DamageFilter(event)
    if event.entindex_attacker_const == nil then return true end

    local attacker = EntIndexToHScript(event.entindex_attacker_const)
    local victim = EntIndexToHScript(event.entindex_victim_const)
    local inflictor

    if event.entindex_inflictor_const ~= nil then
        inflictor = EntIndexToHScript(event.entindex_inflictor_const)
    end

    if event.entindex_inflictor_const ~= nil then
        local hAbility = EntIndexToHScript(event.entindex_inflictor_const)
        if hAbility and hAbility.GetAbilityName and "oracle_false_promise" == hAbility:GetAbilityName() then
            if victim and victim:HasModifier("modifier_hero_refreshing") then
                return false
            end
        end
    end

    if attacker and victim then
        local attackerPlayerId = attacker:GetPlayerOwnerID()
        if PlayerResource:IsValidPlayerID(attackerPlayerId) and event.damage > 0 then
            if inflictor then
                local AbilityName = inflictor:GetAbilityName()
                if math.abs(event.damage - victim:GetHealth()) > 1 then
                    DataManager:RecordDamage(attackerPlayerId, AbilityName,
                                             event.damage,
                                             event.damagetype_const)
                end
            else
                DataManager:RecordDamage(attackerPlayerId,
                                         attacker:GetUnitName() .. "AttackDamage",
                                         event.damage,
                                         event.damagetype_const)
            end
        end
    end
    return true
end