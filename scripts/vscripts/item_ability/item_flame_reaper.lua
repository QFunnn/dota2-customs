--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_last_laugh", "item_ability/item_last_laugh.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_last_laugh_active", "item_ability/item_last_laugh.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_last_laugh_disable", "item_ability/item_last_laugh.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_flame_reaper == nil then
	item_flame_reaper = class({})
end
function item_flame_reaper:OnSpellStart()
	local hCaster = self:GetCaster()
	if IsValid(hCaster) and hCaster:IsAlive() then
		local duration = self:GetSpecialValueFor("duration")
		hCaster:AddNewModifier(hCaster, self, "modifier_item_last_laugh_active", { duration = duration })
		EmitSoundOn("DOTA_Item.PhaseBoots.Activate", hCaster)
		-- EmitSoundOn("DOTA_Item.MaskOfMadness.Activate", hCaster)
	end
end
function item_flame_reaper:GetIntrinsicModifierName()
	return "modifier_item_last_laugh"
end