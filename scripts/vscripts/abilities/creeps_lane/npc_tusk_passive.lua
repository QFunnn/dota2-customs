--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tusk_passive", "abilities/creeps_lane/npc_tusk_passive", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tusk_passive_death", "abilities/creeps_lane/npc_tusk_passive", LUA_MODIFIER_MOTION_NONE)

npc_tusk_passive = class({})

function npc_tusk_passive:GetIntrinsicModifierName()
	return "modifier_tusk_passive"
end

modifier_tusk_passive = class(mod_hidden)
function modifier_tusk_passive:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.parent:AddNewModifier(self.parent, self.ability, "modifier_phased", {})
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_tusk_passive_death", {})
end

modifier_tusk_passive_death = class(mod_hidden)
function modifier_tusk_passive_death:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
end

function modifier_tusk_passive_death:OnDestroy()
	if not IsServer() then
		return
	end
	if self.parent:IsAlive() then
		return
	end
	if self.parent:HasModifier("modifier_death") then
		return
	end

	local ghost = CreateUnitByName("npc_tusk_ghost", self.parent:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_CUSTOM_5)
	ghost:AddNewModifier(self.parent, self.ability, "modifier_invulnerable", {})
end