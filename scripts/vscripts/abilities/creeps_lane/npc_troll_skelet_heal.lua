--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_troll_heal", "abilities/creeps_lane/npc_troll_skelet_heal", LUA_MODIFIER_MOTION_NONE)

npc_troll_skelet_heal = class({})

function npc_troll_skelet_heal:GetIntrinsicModifierName()
	return "modifier_troll_heal"
end

modifier_troll_heal = class(mod_hidden)
function modifier_troll_heal:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.vampiric = self.ability:GetSpecialValueFor("vampiric") / 100

	self.parent:AddAttackEvent_out(self, true)
end

function modifier_troll_heal:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end

	local owner = self.parent:GetOwner()
	if not IsValid(owner) or not owner:IsAlive() then
		return
	end

	owner:GenericHeal(owner:GetMaxHealth() * self.ability.vampiric, self.ability)
end