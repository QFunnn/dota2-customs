--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_alchemist_gold_shiva_custom_stats",
	"abilities/items/item_alchemist_gold_shiva.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_gold_shiva_custom_active",
	"abilities/items/item_alchemist_gold_shiva.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_gold_shiva_custom_aura",
	"abilities/items/item_alchemist_gold_shiva.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_gold_shiva_custom_root",
	"abilities/items/item_alchemist_gold_shiva.lua",
	LUA_MODIFIER_MOTION_NONE
)

item_alchemist_gold_shiva = class({})

function item_alchemist_gold_shiva:GetIntrinsicModifierName()
	return "modifier_alchemist_gold_shiva_custom_stats"
end

function item_alchemist_gold_shiva:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/alchemist/gold_shiva.vpcf", context)
	PrecacheResource("particle", "particles/econ/events/ti10/shivas_guard_ti10_impact.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_frost_lich.vpcf", context)
end

function item_alchemist_gold_shiva:Spawn()
	self.blast_radius = self:GetSpecialValueFor("blast_radius")
	self.wave_duration = self:GetSpecialValueFor("wave_duration")
	self.bonus_armor = self:GetSpecialValueFor("bonus_armor")
	self.bonus_hp = self:GetSpecialValueFor("bonus_hp")
	self.bonus_mana = self:GetSpecialValueFor("bonus_mana")
	self.bonus_intellect = self:GetSpecialValueFor("bonus_intellect")
	self.bonus_damage = self:GetSpecialValueFor("bonus_damage")
	self.aura_radius = self:GetSpecialValueFor("aura_radius")
	self.cdr_bonus = self:GetSpecialValueFor("cdr_bonus")
	self.aura_slow = self:GetSpecialValueFor("aura_slow")
	self.aura_attack_speed = self:GetSpecialValueFor("aura_attack_speed")
	self.blast_speed = self:GetSpecialValueFor("blast_speed")
	self.root_duration = self:GetSpecialValueFor("root_duration")
	self.movespeed = self:GetSpecialValueFor("movespeed")
	self.ticks = self:GetSpecialValueFor("ticks")
	self.damage = self:GetSpecialValueFor("damage")
end

function item_alchemist_gold_shiva:GetCastRange(vector, hTarget)
	return self.blast_radius
end

function item_alchemist_gold_shiva:OnSpellStart()
	local caster = self:GetCaster()
	caster:EmitSound("DOTA_Item.ShivasGuard.Activate")
	caster:Purge(false, true, false, false, false)
	caster:AddNewModifier(
		caster,
		self,
		"modifier_alchemist_gold_shiva_custom_active",
		{ duration = self.wave_duration }
	)
end

modifier_alchemist_gold_shiva_custom_stats = class(mod_hidden)
function modifier_alchemist_gold_shiva_custom_stats:RemoveOnDeath()
	return false
end
function modifier_alchemist_gold_shiva_custom_stats:GetAuraRadius()
	return self.radius
end
function modifier_alchemist_gold_shiva_custom_stats:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_alchemist_gold_shiva_custom_stats:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_alchemist_gold_shiva_custom_stats:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_alchemist_gold_shiva_custom_stats:GetModifierAura()
	return "modifier_alchemist_gold_shiva_custom_aura"
end
function modifier_alchemist_gold_shiva_custom_stats:IsAura()
	return not self.parent:HasModifier("modifier_item_shiva_custom_stats")
end
function modifier_alchemist_gold_shiva_custom_stats:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.armor = self.ability.bonus_armor
	self.health = self.ability.bonus_hp
	self.mana = self.ability.bonus_mana
	self.int = self.ability.bonus_intellect
	self.spell = self.ability.bonus_damage
	self.radius = self.ability.aura_radius

	if not self.parent.cdr_items then
		self.parent.cdr_items = {}
	end
	self.parent.cdr_items[self] = self.ability.cdr_bonus
end

function modifier_alchemist_gold_shiva_custom_stats:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_alchemist_gold_shiva_custom_stats:GetModifierSpellAmplify_Percentage()
	return self.spell
