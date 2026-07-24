--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dark_seer_wall_of_replica_lua = class({})

function modifier_dark_seer_wall_of_replica_lua:IsHidden() return true end
function modifier_dark_seer_wall_of_replica_lua:IsPurgable() return false end
function modifier_dark_seer_wall_of_replica_lua:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end


function modifier_dark_seer_wall_of_replica_lua:OnCreated()
	self.ability = self:GetAbility()
	self.ability.modifier = self
end


function modifier_dark_seer_wall_of_replica_lua:OnIntervalThink()
	local player = Entities:GetLocalPlayer()

	if player:GetClickBehaviors() ~= DOTA_CLICK_BEHAVIOR_VECTOR_CAST then
		ParticleManager:DestroyParticle(self.ability.fx, true)
		self.ability.fx = nil
		self.ability.location = nil
		self:StartIntervalThink(-1)
	end
end