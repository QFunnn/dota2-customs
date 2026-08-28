--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_kunkka_tidebringer_custom_tracker",
	"abilities/kunkka/kunkka_tidebringer_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_tidebringer_custom_cd",
	"abilities/kunkka/kunkka_tidebringer_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_tidebringer_custom_target",
	"abilities/kunkka/kunkka_tidebringer_custom",
	LUA_MODIFIER_MOTION_NONE
)

kunkka_tidebringer_custom = class({})
kunkka_tidebringer_custom.talents = {}

function kunkka_tidebringer_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end

	PrecacheResource("particle", "particles/units/heroes/hero_kunkka/kunkka_weapon_tidebringer.vpcf", context)
end

function kunkka_tidebringer_custom:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {}
	end
end

function kunkka_tidebringer_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_kunkka_tidebringer_custom_tracker"
end

function kunkka_tidebringer_custom:OnSpellStart()
	local point = self.caster:CastPosition(self:GetCursorPosition())

	local target =
		CreateUnitByName("npc_kunkka_tidebringer_target_custom", point, true, nil, nil, self.caster:GetTeamNumber())

	target.player_unit = true

	target:AddNewModifier(self.caster, self, "modifier_kunkka_tidebringer_custom_target", {})
	target:AddNewModifier(target, self, "modifier_kill", { duration = self.target_duration })
end

modifier_kunkka_tidebringer_custom_tracker = class(mod_hidden)
function modifier_kunkka_tidebringer_custom_tracker:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.ability:UpdateTalents()

	self.parent.tidebringer_ability = self.ability

	self.ability.damage_bonus = self.ability:GetSpecialValueFor("damage_bonus")
	self.ability.attack_cd = self.ability:GetSpecialValueFor("attack_cd")
	self.ability.cleave_starting_width = self.ability:GetSpecialValueFor("cleave_starting_width")
	self.ability.cleave_ending_width = self.ability:GetSpecialValueFor("cleave_ending_width")
	self.ability.cleave_distance = self.ability:GetSpecialValueFor("cleave_distance")
	self.ability.cleave_damage = self.ability:GetSpecialValueFor("cleave_damage") / 100
	self.ability.target_duration = self.ability:GetSpecialValueFor("target_duration")
	self.ability.target_hits = self.ability:GetSpecialValueFor("target_hits")

	self:CheckEffect()

	self.parent:AddAttackRecordEvent_out(self)
	self.parent:AddAttackEvent_out(self)
end

function modifier_kunkka_tidebringer_custom_tracker:OnRefresh(table)
	self.ability.damage_bonus = self.ability:GetSpecialValueFor("damage_bonus")
	self.ability.attack_cd = self.ability:GetSpecialValueFor("attack_cd")
	self.ability.cleave_distance = self.ability:GetSpecialValueFor("cleave_distance")
	self.ability.cleave_ending_width = self.ability:GetSpecialValueFor("cleave_ending_width")
end

function modifier_kunkka_tidebringer_custom_tracker:CheckEffect()
	if not IsServer() then
		return
	end

	if not self.effect and not self.parent:HasModifier("modifier_kunkka_tidebringer_custom_cd") then
		self.effect = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_kunkka/kunkka_weapon_tidebringer.vpcf",
			PATTACH_CUSTOMORIGIN_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			self.effect,
			0,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_sword",
			self.parent:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			self.effect,
			2,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_sword",
			self.parent:GetAbsOrigin(),
			true
		)
		self:AddParticle(self.effect, false, false, -1, false, false)

		self.parent:EmitSound("Hero_Kunkaa.Tidebringer")
	end

	if self.effect and self.parent:HasModifier("modifier_kunkka_tidebringer_custom_cd") then
		ParticleManager:DestroyParticle(self.effect, false)
		ParticleManager:ReleaseParticleIndex(self.effect)
		self.effect = nil
	end
end

function modifier_kunkka_tidebringer_custom_tracker:AttackRecordEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end

	self.is_attack = false
	if not params.target:IsUnit() then
		return
	end
	if self.parent:HasModifier("modifier_kunkka_tidebringer_custom_cd") then
		return
	end

	self.is_attack = true
end

function modifier_kunkka_tidebringer_custom_tracker:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end

	local target = params.target
	if not target:IsUnit() then
		return
	end
	if not self.is_attack then
		return
	end

	target:EmitSound("Hero_Kunkka.Tidebringer.Attack")

	local damage = params.damage * self.ability.cleave_damage
	DoCleaveAttack(
		self.parent,
		target,
		self.ability,
		damage,
		self.ability.cleave_starting_width,
		self.ability.cleave_ending_width,
		self.ability.cleave_distance,
		"particles/units/heroes/hero_kunkka/kunkka_spell_tidebringer.vpcf",
		"Hero_Kunkka.TidebringerDamage"
	)

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_kunkka_tidebringer_custom_cd",
		{ duration = self.ability.attack_cd }
	)
	self.is_attack = false
end

function modifier_kunkka_tidebringer_custom_tracker:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function modifier_kunkka_tidebringer_custom_tracker:GetModifierPreAttack_BonusDamage()
	if not self.is_attack then
		return
	end
	return self.ability.damage_bonus
end

function modifier_kunkka_tidebringer_custom_tracker:GetActivityTranslationModifiers()
	if not self.is_attack then
		return
	end
	return "tidebringer"
end

modifier_kunkka_tidebringer_custom_cd = class(mod_cd)
function modifier_kunkka_tidebringer_custom_cd:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.tracker:CheckEffect()
end

function modifier_kunkka_tidebringer_custom_cd:OnDestroy()
	if not IsServer() then
		return
	end
	if not IsValid(self.ability) or not IsValid(self.ability.tracker) then
		return
	end

	self.ability.tracker:CheckEffect()
end

modifier_kunkka_tidebringer_custom_target = class(mod_hidden)
function modifier_kunkka_tidebringer_custom_target:OnCreated(table)
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.hits = self.ability.target_hits

	if not IsServer() then
		return
	end
	self.parent:AddAttackEvent_inc(self, true)

	local dir = (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized()
	dir.z = 0
	self.parent:SetForwardVector(dir)
	self.parent:FaceTowards(self.caster:GetAbsOrigin())

	self.parent:SetBaseMaxHealth(self.hits)
	self.parent:SetHealth(self.hits)
end

function modifier_kunkka_tidebringer_custom_target:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_HEALTHBAR_PIPS,
	}
end

function modifier_kunkka_tidebringer_custom_target:GetModifierHealthBarPips()
	return self.hits
end

function modifier_kunkka_tidebringer_custom_target:GetAbsoluteNoDamagePhysical()
	return 1
end
function modifier_kunkka_tidebringer_custom_target:GetAbsoluteNoDamageMagical()
	return 1
end
function modifier_kunkka_tidebringer_custom_target:GetAbsoluteNoDamagePure()
	return 1
end
function modifier_kunkka_tidebringer_custom_target:CheckState()
	return {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_SPECIALLY_DENIABLE] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES] = true,
		[MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
	}
end

function modifier_kunkka_tidebringer_custom_target:AttackEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.target then
		return
	end
	if self.caster ~= params.attacker then
		return
	end

	self.hits = self.hits - 1
	if self.hits <= 0 then
		self.parent:Kill(nil, attacker)
	else
		self.parent:SetHealth(self.hits)
	end
end