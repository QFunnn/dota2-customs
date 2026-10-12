--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_prawler_aura", "abilities/creeps_neutral/neutral_prawler_aura", LUA_MODIFIER_MOTION_NONE)

neutral_prawler_aura = class({})

function neutral_prawler_aura:GetIntrinsicModifierName()
	return "modifier_prawler_aura"
end

modifier_prawler_aura = class(mod_hidden)
function modifier_prawler_aura:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.heal = self.ability:GetSpecialValueFor("heal") / 100
	self.heal_mult = self.ability:GetSpecialValueFor("heal_mult")

	if not IsServer() then
		return
	end
	self.parent:AddDamageEvent_out(self, true)
end

function modifier_prawler_aura:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end

function modifier_prawler_aura:DamageEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end
	if not params.unit:IsUnit() then
		return
	end
	if not self.parent:CheckLifesteal(params) then
		return
	end

	local heal = params.damage * self.heal
	local no_text = true
	if params.unit:HasModifier("modifier_prawler_armor_custom") then
		heal = heal * self.heal_mult
		no_text = false
	end

	self.parent:GenericHeal(heal, self.ability, no_text)
end