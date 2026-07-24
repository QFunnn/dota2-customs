--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_bounty_hunter_track_custom", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_track_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bounty_hunter_track_custom_purge", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_track_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bounty_hunter_track_custom_buff", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_track_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bounty_hunter_track_custom_passive", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_track_custom", LUA_MODIFIER_MOTION_NONE )

bounty_hunter_track_custom = class({})

function bounty_hunter_track_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_cast.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_shield.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_trail.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_haste.vpcf', context )
end

function bounty_hunter_track_custom:CastFilterResultTarget( target )
	if self:GetCaster():HasModifier("modifier_bounty_hunter_21") then return end
	if not target:IsHero() then
        return UF_FAIL_CREEP
	end

	local nResult = UnitFilter(
		target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
		self:GetCaster():GetTeamNumber()
	)

	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

bounty_hunter_track_custom.modifier_bounty_hunter_3 = {500,1000,1500}
bounty_hunter_track_custom.modifier_bounty_hunter_6 = {-20,-40}
bounty_hunter_track_custom.modifier_bounty_hunter_6_regen = {0.3,0.6}
bounty_hunter_track_custom.modifier_bounty_hunter_21 = 120
bounty_hunter_track_custom.modifier_bounty_hunter_16_gold = {30,60}
bounty_hunter_track_custom.modifier_bounty_hunter_16_damage = {4,8}

function bounty_hunter_track_custom:GetIntrinsicModifierName()
	return "modifier_bounty_hunter_track_custom_passive"
end

function bounty_hunter_track_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	local target = self:GetCursorTarget()
	EmitSoundOnLocationForAllies(self:GetCaster():GetAbsOrigin(), "Hero_BountyHunter.Target", self:GetCaster())
	local particle_projectile_fx = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_cast.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster(), self:GetCaster():GetTeamNumber())
	ParticleManager:SetParticleControlEnt(particle_projectile_fx, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle_projectile_fx, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle_projectile_fx)
	if target:TriggerSpellAbsorb(self) then
		return
	end
	if self:GetCaster():HasModifier("modifier_bounty_hunter_18") then
		local bounty_hunter_shuriken_toss_custom = self:GetCaster():FindAbilityByName("bounty_hunter_shuriken_toss_custom")
		if bounty_hunter_shuriken_toss_custom and bounty_hunter_shuriken_toss_custom:GetLevel() > 0 then
			bounty_hunter_shuriken_toss_custom:OnSpellStart(target)
		end
	end
	target:AddNewModifier(self:GetCaster(), self, "modifier_bounty_hunter_track_custom", {duration = duration * (1 - target:GetStatusResistance())})
	target:AddNewModifier(self:GetCaster(), self, "modifier_bounty_hunter_track_custom_purge", {duration = duration * (1 - target:GetStatusResistance())})
end

modifier_bounty_hunter_track_custom_purge = class({})

function modifier_bounty_hunter_track_custom_purge:IsHidden() return true end
function modifier_bounty_hunter_track_custom_purge:IsPurgable() return not self:GetCaster():HasModifier("modifier_bounty_hunter_5") end
function modifier_bounty_hunter_track_custom_purge:IsPurgeException() return not self:GetCaster():HasModifier("modifier_bounty_hunter_5") end

function modifier_bounty_hunter_track_custom_purge:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_bounty_hunter_track_custom")
end

modifier_bounty_hunter_track_custom = class({})

function modifier_bounty_hunter_track_custom:IsPurgable() return true end
function modifier_bounty_hunter_track_custom:IsPurgeException() return true end

