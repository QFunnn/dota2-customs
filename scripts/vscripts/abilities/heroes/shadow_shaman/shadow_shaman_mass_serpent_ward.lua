--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@class shadow_shaman_mass_serpent_ward_lua:CDOTA_Ability_Lua
shadow_shaman_mass_serpent_ward_lua = class({})
LinkLuaModifier("modifier_shadow_shaman_serpent_ward_chc", "abilities/heroes/shadow_shaman/modifier_shadow_shaman_serpent_ward_chc", LUA_MODIFIER_MOTION_NONE)

function shadow_shaman_mass_serpent_ward_lua:GetAOERadius()
	return 150
end

function shadow_shaman_mass_serpent_ward_lua:IsHiddenAsSecondaryAbility() return true end
function shadow_shaman_mass_serpent_ward_lua:IsHiddenWhenStolen() return true end

function shadow_shaman_mass_serpent_ward_lua:OnSpellStart()
	local caster            = self:GetCaster()
	local target_point      = self:GetCursorPosition()
	local ward_count		= self:GetSpecialValueFor("ward_count")
	local ward_duration 	= self:GetSpecialValueFor("ward_duration")
	local spawn_radius 		= self:GetSpecialValueFor("spawn_radius")
	local spawn_particle    = "particles/units/heroes/hero_shadowshaman/shadowshaman_ward_spawn.vpcf"

	caster:EmitSound("Hero_ShadowShaman.SerpentWard")

	local spawn_particle_fx = ParticleManager:CreateParticle(spawn_particle, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl( spawn_particle_fx, 0, target_point )
	ParticleManager:ReleaseParticleIndex(spawn_particle_fx)

	self:SummonWards(target_point, ward_count, ward_duration, spawn_radius, nil, false)
end

function shadow_shaman_mass_serpent_ward_lua:SummonWards(position, ward_count, ward_duration, spawn_radius, target, is_mega_ward)
	if ward_count == 0 then return end

	local caster 		= self:GetCaster()
	local ward_hp 		= self:GetSpecialValueFor("hits_to_destroy_creeps")
	local ward_damage	= self:GetSpecialValueFor("ward_damage")
	local model_scale   = 1

	local unit_name = "npc_dota_shadow_shaman_ward_" .. self:GetLevel()

	local angle = 90 - 360 / ward_count

	if is_mega_ward then
		ward_count = 1
		ward_damage	= ward_damage * self:GetSpecialValueFor("mega_ward_multiplier_tooltip")
		ward_hp	= ward_hp * self:GetSpecialValueFor("mega_ward_health_tooltip")
		model_scale = self:GetSpecialValueFor("mega_ward_model_scale_multiplier")
	end

	for i = 1, ward_count do
		angle = angle + 360 / ward_count

		local new_pos = position + RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), Vector(spawn_radius, 0, 0))
		if is_mega_ward then new_pos = position end

		local ward = CreateUnitByName(unit_name, new_pos, true, caster, caster, caster:GetTeamNumber())
		ward:SetControllableByPlayer(caster:GetPlayerOwnerID(), true)
		ward:SetForwardVector(caster:GetForwardVector())

		ward:SetBaseDamageMin(ward_damage)
		ward:SetBaseDamageMax(ward_damage)

		ward:SetBaseMaxHealthUpdate(ward_hp)
		ward:SetModelScale(model_scale)

		if is_mega_ward then
			ward:SetMinimumGoldBounty(ward:GetMinimumGoldBounty() * (self:GetSpecialValueFor("mega_ward_multiplier_tooltip") or 1))
			ward:SetMaximumGoldBounty(ward:GetMaximumGoldBounty() * (self:GetSpecialValueFor("mega_ward_multiplier_tooltip") or 1))
		end

		Timers:CreateTimer(0.01, function()
			self:SetHealth(ward:GetMaxHealth())
		end)

		ward:AddNewModifier(caster, self, "modifier_shadow_shaman_serpent_ward_chc", {duration = ward_duration})

		ResolveNPCPositions(new_pos, 64)

		if target then
			ward:SetAttacking(target)
		end
	end
end