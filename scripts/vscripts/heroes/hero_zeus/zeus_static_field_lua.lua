--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


zeus_static_field_lua = class({})
LinkLuaModifier("modifier_zeus_static_field_lua", "heroes/hero_zeus/modifier_zeus_static_field_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zeus_static_field_shock_lua", "heroes/hero_zeus/modifier_zeus_static_field_shock_lua", LUA_MODIFIER_MOTION_NONE)


function zeus_static_field_lua:GetIntrinsicModifierName()
	return "modifier_zeus_static_field_lua"
end


function zeus_static_field_lua:GetBehavior()
	if self:GetCaster():HasShard() then
		return  DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT + DOTA_ABILITY_BEHAVIOR_NO_TARGET
	end
	return DOTA_ABILITY_BEHAVIOR_PASSIVE 
end

-- shard upgrade
function zeus_static_field_lua:OnSpellStart()
	local caster = self:GetCaster()
	caster:AddNewModifier(caster, self, "modifier_zuus_heavenly_jump", {})

	local intrinsic_mod = caster:FindModifierByName("modifier_zeus_static_field_lua")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		self:GetSpecialValueFor("hop_shock_radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
		FIND_CLOSEST,
		false
	)

	if #enemies == 0 then return end

	local shock_target = enemies[1]
	local slow_duration = self:GetSpecialValueFor("hop_slow_duration")

	if IsValid(intrinsic_mod) then
		intrinsic_mod:Shock(shock_target, true)
	end
	shock_target:AddNewModifier(caster, self, "modifier_zuus_static_field_slow", {duration = slow_duration})
end

