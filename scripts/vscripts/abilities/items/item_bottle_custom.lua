--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_bottle_custom", "abilities/items/item_bottle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_bottle_custom_regen", "abilities/items/item_bottle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_bottle_custom_rune", "abilities/items/item_bottle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_bottle_custom_effect", "abilities/items/item_bottle_custom", LUA_MODIFIER_MOTION_NONE)

item_bottle_custom = class({})

function item_bottle_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items_fx/bottle.vpcf", context)
	PrecacheResource("particle", "particles/econ/events/fall_2021/radiance_owner_fall_2021.vpcf", context)
	PrecacheResource("particle", "particles/econ/events/fall_2021/radiance_fall_2021.vpcf", context)
end

function item_bottle_custom:GetIntrinsicModifierName()
	return "modifier_item_bottle_custom"
end

function item_bottle_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_item_bottle_custom_rune") then
		return "bottle_doubledamage"
	end
	if IsValid(self.tracker) and self.tracker:GetStackCount() == 1 then
		return "bottle_empty"
	end
	return "item_bottle"
end

function item_bottle_custom:Spawn()
	self.duration = self:GetSpecialValueFor("duration")
	self.heal_base = self:GetSpecialValueFor("heal_base")
	self.heal_health = self:GetSpecialValueFor("heal_health") / 100
	self.mana_regen = self:GetSpecialValueFor("mana_regen")
	self.duration_inc = self:GetSpecialValueFor("duration_inc")
	self.damage_pct = self:GetSpecialValueFor("damage_pct") / 100
	self.radius = self:GetSpecialValueFor("radius")
	self.interval = self:GetSpecialValueFor("interval")
end

function item_bottle_custom:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self.duration
	local is_rune = 0

	if caster:HasModifier("modifier_item_bottle_custom_rune") then
		duration = self.duration_inc
		is_rune = 1
		caster:RemoveModifierByName("modifier_item_bottle_custom_rune")
	end

	if IsValid(self.tracker) then
		self.tracker:SetStackCount(1)
		self.tracker:StartIntervalThink(0.2)
	end

	caster:RemoveModifierByName("modifier_item_bottle_custom_regen")
	caster:AddNewModifier(caster, self, "modifier_item_bottle_custom_regen", { duration = duration, is_rune = is_rune })
end

modifier_item_bottle_custom = class(mod_hidden)
function modifier_item_bottle_custom:OnCreated()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.ability.tracker = self
end

function modifier_item_bottle_custom:OnIntervalThink()
	if not IsServer() then
		return
	end
	if self.ability:GetCooldownTimeRemaining() > 0 then
		return
	end
	self:SetStackCount(0)
	self:StartIntervalThink(-1)
end

modifier_item_bottle_custom_regen = class(mod_visible)
function modifier_item_bottle_custom_regen:GetTexture()
	return "item_bottle"
end
function modifier_item_bottle_custom_regen:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.mana = self.ability.mana_regen
	self.heal = self.ability.heal_base + self.ability.heal_health * self.parent:GetMaxHealth()
	self.radius = self.ability.radius

	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/items_fx/bottle.vpcf", self)
	self.parent:EmitSound("Bottle.active_regen")

	if table.is_rune == 0 then
		return
	end
	self.parent:EmitSound("Bottle.active_damage")
	self.parent:GenericParticle("particles/econ/events/fall_2021/radiance_owner_fall_2021.vpcf", self)

	self.is_aura = true
	self.interval = self.ability.interval
	self.damageTable = {
		attacker = self.parent,
		ability = self.ability,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage = self.heal * self.ability.damage_pct * self.interval,
	}

	self:StartIntervalThink(self.interval - 0.01)
end

function modifier_item_bottle_custom_regen:OnIntervalThink()
	if not IsServer() then
		return
	end

	for _, target in pairs(self.parent:FindTargets(self.radius)) do
		self.damageTable.victim = target
		DoDamage(self.damageTable)
	end
end

function modifier_item_bottle_custom_regen:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_bottle_custom_regen:GetModifierConstantHealthRegen()
	return self.heal
end

function modifier_item_bottle_custom_regen:GetModifierConstantManaRegen()
	return self.mana
end

function modifier_item_bottle_custom_regen:IsAura()
	return IsServer() and self.parent:IsAlive() and self.is_aura
end
function modifier_item_bottle_custom_regen:GetModifierAura()
	return "modifier_item_bottle_custom_effect"
end
function modifier_item_bottle_custom_regen:GetAuraRadius()
	return self.radius
end
function modifier_item_bottle_custom_regen:GetAuraDuration()
	return 0
end
function modifier_item_bottle_custom_regen:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_item_bottle_custom_regen:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_item_bottle_custom_effect = class(mod_hidden)
function modifier_item_bottle_custom_effect:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self.particle = ParticleManager:CreateParticle(
		"particles/econ/events/fall_2021/radiance_fall_2021.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		self.particle,
		1,
		self.caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self.caster:GetAbsOrigin(),
		false
	)
	self:AddParticle(self.particle, false, false, -1, false, false)
end

modifier_item_bottle_custom_rune = class(mod_hidden)
function modifier_item_bottle_custom_rune:RemoveOnDeath()
	return false
end
function modifier_item_bottle_custom_rune:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self.parent:EmitSound("Bottle.rune_pick")
	self.ability:EndCooldown()
end