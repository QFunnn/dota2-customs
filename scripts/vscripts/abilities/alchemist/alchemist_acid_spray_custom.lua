--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_alchemist_acid_spray_custom_thinker",
	"abilities/alchemist/alchemist_acid_spray_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_acid_spray_custom_aura",
	"abilities/alchemist/alchemist_acid_spray_custom",
	LUA_MODIFIER_MOTION_NONE,
	true
)
LinkLuaModifier(
	"modifier_alchemist_acid_spray_custom_aura_red",
	"abilities/alchemist/alchemist_acid_spray_custom",
	LUA_MODIFIER_MOTION_NONE,
	{ true, "modifier_alchemist_spray_legendary" }
)
LinkLuaModifier(
	"modifier_alchemist_acid_spray_custom_aura_purple",
	"abilities/alchemist/alchemist_acid_spray_custom",
	LUA_MODIFIER_MOTION_NONE,
	{ true, "modifier_alchemist_spray_legendary" }
)
LinkLuaModifier(
	"modifier_alchemist_acid_spray_custom_mixing",
	"abilities/alchemist/alchemist_acid_spray_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_acid_spray_custom_tracker",
	"abilities/alchemist/alchemist_acid_spray_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_acid_spray_custom_effects",
	"abilities/alchemist/alchemist_acid_spray_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_acid_spray_custom_armor",
	"abilities/alchemist/alchemist_acid_spray_custom",
	LUA_MODIFIER_MOTION_NONE,
	"modifier_alchemist_spray_3"
)
LinkLuaModifier(
	"modifier_alchemist_acid_spray_custom_root_cd",
	"abilities/alchemist/alchemist_acid_spray_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_acid_spray_custom_root",
	"abilities/alchemist/alchemist_acid_spray_custom",
	LUA_MODIFIER_MOTION_NONE,
	"modifier_alchemist_spray_4"
)

alchemist_acid_spray_class = class({})
alchemist_acid_spray_class.talents = {}

function alchemist_acid_spray_class:GetAOERadius()
	local ability = self.caster.acid_spray_ability or self
	return (ability.radius or 0) + (ability.talents.has_q4 == 1 and ability.talents.q4_radius or 0)
end

function alchemist_acid_spray_class:GetCooldown(level)
	local ability = self.caster.acid_spray_ability or self
	return self.BaseClass.GetCooldown(self, level) + (ability.talents.q2_cd or 0)
end

function alchemist_acid_spray_class:OnAbilityPhaseStart()
	return not self.caster:HasModifier("modifier_alchemist_acid_spray_custom_mixing")
end

function alchemist_acid_spray_class:OnSpellStart()
	if IsValid(self.active_mod) then
		self.active_mod:RemoveModifierByName("modifier_alchemist_acid_spray_custom_thinker")
	end

	self.active_mod = self.caster.acid_spray_ability:CreateSpray(self:GetCursorPosition(), self)
end

alchemist_acid_spray_custom = class(alchemist_acid_spray_class)
alchemist_acid_spray_red_custom = class(alchemist_acid_spray_class)
alchemist_acid_spray_purple_custom = class(alchemist_acid_spray_class)

function alchemist_acid_spray_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end

	PrecacheResource("particle", "particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_alchemist/alchemist_acid_spray_debuff.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf",
		context
	)
	PrecacheResource("particle", "particles/generic_gameplay/generic_silenced.vpcf", context)
	PrecacheResource("particle", "particles/alchemist/alch_root.vpcf", context)
end

