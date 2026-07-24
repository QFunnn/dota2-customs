--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("item_ability.item_ranged_cleave")

---@class CDOTA_Item_Lua
item_ranged_cleave_2 = class(item_ranged_cleave)

LinkLuaModifier("modifier_item_ranged_cleave_2", "item_ability/item_ranged_cleave_2", LUA_MODIFIER_MOTION_NONE)

---@return string
function item_ranged_cleave_2:GetIntrinsicModifierName()
	return "modifier_item_ranged_cleave_2"
end

---@class CDOTA_Modifier_Lua
modifier_item_ranged_cleave_2 = class({})

for key, value in pairs(modifier_item_ranged_cleave) do
	modifier_item_ranged_cleave_2[key] = value
end