--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_custom_dark_lord_aura",
	"abilities/shadow_fiend/custom_nevermore_dark_lord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_dark_lord_debuff",
	"abilities/shadow_fiend/custom_nevermore_dark_lord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_dark_lord_legendary",
	"abilities/shadow_fiend/custom_nevermore_dark_lord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_dark_lord_legendary_fear",
	"abilities/shadow_fiend/custom_nevermore_dark_lord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_dark_lord_damage",
	"abilities/shadow_fiend/custom_nevermore_dark_lord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_dark_lord_speed",
	"abilities/shadow_fiend/custom_nevermore_dark_lord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_dark_lord_slow",
	"abilities/shadow_fiend/custom_nevermore_dark_lord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_dark_lord_fear_cd",
	"abilities/shadow_fiend/custom_nevermore_dark_lord",
	LUA_MODIFIER_MOTION_NONE
)

custom_nevermore_dark_lord = class({})
custom_nevermore_dark_lord.talents = {}

function custom_nevermore_dark_lord:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end

	PrecacheResource("particle", "particles/sf_fear.vpcf", context)
	PrecacheResource("particle", "particles/sf_wings.vpcf", context)
	PrecacheResource("particle", "particles/sf_timer.vpcf", context)
	PrecacheResource("particle", "particles/sf_aura.vpcf", context)
	PrecacheResource("particle", "particles/shadow_fiend/dark_legendary_caster.vpcf", context)
	PrecacheResource("particle", "particles/shadow_fiend/dark_legendary_stun.vpcf", context)
	PrecacheResource("particle", "particles/shadow_fiend/dark_burn.vpcf", context)
	PrecacheResource("particle", "particles/shadow_fiend/dark_speed.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_slark_shadow_dance.vpcf", context)
end

function custom_nevermore_dark_lord:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			e1_magic = 0,
			e1_armor = 0,

			e2_move = 0,
			e2_attack = 0,

			has_e3 = 0,
			e3_heal = 0,
			e3_heal_reduce = 0,
			e3_creeps = caster:GetTalentValue("modifier_nevermore_darklord_3", "creeps", true),
			e3_health = caster:GetTalentValue("modifier_nevermore_darklord_3", "health", true),

			has_e4 = 0,
			e4_damage = 0,
			e4_burn = 0,
			e4_interval = caster:GetTalentValue("modifier_nevermore_darklord_4", "interval", true),
			e4_duration = caster:GetTalentValue("modifier_nevermore_darklord_4", "duration", true),
			e4_radius = caster:GetTalentValue("modifier_nevermore_darklord_4", "radius", true),
			e4_max = caster:GetTalentValue("modifier_nevermore_darklord_4", "max", true),

			has_e5 = 0,
			e5_speed = caster:GetTalentValue("modifier_nevermore_darklord_5", "speed", true),
			e5_slow = caster:GetTalentValue("modifier_nevermore_darklord_5", "slow", true),
			e5_duration = caster:GetTalentValue("modifier_nevermore_darklord_5", "duration", true),
			e5_radius = caster:GetTalentValue("modifier_nevermore_darklord_5", "radius", true),
			e5_slow_duration = caster:GetTalentValue("modifier_nevermore_darklord_5", "slow_duration", true),

			has_e6 = 0,
			e6_speed = caster:GetTalentValue("modifier_nevermore_darklord_6", "speed", true),
			e6_range = caster:GetTalentValue("modifier_nevermore_darklord_6", "range", true),
			e6_status = caster:GetTalentValue("modifier_nevermore_darklord_6", "status", true),
			e6_cd = caster:GetTalentValue("modifier_nevermore_darklord_6", "cd", true),
			e6_width = caster:GetTalentValue("modifier_nevermore_darklord_6", "width", true),
			e6_fear = caster:GetTalentValue("modifier_nevermore_darklord_6", "fear", true),

			has_e7 = 0,
			e7_damage = caster:GetTalentValue("modifier_nevermore_darklord_7", "damage", true) / 100,
			e7_bonus = caster:GetTalentValue("modifier_nevermore_darklord_7", "bonus", true) / 100,
			e7_radius = caster:GetTalentValue("modifier_nevermore_darklord_7", "radius", true),
			e7_cd = caster:GetTalentValue("modifier_nevermore_darklord_7", "cd", true),
			e7_duration = caster:GetTalentValue("modifier_nevermore_darklord_7", "duration", true),
			e7_fear = caster:GetTalentValue("modifier_nevermore_darklord_7", "fear", true),
			e7_fear_radius = caster:GetTalentValue("modifier_nevermore_darklord_7", "fear_radius", true),
			e7_fear_speed = caster:GetTalentValue("modifier_nevermore_darklord_7", "fear_speed", true),
		}
	end

	if caster:HasTalent("modifier_nevermore_darklord_1") then
		self.talents.e1_magic = caster:GetTalentValue("modifier_nevermore_darklord_1", "magic")
		self.talents.e1_armor = caster:GetTalentValue("modifier_nevermore_darklord_1", "armor")
	end

	if caster:HasTalent("modifier_nevermore_darklord_2") then
		self.talents.e2_move = caster:GetTalentValue("modifier_nevermore_darklord_2", "move")
		self.talents.e2_attack = caster:GetTalentValue("modifier_nevermore_darklord_2", "attack")
	end

	if caster:HasTalent("modifier_nevermore_darklord_3") then
		self.talents.has_e3 = 1
		self.talents.e3_heal = caster:GetTalentValue("modifier_nevermore_darklord_3", "heal") / 100
		self.talents.e3_heal_reduce = caster:GetTalentValue("modifier_nevermore_darklord_3", "heal_reduce")
		caster:AddDamageEvent_out(self.tracker, true)
	end

	if caster:HasTalent("modifier_nevermore_darklord_4") then
		self.talents.has_e4 = 1
		self.talents.e4_damage = caster:GetTalentValue("modifier_nevermore_darklord_4", "damage")
		self.talents.e4_burn = caster:GetTalentValue("modifier_nevermore_darklord_4", "burn") / 100
	end

	if caster:HasTalent("modifier_nevermore_darklord_5") then
		self.talents.has_e5 = 1
	end

	if caster:HasTalent("modifier_nevermore_darklord_6") then
		self.talents.has_e6 = 1
		caster:AddAttackStartEvent_inc(self.tracker, true)
	end

	if caster:HasTalent("modifier_nevermore_darklord_7") then
		self.talents.has_e7 = 1
	end
