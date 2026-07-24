--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


MULTICAST_BEHAVIOR_NONE = 0
MULTICAST_BEHAVIOR_SAME = 1
MULTICAST_BEHAVIOR_UNSAME = 2
MULTICAST_BEHAVIOR_BONUS = 4 ---Появляется невидимый юнит, который кастует способность

MulticastBehavior = {
    storm_spirit_ball_lightning_lua = {
        behavior = MULTICAST_BEHAVIOR_BONUS,
    },
    enigma_black_hole = {
        behavior = MULTICAST_BEHAVIOR_BONUS,
    },
    ember_spirit_sleight_of_fist = {
        behavior = MULTICAST_BEHAVIOR_BONUS,
        duration = 2,
    },
    tusk_snowball_lua = {
        behavior = MULTICAST_BEHAVIOR_BONUS,
    },
    dark_willow_bedlam = {
        behavior = MULTICAST_BEHAVIOR_BONUS,
        duration = 5,
    },
    frostivus2018_dark_willow_bedlam = {
        behavior = MULTICAST_BEHAVIOR_BONUS,
        duration = 5,
    },
    phoenix_icarus_dive = {
        behavior = MULTICAST_BEHAVIOR_BONUS,
        duration = 2,
    },
    juggernaut_omni_slash = {
        behavior = MULTICAST_BEHAVIOR_BONUS,
        duration = 4.5,
    },
    crystal_maiden_freezing_field = {
        behavior = MULTICAST_BEHAVIOR_BONUS,
        duration = 10,
    },
    pangolier_gyroshell = {
        behavior = MULTICAST_BEHAVIOR_BONUS,
        duration = 10,
    },
    kez_raptor_dance = {
        behavior = MULTICAST_BEHAVIOR_BONUS,
        duration = 2
    },
    void_spirit_astral_step = {
        behavior = MULTICAST_BEHAVIOR_BONUS,
        duration = 2
    },
    monkey_king_boundless_strike = {
        behavior = MULTICAST_BEHAVIOR_BONUS,
        duration = 2
    },
}

---@param ability CDOTABaseAbility
---@return table | nil
function MultiCastFilter(ability)
    local abilityName = ability:GetAbilityName()
    if MulticastBehavior[abilityName] == nil then
        return nil
    end

    if MulticastBehavior[abilityName] ~= nil and MulticastBehavior[abilityName].behavior == MULTICAST_BEHAVIOR_NONE then
        return nil
    end
    return MulticastBehavior[abilityName]
end