function alchemist_acid_spray_custom:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			h1_slow = 0,
			h1_heal_reduce = 0,

			has_h4 = 0,
			h4_magic = caster:GetTalentValue("modifier_alchemist_hero_4", "magic", true),
			h4_heal = caster:GetTalentValue("modifier_alchemist_hero_4", "heal", true),
			h4_status = caster:GetTalentValue("modifier_alchemist_hero_4", "status", true),

			q1_damage = 0,
			q1_creeps_max = caster:GetTalentValue("modifier_alchemist_spray_1", "creeps_max", true),

			q2_cd = 0,
			q2_mana = 0,

			has_q3 = 0,
			q3_armor = 0,
			q3_magic = 0,
			q3_max = caster:GetTalentValue("modifier_alchemist_spray_3", "max", true),
			q3_duration = caster:GetTalentValue("modifier_alchemist_spray_3", "duration", true),

			has_q4 = 0,
			q4_radius = caster:GetTalentValue("modifier_alchemist_spray_4", "radius", true),
			q4_root = caster:GetTalentValue("modifier_alchemist_spray_4", "root", true),
			q4_cd = caster:GetTalentValue("modifier_alchemist_spray_4", "cd", true),

			has_q7 = 0,
			q7_damage_reduce = caster:GetTalentValue("modifier_alchemist_spray_legendary", "damage_reduce", true),
			q7_status_reduce = caster:GetTalentValue("modifier_alchemist_spray_legendary", "status_reduce", true),
			q7_creeps = caster:GetTalentValue("modifier_alchemist_spray_legendary", "creeps", true) / 100,

			has_w7 = 0,
			w7_magic_resist = caster:GetTalentValue("modifier_alchemist_unstable_legendary", "magic_resist", true),
		}
	end

	if caster:HasTalent("modifier_alchemist_hero_1") then
		self.talents.h1_slow = caster:GetTalentValue("modifier_alchemist_hero_1", "slow")
		self.talents.h1_heal_reduce = caster:GetTalentValue("modifier_alchemist_hero_1", "heal_reduce")
	end

	if caster:HasTalent("modifier_alchemist_hero_4") then
		self.talents.has_h4 = 1
	end

	if caster:HasTalent("modifier_alchemist_spray_1") then
		self.talents.q1_damage = caster:GetTalentValue("modifier_alchemist_spray_1", "damage") / 100
	end

	if caster:HasTalent("modifier_alchemist_spray_2") then
		self.talents.q2_cd = caster:GetTalentValue("modifier_alchemist_spray_2", "cd")
		self.talents.q2_mana = caster:GetTalentValue("modifier_alchemist_spray_2", "mana")
	end

	if caster:HasTalent("modifier_alchemist_spray_3") then
		self.talents.has_q3 = 1
		self.talents.q3_armor = caster:GetTalentValue("modifier_alchemist_spray_3", "armor")
		self.talents.q3_magic = caster:GetTalentValue("modifier_alchemist_spray_3", "magic")
	end

	if caster:HasTalent("modifier_alchemist_spray_4") then
		self.talents.has_q4 = 1
	end

	if caster:HasTalent("modifier_alchemist_spray_legendary") then
		self.talents.has_q7 = 1
	end

	if caster:HasTalent("modifier_alchemist_unstable_legendary") then
		self.talents.has_w7 = 1
	end
end

function alchemist_acid_spray_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_alchemist_acid_spray_custom_tracker"
end

function alchemist_acid_spray_custom:CreateSpray(point, ability)
	if not IsServer() then
		return
	end
	return CreateModifierThinker(
		self.caster,
		ability,
		"modifier_alchemist_acid_spray_custom_thinker",
		{ duration = self.duration },
		point,
		self.caster:GetTeamNumber(),
		false
	)
end

function alchemist_acid_spray_custom:DoDamage(target)
	if not IsServer() then
		return
	end
	local damage = self.damage

	local bonus = target:GetMaxHealth() * self.talents.q1_damage
	bonus = target:IsCreep() and math.min(bonus, self.talents.q1_creeps_max) or bonus
	damage = damage + bonus

	if self.talents.has_q7 == 1 and target:IsCreep() then
		damage = damage * (1 + self.talents.q7_creeps)
	end

	local damage_type = self.talents.has_w7 == 1 and DAMAGE_TYPE_MAGICAL or DAMAGE_TYPE_PHYSICAL
	local damageTable = {
		victim = target,
		attacker = self.caster,
		damage = damage,
		damage_type = damage_type,
		ability = self,
		damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK,
	}

	DoDamage(damageTable)
	target:AddNewModifier(self.caster, self, "modifier_alchemist_acid_spray_custom_effects", { duration = 1 })

	if
		self.talents.has_q4 == 1
		and not target:HasModifier("modifier_alchemist_acid_spray_custom_root_cd")
		and not target:IsDebuffImmune()
	then
		target:EmitSound("Alch.Root_target")
		target:AddNewModifier(
			self.caster,
			self,
			"modifier_alchemist_acid_spray_custom_root_cd",
			{ duration = self.talents.q4_cd }
		)
		target:AddNewModifier(
			self.caster,
			self,
			"modifier_alchemist_acid_spray_custom_root",
			{ duration = self.talents.q4_root * (1 - target:GetStatusResistance()) }
		)
	end

	target:EmitSound("Hero_Alchemist.AcidSpray.Damage")
