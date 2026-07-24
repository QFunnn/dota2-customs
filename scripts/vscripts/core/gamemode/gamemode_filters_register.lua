--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("core.gamemode.filters.add_to_inventory_filter")
require("core.gamemode.filters.damage_filter")
require("core.gamemode.filters.exp_filter")
require("core.gamemode.filters.gold_filter")
require("core.gamemode.filters.modifier_gained_filter")
require("core.gamemode.filters.order_filter")

function GameMode:RegisterFilters()
    local gmEntity = GameRulesCustom:GetGameModeEntity()

    gmEntity:SetDamageFilter(self.DamageFilter, self)
    gmEntity:SetExecuteOrderFilter(self.OrderFilter, self)
    gmEntity:SetModifierGainedFilter(self.ModifierGainedFilter, self)
    gmEntity:SetItemAddedToInventoryFilter(self.AddedToInventoryFilter, self)
    gmEntity:SetModifyGoldFilter(self.ModifyGoldFilter, self)
    gmEntity:SetModifyExperienceFilter(self.ModifyExpFilter, self)

    gmEntity:SetSelectionGoldPenaltyEnabled(false)
    gmEntity:SetBuybackEnabled(false)
    gmEntity:SetTPScrollSlotItemOverride("item_smoke_of_deceit_lua")
    gmEntity:SetGiveFreeTPOnDeath(false)
    gmEntity:SetLoseGoldOnDeath(false)
    GameRulesCustom:SetTreeRegrowTime(60)
    GameRulesCustom:SetFilterMoreGold(true)
end