function modifier_bounty_hunter_track_custom:OnCreated()
	if not IsServer() then return end
	self.bonus_gold = self:GetAbility():GetSpecialValueFor("bonus_gold")
    self.bonus_gold_hero = self:GetAbility():GetSpecialValueFor("bonus_gold_hero")

	local particle_shield_fx = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_shield.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent(), self:GetCaster():GetTeamNumber())
	ParticleManager:SetParticleControl(particle_shield_fx, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(particle_shield_fx, false, false, -1, false, true)

	local particle_trail_fx = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_trail.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), self:GetCaster():GetTeamNumber())
	ParticleManager:SetParticleControl(particle_trail_fx, 0, self:GetParent():GetAbsOrigin())
	--ParticleManager:SetParticleControlEnt(particle_trail_fx, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle_trail_fx, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(particle_trail_fx, 8, Vector(1,0,0))
	self:AddParticle(particle_trail_fx, false, false, -1, false, false)

	self:StartIntervalThink(FrameTime())
end

function modifier_bounty_hunter_track_custom:OnRefresh()
	if not IsServer() then return end
	self.bonus_gold = self:GetAbility():GetSpecialValueFor("bonus_gold")
    self.bonus_gold_hero = self:GetAbility():GetSpecialValueFor("bonus_gold_hero")
end

function modifier_bounty_hunter_track_custom:OnIntervalThink()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_bounty_hunter_3") then
		AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetAbility().modifier_bounty_hunter_3[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_3")], FrameTime(), false)
		return
	end
	AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 50, FrameTime(), false)
end

function modifier_bounty_hunter_track_custom:DeclareFunctions()
	return 
	{
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end

function modifier_bounty_hunter_track_custom:GetAuraDuration()
	return 0.1
end

function modifier_bounty_hunter_track_custom:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_bounty_hunter_track_custom:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_bounty_hunter_track_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_bounty_hunter_track_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_bounty_hunter_track_custom:GetModifierAura()
	return "modifier_bounty_hunter_track_custom_buff"
end

function modifier_bounty_hunter_track_custom:GetAuraEntityReject(target)
	if target ~= self:GetCaster() then return true end
	return false
end

function modifier_bounty_hunter_track_custom:IsAura()
	return true
end

function modifier_bounty_hunter_track_custom:IsDebuff()
	return true
end

function modifier_bounty_hunter_track_custom:OnDeath(keys)
	if not IsServer() then return end
	if keys.unit ~= self:GetParent() then return end
	local reincarnate = keys.reincarnate
	if reincarnate then
		self:Destroy()
		return nil
	end
    local allies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
    for _, ally in pairs(allies) do
        if self:GetParent():IsRealHero() and ally:IsRealHero() and not ally:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then
            local gold = self.bonus_gold
            if self:GetParent() == self:GetCaster() then
                gold = self.bonus_gold_hero
            end
            if self:GetCaster():HasModifier("modifier_bounty_hunter_16") then
                gold = gold + self:GetAbility().modifier_bounty_hunter_16_gold[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_16")]
            end
            ally:ModifyGold(gold, true, DOTA_ModifyGold_Unspecified)
            SendOverheadEventMessage(ally, OVERHEAD_ALERT_GOLD, ally, gold, nil)
        end
    end
	self:Destroy()
end

function modifier_bounty_hunter_track_custom:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_bounty_hunter_track_custom:GetModifierIncomingDamage_Percentage(params)
    if params.attacker:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        local bonus = 0
        if self:GetCaster():HasModifier("modifier_bounty_hunter_16") then
            bonus = self:GetAbility().modifier_bounty_hunter_16_damage[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_16")]
        end
        return self:GetAbility():GetSpecialValueFor("target_damage_amp") + bonus
    end
end

function modifier_bounty_hunter_track_custom:GetModifierHPRegenAmplify_Percentage()
	if self:GetCaster():HasModifier("modifier_bounty_hunter_6") then
		return self:GetAbility().modifier_bounty_hunter_6[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_6")]
	end
	return 0
end

modifier_bounty_hunter_track_custom_buff = class({})

function modifier_bounty_hunter_track_custom_buff:OnCreated()
	self.bonus_move_speed_pct = self:GetAbility():GetSpecialValueFor("bonus_move_speed_pct")

	if not IsServer() then return end

	local particle_haste_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_haste.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle_haste_fx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_haste_fx, 1, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_haste_fx, 2, self:GetParent():GetAbsOrigin())

	self:AddParticle(particle_haste_fx, false, false, -1, false, false)
end

function modifier_bounty_hunter_track_custom_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
	}
end

function modifier_bounty_hunter_track_custom_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_move_speed_pct
end

function modifier_bounty_hunter_track_custom_buff:GetModifierHealthRegenPercentage()
	if self:GetCaster():HasModifier("modifier_bounty_hunter_6") then
		return self:GetAbility().modifier_bounty_hunter_6_regen[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_6")]
	end
end

modifier_bounty_hunter_track_custom_passive = class({})

function modifier_bounty_hunter_track_custom_passive:IsPurgable() return false end
function modifier_bounty_hunter_track_custom_passive:IsHidden() return true end
function modifier_bounty_hunter_track_custom_passive:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_bounty_hunter_track_custom_passive:GetModifierTotalDamageOutgoing_Percentage(params)
	if params.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then 
		if self:GetParent():HasModifier("modifier_bounty_hunter_21") then
			if params.target:HasModifier("modifier_bounty_hunter_track_custom") then
				SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, params.target, params.original_damage + (params.original_damage / 100 * (self:GetAbility().modifier_bounty_hunter_21 - 100)), nil)
				return self:GetAbility().modifier_bounty_hunter_21 - 100
			end
		end
	end
end