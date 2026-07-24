--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_oracle_fortunes_end_custom_purge", "heroes/npc_dota_hero_oracle_custom/oracle_fortunes_end_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_oracle_fortunes_end_custom_thinker", "heroes/npc_dota_hero_oracle_custom/oracle_fortunes_end_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_oracle_fortunes_end_custom_attack_speed_target", "heroes/npc_dota_hero_oracle_custom/oracle_fortunes_end_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_oracle_fortunes_end_custom_attack_speed_buff", "heroes/npc_dota_hero_oracle_custom/oracle_fortunes_end_custom", LUA_MODIFIER_MOTION_NONE)

oracle_fortunes_end_custom = class({})

function oracle_fortunes_end_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_fortune_channel.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_fortune_cast_tgt.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_fortune_prj.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_fortune_aoe.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_fortune_dmg.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_fortune_purge.vpcf", context )
    PrecacheResource( "particle", "particles/oracle_debuff_blue.vpcf", context )
end

oracle_fortunes_end_custom.modifier_oracle_8_duration = 8
oracle_fortunes_end_custom.modifier_oracle_8 = {35,70,105}
oracle_fortunes_end_custom.modifier_oracle_9 = {100,200}
oracle_fortunes_end_custom.modifier_oracle_11 = {150,200,250}

function oracle_fortunes_end_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_oracle_11") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

function oracle_fortunes_end_custom:GetAOERadius()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_oracle_9") then
		bonus = self.modifier_oracle_9[self:GetCaster():GetTalentLevel("modifier_oracle_9")]
	end
	return self:GetSpecialValueFor("radius")
end

function oracle_fortunes_end_custom:GetChannelTime()
	if self:GetCaster():HasModifier("modifier_oracle_10") then
        return 0
    end
	return self:GetSpecialValueFor("channel_time")
end

function oracle_fortunes_end_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_oracle_10") then
    	if self:GetCaster():HasModifier("modifier_oracle_9") then
        	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL
        else
        	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL
        end
    end
    if self:GetCaster():HasModifier("modifier_oracle_9") then
    	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_CHANNELLED + DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL
    else
    	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_CHANNELLED + DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL
    end
end

function oracle_fortunes_end_custom:OnSpellStart()
	if not IsServer() then return end
	self.target = self:GetCursorTarget()

	if self.target == nil then
		self.target = CreateUnitByName("npc_dota_companion", self:GetCursorPosition(), false, nil, nil, self:GetCaster():GetTeamNumber())
        self.target:AddNewModifier(self, nil, "modifier_oracle_fortunes_end_custom_thinker", {})
	end

	self:GetCaster():EmitSound("Hero_Oracle.FortunesEnd.Channel")

	if self.fortunes_particle then
		ParticleManager:DestroyParticle(self.fortunes_particle, false)
		ParticleManager:ReleaseParticleIndex(self.fortunes_particle)
	end
	
	self.fortunes_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_fortune_channel.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(self.fortunes_particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
	
	self.target_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_fortune_cast_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCursorTarget())
	ParticleManager:ReleaseParticleIndex(self.target_particle)

	if self:GetCaster():HasModifier("modifier_oracle_10") then
		self:OnChannelFinish(false)
	end
end

function oracle_fortunes_end_custom:OnChannelFinish(bInterrupted)
	self:GetCaster():StopSound("Hero_Oracle.FortunesEnd.Channel")
	self:GetCaster():EmitSound("Hero_Oracle.FortunesEnd.Attack")
	
	if self.fortunes_particle then
		ParticleManager:DestroyParticle(self.fortunes_particle, false)
		ParticleManager:ReleaseParticleIndex(self.fortunes_particle)
	end

	ProjectileManager:CreateTrackingProjectile(	
	{
		Target 				= self.target,
		Source 				= self:GetCaster(),
		Ability 			= self,
		EffectName 			= "particles/units/heroes/hero_oracle/oracle_fortune_prj.vpcf",
		iMoveSpeed			= self:GetSpecialValueFor("bolt_speed"),
		vSourceLoc 			= self:GetCaster():GetAbsOrigin(),
		bDrawsOnMinimap 	= false,
		bDodgeable 			= false,
		bIsAttack 			= false,
		bVisibleToEnemies 	= true,
		bReplaceExisting 	= false,
		flExpireTime 		= GameRules:GetGameTime() + 10.0,
		bProvidesVision 	= false,
		iSourceAttachment	= DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
		ExtraData = 
		{
			charge_pct			= ((GameRules:GetGameTime() - self:GetChannelStartTime()) / self:GetChannelTime()),
		}
	})
end

function oracle_fortunes_end_custom:OnProjectileHit_ExtraData(target, location, data)

	if target == nil then return end

	if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		if target:TriggerSpellAbsorb(self) then return end
	end

	if data.charge_pct ~= nil then
		self:ApplyFortunesEnd(target, data.charge_pct)
	end

	if target and target:GetUnitName() == "npc_dota_companion" then
		target:Destroy()
	end
end