end

function custom_nevermore_dark_lord:GetAbilityTextureName()
	return wearables_system:GetAbilityIconReplacement(self.caster, "nevermore_dark_lord", self)
end

function custom_nevermore_dark_lord:GetIntrinsicModifierName()
	return "modifier_custom_dark_lord_aura"
end

function custom_nevermore_dark_lord:GetCooldown(iLevel)
	if self.talents.has_e7 ~= 1 and self.talents.has_e5 ~= 1 then
		return 0
	end
	return self.talents.e7_cd
end

function custom_nevermore_dark_lord:GetBehavior()
	if self.talents.has_e7 ~= 1 and self.talents.has_e5 ~= 1 then
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function custom_nevermore_dark_lord:OnSpellStart()
	if self.talents.has_e5 == 1 then
		self.caster:RemoveModifierByName("modifier_custom_dark_lord_speed")
		self.caster:AddNewModifier(
			self.caster,
			self,
			"modifier_custom_dark_lord_speed",
			{ duration = self.talents.e5_duration }
		)
	end

	if self.talents.has_e7 == 0 then
		return
	end

	self.caster:StartGestureWithPlaybackRate(ACT_DOTA_RAZE_3, 1)

	if not IsValid(self.legendary_mod) then
		self:EndCd(0)
		self:StartCooldown(0.2)

		self.caster:EmitSound("Sf.Aura_Legendary_Buff")
		self.caster:EmitSound("Sf.Aura_Legendary")
		self.caster:AddNewModifier(
			self.caster,
			self,
			"modifier_custom_dark_lord_legendary",
			{ duration = self.talents.e7_duration }
		)
		return
	end

	self:EndCd()
	self.caster:AddNewModifier(
		self.caster,
		self,
		"modifier_custom_dark_lord_legendary_fear",
		{ stack = self.legendary_mod:GetStackCount() }
	)
