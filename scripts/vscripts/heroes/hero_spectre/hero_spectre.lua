--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_spectre_step_buff", "heroes/hero_spectre/hero_spectre", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_step_debuff", "heroes/hero_spectre/hero_spectre", LUA_MODIFIER_MOTION_NONE)

spectre_step = class({})

function spectre_step:OnSpellStart()
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb(self) then
		return
	end
	self:GetCaster():EmitSound("Hero_Visage.GraveChill.Cast")
	target:EmitSound("Hero_Visage.GraveChill.Target")
	self:GetCaster():AddNewModifier(
		target,
		self,
		"modifier_spectre_step_buff",
		{ duration = self:GetSpecialValueFor("duration") * (1 - target:GetStatusResistance()) }
	)
	target:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_spectre_step_debuff",
		{ duration = self:GetSpecialValueFor("duration") * (1 - target:GetStatusResistance()) }
	)

	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = self:GetSpecialValueFor("damage"),
		damage_type = DAMAGE_TYPE_PURE,
	}
	ApplyDamage(damageTable)
end

--------------------------------------------------------------

modifier_spectre_step_buff = class({})

function modifier_spectre_step_buff:IsDebuff()
	return false
end

function modifier_spectre_step_buff:OnCreated()
	self.attackspeed_bonus = self:GetAbility():GetSpecialValueFor("attackspeed_bonus")
end

function modifier_spectre_step_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_spectre_step_buff:GetModifierAttackSpeedBonus_Constant()
	return self.attackspeed_bonus
end

--------------------------------------------------------------

modifier_spectre_step_debuff = class({})

function modifier_spectre_step_debuff:GetStatusEffectName()
	return "particles/units/heroes/hero_visage/status_effect_visage_chill_slow.vpcf"
end

function modifier_spectre_step_debuff:OnCreated()
	self.attackspeed_bonus = self:GetAbility():GetSpecialValueFor("attackspeed_bonus")
end

function modifier_spectre_step_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_spectre_step_debuff:GetModifierAttackSpeedBonus_Constant()
	return -self.attackspeed_bonus
end

--------------------------------------------------------------
--------------------------------------------------------------
LinkLuaModifier("modifier_spectre_desolate_lua", "heroes/hero_spectre/hero_spectre", LUA_MODIFIER_MOTION_NONE)

spectre_desolate_lua = class({})

function spectre_desolate_lua:GetIntrinsicModifierName()
	return "modifier_spectre_desolate_lua"
end

--------------------------------------------------------------

modifier_spectre_desolate_lua = class({})

function modifier_spectre_desolate_lua:IsHidden()
	return true
end

function modifier_spectre_desolate_lua:IsPurgable()
	return false
end

function modifier_spectre_desolate_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
	return funcs
end

function modifier_spectre_desolate_lua:OnAttackLanded(params)
	if
		IsServer()
		and (not self:GetParent():PassivesDisabled())
		and params.attacker == self:GetParent()
		and self:GetParent():GetTeamNumber() ~= params.target:GetTeamNumber()
	then
		self.damage = self:GetAbility():GetSpecialValueFor("bonus_damage")

		local damageTable = {
			victim = params.target,
			attacker = self:GetParent(),
			damage = self:GetParent():GetAttackDamage() / 100 * self.damage,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
				+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
		}
		ApplyDamage(damageTable)
		EmitSoundOn("Hero_Spectre.Desolate", self:GetParent())

		local particle_name = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
		local particle = ParticleManager:CreateParticle(particle_name, PATTACH_POINT, params.target)
		ParticleManager:SetParticleControl(
			particle,
			0,
			Vector(
				params.target:GetAbsOrigin().x,
				params.target:GetAbsOrigin().y,
				GetGroundPosition(params.target:GetAbsOrigin(), params.target).z + 140
			)
		)
		ParticleManager:SetParticleControlForward(particle, 0, self:GetParent():GetForwardVector())
	end
end

--------------------------------------------------------------
--------------------------------------------------------------

LinkLuaModifier("modifier_spectre_dispersion_lua", "heroes/hero_spectre/hero_spectre", LUA_MODIFIER_MOTION_NONE)

spectre_dispersion_lua = class({})

function spectre_dispersion_lua:GetIntrinsicModifierName()
	return "modifier_spectre_dispersion_lua"
end

--------------------------------------------------------------------

modifier_spectre_dispersion_lua = class({})

function modifier_spectre_dispersion_lua:IsHidden()
	return self:GetStackCount() == 0
