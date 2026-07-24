--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


nevermore_requiem_lua = class({}) ---@class nevermore_requiem_lua : CDOTA_Ability_Lua
LinkLuaModifier("modifier_nevermore_requiem_phase_buff_lua", "heroes/hero_nevermore/nevermore_requiem_lua",
	LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_requiem_souls_lua", "heroes/hero_nevermore/nevermore_requiem_lua",
	LUA_MODIFIER_MOTION_NONE)

function nevermore_requiem_lua:OnOwnerDied()
	if not self or self:IsNull() then return end
	if self:GetLevel() < 1 then return end
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then return end
	if self.caster:IsReincarnating() then return end

	local line_count = self:GetLineCount(true)
	self:Requiem(line_count, true, false)
end

function nevermore_requiem_lua:GetCastRange()
	return self:GetSpecialValueFor("requiem_radius") or 0
end

function nevermore_requiem_lua:OnAbilityPhaseStart()
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then return false end

	self.caster:EmitSound("Hero_Nevermore.RequiemOfSoulsCast")
	self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_6)
	self.caster:AddNewModifier(self.caster, self, "modifier_nevermore_requiem_phase_buff_lua", {})

	if not self.wings_particle then
		local particle_cast = ParticleManager:GetParticleReplacement(
			"particles/units/heroes/hero_nevermore/nevermore_wings.vpcf", self.caster)
		self.wings_particle = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.caster)
		ParticleManager:SetParticleControl(self.wings_particle, 0, self.caster:GetAbsOrigin())
		ParticleManager:SetParticleControlEnt(self.wings_particle, 5, self.caster, PATTACH_POINT_FOLLOW, "attach_attack1",
			Vector(0, 0, 0), false)
		ParticleManager:SetParticleControlEnt(self.wings_particle, 6, self.caster, PATTACH_POINT_FOLLOW, "attach_attack2",
			Vector(0, 0, 0), false)
	end

	return true
end

function nevermore_requiem_lua:OnAbilityPhaseInterrupted()
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then return end

	self.caster:StopSound("Hero_Nevermore.RequiemOfSoulsCast")
	self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_6)
	self.caster:RemoveModifierByName("modifier_nevermore_requiem_phase_buff_lua")

	if self.wings_particle then
		ParticleManager:DestroyParticle(self.wings_particle, true)
		ParticleManager:ReleaseParticleIndex(self.wings_particle)
		self.wings_particle = nil
	end
end

function nevermore_requiem_lua:OnSpellStart()
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then return end

	if self.wings_particle then
		ParticleManager:ReleaseParticleIndex(self.wings_particle)
		self.wings_particle = nil
	end

	if not IsServer() then return end

	self.caster:RemoveModifierByName("modifier_nevermore_requiem_phase_buff_lua")

	local line_count = self:GetLineCount(false)
	self:Requiem(line_count, false, false)

	if not self.caster:HasScepter() then return end
	local radius = self:GetSpecialValueFor("requiem_radius") or 0
	local line_speed = self:GetSpecialValueFor("requiem_line_speed") or 1

	Timers:CreateTimer(radius / line_speed, function()
		if not self or self:IsNull() then return end
		if not IsValidEntity(self) then return end
		self:Requiem(line_count, false, true)
	end)
end

---@param is_death_cast boolean
---@return integer
function nevermore_requiem_lua:GetLineCount(is_death_cast)
	if not IsValidEntity(self.caster) then return 0 end

	local max_souls = self:GetSpecialValueFor("max_souls") or 0
	local soul_death_release = self:GetSpecialValueFor("soul_death_release") or 0

	return is_death_cast and (max_souls * soul_death_release) or max_souls
end

