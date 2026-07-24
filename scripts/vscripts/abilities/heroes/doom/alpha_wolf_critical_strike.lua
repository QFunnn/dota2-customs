--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


alpha_wolf_critical_strike = class({})

LinkLuaModifier("modifer_alpha_wolf_critical_strike_lua", "abilities/heroes/doom/alpha_wolf_critical_strike", LUA_MODIFIER_MOTION_NONE)

function alpha_wolf_critical_strike:GetIntrinsicModifierName()
	return "modifer_alpha_wolf_critical_strike_lua"
end

modifer_alpha_wolf_critical_strike_lua = class({})

function modifer_alpha_wolf_critical_strike_lua:IsHidden() return true end
function modifer_alpha_wolf_critical_strike_lua:IsPurgable() return false end
function modifer_alpha_wolf_critical_strike_lua:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifer_alpha_wolf_critical_strike_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}
end

function modifer_alpha_wolf_critical_strike_lua:OnCreated()
	self.parent = self:GetParent()
	
	self:OnRefresh()
end


function modifer_alpha_wolf_critical_strike_lua:OnRefresh()
	local ability = self:GetAbility()
	
	self.crit_chance = ability:GetSpecialValueFor("crit_chance")
	self.crit_mult = ability:GetSpecialValueFor("crit_mult")
end

function modifer_alpha_wolf_critical_strike_lua:GetCritDamage()
	return self.crit_mult * 0.01
end

function modifer_alpha_wolf_critical_strike_lua:GetModifierPreAttack_CriticalStrike(event)
	if event.attacker:PassivesDisabled() then return end
	if event.target:GetTeamNumber() == event.attacker:GetTeamNumber() then return end
	if event.target:IsOther() or event.target:IsBuilding() then return end

	if RollPseudoRandomPercentage(self.crit_chance, DOTA_PSEUDO_RANDOM_WOLF_CRIT, self.parent) then
		return self.crit_mult
	end
end