end

function custom_nevermore_dark_lord:OnProjectileHit(target, vLocation)
	if not target then
		return
	end

	target:EmitSound("Hero_Nevermore.RequiemOfSouls.Damage")
	target:AddNewModifier(
		self.caster,
		self,
		"modifier_nevermore_requiem_fear",
		{ duration = (1 - target:GetStatusResistance()) * self.talents.e6_fear }
	)
end

modifier_custom_dark_lord_aura = class(mod_hidden)
function modifier_custom_dark_lord_aura:AllowIllusionDuplicate()
	return true
end
function modifier_custom_dark_lord_aura:IsAura()
	return not self.caster:PassivesDisabled()
end
function modifier_custom_dark_lord_aura:GetAuraDuration()
	return self.duration
end
function modifier_custom_dark_lord_aura:GetAuraRadius()
	return self.aura_radius
end
function modifier_custom_dark_lord_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE
end
function modifier_custom_dark_lord_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_custom_dark_lord_aura:GetModifierAura()
	return "modifier_custom_dark_lord_debuff"
end
function modifier_custom_dark_lord_aura:OnCreated()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.ability:UpdateTalents()

	self.aura_radius = self.ability:GetSpecialValueFor("presence_radius")
	self.duration = self.ability:GetSpecialValueFor("linger_duration")

	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end

function modifier_custom_dark_lord_aura:OnRefresh()
	self.aura_radius = self.ability:GetSpecialValueFor("presence_radius")
	self.duration = self.ability:GetSpecialValueFor("linger_duration")
end

function modifier_custom_dark_lord_aura:OnIntervalThink()
	if not IsServer() then
		return
	end
	if self.ability.talents.has_e4 == 0 then
		return
	end

	if #self.parent:FindTargets(self.ability.talents.e4_radius) > 0 then
		self.parent:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_custom_dark_lord_damage",
			{ duration = self.ability.talents.e4_duration, interval = self.ability.talents.e4_interval }
		)
	end

	self:StartIntervalThink(self.ability.talents.e4_interval)
end

function modifier_custom_dark_lord_aura:DamageEvent_out(params)
	if not IsServer() then
		return
	end
	if self.ability.talents.has_e3 == 0 then
		return
	end
	if not self.parent:CheckLifesteal(params, 0) then
		return
	end

	local heal = params.damage * self.ability.talents.e3_heal
	if params.unit:IsCreep() then
		heal = heal / self.ability.talents.e3_creeps
	end

	self.parent:GenericHeal(heal, self.ability, true, "", "modifier_nevermore_darklord_3")
end

function modifier_custom_dark_lord_aura:AttackStartEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.ability.talents.has_e6 == 0 then
		return
	end
	if self.parent ~= params.target then
		return
	end
	if not params.attacker:IsUnit() then
		return
	end
	if params.attacker:HasModifier("modifier_custom_dark_lord_fear_cd") then
		return
	end
	if params.attacker:IsInvulnerable() then
		return
	end
	if not params.attacker:IsRealHero() then
		return
	end

	params.attacker:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_custom_dark_lord_fear_cd",
		{ duration = self.ability.talents.e6_cd }
	)
	self.parent:EmitSound("Sf.Dark_fear")

	local particle_lines = wearables_system:GetParticleReplacementAbility(
		self.parent,
		"particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf",
		self.ability
	)

	local direction = params.attacker:GetAbsOrigin() - self.parent:GetAbsOrigin()
	direction.z = 0
	direction = direction:Normalized()

	local projectile_info = {
		Ability = self.ability,
		vSpawnOrigin = self.parent:GetAbsOrigin(),
		fDistance = self.ability.talents.e6_range,
		fStartRadius = self.ability.talents.e6_width,
		fEndRadius = self.ability.talents.e6_width,
		Source = self.parent,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		bDeleteOnHit = false,
		vVelocity = direction * self.ability.talents.e6_speed,
		bProvidesVision = false,
	}

	ProjectileManager:CreateLinearProjectile(projectile_info)

	local particle_lines_fx = ParticleManager:CreateParticle(particle_lines, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle_lines_fx, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_lines_fx, 1, direction * self.ability.talents.e6_speed)
	ParticleManager:SetParticleControl(
		particle_lines_fx,
		2,
		Vector(0, self.ability.talents.e6_range / self.ability.talents.e6_speed, 0)
	)
	ParticleManager:ReleaseParticleIndex(particle_lines_fx)
