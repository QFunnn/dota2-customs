--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_custom_terrorblade_sunder_legendary",
	"abilities/terrorblade/custom_terrorblade_sunder",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_terrorblade_sunder_tracker",
	"abilities/terrorblade/custom_terrorblade_sunder",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_terrorblade_sunder_stats",
	"abilities/terrorblade/custom_terrorblade_sunder",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_terrorblade_sunder_stats_self",
	"abilities/terrorblade/custom_terrorblade_sunder",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_terrorblade_sunder_rooted",
	"abilities/terrorblade/custom_terrorblade_sunder",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_terrorblade_sunder_damage",
	"abilities/terrorblade/custom_terrorblade_sunder",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_terrorblade_sunder_slow",
	"abilities/terrorblade/custom_terrorblade_sunder",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_terrorblade_sunder_cd",
	"abilities/terrorblade/custom_terrorblade_sunder",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_terrorblade_sunder_shield",
	"abilities/terrorblade/custom_terrorblade_sunder",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_terrorblade_sunder_lethal",
	"abilities/terrorblade/custom_terrorblade_sunder",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_terrorblade_sunder_lethal_cd",
	"abilities/terrorblade/custom_terrorblade_sunder",
	LUA_MODIFIER_MOTION_NONE
)

custom_terrorblade_sunder = class({})
custom_terrorblade_sunder.talents = {}

function custom_terrorblade_sunder:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end

	PrecacheResource("particle", "particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf", context)
	PrecacheResource("particle", "particles/econ/events/spring_2021/blink_dagger_spring_2021_start_lvl2.vpcf", context)
	PrecacheResource("particle", "particles/econ/events/spring_2021/blink_dagger_spring_2021_end.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/phylactery_target.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/phylactery.vpcf", context)
	PrecacheResource("particle", "particles/items3_fx/gleipnir_root.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf", context)
	PrecacheResource("particle", "particles/terrorblade/sunder_lethal.vpcf", context)
end

function custom_terrorblade_sunder:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			has_r1 = 0,
			r1_damage = 0,
			r1_heal_reduce = 0,
			r1_duration = caster:GetTalentValue("modifier_terror_sunder_1", "duration", true),

			has_r2 = 0,
			r2_shield = 0,
			r2_duration = caster:GetTalentValue("modifier_terror_sunder_2", "duration", true),

			r3_cd = 0,
			r3_range = 0,

			has_r4 = 0,
			r4_init = 0,
			r4_duration = caster:GetTalentValue("modifier_terror_sunder_4", "duration", true),
			r4_max = caster:GetTalentValue("modifier_terror_sunder_4", "max", true),

			has_r5 = 0,
			r5_speed = caster:GetTalentValue("modifier_terror_sunder_5", "speed", true),
			r5_cd = caster:GetTalentValue("modifier_terror_sunder_5", "cd", true),
			r5_cast = caster:GetTalentValue("modifier_terror_sunder_5", "cast", true),
			r5_duration = caster:GetTalentValue("modifier_terror_sunder_5", "duration", true),

			has_r6 = 0,
			r6_health = caster:GetTalentValue("modifier_terror_sunder_6", "health", true),
			r6_root = caster:GetTalentValue("modifier_terror_sunder_6", "root", true),

			has_r7 = 0,
			r7_radius = caster:GetTalentValue("modifier_terror_sunder_7", "radius", true),
			r7_interval = caster:GetTalentValue("modifier_terror_sunder_7", "interval", true),
			r7_cost = caster:GetTalentValue("modifier_terror_sunder_7", "cost", true) / 100,
			r7_slow = caster:GetTalentValue("modifier_terror_sunder_7", "slow", true),
			r7_cd = caster:GetTalentValue("modifier_terror_sunder_7", "cd", true),
			r7_heal = caster:GetTalentValue("modifier_terror_sunder_7", "heal", true) / 100,
			r7_slow_duration = caster:GetTalentValue("modifier_terror_sunder_7", "slow_duration", true),
			r7_max = caster:GetTalentValue("modifier_terror_sunder_7", "max", true),
		}
	end

	if caster:HasTalent("modifier_terror_sunder_1") then
		self.talents.has_r1 = 1
		self.talents.r1_damage = caster:GetTalentValue("modifier_terror_sunder_1", "damage") / 100
		self.talents.r1_heal_reduce = caster:GetTalentValue("modifier_terror_sunder_1", "heal_reduce")
	end

	if caster:HasTalent("modifier_terror_sunder_2") then
		self.talents.has_r2 = 1
		self.talents.r2_shield = caster:GetTalentValue("modifier_terror_sunder_2", "shield") / 100
	end

	if caster:HasTalent("modifier_terror_sunder_3") then
		self.talents.r3_cd = caster:GetTalentValue("modifier_terror_sunder_3", "cd")
		self.talents.r3_range = caster:GetTalentValue("modifier_terror_sunder_3", "range")
	end

	if caster:HasTalent("modifier_terror_sunder_4") then
		self.talents.has_r4 = 1
		self.talents.r4_init = caster:GetTalentValue("modifier_terror_sunder_4", "init") / 100
		caster:AddAttackEvent_out(self.tracker, true)
	end

	if caster:HasTalent("modifier_terror_sunder_5") then
		self.talents.has_r5 = 1
		caster:AddDamageEvent_inc(self.tracker, true)
	end

	if caster:HasTalent("modifier_terror_sunder_6") then
		self.talents.has_r6 = 1
	end

	if caster:HasTalent("modifier_terror_sunder_7") then
		self.talents.has_r7 = 1
		caster:AddAttackEvent_out(self.tracker, true)
	end
