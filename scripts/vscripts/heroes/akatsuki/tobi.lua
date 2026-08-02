--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tobi_phantom_strike", "heroes/akatsuki/tobi", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tobi_turn_rate_slow", "heroes/akatsuki/tobi", LUA_MODIFIER_MOTION_NONE)

tobi_phantom_strike = class({})

function tobi_phantom_strike:GetIntrinsicModifierName()
	return "modifier_tobi_phantom_strike"
end

---------------------------------------------------------------------------

modifier_tobi_phantom_strike = class({})

function modifier_tobi_phantom_strike:IsHidden()
	return false
end

function modifier_tobi_phantom_strike:IsPurgable()
	return false
end

function modifier_tobi_phantom_strike:IsPermanent()
	return true
end

function modifier_tobi_phantom_strike:_GetChance()
	return self:GetAbility():GetSpecialValueFor("base_chance")
end

function modifier_tobi_phantom_strike:OnCreated()
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1.0)
end

function modifier_tobi_phantom_strike:OnIntervalThink()
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local new_level = math.min(math.floor((self:GetParent():GetLevel() - 1) / 6) + 1, ability:GetMaxLevel())
	if ability:GetLevel() ~= new_level then
		ability:SetLevel(new_level)
	end
end

function modifier_tobi_phantom_strike:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_tobi_phantom_strike:GetModifierIncomingDamage_Percentage()
	if RollPercentage(self:_GetChance()) then
		self.caster = self:GetCaster()
		local backtrack_fx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf",
			PATTACH_ABSORIGIN,
			self.caster
		)
		ParticleManager:SetParticleControl(backtrack_fx, 0, self.caster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(backtrack_fx)
		return -100
	end
end

function modifier_tobi_phantom_strike:OnAttackLanded(data)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if data.attacker ~= caster then
		return
	end
	local target = data.target
	if not target or target:IsNull() or not target:IsAlive() then
		return
	end

	if not RollPercentage(self:_GetChance()) then
		return
	end

	local ability = self:GetAbility()
	local enemy_pos = target:GetAbsOrigin()

	-- Teleport behind enemy (relative to enemy facing direction, offset >= min_angle)
	local fwd = target:GetForwardVector()
	local facing = math.atan2(fwd.y, fwd.x)
	local min_rad = ability:GetSpecialValueFor("min_angle") * math.pi / 180
	-- random offset between min_angle and 90 degrees on either side of straight-behind
	local offset = min_rad + math.random() * (math.pi * 0.5 - min_rad)
	if math.random() < 0.5 then
		offset = -offset
	end
	local teleport_angle = facing + math.pi + offset
	local dist = ability:GetSpecialValueFor("teleport_distance")

	local new_pos = GetGroundPosition(
		Vector(
			enemy_pos.x + dist * math.cos(teleport_angle),
			enemy_pos.y + dist * math.sin(teleport_angle),
			enemy_pos.z + 200
		),
		caster
	)

	-- blink_start фиксируется на СТАРОЙ позиции
	local old_pos = caster:GetAbsOrigin()

	local blink_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_antimage/antimage_blink_start.vpcf",
		PATTACH_ABSORIGIN,
		caster
	)
	ParticleManager:ReleaseParticleIndex(blink_pfx)
	caster:EmitSound("Hero_Antimage.Blink_out")

	caster:SetAbsOrigin(new_pos)
	FindClearSpaceForUnit(caster, new_pos, true)
	caster:FaceTowards(enemy_pos)

	-- blink_end фиксируется на НОВОЙ позиции
	local blink_end_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_antimage/antimage_blink_end.vpcf",
		PATTACH_ABSORIGIN,
		caster
	)
	ParticleManager:ReleaseParticleIndex(blink_end_pfx)
	caster:EmitSound("Hero_Antimage.Blink_in")

	caster:EmitSound("Hero_Antimage.Blink")

	-- Critical bonus: 300% total => extra 200% of base attack damage
	local crit_mult = ability:GetSpecialValueFor("crit_multiplier")
	local base_dmg = caster:GetAverageTrueAttackDamage(caster)
	local extra_dmg = base_dmg * (crit_mult / 100 - 1)
	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = extra_dmg,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = ability,
	})

	-- Turn rate slow (stackable)
	target:AddNewModifier(
		caster,
		ability,
		"modifier_tobi_turn_rate_slow",
		{ duration = ability:GetSpecialValueFor("slow_duration") }
	)
end

---------------------------------------------------------------------------

modifier_tobi_turn_rate_slow = class({})

function modifier_tobi_turn_rate_slow:IsHidden()
	return false
end

function modifier_tobi_turn_rate_slow:IsPurgable()
	return true
end

function modifier_tobi_turn_rate_slow:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_tobi_turn_rate_slow:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_tobi_turn_rate_slow:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_tobi_turn_rate_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_tobi_turn_rate_slow:GetModifierTurnRate_Percentage()
	return -self:GetAbility():GetSpecialValueFor("turn_rate_slow_pct") * self:GetStackCount()
end

function modifier_tobi_turn_rate_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("move_slow_pct") * self:GetStackCount()
end