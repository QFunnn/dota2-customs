--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ghost_frost_attack = class({})

LinkLuaModifier("modifer_ghost_frost_attack_lua", "abilities/heroes/doom/ghost_frost_attack", LUA_MODIFIER_MOTION_NONE)

function ghost_frost_attack:GetIntrinsicModifierName()
	return "modifer_ghost_frost_attack_lua"
end

modifer_ghost_frost_attack_lua = class({})

function modifer_ghost_frost_attack_lua:IsHidden() return true end
function modifer_ghost_frost_attack_lua:IsPurgable() return false end
function modifer_ghost_frost_attack_lua:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifer_ghost_frost_attack_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifer_ghost_frost_attack_lua:GetModifierProcAttack_Feedback(event)
	if event.attacker:PassivesDisabled() then return end
	if event.target:GetTeamNumber() == event.attacker:GetTeamNumber() then return end
	if event.target:IsOther() or event.target:IsBuilding() then return end

	local ability = self:GetAbility()

	local duration = ability:GetSpecialValueFor("duration") * (1 - event.target:GetStatusResistance())
	event.target:AddNewModifier(event.attacker, ability, "modifier_ghost_frost_attack_slow", {duration = duration})
end