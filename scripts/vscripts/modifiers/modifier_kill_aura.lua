--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_kill_aura = class({})

function modifier_kill_aura:IsAura()
	return self.thinker
end

function modifier_kill_aura:GetModifierAura()
	return "modifier_kill_aura"
end

function modifier_kill_aura:GetAuraRadius()
	return self:GetStackCount() > 0 and self:GetStackCount() or 800
end

function modifier_kill_aura:GetAuraDuration()
	return 0.1
end

function modifier_kill_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_kill_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_kill_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_kill_aura:OnCreated(kv)
	self.thinker = kv.isProvidedByAura ~= 1
	if not IsServer() then
		return
	end
	if self.thinker then
		return
	end

	self:OnIntervalThink()
end

function modifier_kill_aura:OnIntervalThink()
	self:GetParent():Kill(nil, self:GetAuraOwner())
	self:StartIntervalThink(0.2)
end