end

function modifier_custom_dark_lord_aura:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	}
end

function modifier_custom_dark_lord_aura:GetModifierStatusResistanceStacking()
	if self.ability.talents.has_e6 ~= 1 then
		return
	end
	return self.ability.talents.e6_status
end

function modifier_custom_dark_lord_aura:GetAuraEntityReject(target)
	if target:IsFieldInvun(self.caster) then
		return true
	end
	if self.caster:GetTeam() == target:GetTeam() and self.caster ~= target then
		return true
	end
	return false
end

function modifier_custom_dark_lord_aura:GetAuraSearchTeam()
	if IsValid(self.ability.legendary_mod) then
		return DOTA_UNIT_TARGET_TEAM_ENEMY + DOTA_UNIT_TARGET_TEAM_FRIENDLY
	end
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

modifier_custom_dark_lord_debuff = class(mod_visible)
function modifier_custom_dark_lord_debuff:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()

	self.armor = -1 * self.ability:GetSpecialValueFor("presence_armor_reduction")

	self.self_k = 1
	if self.caster:GetTeamNumber() == self.parent:GetTeamNumber() then
		self.self_k = -1
	end

	if not IsServer() then
		return
	end
	if self.ability.talents.has_e4 == 0 then
		return
	end
	if self.self_k == -1 then
		return
	end

	self.damageTable = {
		victim = self.parent,
		attacker = self.caster,
		ability = self.ability,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK,
	}
	self:StartIntervalThink(self.ability.talents.e4_interval)
end

function modifier_custom_dark_lord_debuff:OnIntervalThink()
	if not IsServer() then
		return
	end

	local near = (self.parent:GetAbsOrigin() - self.caster:GetAbsOrigin()):Length2D() <= self.ability.talents.e4_radius

	if near then
		self.damageTable.damage = self.ability.talents.e4_interval
			* self.ability.talents.e4_burn
			* self.caster:GetAverageTrueAttackDamage(nil)
		DoDamage(self.damageTable, "modifier_nevermore_darklord_4")

		if not self.burn_particle then
			self.burn_particle = self.parent:GenericParticle("particles/shadow_fiend/dark_burn.vpcf", self)
		end
	else
		if self.burn_particle then
			ParticleManager:DestroyParticle(self.burn_particle, false)
			ParticleManager:ReleaseParticleIndex(self.burn_particle)
			self.burn_particle = nil
		end
	end
end

function modifier_custom_dark_lord_debuff:GetBonus(bonus)
	local result = bonus
	if IsValid(self.ability.legendary_mod) then
		result = result * (1 + self.ability.legendary_mod:GetStackCount() * self.ability.talents.e7_bonus)
	end
	return result * self.self_k
end

function modifier_custom_dark_lord_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_custom_dark_lord_debuff:GetModifierPhysicalArmorBonus()
	return self:GetBonus(self.armor + (self.ability.talents.e1_armor or 0))
end

function modifier_custom_dark_lord_debuff:GetModifierMagicalResistanceBonus()
	return self:GetBonus(self.ability.talents.e1_magic or 0)
end

function modifier_custom_dark_lord_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetBonus(self.ability.talents.e2_move or 0)
end

function modifier_custom_dark_lord_debuff:GetModifierAttackSpeedBonus_Constant()
	return self:GetBonus(self.ability.talents.e2_attack or 0)
end

function modifier_custom_dark_lord_debuff:GetModifierHPRegenAmplify_Percentage()
	if not IsValid(self.parent) then
		return
	end
	if self.ability.talents.has_e3 ~= 1 then
		return
	end
	if self.parent:GetHealthPercent() > self.ability.talents.e3_health then
		return
	end
	return self:GetBonus(self.ability.talents.e3_heal_reduce)
end

