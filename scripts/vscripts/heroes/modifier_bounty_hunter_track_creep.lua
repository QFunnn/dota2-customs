--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bounty_hunter_track_creep_movespeed", "heroes/modifier_bounty_hunter_track_creep", LUA_MODIFIER_MOTION_NONE)

modifier_bounty_hunter_track_creep = class({})

function modifier_bounty_hunter_track_creep:IsHidden() return true end
function modifier_bounty_hunter_track_creep:IsPurgable() return false end

function modifier_bounty_hunter_track_creep:OnCreated()
	if not IsServer() then return end

	self.ability = self:GetAbility()
	self.bonus_gold_self = self.ability:GetSpecialValueFor("bonus_gold_self") + self:GetCaster():FindTalentValue("special_bonus_unique_bounty_hunter_3")
	self.bonus_gold_allies = self.ability:GetSpecialValueFor("bonus_gold") + self:GetCaster():FindTalentValue("special_bonus_unique_bounty_hunter_3")
	self.target_crit_multiplier = self.ability:GetSpecialValueFor("target_crit_multiplier")

	if IsServer() then
		self.particle_shield_fx = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_shield.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent(), self:GetCaster():GetTeamNumber())
		ParticleManager:SetParticleControl(self.particle_shield_fx, 0, self:GetParent():GetAbsOrigin())
		self:AddParticle(self.particle_shield_fx, false, false, -1, false, true)

		self.particle_trail_fx = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_trail.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), self:GetCaster():GetTeamNumber())
		ParticleManager:SetParticleControl(self.particle_trail_fx, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControlEnt(self.particle_trail_fx, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(self.particle_trail_fx, 8, Vector(1,0,0))
		self:AddParticle(self.particle_trail_fx, false, false, -1, false, false)
	end

	self:StartIntervalThink(0.1)
end

function modifier_bounty_hunter_track_creep:OnRefresh()
	self:OnCreated()
end

function modifier_bounty_hunter_track_creep:OnIntervalThink()
	if not IsServer() then return end
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_truesight", {duration = 0.1*2})
	AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 50, 0.1, true)
end

function modifier_bounty_hunter_track_creep:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE,
	}
end

function modifier_bounty_hunter_track_creep:GetAuraDuration()
	return 0.1
end

function modifier_bounty_hunter_track_creep:GetAuraRadius()
	return -1
end

function modifier_bounty_hunter_track_creep:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_bounty_hunter_track_creep:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_bounty_hunter_track_creep:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_bounty_hunter_track_creep:GetModifierAura()
	return "modifier_bounty_hunter_track_creep_movespeed"
end

function modifier_bounty_hunter_track_creep:IsAura()
	return true
end

function modifier_bounty_hunter_track_creep:IsDebuff()
	return true
end

function modifier_bounty_hunter_track_creep:RemoveOnDeath()
	return false
end

function modifier_bounty_hunter_track_creep:GetModifierPreAttack_Target_CriticalStrike(keys)
	if keys.attacker == self:GetCaster() then
		return self.target_crit_multiplier
	else
		return 0
	end
end

function modifier_bounty_hunter_track_creep:OnDeathEvent(keys)
	if not IsServer() then return end
	if keys.unit ~= self:GetParent() then return end
	local reincarnate = keys.reincarnate

	if reincarnate then
		self:Destroy()
		return nil
	end

	if self:GetAbility().bRoundDueled then
		self:Destroy()
		return nil
	end

	self:GetAbility().bRoundDueled = true

			
	self:GetCaster():ModifyGoldFiltered(self.bonus_gold_self, true, DOTA_ModifyGold_Unspecified)
	SendOverheadEventMessage(self:GetCaster(), OVERHEAD_ALERT_GOLD, self:GetCaster(), self.bonus_gold_self, nil)

	local allies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)

	for _,ally in pairs(allies) do
		if ally ~= self:GetCaster() then
			ally:ModifyGoldFiltered(self.bonus_gold_allies, true, DOTA_ModifyGold_Unspecified)
			SendOverheadEventMessage(ally, OVERHEAD_ALERT_GOLD, ally, self.bonus_gold_allies, nil)
		end
	end

	self:Destroy()
end

function modifier_bounty_hunter_track_creep:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

modifier_bounty_hunter_track_creep_movespeed = class({})

function modifier_bounty_hunter_track_creep_movespeed:IsHidden() return true end

function modifier_bounty_hunter_track_creep_movespeed:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.particle_haste = "particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_haste.vpcf"
	self.ms_bonus_allies_pct = self.ability:GetSpecialValueFor("bonus_move_speed_pct")

	if IsServer() then
		self.particle_haste_fx = ParticleManager:CreateParticle(self.particle_haste, PATTACH_ABSORIGIN_FOLLOW, self.parent)
		ParticleManager:SetParticleControl(self.particle_haste_fx, 0, self.parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(self.particle_haste_fx, 1, self.parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(self.particle_haste_fx, 2, self.parent:GetAbsOrigin())
		self:AddParticle(self.particle_haste_fx, false, false, -1, false, false)
	end
end

function modifier_bounty_hunter_track_creep_movespeed:DeclareFunctions()
	local decFuncs = {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE}

	return decFuncs
end

function modifier_bounty_hunter_track_creep_movespeed:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_bonus_allies_pct
end









