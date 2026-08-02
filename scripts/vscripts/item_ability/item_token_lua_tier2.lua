--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


--Abilities
if item_token_lua_tier2 == nil then
	item_token_lua_tier2 = class({})
end
function item_token_lua_tier2:OnSpellStart()
	local hCaster = self:GetCaster()
	local choice = self:GetSpecialValueFor("choice")
	local tier = self:GetSpecialValueFor("tier")
	if hCaster:IsRealHero() then
		ItemLoot:ShowNeutralItemSelect(hCaster:GetPlayerOwnerID(), tier, choice)
	end
end