end

function custom_terrorblade_sunder:GetAbilityTextureName()
	return wearables_system:GetAbilityIconReplacement(self.caster, "terrorblade_sunder", self)
end

function custom_terrorblade_sunder:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_custom_terrorblade_sunder_tracker"
end

function custom_terrorblade_sunder:GetManaCost(level)
	if self.talents.has_r6 == 1 then
		return 0
	end
	return self.BaseClass.GetManaCost(self, level)
end

function custom_terrorblade_sunder:GetCastPoint()
	return self.BaseClass.GetCastPoint(self) + (self.talents.has_r5 == 1 and self.talents.r5_cast or 0)
end

function custom_terrorblade_sunder:GetCastRange(vLocation, hTarget)
	return self.BaseClass.GetCastRange(self, vLocation, hTarget)
end

function custom_terrorblade_sunder:GetCooldown(iLevel)
	return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.r3_cd or 0)
end

function custom_terrorblade_sunder:GetAbilityTargetFlags()
	if self.talents.has_r6 == 1 then
		return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
	end
	return DOTA_UNIT_TARGET_FLAG_NONE
end

function custom_terrorblade_sunder:GetBehavior()
	if self.talents.has_r7 == 1 then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
			+ DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK
			+ DOTA_ABILITY_BEHAVIOR_AUTOCAST
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK
end

function custom_terrorblade_sunder:CastFilterResultTarget(target)
	if target == self.caster then
		return UF_FAIL_CUSTOM
	end

	if target ~= nil and target:HasModifier("modifier_generic_debuff_immune") and self.talents.has_r6 ~= 1 then
		return UF_FAIL_MAGIC_IMMUNE_ENEMY
	end

	if self.talents.has_r7 == 1 then
		return UnitFilter(
			target,
			DOTA_UNIT_TARGET_TEAM_BOTH,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_CHECK_DISABLE_HELP,
			self.caster:GetTeamNumber()
		)
	end
	return UnitFilter(
		target,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO
			+ DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
			+ DOTA_UNIT_TARGET_FLAG_CHECK_DISABLE_HELP,
		self.caster:GetTeamNumber()
	)
end

function custom_terrorblade_sunder:GetCustomCastErrorTarget(target)
	if target ~= self.caster then
		return
	end
	return "#dota_hud_error_cant_cast_on_self"
