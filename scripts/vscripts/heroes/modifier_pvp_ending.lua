--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


modifier_pvp_ending = class({}) ---@class modifier_pvp_ending : CDOTA_Modifier_Lua

function modifier_pvp_ending:IsHidden()
	return true
end

function modifier_pvp_ending:IsDebuff()
	return false
end

function modifier_pvp_ending:IsPurgable()
	return false
end

function modifier_pvp_ending:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_pvp_ending:RemoveOnDeath()
	return false
end

function modifier_pvp_ending:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}
end

function modifier_pvp_ending:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_pvp_ending:GetOverrideAnimation()
	return ACT_DOTA_VICTORY
end

function modifier_pvp_ending:IsAura()
	return true
end

function modifier_pvp_ending:GetAuraRadius()
	return 3000
end

function modifier_pvp_ending:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_pvp_ending:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_pvp_ending:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_OTHER
end

function modifier_pvp_ending:GetModifierAura()
	return "modifier_pvp_ending_effect"
end

function modifier_pvp_ending:OnCreated()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local origin = parent:GetAbsOrigin()

	self.portParticle = ParticleManager:CreateParticle(
		"particles/econ/events/seasonal_reward_line_summer_2026/teleport_start_summerrewardline_2026.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	local color = GameMode.teamColors[parent:GetTeam()]
	ParticleManager:SetParticleControl(self.portParticle, 0, origin)
	-- ParticleManager:SetParticleControl(self.portParticle, 1, origin)
	ParticleManager:SetParticleControl(self.portParticle, 2, Vector(color[1], color[2], color[3])) -- цвет
	ParticleManager:SetParticleControl(self.portParticle, 7, Vector(1, 0, 0))
	-- ParticleManager:SetParticleControl(self.portParticle, 30, origin)
	EmitSoundOn("Portal.Loop_Disappear", parent)
end

function modifier_pvp_ending:OnDestroy()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	ParticleManager:DestroyParticle(self.portParticle, true)
	ParticleManager:ReleaseParticleIndex(self.portParticle)
	StopSoundOn("Portal.Loop_Disappear", parent)
	EmitSoundOn("Portal.Hero_Appear", parent)
end

----------------------modifier_pvp_ending_effect------------------
modifier_pvp_ending_effect = class({}) ---@class modifier_pvp_ending_effect : CDOTA_Modifier_Lua
function modifier_pvp_ending_effect:IsHidden()
	return true
end

function modifier_pvp_ending_effect:IsDebuff()
	return false
end

function modifier_pvp_ending_effect:IsPurgable()
	return false
end

function modifier_pvp_ending_effect:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_pvp_ending_effect:RemoveOnDeath()
	return false
end

function modifier_pvp_ending_effect:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end