end

modifier_alchemist_acid_spray_custom_thinker = class(mod_hidden)
function modifier_alchemist_acid_spray_custom_thinker:IsAura()
	return true
end
function modifier_alchemist_acid_spray_custom_thinker:GetModifierAura()
	return self.aura_mod
end
function modifier_alchemist_acid_spray_custom_thinker:GetAuraRadius()
	return self.radius
end
function modifier_alchemist_acid_spray_custom_thinker:GetAuraDuration()
	return 0.5
end
function modifier_alchemist_acid_spray_custom_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY + DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_alchemist_acid_spray_custom_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_alchemist_acid_spray_custom_thinker:GetAuraSearchFlags()
	return 0
end
function modifier_alchemist_acid_spray_custom_thinker:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()

	self.aura_mod = "modifier_alchemist_acid_spray_custom_aura"
	local effect_name = "particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf"
	local color_vec = Vector(0, 0, 0)

	local ability_name = self.ability:GetName()
	if ability_name == "alchemist_acid_spray_red_custom" then
		self.aura_mod = "modifier_alchemist_acid_spray_custom_aura_red"
		color_vec = Vector(220, 20, 60)
	elseif ability_name == "alchemist_acid_spray_purple_custom" then
		self.aura_mod = "modifier_alchemist_acid_spray_custom_aura_purple"
		color_vec = Vector(180, 92, 179)
	end

	self.radius = self.ability:GetAOERadius()

	AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), self.radius, 3, false)

	local particle = ParticleManager:CreateParticle(effect_name, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, 1, 1))
	ParticleManager:SetParticleControl(particle, 15, color_vec)
	ParticleManager:SetParticleControl(
		particle,
		16,
		Vector(ability_name ~= "alchemist_acid_spray_custom" and 1 or 0, 0, 0)
	)
	self:AddParticle(particle, false, false, -1, false, false)

	self.parent:EmitSound("Hero_Alchemist.AcidSpray")
end

function modifier_alchemist_acid_spray_custom_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	if not IsValid(self.parent) then
		return
	end
	self.parent:StopSound("Hero_Alchemist.AcidSpray")
	UTIL_Remove(self.parent)
end

acid_spray_aura_class = class(mod_visible)
function acid_spray_aura_class:IsHidden()
	return not self.is_enemy
end
function acid_spray_aura_class:GetEffectName()
	return self.is_enemy and "particles/units/heroes/hero_alchemist/alchemist_acid_spray_debuff.vpcf" or nil
end
function acid_spray_aura_class:OnCreated()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self.caster.acid_spray_ability

	self.is_enemy = self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber()

	self.armor = 0
	self.magic_resist = 0
	self.damage_reduce = 0
	self.status_reduce = 0

	if self.is_enemy then
		self.armor = self.ability.talents.has_w7 == 1 and 0 or -self.ability.armor_reduction
		self.magic_resist = self.ability.talents.has_w7 == 1 and self.ability.talents.w7_magic_resist or 0
		if self.ability.talents.has_q7 == 1 then
			self.damage_reduce = self.ability.talents.q7_damage_reduce
			self.status_reduce = self.ability.talents.q7_status_reduce
		end
	end

	if not IsServer() then
		return
	end

	self.armor_duration = self.ability.talents.q3_duration

	if
		self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura")
		and self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_red")
		and self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_purple")
		and self.is_enemy
	then
		self.parent:EmitSound("Alch.Triple")
	end

	self:StartIntervalThink(0.1)
end

function acid_spray_aura_class:OnIntervalThink()
	if not IsServer() then
		return
	end

	if self.is_enemy then
		self.ability:DoDamage(self.parent)
	end

	if self.ability.talents.has_q3 == 1 then
		self.parent:AddNewModifier(
			self.caster,
			self.caster:BkbAbility(self.ability, true),
			"modifier_alchemist_acid_spray_custom_armor",
			{ duration = self.armor_duration }
		)
	end

	self:StartIntervalThink(1)
end

modifier_alchemist_acid_spray_custom_aura = class(acid_spray_aura_class)
function modifier_alchemist_acid_spray_custom_aura:GetTexture()
	return "alchemist_acid_spray"
end
function modifier_alchemist_acid_spray_custom_aura:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_alchemist_acid_spray_custom_aura:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_alchemist_acid_spray_custom_aura:GetModifierMagicalResistanceBonus()
	return self.magic_resist
