--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_golden_forest_death_investment",
	"abilities/addition_bosses/golden_forest",
	LUA_MODIFIER_MOTION_NONE
)

golden_forest_death_investment = class({})

function golden_forest_death_investment:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_oracle/oracle_fortune_purge.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_clinkz/clinkz_strafe_fire.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_bane/bane_enfeeble.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts", context)
end

function golden_forest_death_investment:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")

	if target:TriggerSpellAbsorb(self) then
		return
	end

	target:AddNewModifier(caster, self, "modifier_golden_forest_death_investment", { duration = duration })
	caster:EmitSound("Hero_Bane.Enfeeble.Cast")
end

--------------------------------------------------------------------------------

modifier_golden_forest_death_investment = class({})

function modifier_golden_forest_death_investment:IsPurgable()
	return false
end

function modifier_golden_forest_death_investment:OnCreated()
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.bonus_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")

	if not IsServer() then
		return
	end

	self.accumulated_damage = 0
	self.has_attacked = false

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_clinkz/clinkz_strafe_fire.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	self:AddParticle(pfx, false, false, -1, false, false)
end

function modifier_golden_forest_death_investment:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_golden_forest_death_investment:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_golden_forest_death_investment:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_speed
end

function modifier_golden_forest_death_investment:OnTakeDamage(params)
	if not IsServer() then
		return
	end

	if params.attacker ~= self:GetParent() then
		return
	end

	if params.unit == self:GetParent() then
		return
	end

	self.accumulated_damage = self.accumulated_damage + params.damage
	self.has_attacked = true
end

function modifier_golden_forest_death_investment:OnDestroy()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local caster = self:GetCaster()

	if self.has_attacked then
		ApplyDamage({
			victim = parent,
			attacker = caster,
			damage = self.accumulated_damage,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self:GetAbility(),
		})

		local sapFX =
			ParticleManager:CreateParticle("particles/units/heroes/hero_bane/bane_sap.vpcf", PATTACH_ABSORIGIN, caster)
		ParticleManager:SetParticleControlEnt(
			sapFX,
			0,
			caster,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			caster:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			sapFX,
			1,
			parent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			parent:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(sapFX)
		EmitSoundOn("Hero_Bane.BrainSap.Target", parent)
	else
		parent:AddNewModifier(caster, self:GetAbility(), "modifier_stunned", { duration = self.stun_duration })
		parent:EmitSound("Hero_Oracle.FortunesEnd.Target_Alter")
	end
end

function modifier_golden_forest_death_investment:GetEffectName()
	return "particles/units/heroes/hero_bane/bane_enfeeble.vpcf"
end

function modifier_golden_forest_death_investment:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end