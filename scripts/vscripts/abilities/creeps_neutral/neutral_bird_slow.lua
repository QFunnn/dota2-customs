--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bird_slow", "abilities/creeps_neutral/neutral_bird_slow", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bird_slow_buff", "abilities/creeps_neutral/neutral_bird_slow", LUA_MODIFIER_MOTION_NONE)

neutral_bird_slow = class({})

function neutral_bird_slow:GetIntrinsicModifierName()
	return "modifier_bird_slow"
end

modifier_bird_slow = class(mod_hidden)
function modifier_bird_slow:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.radius = self.ability:GetSpecialValueFor("radius")
	self.ability.move = self.ability:GetSpecialValueFor("move")
	self.ability.speed = self.ability:GetSpecialValueFor("speed")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")

	if not IsServer() then
		return
	end
	self.parent:AddAttackEvent_out(self, true)
end

function modifier_bird_slow:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end

	for _, unit in pairs(self.parent:FindTargets(self.ability.radius)) do
		if unit:CanEntityBeSeenByMyTeam(self.parent) then
			local mod = unit:FindModifierByNameAndCaster("modifier_bird_slow_buff", self.parent)
			if mod then
				mod:SetDuration(self.ability.duration, true)
			else
				unit:AddNewModifier(
					self.parent,
					self.ability,
					"modifier_bird_slow_buff",
					{ duration = self.ability.duration }
				)
			end
		end
	end
end

modifier_bird_slow_buff = class(mod_visible)
function modifier_bird_slow_buff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_bird_slow_buff:OnCreated()
	self.ability = self:GetAbility()

	self.move = self.ability.move
	self.speed = self.ability.speed
end

function modifier_bird_slow_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_bird_slow_buff:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end

function modifier_bird_slow_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.move
end