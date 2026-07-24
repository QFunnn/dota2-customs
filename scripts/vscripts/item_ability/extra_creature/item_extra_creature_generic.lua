--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_extra_creature_generic = class({}) ---@class item_extra_creature_generic : CDOTA_Item_Lua

function item_extra_creature_generic:OnSpellStart()
    if not IsServer() then return end

    local hCaster = self:GetCaster()
    if not hCaster or hCaster:IsTempestDouble() or hCaster:HasModifier("modifier_arc_warden_tempest_double_lua") then return end

    local hPlayer = hCaster:GetPlayerOwner()

    local playerId
    if hPlayer then
        playerId = hPlayer:GetPlayerID()
    else
        playerId = -1
    end
    ExtraCreature:AddExtraCreature(playerId, self:GetAbilityKeyValues().AbilityValues.creature_name)
    self:SpendCharge()
end

local extraCreatureItems = {
    "item_extra_creature_satyr_trickster",
    "item_extra_creature_big_thunder_lizard",
    "item_extra_creature_spider_range",
    "item_extra_creature_dark_troll_warlord",
    "item_extra_creature_ghost",
    "item_extra_creature_centaur_khan",
    "item_extra_creature_prowler_shaman",
    "item_extra_creature_granite_golem",
    "item_extra_creature_rock_golem",
    "item_extra_creature_gnoll_assassin",
    "item_extra_creature_kobold",
    "item_extra_creature_timber_spider",
    "item_extra_creature_explode_spider",
    "item_extra_creature_elf_wolf",
}

for _, name in ipairs(extraCreatureItems) do
    _G[name] = item_extra_creature_generic
end