--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_bounty_hunter_wind_walk_custom", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_wind_walk_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bounty_hunter_wind_walk_custom_passive", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_wind_walk_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bounty_hunter_wind_walk_custom_passive_cooldown", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_wind_walk_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bounty_hunter_wind_walk_custom_passive_active", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_wind_walk_custom", LUA_MODIFIER_MOTION_NONE )

bounty_hunter_wind_walk_custom = class({})

function bounty_hunter_wind_walk_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_bounty_hunter/bounty_hunter_windwalk.vpcf', context )
    PrecacheResource( "particle", 'particles/generic_hero_status/status_invisibility_start.vpcf', context )
    PrecacheResource( "particle", 'particles/generic_gameplay/generic_silence.vpcf', context )
end

bounty_hunter_wind_walk_custom.modifier_bounty_hunter_8 = {4,8}
bounty_hunter_wind_walk_custom.modifier_bounty_hunter_9 = {1,2}
bounty_hunter_wind_walk_custom.modifier_bounty_hunter_10 = {0.2,0.4}
bounty_hunter_wind_walk_custom.modifier_bounty_hunter_11 = {-2,-4,-6}
bounty_hunter_wind_walk_custom.modifier_bounty_hunter_12 = {5,10,15}
bounty_hunter_wind_walk_custom.modifier_bounty_hunter_14_duration = 3
bounty_hunter_wind_walk_custom.modifier_bounty_hunter_14_restore = 20

function bounty_hunter_wind_walk_custom:GetIntrinsicModifierName()
	return "modifier_bounty_hunter_wind_walk_custom_passive"
end