function oracle_fortunes_end_custom:ApplyFortunesEnd(target, charge_pct)
	if self:GetCaster():HasModifier("modifier_oracle_10") then
		charge_pct = 1
	end
	local radius = self:GetSpecialValueFor("radius")
	EmitSoundOnLocationWithCaster(target:GetAbsOrigin(), "Hero_Oracle.FortunesEnd.Target", self:GetCaster())
	self.aoe_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_fortune_aoe.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(self.aoe_particle, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.aoe_particle, 2, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(self.aoe_particle)

	if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
		target:Purge(false, true, false, false, false)
	end

	local damage = self:GetSpecialValueFor("damage")

	local damage_type = DAMAGE_TYPE_MAGICAL
	if self:GetCaster():HasModifier("modifier_oracle_11") then
		damage_type = DAMAGE_TYPE_PHYSICAL
		damage = damage + (self:GetCaster():GetAgility() / 100 * self.modifier_oracle_11[self:GetCaster():GetTalentLevel("modifier_oracle_11")])
	end

	for _, enemy in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)) do
		self.damage_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_fortune_dmg.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
		ParticleManager:SetParticleControl(self.damage_particle, 1, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(self.damage_particle, 3, enemy:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(self.damage_particle)
        if not enemy:IsDebuffImmune() then
		    enemy:Purge(true, false, false, false, false)
        end
		enemy:AddNewModifier(self:GetCaster(), self, "modifier_oracle_fortunes_end_custom_purge", {duration = (math.max(self:GetSpecialValueFor("maximum_purge_duration") * math.min(charge_pct, 1), self:GetSpecialValueFor("minimum_purge_duration")) * (1 - enemy:GetStatusResistance()))})
		ApplyDamage({ victim = enemy, damage = damage, damage_type = damage_type, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self })
		if self:GetCaster():HasModifier("modifier_oracle_8") then
			enemy:AddNewModifier(self:GetCaster(), self, "modifier_oracle_fortunes_end_custom_attack_speed_target", {duration = self.modifier_oracle_8_duration})
		end
	end
end

modifier_oracle_fortunes_end_custom_purge = class({})

function modifier_oracle_fortunes_end_custom_purge:GetEffectName()
	return "particles/units/heroes/hero_oracle/oracle_fortune_purge.vpcf"
end

function modifier_oracle_fortunes_end_custom_purge:OnCreated( kv )
    if IsServer() then
        self:StartIntervalThink(FrameTime())
    end
end

function modifier_oracle_fortunes_end_custom_purge:OnIntervalThink( kv )
    if IsServer() then
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_truesight", {duration = FrameTime()+FrameTime()})
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 50, FrameTime()+FrameTime(), false)
    end
end

function modifier_oracle_fortunes_end_custom_purge:CheckState()
	return 
	{
		[MODIFIER_STATE_ROOTED]	= true,
	}
end

modifier_oracle_fortunes_end_custom_thinker = class({})

function modifier_oracle_fortunes_end_custom_thinker:IsHidden() return true end
function modifier_oracle_fortunes_end_custom_thinker:IsPurgable() return false end

function modifier_oracle_fortunes_end_custom_thinker:CheckState()
    return 
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
    }
end

modifier_oracle_fortunes_end_custom_attack_speed_target = class({})
function modifier_oracle_fortunes_end_custom_attack_speed_target:GetTexture() return "oracle_8" end
function modifier_oracle_fortunes_end_custom_attack_speed_target:IsPurgable() return false end
function modifier_oracle_fortunes_end_custom_attack_speed_target:IsPurgeException() return false end
function modifier_oracle_fortunes_end_custom_attack_speed_target:DeclareFunctions()
	return
	{
		MODIFIER_EVENT_ON_ATTACK_START,
		 
	}
end

function modifier_oracle_fortunes_end_custom_attack_speed_target:OnAttackStart(params)
    if not IsServer() then return end
    if params.target ~= self:GetParent() then return end
    if params.attacker:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then return end
    params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_oracle_fortunes_end_custom_attack_speed_buff", {duration = self:GetAbility().modifier_oracle_8_duration})
end

function modifier_oracle_fortunes_end_custom_attack_speed_target:OnAttackLanded(params)
    if not IsServer() then return end
    if params.target ~= self:GetParent() then return end
    if params.attacker:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then return end
    params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_oracle_fortunes_end_custom_attack_speed_buff", {duration = self:GetAbility().modifier_oracle_8_duration})
end

function modifier_oracle_fortunes_end_custom_attack_speed_target:GetEffectName()
	return "particles/oracle_debuff_blue.vpcf"
end

modifier_oracle_fortunes_end_custom_attack_speed_buff = class({})
function modifier_oracle_fortunes_end_custom_attack_speed_buff:IsHidden() return true end
function modifier_oracle_fortunes_end_custom_attack_speed_buff:IsPurgable() return false end

function modifier_oracle_fortunes_end_custom_attack_speed_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_EVENT_ON_ATTACK_START
    }
end

function modifier_oracle_fortunes_end_custom_attack_speed_buff:OnAttackStart(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target and not params.target:HasModifier("modifier_oracle_fortunes_end_custom_attack_speed_target") then
		self:Destroy()
	end
end

function modifier_oracle_fortunes_end_custom_attack_speed_buff:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility().modifier_oracle_8[self:GetCaster():GetTalentLevel("modifier_oracle_8")]
end