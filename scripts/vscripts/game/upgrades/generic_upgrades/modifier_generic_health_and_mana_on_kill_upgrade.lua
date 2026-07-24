--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_health_and_mana_on_kill_upgrade = class(modifier_base_generic_upgrade)


if not IsServer() then return end

function modifier_generic_health_and_mana_on_kill_upgrade:OnCreated()
	self._kill_listener = EventDriver:Listen("Events:entity_killed", self.OnUnitKilled, self)

	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_health_and_mana_on_kill_upgrade:OnDestroy()
	if self._kill_listener then
		self._kill_listener = EventDriver:CancelListener("Events:entity_killed", self._kill_listener)
	end
end


function modifier_generic_health_and_mana_on_kill_upgrade:RecalculateBonusPerUpgrade()
	self.health_gained = self:CalculateBonusPerUpgrade("health_gained")
	self.mana_gained = self:CalculateBonusPerUpgrade("mana_gained")
end


function modifier_generic_health_and_mana_on_kill_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_health_and_mana_on_kill_upgrade:OnUnitKilled(event)
	local parent = self:GetParent()
	local killer = event.killer
	local killed = event.killed

	if not IsValidEntity(parent) or not IsValidEntity(killer) then return end
	if parent:GetPlayerOwnerID() ~= killer:GetPlayerOwnerID() then return end
	if killed:IsOther() or killed:IsBuilding() or killed:GetClassname() == "npc_dota_base_additive" then return end
	if killer:GetTeam() == killed:GetTeam() then return end

	parent:HealWithParams(self.health_gained, parent, true, true, parent, false)
	parent:GiveMana(self.mana_gained)

	local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_OVERHEAD_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)

	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, parent, self.health_gained, nil)
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, parent, self.mana_gained, nil)
end