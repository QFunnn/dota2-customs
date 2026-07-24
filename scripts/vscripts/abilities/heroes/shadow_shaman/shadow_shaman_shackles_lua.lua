--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


shadow_shaman_shackles_lua = class({})
LinkLuaModifier("modifier_shadow_shaman_serpent_ward_chc", "abilities/heroes/shadow_shaman/modifier_shadow_shaman_serpent_ward_chc", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shadow_shaman_shackles_dummy_duration", "abilities/heroes/shadow_shaman/modifier_shadow_shaman_shackles_dummy_duration", LUA_MODIFIER_MOTION_NONE)

function shadow_shaman_shackles_lua:GetChannelTime()
	if self.channel_duration then return self.channel_duration end

	return self:GetSpecialValueFor("channel_time")
end

function shadow_shaman_shackles_lua:GetAssociatedSecondaryAbilities()
	return "shadow_shaman_mass_serpent_ward_lua"
end

local wards_names = {
	npc_dota_shadow_shaman_ward_1 = true,
	npc_dota_shadow_shaman_ward_2 = true,
	npc_dota_shadow_shaman_ward_3 = true,
}

function shadow_shaman_shackles_lua:CastFilterResultTarget(target)
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end

	local alt_cast_on_allies = self:GetSpecialValueFor("alt_cast_on_allies")

	if target == caster then
		return UF_FAIL_CUSTOM
	end

	local caster_team = caster:GetTeamNumber()

	if alt_cast_on_allies > 0 and wards_names[target:GetUnitName()] then
		return UF_SUCCESS
	end

	local team_check = DOTA_UNIT_TARGET_TEAM_ENEMY
	if alt_cast_on_allies > 0 and target ~= caster and target:GetTeamNumber() == caster_team then
		team_check = DOTA_UNIT_TARGET_TEAM_BOTH
	end

	return UnitFilter(target, team_check, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, caster_team)
end

function shadow_shaman_shackles_lua:GetCustomCastErrorTarget( hTarget )
	return "#dota_hud_error_cant_cast_on_self"
end

function shadow_shaman_shackles_lua:OnSpellStart()
	-- unit identifier
	local target = self:GetCursorTarget()
	local caster = self:GetCaster()
	self.shackle_target = target

	-- cancel if linken
	if target:TriggerSpellAbsorb(self) then
		Timers:CreateTimer(0.01, function()
			if not IsValidEntity(self) then return end
			self:EndChannel(true)
		end)
		return
	end

	local duration = self:GetSpecialValueFor("channel_time") * (1 - target:GetStatusResistance())

	-- Total Damage and tick damage is calculated in the modifier
	local modifier = target:AddNewModifier(caster, self, "modifier_shadow_shaman_shackles", {duration = duration})

	if modifier then
		caster:AddNewModifier(caster, self, "modifier_shadow_shaman_shackles_dummy_duration", {duration = modifier:GetDuration()})
	end

	-- Particles
	EmitSoundOn("Hero_ShadowShaman.shackles.Cast", caster)

	self.shackles_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_shadowshaman/shadowshaman_shackle.vpcf", PATTACH_POINT_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(self.shackles_pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(self.shackles_pfx, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(self.shackles_pfx, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(self.shackles_pfx, 4, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)

	ParticleManager:SetParticleControlEnt(self.shackles_pfx, 5, caster, PATTACH_POINT_FOLLOW, "attach_attack1", caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(self.shackles_pfx, 6, caster, PATTACH_POINT_FOLLOW, "attach_attack2", caster:GetAbsOrigin(), true)
end

function shadow_shaman_shackles_lua:OnChannelFinish()
	local caster = self:GetCaster()
	caster:RemoveModifierByName("modifier_shadow_shaman_shackles_dummy_duration")

	StopSoundOn("Hero_ShadowShaman.Shackles", caster)
	if self.shackles_pfx then
		ParticleManager:DestroyParticle(self.shackles_pfx, false)
		ParticleManager:ReleaseParticleIndex(self.shackles_pfx)
	end
end