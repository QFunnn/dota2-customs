--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_outpost_activation = class({})

function modifier_outpost_activation:IsHidden()
	return true
end
function modifier_outpost_activation:IsPurgable()
	return false
end

function modifier_outpost_activation:IsAura()
	return self.isProvidedByAura == false
end

function modifier_outpost_activation:GetModifierAura()
	return "modifier_outpost_activation"
end

function modifier_outpost_activation:GetAuraRadius()
	return 500
end

function modifier_outpost_activation:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_outpost_activation:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_outpost_activation:GetAuraDuration()
	return 0.5
end

function modifier_outpost_activation:GetAuraEntityReject(entity)
	return entity:IsInvulnerable()
end

function modifier_outpost_activation:OnCreated(kv)
	self.isProvidedByAura = kv.isProvidedByAura == 1
	if IsServer() and self.isProvidedByAura then
		local auraOwner = self:GetAuraOwner()
		if not auraOwner or auraOwner:IsNull() then
			return
		end
		local origin = auraOwner:GetOrigin()
		local npc_dota_watch_tower = nil
		local ent = Entities:FindByClassname(nil, "npc_dota_watch_tower")
		while ent do
			if (ent:GetOrigin() - origin):Length() <= 100 then
				npc_dota_watch_tower = ent
				break
			end
			ent = Entities:FindByClassname(ent, "npc_dota_watch_tower")
		end
		if npc_dota_watch_tower and npc_dota_watch_tower:IsOpposingTeam(self:GetParent():GetTeamNumber()) then
			npc_dota_watch_tower:ChangeTeam(DOTA_TEAM_GOODGUYS)
			StartSoundEvent("Outpost.Captured.Notification", self:GetAuraOwner())
		end
	end
end

-- function modifier_outpost_activation:OnCreated( kv )
--     self.isProvidedByAura = kv.isProvidedByAura == 1
--     if IsServer() and self.isProvidedByAura then
--         local npc_dota_watch_tower = Entities:FindByClassnameNearest("npc_dota_watch_tower", self:GetAuraOwner():GetOrigin(), 100)
--         if npc_dota_watch_tower and npc_dota_watch_tower:IsOpposingTeam(self:GetParent():GetTeamNumber()) then
--             npc_dota_watch_tower:ChangeTeam(DOTA_TEAM_GOODGUYS)
--             StartSoundEvent("Outpost.Captured.Notification", self:GetAuraOwner())
--         end
--     end
-- end

function modifier_outpost_activation:CheckState()
	if not self.isProvidedByAura then
		return {
			[MODIFIER_STATE_UNSELECTABLE] = true,
			[MODIFIER_STATE_INVULNERABLE] = true,
			[MODIFIER_STATE_MAGIC_IMMUNE] = true,
			[MODIFIER_STATE_ATTACK_IMMUNE] = true,
			[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
			[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		}
	end
end