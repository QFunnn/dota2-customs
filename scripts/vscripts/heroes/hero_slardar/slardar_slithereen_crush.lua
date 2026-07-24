--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("slardar_slithereen_crush_custom_debuff", "heroes/hero_slardar/slardar_slithereen_crush", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("slardar_slithereen_crush_custom_puddle", "heroes/hero_slardar/slardar_slithereen_crush", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("slardar_slithereen_crush_custom_puddle_buff", "heroes/hero_slardar/slardar_slithereen_crush", LUA_MODIFIER_MOTION_NONE)

slardar_slithereen_crush_custom = class({})

function slardar_slithereen_crush_custom:OnSpellStart()
	if not IsServer() then return end
	local crush_radius = self:GetSpecialValueFor("crush_radius") + self:GetSpecialValueFor("shard_bonus_radius")
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local slow_duration = self:GetSpecialValueFor("crush_extra_slow_duration")
	local crush_damage = self:GetSpecialValueFor("crush_damage")

	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, crush_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false )

	for _, enemy in pairs(enemies) do
		ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = crush_damage, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, ability = self })
		enemy:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = stun_duration } )
		enemy:AddNewModifier( self:GetCaster(), self, "slardar_slithereen_crush_custom_debuff", { duration = stun_duration + slow_duration } )

		if self:GetCaster():HasShard() then
			local corrosive_ability = self:GetCaster():FindAbilityByName("slardar_amplify_damage_custom")
			if corrosive_ability then
				enemy:AddNewModifier(self:GetCaster(), corrosive_ability, "modifier_slardar_amplify_damage", {duration = self:GetSpecialValueFor("shard_amp_duration") * (1 - enemy:GetStatusResistance())})
			end
		end
	end

	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_slardar/slardar_crush.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( particle, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( particle, 1, Vector(crush_radius, crush_radius, crush_radius) )
	ParticleManager:ReleaseParticleIndex( particle )

	self:GetCaster():EmitSound("Hero_Slardar.Slithereen_Crush")

	if self:GetCaster():HasScepter() then
		CreateModifierThinker(self:GetCaster(), self, "slardar_slithereen_crush_custom_puddle", {duration = self:GetSpecialValueFor("puddle_duration")}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
	end
end

slardar_slithereen_crush_custom_debuff = class({})

function slardar_slithereen_crush_custom_debuff:IsHidden() return true end

function slardar_slithereen_crush_custom_debuff:OnCreated( kv )
	self.ms_slow = self:GetAbility():GetSpecialValueFor("crush_extra_slow")
	self.as_slow = self:GetAbility():GetSpecialValueFor("crush_attack_slow_tooltip")
end

function slardar_slithereen_crush_custom_debuff:OnRefresh( kv )
	self:OnCreated()
end

function slardar_slithereen_crush_custom_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function slardar_slithereen_crush_custom_debuff:GetModifierMoveSpeedBonus_Percentage( params )
	return self.ms_slow
end

function slardar_slithereen_crush_custom_debuff:GetModifierAttackSpeedBonus_Constant( params )
	return self.as_slow
end

function slardar_slithereen_crush_custom_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_slardar_crush.vpcf"
end

function slardar_slithereen_crush_custom_debuff:StatusEffectPriority()
	return 10
end

slardar_slithereen_crush_custom_puddle = class({})

function slardar_slithereen_crush_custom_puddle:IsHidden() return true end
function slardar_slithereen_crush_custom_puddle:IsPurgable() return false end

function slardar_slithereen_crush_custom_puddle:OnCreated()
	if not IsServer() then return end
	self.radius = self:GetAbility():GetSpecialValueFor("puddle_radius")
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_slardar/slardar_water_puddle.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.radius,1,1))
	self:AddParticle(particle, false, false, -1, false, false)
end

function slardar_slithereen_crush_custom_puddle:IsAura()
    return true
end

function slardar_slithereen_crush_custom_puddle:GetModifierAura()
    return "slardar_slithereen_crush_custom_puddle_buff"
end

function slardar_slithereen_crush_custom_puddle:GetAuraRadius()
    return self.radius
end

function slardar_slithereen_crush_custom_puddle:GetAuraEntityReject(target)
    if target ~= self:GetCaster() then return true end
    return false
end

function slardar_slithereen_crush_custom_puddle:GetAuraDuration()
    return 0.5
end

function slardar_slithereen_crush_custom_puddle:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function slardar_slithereen_crush_custom_puddle:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO
end

function slardar_slithereen_crush_custom_puddle:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

slardar_slithereen_crush_custom_puddle_buff = class({})

function slardar_slithereen_crush_custom_puddle_buff:IsHidden() return true end

function slardar_slithereen_crush_custom_puddle_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
	}
end

function slardar_slithereen_crush_custom_puddle_buff:OnCreated()
	if not IsServer() then return end

	local Parent = self:GetParent()
	if not Parent or Parent:IsNull() then return end

	Parent:AddNewModifier(Parent, nil, "modifier_slardar_puddle", {})
end

function slardar_slithereen_crush_custom_puddle_buff:OnDestroy()
	if not IsServer() then return end

	local Parent = self:GetParent()
	if not Parent or Parent:IsNull() then return end

	Parent:RemoveModifierByName("modifier_slardar_puddle")
end

function slardar_slithereen_crush_custom_puddle_buff:GetModifierConstantHealthRegen()
	return 30
end

function slardar_slithereen_crush_custom_puddle_buff:GetModifierPhysicalArmorBonus()
	return 10
end

function slardar_slithereen_crush_custom_puddle_buff:GetModifierStatusResistanceStacking()
	return 40
end

