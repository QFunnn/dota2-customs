--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



--Abilities
if item_reroll_token_lua_tier3 == nil then
	item_reroll_token_lua_tier3 = class({})
end
function item_reroll_token_lua_tier3:OnSpellStart()
	local hCaster = self:GetCaster()
	local choice = self:GetSpecialValueFor("choice")
	local tier = self:GetSpecialValueFor("tier")
	if hCaster:IsRealHero() then
		ItemLoot:ShowNeutralItemSelect(hCaster:GetPlayerOwnerID(), tier, choice, true)
	end
end