function modifier_custom_dark_lord_debuff:GetModifierHealChange()
	if not IsValid(self.parent) then
		return
	end
	if self.ability.talents.has_e3 ~= 1 then
		return
	end
	if self.parent:GetHealthPercent() > self.ability.talents.e3_health then
		return
	end
	return self:GetBonus(self.ability.talents.e3_heal_reduce)
end

modifier_custom_dark_lord_legendary = class(mod_hidden)
function modifier_custom_dark_lord_legendary:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.legendary_mod = self
	self.RemoveForDuel = true

	if not IsServer() then
		return
	end
	self.max_time = self:GetRemainingTime()
	self.particle = self.parent:GenericParticle("particles/sf_timer.vpcf", self, true)

	local effect_cast = ParticleManager:CreateParticle(
		"particles/shadow_fiend/dark_legendary_caster.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControl(effect_cast, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(
		effect_cast,
		2,
		Vector(self.ability.talents.e7_radius, self:GetRemainingTime(), self.ability.talents.e7_radius)
	)
	self:AddParticle(effect_cast, false, false, -1, false, false)

	self.interval = 0.1
	self.count = -self.interval
	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_custom_dark_lord_legendary:OnDestroy()
	if not IsServer() then
		return
	end
	self.ability:StartCd()
	self.parent:RemoveModifierByName("modifier_custom_dark_lord_debuff")
	self.parent:UpdateUIshort({ hide = 1, hide_full = 1, style = "FiendDark" })
end

function modifier_custom_dark_lord_legendary:OnIntervalThink()
	if not IsServer() then
		return
	end

	if #self.parent:FindTargets(self.ability.talents.e7_radius) > 0 then
		self.count = self.count + self.interval
		if self.count >= 0.99 then
			self.count = 0
			self:IncrementStackCount()
			ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
		end
	end

	self.parent:UpdateUIshort({
		max_time = self.max_time,
		time = self:GetRemainingTime(),
		stack = self:GetStackCount(),
		style = "FiendDark",
	})
end

modifier_custom_dark_lord_legendary_fear = class(mod_hidden)
function modifier_custom_dark_lord_legendary_fear:RemoveOnDeath()
	return false
