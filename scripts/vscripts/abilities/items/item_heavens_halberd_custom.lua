--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_heavens_halberd_custom",
	"abilities/items/item_heavens_halberd_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_heavens_halberd_custom_disarm",
	"abilities/items/item_heavens_halberd_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_heavens_halberd_custom_steal",
	"abilities/items/item_heavens_halberd_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_heavens_halberd_custom_steal_target",
	"abilities/items/item_heavens_halberd_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_heavens_halberd_custom = class({})

function item_heavens_halberd_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items2_fx/heavens_halberd.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/harpoon_pull.vpcf", context)
end

function item_heavens_halberd_custom:GetIntrinsicModifierName()
	return "modifier_item_heavens_halberd_custom"
end

function item_heavens_halberd_custom:Spawn()
	self.bonus_str = self:GetSpecialValueFor("bonus_str")
	self.bonus_agi = self:GetSpecialValueFor("bonus_agi")
	self.bonus_health = self:GetSpecialValueFor("bonus_health")
	self.bonus_armor = self:GetSpecialValueFor("bonus_armor")
	self.bonus_evasion = self:GetSpecialValueFor("bonus_evasion")
	self.pull_distance = self:GetSpecialValueFor("pull_distance")
	self.pull_duration = self:GetSpecialValueFor("pull_duration")
	self.steal_duration = self:GetSpecialValueFor("steal_duration")
	self.attack_speed = self:GetSpecialValueFor("attack_speed")
	self.attack_damage = self:GetSpecialValueFor("attack_damage")
	self.disarm_duration = self:GetSpecialValueFor("disarm_duration")
end

function item_heavens_halberd_custom:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	caster:EmitSound("Item.heavens_halberd.Cast")

	if target:TriggerSpellAbsorb(self) then
		return nil
	end

	local duration = self.disarm_duration

	local dir = (caster:GetAbsOrigin() - target:GetAbsOrigin()):Normalized()
	local point = caster:GetAbsOrigin() - dir * 100
	local distance = (point - target:GetAbsOrigin()):Length2D()
	local max_dist = self.pull_distance
	local pull_duration = self.pull_duration

	distance = math.min(max_dist, math.max(40, distance))
	point = target:GetAbsOrigin() + dir * distance

	local mod = target:AddNewModifier(caster, self, "modifier_generic_arc", {
		target_x = point.x,
		target_y = point.y,
		distance = distance,
		duration = pull_duration,
		height = 0,
		fix_end = false,
		isStun = false,
		activity = ACT_DOTA_FLAIL,
	})

	if mod then
		target:GenericParticle("particles/items_fx/harpoon_pull.vpcf", mod)
	end

	target:EmitSound("DOTA_Item.HeavensHalberd.Activate")
	target:AddNewModifier(
		caster,
		self,
		"modifier_item_heavens_halberd_custom_disarm",
		{ duration = (1 - target:GetStatusResistance()) * duration }
	)

	target:RemoveModifierByName("modifier_item_heavens_halberd_custom_steal_target")
	caster:RemoveModifierByName("modifier_item_heavens_halberd_custom_steal")

	caster:AddNewModifier(
		caster,
		self,
		"modifier_item_heavens_halberd_custom_steal",
		{ duration = self.steal_duration, damage = target:GetAverageTrueAttackDamage(nil) }
	)
	target:AddNewModifier(
		caster,
		self,
		"modifier_item_heavens_halberd_custom_steal_target",
		{ duration = self.steal_duration }
	)
end

modifier_item_heavens_halberd_custom = class(mod_hidden)
function modifier_item_heavens_halberd_custom:RemoveOnDeath()
	return false
end
function modifier_item_heavens_halberd_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
	}
end

function modifier_item_heavens_halberd_custom:GetModifierBonusStats_Strength()
	return self.ability.bonus_str
end

function modifier_item_heavens_halberd_custom:GetModifierBonusStats_Agility()
	return self.ability.bonus_agi
end

function modifier_item_heavens_halberd_custom:GetModifierPhysicalArmorBonus()
	return self.ability.bonus_armor
end

function modifier_item_heavens_halberd_custom:GetModifierHealthBonus()
	return self.ability.bonus_health
end

function modifier_item_heavens_halberd_custom:GetModifierEvasion_Constant()
	return self.ability.bonus_evasion
end

function modifier_item_heavens_halberd_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
end

modifier_item_heavens_halberd_custom_disarm = class(mod_hidden)
function modifier_item_heavens_halberd_custom_disarm:IsPurgeException()
	return true
end
function modifier_item_heavens_halberd_custom_disarm:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
	}
end

function modifier_item_heavens_halberd_custom_disarm:OnCreated()
	if not IsServer() then
		return
	end
	self:GetParent():GenericParticle("particles/items2_fx/heavens_halberd.vpcf", self, true)
end

modifier_item_heavens_halberd_custom_steal = class(mod_visible)
function modifier_item_heavens_halberd_custom_steal:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.speed = self.ability.attack_speed
	if not IsServer() then
		return
	end
	self.damage = table.damage * self.ability.attack_damage / 100

	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end

function modifier_item_heavens_halberd_custom_steal:AddCustomTransmitterData()
	return {
		damage = self.damage,
	}
end

function modifier_item_heavens_halberd_custom_steal:HandleCustomTransmitterData(data)
	self.damage = data.damage
end

function modifier_item_heavens_halberd_custom_steal:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_item_heavens_halberd_custom_steal:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end

function modifier_item_heavens_halberd_custom_steal:GetModifierPreAttack_BonusDamage()
	return self.damage
end

modifier_item_heavens_halberd_custom_steal_target = class(mod_visible)
function modifier_item_heavens_halberd_custom_steal_target:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.speed = self.ability.attack_speed * -1
	self.damage = self.ability.attack_damage * -1
end

function modifier_item_heavens_halberd_custom_steal_target:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_item_heavens_halberd_custom_steal_target:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end

function modifier_item_heavens_halberd_custom_steal_target:GetModifierDamageOutgoing_Percentage()
	return self.damage
end