function bounty_hunter_wind_walk_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_bounty_hunter_11") then
        bonus = self.modifier_bounty_hunter_11[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_11")]
    end
    return self.BaseClass.GetCooldown( self, iLevel ) + bonus
end

function bounty_hunter_wind_walk_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_bounty_hunter_13") then
        return 0
    end
    return self.BaseClass.GetManaCost( self, iLevel )
end

modifier_bounty_hunter_wind_walk_custom_passive = class({})

function modifier_bounty_hunter_wind_walk_custom_passive:IsHidden() return true end
function modifier_bounty_hunter_wind_walk_custom_passive:IsPurgable() return false end

function modifier_bounty_hunter_wind_walk_custom_passive:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_bounty_hunter_wind_walk_custom_passive:GetMinHealth()
    if self:GetParent():IsIllusion() then return end
    if not self:GetParent():HasModifier("modifier_bounty_hunter_14") then return end
    if self:GetParent():HasModifier("modifier_bounty_hunter_wind_walk_custom_passive_cooldown") then return end
    return 1
end

function modifier_bounty_hunter_wind_walk_custom_passive:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if not self:GetParent():IsAlive() then return end
    if self:GetParent():GetHealth() > 1 then return end
	if not self:GetParent():HasModifier("modifier_bounty_hunter_14") then return end
    if self:GetParent():HasModifier("modifier_bounty_hunter_wind_walk_custom_passive_cooldown") then return end
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_bounty_hunter_wind_walk_custom_passive_active", {duration = self:GetAbility().modifier_bounty_hunter_14_duration})
	self:GetAbility():OnSpellStart()
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_bounty_hunter_wind_walk_custom_passive_cooldown", {duration = 120})
end

function bounty_hunter_wind_walk_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local ability = self
	local duration = self:GetSpecialValueFor("duration")
	local fade_time = self:GetSpecialValueFor("fade_time")
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bounty_hunter/bounty_hunter_windwalk.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
	if self:GetCaster():HasModifier("modifier_bounty_hunter_13") then
		self:GetCaster():Purge(false, true, false, true, true)
	end
	Timers:CreateTimer(fade_time, function()
		local particle_2 = ParticleManager:CreateParticle("particles/generic_hero_status/status_invisibility_start.vpcf", PATTACH_ABSORIGIN, caster)
		ParticleManager:SetParticleControl(particle_2, 0, caster:GetAbsOrigin())
		caster:AddNewModifier(caster, ability, "modifier_bounty_hunter_wind_walk_custom", {duration = duration})
	end)
	self:GetCaster():EmitSound("Hero_BountyHunter.WindWalk")
end

modifier_bounty_hunter_wind_walk_custom = class({})

function modifier_bounty_hunter_wind_walk_custom:IsPurgable() return false end

function modifier_bounty_hunter_wind_walk_custom:OnCreated()
    self.bonus_move_speed_pct = self:GetAbility():GetSpecialValueFor("bonus_move_speed_pct")
	if not IsServer() then return end
	if self:GetParent():GetAggroTarget() ~= nil then
		self:GetParent():MoveToTargetToAttack(self:GetParent():GetAggroTarget())
	end
end

function modifier_bounty_hunter_wind_walk_custom:OnRefresh()
	if not IsServer() then return end
	self:OnCreated()
end

function modifier_bounty_hunter_wind_walk_custom:DeclareFunctions()
	local decFuncs = 
	{
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		 
        MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return decFuncs
end

function modifier_bounty_hunter_wind_walk_custom:CheckState()
	local state = 
	{
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true
	}
	return state
end

function modifier_bounty_hunter_wind_walk_custom:GetModifierInvisibilityLevel()
	return 1
end

function modifier_bounty_hunter_wind_walk_custom:GetModifierIncomingDamage_Percentage()
	return self:GetAbility():GetSpecialValueFor("incoming_damage")
end

function modifier_bounty_hunter_wind_walk_custom:GetModifierMoveSpeedBonus_Percentage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_bounty_hunter_8") then
		bonus = self:GetAbility().modifier_bounty_hunter_8[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_8")]
	end
	return self.bonus_move_speed_pct + bonus
end

function modifier_bounty_hunter_wind_walk_custom:GetModifierTotal_ConstantBlock(params)
	if self:GetCaster():HasModifier("modifier_bounty_hunter_12") then
		local bonus = self:GetAbility().modifier_bounty_hunter_12[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_12")]
        if params.damage > 0 and RollPercentage(bonus) then
            SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, self:GetParent(), params.damage, nil)
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
            ParticleManager:ReleaseParticleIndex(particle)
            return params.damage
        end
	end
end

function modifier_bounty_hunter_wind_walk_custom:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.no_attack_cooldown then return end
	
	local stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
	if self:GetCaster():HasModifier("modifier_bounty_hunter_10") then
		stun_duration = stun_duration + self:GetAbility().modifier_bounty_hunter_10[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_10")]
	end
    
    local ability = self:GetAbility()
    if self:GetCaster():HasModifier("modifier_bounty_hunter_11") then
        ability = self:GetCaster():FindAbilityByName("bounty_hunter_wind_walk_custom_immune")
        if not ability then
            ability = self:GetCaster():AddAbility("bounty_hunter_wind_walk_custom_immune")
            ability:SetLevel(1)
        end
    end
	
	params.target:AddNewModifier(self:GetCaster(), ability, "modifier_stunned", {duration = stun_duration * (1 - params.target:GetStatusResistance())})

	if self:GetStackCount() > 0 then
		self:DecrementStackCount()
	end

	if self:GetStackCount() <= 0 then
		self:Destroy()
	end

    if self:GetCaster():HasModifier("modifier_bounty_hunter_9") then
        for i=1, self:GetAbility().modifier_bounty_hunter_9[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_9")] do
            self:GetCaster():PerformAttack(params.target, true, true, true, true, false, false, false)
        end
    end
end

modifier_bounty_hunter_wind_walk_custom_passive_cooldown = class({})
function modifier_bounty_hunter_wind_walk_custom_passive_cooldown:IsHidden() return false end
function modifier_bounty_hunter_wind_walk_custom_passive_cooldown:IsPurgable() return false end
function modifier_bounty_hunter_wind_walk_custom_passive_cooldown:IsDebuff() return true end
function modifier_bounty_hunter_wind_walk_custom_passive_cooldown:RemoveOnDeath() return false end


modifier_bounty_hunter_wind_walk_custom_passive_active = class({})
function modifier_bounty_hunter_wind_walk_custom_passive_active:IsHidden() return false end
function modifier_bounty_hunter_wind_walk_custom_passive_active:IsPurgable() return false end
function modifier_bounty_hunter_wind_walk_custom_passive_active:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
	}
end
function modifier_bounty_hunter_wind_walk_custom_passive_active:GetMinHealth()
	return 1
end
function modifier_bounty_hunter_wind_walk_custom_passive_active:GetModifierInvisibilityLevel()
	return 1
end
function modifier_bounty_hunter_wind_walk_custom_passive_active:CheckState()
	return 
    {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end
function modifier_bounty_hunter_wind_walk_custom_passive_active:OnDestroy()
	if not IsServer() then return end
	self:GetParent():Purge(false, true, false, true, true)
	self:GetParent():Heal(self:GetParent():GetMaxHealth() * (self:GetAbility().modifier_bounty_hunter_14_restore / 100), nil)
	self:GetParent():GiveMana(self:GetParent():GetMaxMana() * (self:GetAbility().modifier_bounty_hunter_14_restore / 100))
end

bounty_hunter_wind_walk_custom_immune = class({})