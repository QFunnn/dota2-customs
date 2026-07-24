--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


Filters = Filters or {}

require("filters/damage")
require("filters/modifier")
require("filters/order")
require("filters/item")
require("filters/experience")
require("filters/gold")
require("filters/healing")

function Filters:Init()
	local game_mode_entity = GameRules:GetGameModeEntity()

	-- game_mode_entity:SetModifierGainedFilter(Dynamic_Wrap(Filters, "ModifierFilter"), Filters)
	-- game_mode_entity:SetDamageFilter(Dynamic_Wrap(Filters, "DamageFilter"), Filters)
	-- game_mode_entity:SetModifyExperienceFilter(Dynamic_Wrap(Filters, "FilterModifyExperience"), Filters)
	-- game_mode_entity:SetModifyGoldFilter(Dynamic_Wrap(Filters, "ModifyGoldFilter"), Filters)

	game_mode_entity:SetExecuteOrderFilter(Dynamic_Wrap(Filters, "ExecuteOrderFilter"), Filters)
	game_mode_entity:SetItemAddedToInventoryFilter(Dynamic_Wrap(Filters, "ItemAddedToInventoryFilter"), Filters)
	game_mode_entity:SetHealingFilter(Dynamic_Wrap(Filters, "HealingFilter"), Filters)
end