end
function modifier_spectre_dispersion_lua:IsPurgable()
	return false
end
function modifier_spectre_dispersion_lua:AllowIllusionDuplicate()
	return true
end

function modifier_spectre_dispersion_lua:OnCreated()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end

	self.parent = self:GetParent()
	self.radius = ability:GetSpecialValueFor("radius")

	if IsServer() then
		local interval = ability:GetSpecialValueFor("damage_release_interval")
		self:StartIntervalThink(interval)
	end
end

modifier_spectre_dispersion_lua.OnRefresh = modifier_spectre_dispersion_lua.OnCreated

function modifier_spectre_dispersion_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_spectre_dispersion_lua:GetModifierIncomingDamage_Percentage()
	if self.parent:PassivesDisabled() then
		return 0
	end
	return -self:GetAbility():GetSpecialValueFor("damage_reflection_pct")
end

function modifier_spectre_dispersion_lua:OnTakeDamage(params)
	if not IsServer() or params.unit ~= self.parent or self.parent:PassivesDisabled() then
		return
	end
	self.reflect_pct = self:GetAbility():GetSpecialValueFor("damage_reflection_pct")

	local blocked_damage = (params.damage / (1 - self.reflect_pct / 100)) * (self.reflect_pct / 100)

	if blocked_damage > 0 then
		self:SetStackCount(self:GetStackCount() + blocked_damage)
	end
end

function modifier_spectre_dispersion_lua:OnIntervalThink()
	local stacks = self:GetStackCount()
	if stacks <= 0 then
		return
	end

	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		self.parent:GetAbsOrigin(),
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = self.parent,
			damage = stacks,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = DOTA_DAMAGE_FLAG_REFLECTION
				+ DOTA_DAMAGE_FLAG_HPLOSS
				+ DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
				+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
			ability = self:GetAbility(),
		})
	end

	self:SetStackCount(0)
end

--------------------------------------------------------------------
--------------------------------------------------------------------

spectre_haunt_lua = class({})

function spectre_haunt_lua:GetCooldown(level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_spectre_4")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 20
	end
	return self.BaseClass.GetCooldown(self, level)
end

function spectre_haunt_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("illusion_duration")
	local count = self:GetSpecialValueFor("count")
	local outgoing = self:GetSpecialValueFor("illusion_outgoing_damage")
	local incoming = self:GetSpecialValueFor("illusion_incoming_damage") - 100
	local distance = 72

	local illusions = CreateIllusions(self:GetCaster(), caster, {
		outgoing_damage = 0,
		incoming_damage = incoming,
		duration = duration,
	}, count, distance, false, true)

	if illusions then
		for _, illusion in pairs(illusions) do
			local average_bonus_damage = caster:GetAverageTrueAttackDamage(nil) / 100 * outgoing
			illusion:SetBaseDamageMin(average_bonus_damage - self:GetCaster():GetAgility())
			illusion:SetBaseDamageMax(average_bonus_damage - self:GetCaster():GetAgility())
		end
	end

	EmitSoundOn("Hero_Spectre.HauntCast", illusion)
end

--------------------------------------------------------------------

spectre_reality_lua = class({})

function spectre_reality_lua:CastFilterResultTarget(hTarget)
	local caster = self:GetCaster()

	if caster:HasModifier("modifier_guild_event") then
		return UF_FAIL_CUSTOM
	end
	if hTarget and hTarget:IsIllusion() and hTarget:GetPlayerOwnerID() == caster:GetPlayerOwnerID() then
		return UF_SUCCESS
	end

	return UF_FAIL_CUSTOM
end

function spectre_reality_lua:GetCustomCastErrorTarget(hTarget)
	if self:GetCaster():HasModifier("modifier_guild_event") then
		return "#dota_hud_error_disabled_in_event"
	end
	return "#dota_hud_error_cant_cast_on_non_illusion"
end

function spectre_reality_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if not target or not target:IsAlive() then
		return
	end

	local caster_pos = caster:GetAbsOrigin()
	local target_pos = target:GetAbsOrigin()
	local caster_fwd = caster:GetForwardVector()
	local target_fwd = target:GetForwardVector()

	caster:SetAbsOrigin(target_pos)
	target:SetAbsOrigin(caster_pos)

	caster:SetForwardVector(target_fwd)
	target:SetForwardVector(caster_fwd)

	FindClearSpaceForUnit(caster, target_pos, true)
	FindClearSpaceForUnit(target, caster_pos, true)

	EmitSoundOn("Hero_Spectre.Reality", caster)
end