--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ursa_aura", "abilities/creeps_neutral/neutral_ursa_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ursa_aura_buff", "abilities/creeps_neutral/neutral_ursa_aura", LUA_MODIFIER_MOTION_NONE)

neutral_ursa_aura = class({})

function neutral_ursa_aura:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/hellbear_rush_cast.vpcf", context)
	PrecacheResource("particle", "particles/neutral_fx/hellbear_power.vpcf", context)
end

function neutral_ursa_aura:GetIntrinsicModifierName()
	return "modifier_ursa_aura"
end

modifier_ursa_aura = class(mod_hidden)
function modifier_ursa_aura:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.speed = self.ability:GetSpecialValueFor("speed")
	self.ability.radius = self.ability:GetSpecialValueFor("radius")

	if not IsServer() then
		return
	end
	self.parent:AddDeathEvent(self, true)
end

function modifier_ursa_aura:DeathEvent(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end

	self.parent:GenericParticle("particles/neutral_fx/hellbear_rush_cast.vpcf")
	for _, unit in pairs(self.parent:FindFriends(self.ability.radius)) do
		unit:AddNewModifier(self.parent, self.ability, "modifier_ursa_aura_buff", {})
	end
end

modifier_ursa_aura_buff = class(mod_visible)
function modifier_ursa_aura_buff:GetEffectName()
	return "particles/neutral_fx/hellbear_power.vpcf"
end
function modifier_ursa_aura_buff:OnCreated()
	self.ability = self:GetAbility()

	self.damage = self.ability.damage
	self.speed = self.ability.speed

	if not IsServer() then
		return
	end
	self:OnRefresh()
end

function modifier_ursa_aura_buff:OnRefresh()
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
end

function modifier_ursa_aura_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_ursa_aura_buff:GetModifierAttackSpeedBonus_Constant()
	return self.speed * self:GetStackCount()
end

function modifier_ursa_aura_buff:GetModifierPreAttack_BonusDamage()
	return self.damage * self:GetStackCount()
end