end

function modifier_alchemist_gold_shiva_custom_stats:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_alchemist_gold_shiva_custom_stats:GetModifierHealthBonus()
	return self.health
end

function modifier_alchemist_gold_shiva_custom_stats:GetModifierManaBonus()
	return self.mana
end

function modifier_alchemist_gold_shiva_custom_stats:GetModifierBonusStats_Intellect()
	return self.int
end

modifier_alchemist_gold_shiva_custom_aura = class(mod_visible)
function modifier_alchemist_gold_shiva_custom_aura:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost_lich.vpcf"
end
function modifier_alchemist_gold_shiva_custom_aura:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_alchemist_gold_shiva_custom_aura:OnCreated()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.move_slow = self.ability.aura_slow
	self.attack_slow = self.ability.aura_attack_speed
end

function modifier_alchemist_gold_shiva_custom_aura:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_alchemist_gold_shiva_custom_aura:GetModifierAttackSpeedBonus_Constant()
	return self.attack_slow
end

function modifier_alchemist_gold_shiva_custom_aura:GetModifierMoveSpeedBonus_Percentage()
	return self.move_slow
end

modifier_alchemist_gold_shiva_custom_active = class(mod_hidden)
function modifier_alchemist_gold_shiva_custom_active:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_alchemist_gold_shiva_custom_active:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.speed = self.ability.blast_speed
	self.radius = self.ability.blast_radius

	self.root_duration = self.ability.root_duration
	self.movespeed = self.ability.movespeed

	self.interval = 0.1
	self.max_time = self.radius / self.speed

	if not IsServer() then
		return
	end

	local visual_speed = self.speed * 0.9

	self.particle = self.parent:GenericParticle("particles/alchemist/gold_shiva.vpcf", self)
	ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius, self.radius / visual_speed, visual_speed))

	self.targets = {}
	self.current_radius = 10

	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_alchemist_gold_shiva_custom_active:OnIntervalThink()
	if not IsServer() then
		return
	end

	for _, enemy in pairs(self.parent:FindTargets(self.current_radius)) do
		if not self.targets[enemy] then
			self.targets[enemy] = true

			enemy:EmitSound("hero_Crystal.frostbite")
			enemy:AddNewModifier(
				self.parent,
				self.ability,
				"modifier_alchemist_gold_shiva_custom_root",
				{ duration = self.root_duration }
			)

			enemy:GenericParticle("particles/econ/events/ti10/shivas_guard_ti10_impact.vpcf", nil, nil, { 1 })
		end
	end

	AddFOWViewer(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), self.current_radius, self.interval * 2, false)

	if self.particle then
		ParticleManager:SetParticleControl(self.particle, 3, Vector(self.current_radius < self.radius and 1 or 0, 0, 0))
	end

	if self.current_radius < self.radius then
		self.current_radius = self.current_radius + self.speed * self.interval
	end
end

modifier_alchemist_gold_shiva_custom_root = class(mod_hidden)
function modifier_alchemist_gold_shiva_custom_root:IsPurgable()
	return true
end
function modifier_alchemist_gold_shiva_custom_root:GetEffectName()
	return "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf"
end
function modifier_alchemist_gold_shiva_custom_root:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()

	self.ticks = self.ability.ticks

	if not IsServer() then
		return
	end

	local damage = self.ability.damage
	self.damageTable = {
		victim = self.parent,
		attacker = self.caster,
		ability = self.ability,
		damage = damage / self.ticks,
		damage_type = DAMAGE_TYPE_MAGICAL,
	}

	self.count = 0
	self.interval = self:GetRemainingTime() / self.ticks

	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_alchemist_gold_shiva_custom_root:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
	}
end

function modifier_alchemist_gold_shiva_custom_root:OnRefresh(table)
	if not IsServer() then
		return
	end
	self.count = 0
end

function modifier_alchemist_gold_shiva_custom_root:OnIntervalThink()
	if not IsServer() then
		return
	end
	if self.count >= self.ticks then
		return
	end

	DoDamage(self.damageTable)
	self.count = self.count + 1
end