end
function modifier_custom_dark_lord_legendary_fear:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.origin = self.parent:GetAbsOrigin()

	self.stack = table.stack
	self.fear_duration = self.stack * self.ability.talents.e7_fear
	self.fear_damage = self.stack * self.ability.talents.e7_damage

	self.damageTable = {
		ability = self.ability,
		attacker = self.parent,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK,
	}

	self.width = 100
	self.targets = {}

	self.parent:EmitSound("Sf.Aura_Ring")
	self.effect_cast = ParticleManager:CreateParticle("particles/sf_fear.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.effect_cast, 0, self.origin)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(900, 1000, 1000))
	self:AddParticle(self.effect_cast, false, false, -1, false, false)

	AddFOWViewer(
		self.parent:GetTeamNumber(),
		self.origin,
		self.ability.talents.e7_fear_radius + 100,
		self.ability.talents.e7_fear_radius / self.ability.talents.e7_fear_speed + 2,
		false
	)

	self:StartIntervalThink(0.03)
end

function modifier_custom_dark_lord_legendary_fear:OnIntervalThink()
	if not IsServer() then
		return
	end

	local radius = self.ability.talents.e7_fear_speed * self:GetElapsedTime()

	if radius > self.ability.talents.e7_fear_radius then
		self:Destroy()
		return
	end

	if self.stack <= 0 then
		return
	end

	for _, target in pairs(self.parent:FindTargets(radius, self.origin)) do
		if not self.targets[target] and (target:GetOrigin() - self.origin):Length2D() > (radius - self.width) then
			self.targets[target] = true
			target:EmitSound("Sf.Aura_Fear")
			target:GenericParticle("particles/shadow_fiend/dark_legendary_stun.vpcf")
			target:AddNewModifier(
				self.parent,
				self.ability,
				"modifier_stunned",
				{ duration = self.fear_duration * (1 - target:GetStatusResistance()) }
			)

			self.damageTable.victim = target
			self.damageTable.damage = self.parent:GetAverageTrueAttackDamage(nil) * self.fear_damage
			DoDamage(self.damageTable, "modifier_nevermore_darklord_7")
		end
	end
end

modifier_custom_dark_lord_damage = class(mod_visible)
function modifier_custom_dark_lord_damage:GetTexture()
	return "buffs/darklord_health"
end
function modifier_custom_dark_lord_damage:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self.count = table.interval
end

function modifier_custom_dark_lord_damage:OnRefresh(table)
	if not IsServer() then
		return
	end
	self.count = self.count + table.interval
	if self.count < 0.99 then
		return
	end

	self.count = 0
	if self:GetStackCount() >= self.ability.talents.e4_max then
		return
	end
	self:IncrementStackCount()
end

function modifier_custom_dark_lord_damage:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_custom_dark_lord_damage:GetModifierPreAttack_BonusDamage()
	return self.ability.talents.e4_damage * self:GetStackCount()
end

modifier_custom_dark_lord_speed = class(mod_visible)
function modifier_custom_dark_lord_speed:GetTexture()
	return "buffs/Sonic_stack"
end
function modifier_custom_dark_lord_speed:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.targets = {}

	if not IsServer() then
		return
	end

	if self.ability.talents.has_e7 == 0 then
		self.ability:EndCd()
	end

	self.parent:EmitSound("Sf.Dark_speed")
	self.parent:EmitSound("Sf.Dark_speed2")

	self.effect_cast = ParticleManager:CreateParticle("particles/sf_aura.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(self.effect_cast, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.ability.talents.e5_radius, 0, 0))
	self:AddParticle(self.effect_cast, false, false, -1, false, false)

	self.parent:GenericParticle("particles/shadow_fiend/dark_speed.vpcf", self)
	self.parent:GenericParticle("particles/sf_wings.vpcf", self)

	self:StartIntervalThink(0.1)
end

function modifier_custom_dark_lord_speed:OnIntervalThink()
	if not IsServer() then
		return
	end

	for _, target in pairs(self.parent:FindTargets(self.ability.talents.e5_radius)) do
		if not self.targets[target] then
			self.targets[target] = true
			target:EmitSound("Sf.Dark_slow_hit")
			target:GenericParticle("particles/shadow_fiend/dark_legendary_stun.vpcf")
			target:AddNewModifier(
				self.parent,
				self.ability,
				"modifier_custom_dark_lord_slow",
				{ duration = (1 - target:GetStatusResistance()) * self.ability.talents.e5_slow_duration }
			)
		end
	end
end

function modifier_custom_dark_lord_speed:OnDestroy()
	if not IsServer() then
		return
	end
	if self.ability.talents.has_e7 == 1 then
		return
	end
	self.ability:StartCd()
end

function modifier_custom_dark_lord_speed:CheckState()
	return {
		[MODIFIER_STATE_UNSLOWABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_custom_dark_lord_speed:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function modifier_custom_dark_lord_speed:GetModifierMoveSpeed_Absolute()
	return self.ability.talents.e5_speed
end

function modifier_custom_dark_lord_speed:GetActivityTranslationModifiers()
	return "haste"
end

modifier_custom_dark_lord_slow = class(mod_hidden)
function modifier_custom_dark_lord_slow:IsPurgable()
	return true
end
function modifier_custom_dark_lord_slow:GetStatusEffectName()
	return "particles/status_fx/status_effect_slark_shadow_dance.vpcf"
end
function modifier_custom_dark_lord_slow:StatusEffectPriority()
	return MODIFIER_PRIORITY_HIGH
end
function modifier_custom_dark_lord_slow:OnCreated()
	self.ability = self:GetAbility()
	self.slow = self.ability.talents.e5_slow
end

function modifier_custom_dark_lord_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_custom_dark_lord_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_custom_dark_lord_slow:CheckState()
	return {
		[MODIFIER_STATE_TETHERED] = true,
	}
end

modifier_custom_dark_lord_fear_cd = class(mod_hidden)
function modifier_custom_dark_lord_fear_cd:RemoveOnDeath()
	return false
end
function modifier_custom_dark_lord_fear_cd:OnCreated()
	self.RemoveForDuel = true
end