end

function custom_terrorblade_sunder:OnSpellStart()
	local target = self:GetCursorTarget()

	local is_enemy = self.caster:GetTeamNumber() ~= target:GetTeamNumber()

	if is_enemy then
		if target:TriggerSpellAbsorb(self) then
			return
		end
	end

	if self.talents.has_r6 == 1 and is_enemy then
		local stun = 0
		if self.caster:GetHealthPercent() <= self.talents.r6_health then
			stun = 1
		end
		target:AddNewModifier(
			self.caster,
			self.caster:BkbAbility(self, true),
			"modifier_custom_terrorblade_sunder_rooted",
			{ stun = stun, duration = (1 - target:GetStatusResistance()) * self.talents.r6_root }
		)
	end

	if self.talents.has_r7 == 1 and target ~= nil and is_enemy then
		self.caster:AddNewModifier(
			self.caster,
			self,
			"modifier_custom_terrorblade_sunder_legendary",
			{ target = target:entindex() }
		)
	else
		local caster_health_percent = self.caster:GetHealthPercent()
		local target_health_percent = target:GetHealthPercent()

		local current_health = self.caster:GetHealth()

		self:PlayEffect(target)

		self.caster:SetHealth(
			self.caster:GetMaxHealth() * math.max(target_health_percent, self.hit_point_minimum_pct) * 0.01
		)

		self.caster:AddHealingInfo({
			ability_name = self:GetName(),
			inflictor = self,
			healing = self.caster:GetHealth() - current_health,
		})

		if
			self.caster:GetHealth() > current_health
			and self.caster:GetQuest() == "Terr.Quest_8"
			and not self.caster:QuestCompleted()
			and target:IsRealHero()
			and target:GetTeamNumber() ~= self.caster:GetTeamNumber()
		then
			self.caster:UpdateQuest(self.caster:GetHealth() - current_health)
		end

		target:SetHealth(target:GetMaxHealth() * math.max(caster_health_percent, self.hit_point_minimum_pct) * 0.01)
	end

	if self.talents.has_r4 == 1 and is_enemy then
		self.caster:RemoveModifierByName("modifier_custom_terrorblade_sunder_stats_self")
		self.caster:RemoveModifierByName("modifier_custom_terrorblade_sunder_stats")
		target:RemoveModifierByName("modifier_custom_terrorblade_sunder_stats")

		local stats_target = target
		if stats_target:IsCreep() then
			stats_target = self.caster
		end

		stats_target:AddNewModifier(
			self.caster,
			self,
			"modifier_custom_terrorblade_sunder_stats",
			{ duration = self.talents.r4_duration }
		)
	end

	if self.talents.has_r1 == 1 and is_enemy then
		target:AddNewModifier(self.caster, self, "modifier_custom_terrorblade_sunder_damage", {})
	end

	if self.talents.has_r2 == 1 then
		self.caster:AddNewModifier(
			self.caster,
			self,
			"modifier_custom_terrorblade_sunder_shield",
			{ duration = self.talents.r2_duration }
		)
	end
end

function custom_terrorblade_sunder:CreateTalent()
	self:ToggleAutoCast()
end

