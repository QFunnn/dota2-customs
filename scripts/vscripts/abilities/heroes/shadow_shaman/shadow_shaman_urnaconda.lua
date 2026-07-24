--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@class shadow_shaman_urnaconda_lua:CDOTA_Ability_Lua
shadow_shaman_urnaconda_lua = class({})
LinkLuaModifier("modifier_shadow_shaman_urnaconda_thinker", "abilities/heroes/shadow_shaman/shadow_shaman_urnaconda", LUA_MODIFIER_MOTION_NONE)

function shadow_shaman_urnaconda_lua:OnSpellStart()
	local caster = self:GetCaster()
	if not IsValidEntity(caster) then return end
	local target_point = self:GetCursorPosition()

	local projectile_speed = self:GetSpecialValueFor("speed")
	local distance = (target_point - caster:GetAbsOrigin()):Length2D()
	local delay = distance / projectile_speed
	CreateModifierThinker(caster, self, "modifier_shadow_shaman_urnaconda_thinker", {duration = delay}, target_point, caster:GetTeamNumber(), false)
end


------------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_shadow_shaman_urnaconda_thinker = class({})

function modifier_shadow_shaman_urnaconda_thinker:IsHidden() return false end
function modifier_shadow_shaman_urnaconda_thinker:IsDebuff()	return false end
function modifier_shadow_shaman_urnaconda_thinker:IsStunDebuff() return false end
function modifier_shadow_shaman_urnaconda_thinker:IsPurgable() return true end

function modifier_shadow_shaman_urnaconda_thinker:OnCreated(kv)
	if not IsServer() then return end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsValidEntity(self.caster) then return end
	if not IsValidEntity(self.parent) then return end
	if not IsValidEntity(self.ability) then return end

	local projectile_speed = self.ability:GetSpecialValueFor("speed")
	self.radius = self.ability:GetSpecialValueFor("impact_radius")
	self.ward_count = self.ability:GetSpecialValueFor("ward_count")
	self.ward_duration = self.ability:GetSpecialValueFor("ward_duration")
	self.spawn_radius = self.ability:GetSpecialValueFor("spawn_radius")

	local damage = self.ability:GetSpecialValueFor("impact_damage")
	self.damage_table = {
		-- victim = target,
		attacker = self.caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}

	self.caster:EmitSound("Hero_ShadowShaman.Urnaconda.Cast")

	local effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_shadowshaman/shadowshaman_snake_jar.vpcf", PATTACH_WORLDORIGIN, self.parent)
	ParticleManager:SetParticleControl(effect_cast, 0, self.caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(projectile_speed, 0, 0))
	-- ParticleManager:SetParticleControl(effect_cast, 3, self.parent:GetAbsOrigin())
	-- ParticleManager:SetParticleControl(effect_cast, 4, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(effect_cast, 5, self.parent:GetAbsOrigin())

	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end

function modifier_shadow_shaman_urnaconda_thinker:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_shadow_shaman_urnaconda_thinker:OnDestroy()
	if not IsServer() then return end

	local enemies = FindUnitsInRadius(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	for _, enemy in pairs(enemies) do
		if IsValidEntity(enemy) then
			self.damage_table.victim = enemy
			ApplyDamage(self.damage_table)
		end
	end

	local mass_serpent_ward = self.caster:FindAbilityByName("shadow_shaman_mass_serpent_ward_lua")
	if IsValidEntity(mass_serpent_ward) and mass_serpent_ward:IsTrained() then
		EmitSoundOn("Hero_ShadowShaman.Urnaconda", self.parent)
		mass_serpent_ward:SummonWards(self.parent:GetAbsOrigin(), self.ward_count, self.ward_duration, self.spawn_radius, nil, true)
	end

	UTIL_Remove(self.parent)
end