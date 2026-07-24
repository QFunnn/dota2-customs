--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


elder_titan_tip_the_scales_lua = class({})
LinkLuaModifier("modifier_elder_titan_tip_the_scales_lua", "abilities/heroes/elder_titan/elder_titan_tip_the_scales", LUA_MODIFIER_MOTION_NONE)

function elder_titan_tip_the_scales_lua:GetIntrinsicModifierName()
	return "modifier_elder_titan_tip_the_scales_lua"
end


---------------------------------------------------------------------------------------------------------------------------------------------------


modifier_elder_titan_tip_the_scales_lua = class({})

function modifier_elder_titan_tip_the_scales_lua:IsHidden() return true end
function modifier_elder_titan_tip_the_scales_lua:IsDebuff() return false end
function modifier_elder_titan_tip_the_scales_lua:IsPurgable() return false end
function modifier_elder_titan_tip_the_scales_lua:RemoveOnDeath() return false end
function modifier_elder_titan_tip_the_scales_lua:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_elder_titan_tip_the_scales_lua:OnCreated()
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then return end
	self.ability = self:GetAbility()
	if not IsValidEntity(self.ability) then return end

	self.common_orb_generation_rate_pct = self.ability:GetSpecialValueFor("common_orb_generation_rate_pct") or 0
end

function modifier_elder_titan_tip_the_scales_lua:OnRefresh()
	self:OnCreated()
end