--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


kotl_chakra_burn = class({})
LinkLuaModifier("modifier_kotl_chakra_burn", "heroes/hero_keeper_of_the_light/modifier_kotl_chakra_burn", LUA_MODIFIER_MOTION_NONE)
-- LinkLuaModifier("modifier_kotl_chakra_burn_debuff", "heroes/hero_keeper_of_the_light/modifier_kotl_chakra_burn_debuff", LUA_MODIFIER_MOTION_NONE)
--LinkLuaModifier( "modifier_kotl_mana_drain_winter_effect", "modifiers/heroes/modifier_kotl_mana_drain_winter_effect", LUA_MODIFIER_MOTION_NONE )

function kotl_chakra_burn:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end
function kotl_chakra_burn:OnSpellStart()
	local hCaster = self:GetCaster()
	local hAbility = self
	local vPos = self:GetCursorPosition()
	local purge_target = self:GetSpecialValueFor("purge_target")
	local radius = self:GetSpecialValueFor("radius")
	local max_stack = self:GetSpecialValueFor("max_stack")
	local int_factor = self:GetSpecialValueFor("int_factor")
	local min_stack = self:GetSpecialValueFor("min_stack")
	local duration = self:GetSpecialValueFor("duration")

	EmitSoundOn("Hero_KeeperOfTheLight.ManaLeak.Cast", hCaster)

	local total_stack = hCaster:GetIntellect(true) * int_factor * 0.01

	local targets = {}
	local units = FindUnitsInRadius(hCaster:GetTeamNumber(), vPos, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_ANY_ORDER, false)
	for _, unit in pairs(units) do
		if IsValid(unit) and unit:IsAlive() then
			table.insert(targets, unit)
		end
	end
	local nFXIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_cast02.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlEnt(nFXIndex, 0, hCaster, PATTACH_POINT_FOLLOW, "attach_attack1", hCaster:GetOrigin(), true)
	ParticleManager:ReleaseParticleIndex(nFXIndex)
	for _, target in pairs(targets) do
		if purge_target > 0 then
			target:Purge(true, false, false, false, false)
		end
		local stack = total_stack / #targets
		stack = math.min(max_stack, stack)
		stack = math.max(min_stack, stack)
		target:AddNewModifier(hCaster, hAbility, "modifier_kotl_chakra_burn", { duration = duration * target:GetStatusResistanceFactor(hCaster), stack = stack })
	end


end