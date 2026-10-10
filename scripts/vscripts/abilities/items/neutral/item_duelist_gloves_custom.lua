--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_duelist_gloves_custom",
	"abilities/items/neutral/item_duelist_gloves_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_duelist_gloves_custom = class({})

function item_duelist_gloves_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_item_duelist_gloves_custom"
end

function item_duelist_gloves_custom:Spawn()
	self.bonus_attack_speed = self:GetSpecialValueFor("bonus_attack_speed")
	self.hero_attack_speed = self:GetSpecialValueFor("hero_attack_speed")
	self.radius = self:GetSpecialValueFor("radius")
end

modifier_item_duelist_gloves_custom = class(mod_hidden)
function modifier_item_duelist_gloves_custom:RemoveOnDeath()
	return false
end
function modifier_item_duelist_gloves_custom:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.speed = self.ability.bonus_attack_speed
	self.hero_speed = self.ability.hero_attack_speed
	self.radius = self.ability.radius

	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.5)
	self:OnIntervalThink()
end

function modifier_item_duelist_gloves_custom:OnIntervalThink()
	if not IsServer() then
		return
	end
	local heroes = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		self.parent:GetAbsOrigin(),
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_ANY_ORDER,
		false
	)
	self:SetStackCount(#heroes > 0 and 1 or 0)
end

function modifier_item_duelist_gloves_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_item_duelist_gloves_custom:GetModifierAttackSpeedBonus_Constant()
	return self.speed + self.hero_speed * self:GetStackCount()
end