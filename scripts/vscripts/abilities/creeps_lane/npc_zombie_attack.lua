--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zombie_attack", "abilities/creeps_lane/npc_zombie_attack", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zombie_debuff", "abilities/creeps_lane/npc_zombie_attack", LUA_MODIFIER_MOTION_NONE)

npc_zombie_attack = class({})

function npc_zombie_attack:GetIntrinsicModifierName()
	return "modifier_zombie_attack"
end

modifier_zombie_attack = class(mod_hidden)
function modifier_zombie_attack:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.slow = self.ability:GetSpecialValueFor("slow")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.max = self.ability:GetSpecialValueFor("max")
end

function modifier_zombie_attack:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_zombie_attack:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end

	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_zombie_debuff",
		{ duration = self.ability.duration * (1 - params.target:GetStatusResistance()) }
	)
end

modifier_zombie_debuff = class(mod_visible)
function modifier_zombie_debuff:IsPurgable()
	return true
end
function modifier_zombie_debuff:GetTexture()
	return "undying_tombstone_zombie_deathstrike"
end
function modifier_zombie_debuff:OnCreated()
	self.ability = self:GetAbility()

	self.slow = -self.ability.slow
	self.max = self.ability.max

	if not IsServer() then
		return
	end
	self:OnRefresh()
end

function modifier_zombie_debuff:OnRefresh()
	if not IsServer() then
		return
	end
	if self:GetStackCount() >= self.max then
		return
	end
	self:IncrementStackCount()
end

function modifier_zombie_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_zombie_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow * self:GetStackCount()
end

function modifier_zombie_debuff:OnTooltip()
	return self.slow * self:GetStackCount()
end