end

function modifier_alchemist_acid_spray_custom_aura:CheckState()
	if not self.is_enemy then
		return
	end
	if
		not self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_red")
		or not self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_purple")
	then
		return
	end
	return {
		[MODIFIER_STATE_TETHERED] = true,
	}
end

modifier_alchemist_acid_spray_custom_aura_red = class(acid_spray_aura_class)
function modifier_alchemist_acid_spray_custom_aura_red:GetTexture()
	return "spray_red"
end
function modifier_alchemist_acid_spray_custom_aura_red:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_alchemist_acid_spray_custom_aura_red:GetModifierSpellAmplify_Percentage()
	return self.damage_reduce
end

function modifier_alchemist_acid_spray_custom_aura_red:GetModifierDamageOutgoing_Percentage()
	return self.damage_reduce
end

modifier_alchemist_acid_spray_custom_aura_purple = class(acid_spray_aura_class)
function modifier_alchemist_acid_spray_custom_aura_purple:GetTexture()
	return "spray_purple"
end
function modifier_alchemist_acid_spray_custom_aura_purple:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	}
end

function modifier_alchemist_acid_spray_custom_aura_purple:GetModifierStatusResistanceStacking()
	return self.status_reduce
end

modifier_alchemist_acid_spray_custom_tracker = class(mod_hidden)
function modifier_alchemist_acid_spray_custom_tracker:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.parent.acid_spray_ability = self.ability
	self.ability:UpdateTalents()

	self.ability.radius = self.ability:GetSpecialValueFor("radius")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.armor_reduction = self.ability:GetSpecialValueFor("armor_reduction")
end

function modifier_alchemist_acid_spray_custom_tracker:OnRefresh()
	self.ability.radius = self.ability:GetSpecialValueFor("radius")
	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.armor_reduction = self.ability:GetSpecialValueFor("armor_reduction")
end

function modifier_alchemist_acid_spray_custom_tracker:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_alchemist_acid_spray_custom_tracker:GetModifierPercentageManacostStacking()
	return self.ability.talents.q2_mana
end

function modifier_alchemist_acid_spray_custom_tracker:GetModifierMagicalResistanceBonus()
	if self.ability.talents.has_h4 == 0 then
		return
	end
	return self.ability.talents.h4_magic
end

function modifier_alchemist_acid_spray_custom_tracker:GetModifierStatusResistanceStacking()
	if self.ability.talents.has_h4 == 0 then
		return
	end
	return (
		self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura")
		or self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_red")
		or self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_purple")
		or self.parent:HasModifier("modifier_alchemist_unstable_concoction_custom")
	)
			and self.ability.talents.h4_status
		or 0
end

function modifier_alchemist_acid_spray_custom_tracker:GetModifierHealthRegenPercentage()
	if self.ability.talents.has_h4 == 0 then
		return
	end
	local regen = (
		self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura")
		or self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_red")
		or self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_purple")
	)
			and self.ability.talents.h4_heal
		or 0

	if IsServer() then
		if regen > 0 and not self.heal_effect then
			self.heal_effect =
				self.parent:GenericParticle("particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", self)
		end
		if regen <= 0 and self.heal_effect then
			ParticleManager:Delete(self.heal_effect, 1)
			self.heal_effect = nil
		end
	end

	return regen
end

modifier_alchemist_acid_spray_custom_effects = class(mod_hidden)
function modifier_alchemist_acid_spray_custom_effects:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.slow = self.ability.talents.h1_slow
	self.heal_reduce = self.ability.talents.h1_heal_reduce

	if not IsServer() then
		return
	end
	self.interval = 1
	self:StartIntervalThink(1)
end

function modifier_alchemist_acid_spray_custom_effects:OnIntervalThink()
	if not IsServer() then
		return
	end

	if IsValid(self.caster.corrosive_ability) then
		self.caster.corrosive_ability:AddStack(self.parent, 1)
	end

	if self.caster:GetQuest() == "Alch.Quest_5" and not self.caster:QuestCompleted() and self.parent:IsRealHero() then
		self.caster:UpdateQuest(self.interval)
	end
end

function modifier_alchemist_acid_spray_custom_effects:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_alchemist_acid_spray_custom_effects:GetModifierHealChange()
	return self.heal_reduce
end