function nevermore_requiem_lua:Requiem(line_count, is_death_cast, is_scepter_cast)
	if not self or self:IsNull() then return end
	if not IsValidEntity(self.caster) then return end
	if line_count <= 0 then return end

	local radius = self:GetSpecialValueFor("requiem_radius") or 0
	local line_width_start = self:GetSpecialValueFor("requiem_line_width_start") or 0
	local line_width_end = self:GetSpecialValueFor("requiem_line_width_end") or 0
	local line_speed = self:GetSpecialValueFor("requiem_line_speed") or 0
	local damage_pct_scepter = self:GetSpecialValueFor("requiem_damage_pct_scepter") or 0
	local heal_pct_scepter = self:GetSpecialValueFor("requiem_heal_pct_scepter") or 0

	self.slow_duration = self:GetSpecialValueFor("requiem_slow_duration") or 0
	self.slow_duration_max = self:GetSpecialValueFor("requiem_slow_duration_max") or 0
	self.requiem_cache = {
		radius = radius,
		line_width_start = line_width_start,
		line_width_end = line_width_end,
		line_speed = line_speed,
		damage_pct_scepter = damage_pct_scepter,
		heal_pct_scepter = heal_pct_scepter,
	}

	self.damage_table = {
		-- victim = target,
		attacker = self.caster,
		--damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	}

	self.projectile_info = {
		Ability = self,
		EffectName = "",
		Source = self.caster,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		bDeleteOnHit = false,
		bProvidesVision = false,
	}

	EmitSoundOn("Hero_Nevermore.RequiemOfSouls", self.caster)

	if not is_scepter_cast then
		local particle_cast = ParticleManager:GetParticleReplacement(
			"particles/units/heroes/hero_nevermore/nevermore_requiemofsouls.vpcf", self.caster)
		local particle_requiem_fx = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self.caster)
		ParticleManager:SetParticleControl(particle_requiem_fx, 0, self.caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle_requiem_fx, 1, Vector(line_count, 0, 0))
		ParticleManager:ReleaseParticleIndex(particle_requiem_fx)
	end

	local line_position = self.caster:GetAbsOrigin() + Vector(1, 0, 0) * radius

	local qangle_rotation_rate = 360 / line_count
	for i = 1, line_count do
		local line_start_position = self.caster:GetAbsOrigin()
		local line_end_position = line_position

		if is_scepter_cast then
			line_start_position, line_end_position = line_end_position, line_start_position
		end

		self:CreateRequiemSoulLine(line_start_position, line_end_position, is_death_cast, is_scepter_cast)
		local qangle = QAngle(0, qangle_rotation_rate, 0)
		line_position = RotatePosition(self.caster:GetAbsOrigin(), qangle, line_position)
	end
end

function nevermore_requiem_lua:CreateRequiemSoulLine(
	line_start_position,
	line_end_position,
	is_death_cast,
	is_scepter_cast)
	if not IsValidEntity(self) then return end
	if not IsValidEntity(self.caster) then return end

	local cache = self.requiem_cache or {}
	local radius = cache.radius or (self:GetSpecialValueFor("requiem_radius") or 0)
	local line_width_start = cache.line_width_start or (self:GetSpecialValueFor("requiem_line_width_start") or 0)
	local line_width_end = cache.line_width_end or (self:GetSpecialValueFor("requiem_line_width_end") or 0)
	local line_speed = cache.line_speed or (self:GetSpecialValueFor("requiem_line_speed") or 0)

	local max_distance_time = radius / line_speed
	local velocity = (line_end_position - line_start_position):Normalized() * line_speed

	if is_scepter_cast then
		line_width_start, line_width_end = line_width_end, line_width_start
	end

	self.projectile_info.vSpawnOrigin = line_start_position
	self.projectile_info.fDistance = radius
	self.projectile_info.fStartRadius = line_width_start
	self.projectile_info.fEndRadius = line_width_end
	self.projectile_info.vVelocity = velocity

	local projectile_id = ProjectileManager:CreateLinearProjectile(self.projectile_info)
	local damage_pct_scepter = cache.damage_pct_scepter or (self:GetSpecialValueFor("requiem_damage_pct_scepter") or 0)
	local heal_pct_scepter = cache.heal_pct_scepter or (self:GetSpecialValueFor("requiem_heal_pct_scepter") or 0)
	local damage = self:GetAbilityDamage() * (is_scepter_cast and (0.01 * damage_pct_scepter) or 1)

	self.projectile_table[projectile_id] = {
		damage_dealt_sum = 0,
		is_scepter_cast = is_scepter_cast,
		is_death_cast = is_death_cast,
		damage = damage,
		heal_pct_scepter = is_scepter_cast and heal_pct_scepter or 0,
	}

	local particle_cast = ParticleManager:GetParticleReplacement(
		"particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf", self.caster)
	local particle_lines_fx = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self.caster)
	ParticleManager:SetParticleControl(particle_lines_fx, 0, line_start_position)
	ParticleManager:SetParticleControl(particle_lines_fx, 1, velocity)
	ParticleManager:SetParticleControl(particle_lines_fx, 2, Vector(0, max_distance_time, 0))
	ParticleManager:ReleaseParticleIndex(particle_lines_fx)