function custom_terrorblade_sunder:PlayEffect(target)
	if not IsServer() then
		return
	end

	self.caster:EmitSound("Hero_Terrorblade.Sunder.Cast")
	target:EmitSound("Hero_Terrorblade.Sunder.Target")
	local effect_name = wearables_system:GetParticleReplacementAbility(
		self.caster,
		"particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf",
		self
	)

	local sunder_particle_1 = ParticleManager:CreateParticle(effect_name, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		sunder_particle_1,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		sunder_particle_1,
		1,
		self.caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(sunder_particle_1, 2, target:GetAbsOrigin())
	if self.caster.current_model == "models/heroes/terrorblade/terrorblade_arcana.vmdl" then
		local color = self.caster:GetTerrorbladeColor()
		ParticleManager:SetParticleControl(sunder_particle_1, 15, color)
		ParticleManager:SetParticleControl(sunder_particle_1, 16, Vector(1, 0, 0))
	else
		ParticleManager:SetParticleControl(sunder_particle_1, 15, Vector(0, 152, 255))
		ParticleManager:SetParticleControl(sunder_particle_1, 16, Vector(1, 0, 0))
	end
	ParticleManager:ReleaseParticleIndex(sunder_particle_1)

	local sunder_particle_2 = ParticleManager:CreateParticle(effect_name, PATTACH_ABSORIGIN_FOLLOW, self.caster)
	ParticleManager:SetParticleControlEnt(
		sunder_particle_2,
		0,
		self.caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		sunder_particle_2,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(sunder_particle_2, 2, self.caster:GetAbsOrigin())
	if self.caster.current_model == "models/heroes/terrorblade/terrorblade_arcana.vmdl" then
		local color = self.caster:GetTerrorbladeColor()
		ParticleManager:SetParticleControl(sunder_particle_2, 15, color)
		ParticleManager:SetParticleControl(sunder_particle_2, 16, Vector(1, 0, 0))
	else
		ParticleManager:SetParticleControl(sunder_particle_2, 15, Vector(0, 152, 255))
		ParticleManager:SetParticleControl(sunder_particle_2, 16, Vector(1, 0, 0))
	end
	ParticleManager:ReleaseParticleIndex(sunder_particle_2)
end

modifier_custom_terrorblade_sunder_legendary = class(mod_hidden)
function modifier_custom_terrorblade_sunder_legendary:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end

	if table.target then
		self.target = EntIndexToHScript(table.target)
	end

	self.heal = self.ability.talents.r7_heal
	self.interval = self.ability.talents.r7_interval
	self.max = self.ability.talents.r7_max

	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_custom_terrorblade_sunder_legendary:OnIntervalThink()
	if not IsServer() then
		return
	end
	if not self.target or self.target:IsNull() or not self.target:IsAlive() then
		self:Destroy()
		return
	end

	local current_health = self.parent:GetHealth()
	local heal = (self.parent:GetMaxHealth() - current_health) * self.heal

	self.parent:SetHealth(math.min(self.parent:GetMaxHealth(), self.parent:GetHealth() + heal))

	self.parent:AddHealingInfo({
		ability_name = self.ability:GetName(),
		inflictor = self.ability,
		healing = self.parent:GetHealth() - current_health,
	})

	if
		self.parent:GetHealth() > current_health
		and self.parent:GetQuest() == "Terr.Quest_8"
		and not self.parent:QuestCompleted()
		and self.target:IsRealHero()
		and self.target:GetTeamNumber() ~= self.parent:GetTeamNumber()
	then
		self.parent:UpdateQuest(self.parent:GetHealth() - current_health)
	end

	SendOverheadEventMessage(self.parent, 10, self.parent, heal, nil)
	DoDamage({
		victim = self.target,
		damage = heal,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = self.parent,
		ability = self.ability,
	})
	self.ability:PlayEffect(self.target)

	self:IncrementStackCount()
	if self:GetStackCount() >= self.max then
		self:Destroy()
		return
	end
end

modifier_custom_terrorblade_sunder_tracker = class(mod_hidden)
function modifier_custom_terrorblade_sunder_tracker:RemoveOnDeath()
	return false
end
function modifier_custom_terrorblade_sunder_tracker:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.ability:UpdateTalents()

	self.parent.sunder_ability = self.ability

	self.ability.hit_point_minimum_pct = self.ability:GetSpecialValueFor("hit_point_minimum_pct")
end

function modifier_custom_terrorblade_sunder_tracker:OnRefresh()
	self.ability.hit_point_minimum_pct = self.ability:GetSpecialValueFor("hit_point_minimum_pct")
end

function modifier_custom_terrorblade_sunder_tracker:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_custom_terrorblade_sunder_tracker:GetModifierCastRangeBonusStacking()
	return self.ability.talents.r3_range
end

function modifier_custom_terrorblade_sunder_tracker:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self.parent then
		return
	end
	if not params.target:IsUnit() then
		return
	end

	local target = params.target

	if self.ability.talents.has_r4 == 1 then
		local mod = target:FindModifierByName("modifier_custom_terrorblade_sunder_stats")
		if not mod then
			mod = self.parent:FindModifierByName("modifier_custom_terrorblade_sunder_stats")
		end

		if mod and mod.max and mod:GetCaster() == self.parent and mod:GetStackCount() < mod.max then
			mod:IncrementStackCount()
		end
	end

	if self.ability.talents.has_r7 == 0 then
		return
	end
	if self.parent:HasModifier("modifier_custom_terrorblade_sunder_cd") then
		return
	end
	if not self.ability:GetAutoCastState() then
		return
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_custom_terrorblade_sunder_cd",
		{ duration = self.ability.talents.r7_cd }
	)

	local sunder_particle_1 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControlEnt(
		sunder_particle_1,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		sunder_particle_1,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(sunder_particle_1, 2, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(sunder_particle_1, 15, Vector(191, 100, 255))
	ParticleManager:SetParticleControl(sunder_particle_1, 16, Vector(1, 0, 0))
	ParticleManager:ReleaseParticleIndex(sunder_particle_1)

	local damage = self.parent:GetMaxHealth() * self.ability.talents.r7_cost
	self.parent:SetHealth(math.max(1, self.parent:GetHealth() - damage))
	local damage_table =
		{ damage = damage, damage_type = DAMAGE_TYPE_PURE, attacker = self.parent, ability = self.ability }

	for _, aoe_target in pairs(self.parent:FindTargets(self.ability.talents.r7_radius, target:GetAbsOrigin())) do
		damage_table.victim = aoe_target
		local real_damage = DoDamage(damage_table, "modifier_terror_sunder_7")
		aoe_target:SendNumber(4, real_damage)
		aoe_target:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_custom_terrorblade_sunder_slow",
			{ duration = (1 - aoe_target:GetStatusResistance()) * self.ability.talents.r7_slow_duration }
		)

		local particle_2 = ParticleManager:CreateParticle(
			"particles/items_fx/phylactery_target.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			particle_2,
			1,
			aoe_target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			aoe_target:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(particle_2)
	end

	target:EmitSound("TB.Sunder_attack")
end

function modifier_custom_terrorblade_sunder_tracker:DamageEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.ability.talents.has_r5 == 0 then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if self.parent:GetHealth() > 1 then
		return
	end
	if self.parent:PassivesDisabled() then
		return
	end
	if not self.parent:IsAlive() then
		return
	end
	if self.parent:HasModifier("modifier_death") then
		return
	end
	if self.parent:HasModifier("modifier_custom_terrorblade_sunder_lethal_cd") then
		return
	end

	self.parent:AddNewModifier(
		self.parent,
		self.parent:BkbAbility(self.ability, true),
		"modifier_custom_terrorblade_sunder_lethal",
		{ duration = self.ability.talents.r5_duration }
	)
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_custom_terrorblade_sunder_lethal_cd",
		{ duration = self.ability.talents.r5_cd }
	)
end

function modifier_custom_terrorblade_sunder_tracker:GetMinHealth()
	if self.ability.talents.has_r5 == 0 then
		return
	end
	if self.parent:PassivesDisabled() then
		return
	end
	if self.parent:LethalDisabled() then
		return
	end
	if self.parent:HasModifier("modifier_custom_terrorblade_sunder_lethal_cd") then
		return
	end
	if not self.parent:IsAlive() then
		return
	end
	return 1
end

modifier_custom_terrorblade_sunder_slow = class(mod_hidden)
function modifier_custom_terrorblade_sunder_slow:IsPurgable()
	return true
end
function modifier_custom_terrorblade_sunder_slow:GetEffectName()
	return "particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf"
end
function modifier_custom_terrorblade_sunder_slow:OnCreated()
	self.ability = self:GetAbility()
	self.slow = self.ability.talents.r7_slow
end

function modifier_custom_terrorblade_sunder_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_custom_terrorblade_sunder_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

modifier_custom_terrorblade_sunder_cd = class(mod_cd)
function modifier_custom_terrorblade_sunder_cd:GetTexture()
	return "buffs/sunder_stats"
end

modifier_custom_terrorblade_sunder_stats = class(mod_visible)
function modifier_custom_terrorblade_sunder_stats:GetTexture()
	return "buffs/sunder_heal"
end
function modifier_custom_terrorblade_sunder_stats:OnCreated(table)
	if not IsServer() then
		return
	end

	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.is_self = self.parent == self.caster

	self.init = self.ability.talents.r4_init
	self.max = self.ability.talents.r4_max
	self.inc = self.init / self.max

	if not self.is_self then
		self.caster:AddNewModifier(
			self.caster,
			self.ability,
			"modifier_custom_terrorblade_sunder_stats_self",
			{ duration = self:GetRemainingTime() }
		)
	end

	self.k = 1
	if not self.is_self then
		self.k = -1
	end
	self.strength = 0
	self.agility = 0
	self.int = 0

	self:OnIntervalThink()
	self:StartIntervalThink(0.1)
end

function modifier_custom_terrorblade_sunder_stats:OnIntervalThink()
	if not IsServer() then
		return
	end

	self.strength = 0
	self.agility = 0
	self.int = 0

	self.strength = self.parent:GetStrength() * (self.init + self.inc * self:GetStackCount())
	self.agility = self.parent:GetAgility() * (self.init + self.inc * self:GetStackCount())
	self.int = self.parent:GetIntellect(false) * (self.init + self.inc * self:GetStackCount())

	self.parent:CalculateStatBonus(true)

	if self.is_self then
		return
	end

	local mod = self.caster:FindModifierByName("modifier_custom_terrorblade_sunder_stats_self")
	if not mod then
		return
	end

	mod.strength = self.strength
	mod.agility = self.agility
	mod.int = self.int

	mod:SetStackCount(self:GetStackCount())
	self.caster:CalculateStatBonus(true)
end

function modifier_custom_terrorblade_sunder_stats:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_custom_terrorblade_sunder_stats:GetModifierBonusStats_Strength()
	return self.k * self.strength
end

function modifier_custom_terrorblade_sunder_stats:GetModifierBonusStats_Agility()
	return self.k * self.agility
end

function modifier_custom_terrorblade_sunder_stats:GetModifierBonusStats_Intellect()
	return self.k * self.int
end

modifier_custom_terrorblade_sunder_stats_self = class(mod_visible)
function modifier_custom_terrorblade_sunder_stats_self:GetTexture()
	return "buffs/sunder_heal"
end
function modifier_custom_terrorblade_sunder_stats_self:OnCreated(table)
	if not IsServer() then
		return
	end
	self.strength = 0
	self.agility = 0
	self.int = 0
end

function modifier_custom_terrorblade_sunder_stats_self:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_custom_terrorblade_sunder_stats_self:GetModifierBonusStats_Strength()
	return self.strength
end

function modifier_custom_terrorblade_sunder_stats_self:GetModifierBonusStats_Agility()
	return self.agility
end

function modifier_custom_terrorblade_sunder_stats_self:GetModifierBonusStats_Intellect()
	return self.int
end

modifier_custom_terrorblade_sunder_rooted = class(mod_hidden)
function modifier_custom_terrorblade_sunder_rooted:IsPurgable()
	return true
end
function modifier_custom_terrorblade_sunder_rooted:GetEffectName()
	return "particles/items3_fx/gleipnir_root.vpcf"
end
function modifier_custom_terrorblade_sunder_rooted:OnCreated(table)
	if not IsServer() then
		return
	end
	if table.stun == 0 then
		return
	end

	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.parent:EmitSound("TB.Sunder_stun")
	self.parent:AddNewModifier(self.caster, self.ability, "modifier_stunned", { duration = self:GetRemainingTime() })
end

function modifier_custom_terrorblade_sunder_rooted:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
	}
end

modifier_custom_terrorblade_sunder_damage = class(mod_hidden)
function modifier_custom_terrorblade_sunder_damage:GetTexture()
	return "buffs/sunder_damage"
end
function modifier_custom_terrorblade_sunder_damage:OnCreated(table)
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.duration = self.ability.talents.r1_duration
	self.damage = self.ability.talents.r1_damage
	self.interval = 1
	self.heal_reduce = self.ability.talents.r1_heal_reduce

	self.damageTable =
		{ victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_PURE }

	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/items4_fx/spirit_vessel_damage.vpcf", self)
	self:StartIntervalThink(self.interval)
end

function modifier_custom_terrorblade_sunder_damage:OnIntervalThink()
	if not IsServer() then
		return
	end

	self.damageTable.damage = (self.damage / self.duration) * self.caster:GetMaxHealth()
	local damage = DoDamage(self.damageTable, "modifier_terror_sunder_1")
	self.parent:SendNumber(4, damage)

	self:IncrementStackCount()
	if self:GetStackCount() >= self.duration then
		self:Destroy()
		return
	end
end

function modifier_custom_terrorblade_sunder_damage:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_custom_terrorblade_sunder_damage:GetModifierHealChange()
	return self.heal_reduce
end

function modifier_custom_terrorblade_sunder_damage:GetModifierHPRegenAmplify_Percentage()
	return self.heal_reduce
end

modifier_custom_terrorblade_sunder_shield = class(mod_hidden)
function modifier_custom_terrorblade_sunder_shield:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.shield_talent = "modifier_terror_sunder_2"
	self.max_shield = self.ability.talents.r2_shield * self.parent:GetMaxHealth()

	if not IsServer() then
		return
	end

	self:SetStackCount(self.max_shield)
end

function modifier_custom_terrorblade_sunder_shield:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
end

function modifier_custom_terrorblade_sunder_shield:GetModifierIncomingDamageConstant(params)
	if self:GetStackCount() == 0 then
		return
	end

	if IsClient() then
		if params.report_max then
			return self.max_shield
		else
			return self:GetStackCount()
		end
	end

	if not IsServer() then
		return
	end

	local damage = math.min(params.damage, self:GetStackCount())
	self.parent:AddShieldInfo({ shield_mod = self, healing = damage, healing_type = "shield" })

	self:SetStackCount(self:GetStackCount() - damage)
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end

	return -damage
end

modifier_custom_terrorblade_sunder_lethal = class(mod_hidden)
function modifier_custom_terrorblade_sunder_lethal:IsDebuff()
	return true
end
function modifier_custom_terrorblade_sunder_lethal:GetStatusEffectName()
	return "particles/status_fx/status_effect_dark_willow_shadow_realm.vpcf"
end
function modifier_custom_terrorblade_sunder_lethal:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end
function modifier_custom_terrorblade_sunder_lethal:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()

	self.speed = 0
	if IsValid(self.caster.sunder_ability) then
		self.speed = self.caster.sunder_ability.talents.r5_speed
	end

	if not IsServer() then
		return
	end

	self.parent:EmitSound("TB.Sunder_lethal")
	self.parent:EmitSound("TB.Sunder_lethal2")

	self.effect_cast = ParticleManager:CreateParticle(
		"particles/terrorblade/sunder_lethal.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControl(self.effect_cast, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(self.effect_cast, false, false, -1, false, false)
end

function modifier_custom_terrorblade_sunder_lethal:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSLOWABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end

function modifier_custom_terrorblade_sunder_lethal:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_custom_terrorblade_sunder_lethal:GetModifierMoveSpeedBonus_Percentage()
	return self.speed
end

modifier_custom_terrorblade_sunder_lethal_cd = class(mod_cd)
function modifier_custom_terrorblade_sunder_lethal_cd:GetTexture()
	return "buffs/midnight_haste"
end