function modifier_alchemist_acid_spray_custom_effects:GetModifierHPRegenAmplify_Percentage()
	return self.heal_reduce
end

function modifier_alchemist_acid_spray_custom_effects:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

modifier_alchemist_acid_spray_custom_armor = class(mod_visible)
function modifier_alchemist_acid_spray_custom_armor:GetTexture()
	return "buffs/alchemist/spray_3"
end
function modifier_alchemist_acid_spray_custom_armor:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self.caster.acid_spray_ability

	self.is_enemy = self.caster:GetTeamNumber() ~= self.parent:GetTeamNumber()

	self:OnRefresh()

	if not IsServer() then
		return
	end
	self.RemoveForDuel = true
	self:StartIntervalThink(1)
end

function modifier_alchemist_acid_spray_custom_armor:OnRefresh()
	self.max = self.ability.talents.q3_max
	self.armor = self.ability.talents.has_w7 == 1 and 0 or self.ability.talents.q3_armor / self.max
	self.magic = self.ability.talents.has_w7 == 1 and self.ability.talents.q3_magic / self.max or 0

	if self.is_enemy then
		self.armor = self.armor * -1
		self.magic = self.magic * -1
	end
end

function modifier_alchemist_acid_spray_custom_armor:OnIntervalThink()
	if not IsServer() then
		return
	end
	if
		not self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura")
		and not self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_red")
		and not self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_purple")
	then
		return
	end

	if self:GetStackCount() >= self.max then
		return
	end

	self:IncrementStackCount()

	if self.is_enemy and self:GetStackCount() >= self.max then
		self.parent:EmitSound("Hoodwink.Acorn_armor")
		self.parent:GenericParticle("particles/generic/generic_armor_reduction.vpcf", self, true)
	end
end

function modifier_alchemist_acid_spray_custom_armor:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_alchemist_acid_spray_custom_armor:GetModifierPhysicalArmorBonus()
	return self:GetStackCount() * self.armor
end

function modifier_alchemist_acid_spray_custom_armor:GetModifierMagicalResistanceBonus()
	return self:GetStackCount() * self.magic
end

modifier_alchemist_acid_spray_custom_root = class(mod_hidden)
function modifier_alchemist_acid_spray_custom_root:IsPurgable()
	return true
end
function modifier_alchemist_acid_spray_custom_root:GetEffectName()
	return "particles/alchemist/alch_root.vpcf"
end
function modifier_alchemist_acid_spray_custom_root:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
	}
end

modifier_alchemist_acid_spray_custom_root_cd = class(mod_hidden)

alchemist_acid_spray_mixing = class({})
alchemist_acid_spray_mixing.talents = {}
alchemist_acid_spray_mixing.current_spray = 1

function alchemist_acid_spray_mixing:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			q7_delay = caster:GetTalentValue("modifier_alchemist_spray_legendary", "delay", true),
		}
	end
end

function alchemist_acid_spray_mixing:CreateTalent()
	self:SetLevel(1)
	self:SetHidden(false)
	self:UpdateTalents()
end

function alchemist_acid_spray_mixing:OnSpellStart()
	self.caster:StartGesture(ACT_DOTA_ALCHEMIST_CONCOCTION)
	self.caster:AddNewModifier(
		self.caster,
		self,
		"modifier_alchemist_acid_spray_custom_mixing",
		{ duration = self.talents.q7_delay }
	)
end

modifier_alchemist_acid_spray_custom_mixing = class(mod_visible)
function modifier_alchemist_acid_spray_custom_mixing:OnCreated()
	if not IsServer() then
		return
	end
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.parent:EmitSound("Alch.Mix")

	self.abilities =
		{ "alchemist_acid_spray_custom", "alchemist_acid_spray_red_custom", "alchemist_acid_spray_purple_custom" }

	self.ability:SetActivated(false)
	self.ability:StartCooldown(self:GetRemainingTime())
end

function modifier_alchemist_acid_spray_custom_mixing:OnDestroy()
	if not IsServer() then
		return
	end

	self.parent:FadeGesture(ACT_DOTA_ALCHEMIST_CONCOCTION)
	self.ability:SetActivated(true)

	self.parent:StopSound("Alch.Mix")

	local current = self.ability.current_spray
	local next = self.ability.current_spray >= #self.abilities and 1 or self.ability.current_spray + 1

	self.parent:SwapAbilities(self.abilities[current], self.abilities[next], false, true)
	self.ability.current_spray = next
end