end

nevermore_requiem_lua.projectile_table = {}

function nevermore_requiem_lua:OnProjectileHitHandle(target, location, projectile_id)
	if not IsValidEntity(self) then return end
	if not IsValidEntity(self.caster) then return end
	local projectile_data = self.projectile_table[projectile_id]
	if not projectile_data then return end

	local damage_dealt_sum = projectile_data.damage_dealt_sum
	local is_scepter_cast = projectile_data.is_scepter_cast
	local is_death_cast = projectile_data.is_death_cast
	local damage = projectile_data.damage
	local heal_pct_scepter = projectile_data.heal_pct_scepter

	if not IsValidEntity(target) then -- projectile reaches the end
		if is_scepter_cast and damage_dealt_sum > 0 then
			local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf",
				PATTACH_ABSORIGIN_FOLLOW, self.caster)
			ParticleManager:ReleaseParticleIndex(particle)
			self.caster:HealWithParams(damage_dealt_sum * 0.01 * heal_pct_scepter, self, false, true, self.caster, false)
		end
		self.projectile_table[projectile_id] = nil
		return
	end

	local debuff_time_increment = self.slow_duration * (1 - target:GetStatusResistance())
	local slow_modifier = target:FindModifierByName("modifier_nevermore_requiem_slow")
	local slow_debuff_time = debuff_time_increment
	if slow_modifier then
		slow_debuff_time = math.min(slow_modifier:GetRemainingTime() + debuff_time_increment, self.slow_duration_max)
	end

	self.damage_table.victim = target
	self.damage_table.damage = damage
	local damage_dealt = ApplyDamage(self.damage_table)
	if is_scepter_cast then
		projectile_data.damage_dealt_sum = damage_dealt_sum + damage_dealt
	end

	if (not is_death_cast) and (not target:HasModifier("modifier_item_aeon_disk_lua_buff")) then
		local fear_modifier = target:FindModifierByName("modifier_nevermore_requiem_fear")
		local fear_debuff_time = debuff_time_increment
		if fear_modifier then
			fear_debuff_time = math.min(fear_modifier:GetRemainingTime() + debuff_time_increment, self.slow_duration_max)
			fear_modifier:SetDuration(fear_debuff_time, true)
		else
			target:AddNewModifier(self.caster, self, "modifier_nevermore_requiem_fear", { duration = fear_debuff_time })
		end
	end

	if slow_modifier then
		slow_modifier:SetDuration(slow_debuff_time, true)
	else
		target:AddNewModifier(self.caster, self, "modifier_nevermore_requiem_slow", { duration = slow_debuff_time })
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_nevermore_requiem_phase_buff_lua = class({}) ---@class modifier_nevermore_requiem_phase_buff_lua : CDOTA_Modifier_Lua

function modifier_nevermore_requiem_phase_buff_lua:IsHidden() return true end

function modifier_nevermore_requiem_phase_buff_lua:IsPurgable() return false end

function modifier_nevermore_requiem_phase_buff_lua:IsDebuff() return false end

function modifier_nevermore_requiem_phase_buff_lua:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true
	}
end