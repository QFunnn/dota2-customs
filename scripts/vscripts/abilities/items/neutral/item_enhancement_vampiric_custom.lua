--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_enhancement_vampiric_custom",
	"abilities/items/neutral/item_enhancement_vampiric_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_enhancement_vampiric_custom = class({})

function item_enhancement_vampiric_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items3_fx/octarine_core_lifesteal.vpcf", context)
end

function item_enhancement_vampiric_custom:GetIntrinsicModifierName()
	return "modifier_item_enhancement_vampiric_custom"
end

function item_enhancement_vampiric_custom:Spawn()
	self.health_regen = self:GetSpecialValueFor("health_regen")
	self.lifesteal = self:GetSpecialValueFor("lifesteal")
	self.creeps = self:GetSpecialValueFor("creeps")
end

modifier_item_enhancement_vampiric_custom = class(mod_hidden)
function modifier_item_enhancement_vampiric_custom:RemoveOnDeath()
	return false
end
function modifier_item_enhancement_vampiric_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.health_regen = self.ability.health_regen
	self.lifesteal = self.ability.lifesteal / 100
	self.creeps = self.ability.creeps

	if not self.parent:IsRealHero() then
		return
	end
	self.parent:AddDamageEvent_out(self, true)
end

function modifier_item_enhancement_vampiric_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_enhancement_vampiric_custom:GetModifierConstantHealthRegen()
	return self.health_regen
end

function modifier_item_enhancement_vampiric_custom:DamageEvent_out(params)
	if not IsServer() then
		return
	end
	if not IsValid(self.ability) then
		return
	end
	if not self.parent:CheckLifesteal(params) then
		return
	end

	local heal = self.lifesteal * params.damage
	heal = params.unit:IsCreep() and heal / self.creeps or heal

	self.parent:GenericHeal(
		heal,
		self.ability,
		true,
		params.inflictor and "particles/items3_fx/octarine_core_lifesteal.vpcf" or nil
	)
end