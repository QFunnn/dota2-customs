--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

hp_per_kill = class(base_game_perk)

function hp_per_kill:__OnCreated()
	if not IsServer() then
		return
	end
	if not self._kill_listener then
		self._kill_listener = EventDriver:Listen("Events:entity_killed", self.OnUnitKilled, self)
	end
end

function hp_per_kill:OnDestroy()
	if not IsServer() then
		return
	end

	if self._kill_listener then
		self._kill_listener = EventDriver:CancelListener("Events:entity_killed", self._kill_listener)
	end
end

function hp_per_kill:OnUnitKilled(event)
	local killer = event.killer
	local killed = event.killed

	if not IsValidEntity(self.parent) or not IsValidEntity(killer) or not IsValidEntity(event.killed) then
		return
	end
	if killed:IsOther() or killed:IsBuilding() or killed:GetClassname() == "npc_dota_base_additive" then
		return
	end
	if not killer.GetPlayerOwnerID then
		return
	end
	if self.parent:GetPlayerOwnerID() ~= killer:GetPlayerOwnerID() then
		return
	end
	if killer:GetTeamNumber() == killed:GetTeamNumber() then
		return
	end

	local hp_restore = self.heal
	if event.killed:IsCreep() then
		hp_restore = self.heal_per_creep
	end

	self.parent:HealWithParams(hp_restore, self.parent, true, true, self.parent, false)

	local particle = ParticleManager:CreateParticle(
		"particles/generic_gameplay/generic_lifesteal.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)

	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self.parent, hp_restore, nil)
end