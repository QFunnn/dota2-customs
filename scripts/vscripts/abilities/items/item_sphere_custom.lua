--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("item_sphere_custom_passive", "abilities/items/item_sphere_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("item_sphere_custom_block", "abilities/items/item_sphere_custom", LUA_MODIFIER_MOTION_NONE)

item_sphere_custom = class({})

function item_sphere_custom:GetIntrinsicModifierName()
	return "item_sphere_custom_passive"
end

function item_sphere_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items/linken_active.vpcf", context)
end

function item_sphere_custom:Spawn()
	self.bonus_all_stats = self:GetSpecialValueFor("bonus_all_stats")
	self.bonus_health_regen = self:GetSpecialValueFor("bonus_health_regen")
	self.bonus_mana_regen = self:GetSpecialValueFor("bonus_mana_regen")
	self.block_cooldown = self:GetSpecialValueFor("block_cooldown")
	self.block_duration = self:GetSpecialValueFor("block_duration")
end

function item_sphere_custom:GetCooldown(level)
	return self.BaseClass.GetCooldown(self, level) / self:GetCaster():GetCooldownReduction()
end

function item_sphere_custom:Block(unit, params)
	if unit:HasModifier("modifier_antimage_counterspell_custom_active") then
		return
	end
	if unit:IsInvulnerable() then
		return
	end

	local attacker = params.ability:GetCaster()

	if not attacker then
		return
	end
	if attacker:IsCreep() then
		return
	end
	if attacker:GetTeamNumber() == unit:GetTeamNumber() then
		return
	end

	local particle =
		ParticleManager:CreateParticle("particles/items_fx/immunity_sphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		unit,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		unit:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)

	unit:EmitSound("DOTA_Item.LinkensSphere.Activate")
	return true
end

item_sphere_custom_passive = class(mod_hidden)
function item_sphere_custom_passive:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function item_sphere_custom_passive:RemoveOnDeath()
	return false
end
function item_sphere_custom_passive:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.bonus_all_stats = self.ability.bonus_all_stats
	self.bonus_health_regen = self.ability.bonus_health_regen
	self.bonus_mana_regen = self.ability.bonus_mana_regen
	self.block_cooldown = self.ability.block_cooldown
	self.block_duration = self.ability.block_duration
end

function item_sphere_custom_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_ABSORB_SPELL,
	}
end

function item_sphere_custom_passive:GetModifierBonusStats_Agility()
	return self.bonus_all_stats
end

function item_sphere_custom_passive:GetModifierBonusStats_Strength()
	return self.bonus_all_stats
end

function item_sphere_custom_passive:GetModifierBonusStats_Intellect()
	return self.bonus_all_stats
end

function item_sphere_custom_passive:GetModifierConstantManaRegen()
	return self.bonus_mana_regen
end

function item_sphere_custom_passive:GetModifierConstantHealthRegen()
	return self.bonus_health_regen
end

function item_sphere_custom_passive:GetAbsorbSpell(params)
	if not IsServer() then
		return
	end
	if self.parent:IsIllusion() then
		return
	end
	if self.parent:HasModifier("item_sphere_custom_block") then
		return
	end
	if not self.ability:IsFullyCastable() then
		return
	end
	if not self.ability:Block(self.parent, params) then
		return
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"item_sphere_custom_block",
		{ duration = self.block_duration }
	)
	self.ability:StartCooldown(self.block_cooldown)
	return 1
end

item_sphere_custom_block = class(mod_hidden)
function item_sphere_custom_block:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	local particle =
		ParticleManager:CreateParticle("particles/items/linken_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(particle, false, false, -1, false, false)
end

function item_sphere_custom_block:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSORB_SPELL,
	}
end

function item_sphere_custom_block:GetAbsorbSpell(params)
	if not IsServer() then
		return
	end
	if not self.ability:Block(self.parent, params) then
		return
	end
	return 1
end