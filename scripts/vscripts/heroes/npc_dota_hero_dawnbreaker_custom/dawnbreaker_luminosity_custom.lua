--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



LinkLuaModifier( "modifier_dawnbreaker_luminosity_custom", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_luminosity_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dawnbreaker_luminosity_custom_buff", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_luminosity_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dawnbreaker_luminosity_custom_buff_animate", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_luminosity_custom", LUA_MODIFIER_MOTION_NONE )

dawnbreaker_luminosity_custom = class({})
dawnbreaker_luminosity_custom.modifier_dawnbreaker_5 = {15,30}
dawnbreaker_luminosity_custom.modifier_dawnbreaker_9 = {3,2}

function dawnbreaker_luminosity_custom:GetIntrinsicModifierName()
	return "modifier_dawnbreaker_luminosity_custom"
end

modifier_dawnbreaker_luminosity_custom = class({})

function modifier_dawnbreaker_luminosity_custom:IsHidden() return self:GetStackCount() < 1 or self:GetParent():HasModifier("modifier_dawnbreaker_luminosity_custom_buff") end
function modifier_dawnbreaker_luminosity_custom:IsPurgable() return false end
function modifier_dawnbreaker_luminosity_custom:IsPurgeException() return false end
function modifier_dawnbreaker_luminosity_custom:RemoveOnDeath() return false end

function modifier_dawnbreaker_luminosity_custom:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.count = self:GetAbility():GetSpecialValueFor( "attack_count" )
end

function modifier_dawnbreaker_luminosity_custom:OnRefresh( kv )
	self.count = self:GetAbility():GetSpecialValueFor( "attack_count" )
end

function modifier_dawnbreaker_luminosity_custom:DeclareFunctions()
	return
    {
        MODIFIER_EVENT_ON_ATTACK_FINISHED,
	}
end

function modifier_dawnbreaker_luminosity_custom:OnAttackLanded( params )
    if not IsServer() then return end
    if params.attacker ~= self.parent then return end
    if params.attacker:GetTeamNumber() == params.target:GetTeamNumber() then return end
	if self.parent:HasModifier( "modifier_dawnbreaker_fire_wreath_custom" ) then
        return 
    end
    if self.parent:HasModifier( "modifier_dawnbreaker_luminosity_custom_buff" ) then
        self:SetStackCount(0)
        return
    end
	self:Increment()
end

function modifier_dawnbreaker_luminosity_custom:OnAttackFinished( params )
    if params.attacker ~= self.parent then return end
    if params.target:GetTeamNumber() == self.parent:GetTeamNumber() then return end
	if self.parent:HasModifier( "modifier_dawnbreaker_fire_wreath_custom" ) then return end
	if self:GetParent():HasModifier("modifier_dawnbreaker_luminosity_custom_buff") then
        self:GetParent():AddNewModifier(self:GetParent(), self.ability, "modifier_dawnbreaker_luminosity_custom_buff_animate", {})
    end
end

function modifier_dawnbreaker_luminosity_custom:Increment()
    if not IsServer() then return end
	if self.parent:PassivesDisabled() then return end
    if self.parent:HasModifier("modifier_dawnbreaker_luminosity_custom_buff") then
        return
    end
	self:IncrementStackCount()
	if self:GetStackCount() >= self.count then
        local mod = self.parent:AddNewModifier( self.parent, self.ability, "modifier_dawnbreaker_luminosity_custom_buff", {} )
        if self:GetParent():HasModifier("modifier_dawnbreaker_9") then
            local dawnbreaker_solar_guardian_custom = self:GetParent():FindAbilityByName("dawnbreaker_solar_guardian_custom")
            if dawnbreaker_solar_guardian_custom and dawnbreaker_solar_guardian_custom:GetLevel() > 0 then
                local modifier_dawnbreaker_9_buff = self:GetParent():FindModifierByName("modifier_dawnbreaker_9_buff")
                if modifier_dawnbreaker_9_buff then
                    local talent_counter = math.min(modifier_dawnbreaker_9_buff:GetStackCount() + 1, self:GetAbility().modifier_dawnbreaker_9[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_9")])
                    modifier_dawnbreaker_9_buff:SetStackCount(talent_counter)
                end
            end
        end
    end
end

modifier_dawnbreaker_luminosity_custom_buff = class({})

function modifier_dawnbreaker_luminosity_custom_buff:IsHidden()
	return false
end

function modifier_dawnbreaker_luminosity_custom_buff:IsDebuff()
	return false
end

function modifier_dawnbreaker_luminosity_custom_buff:IsPurgable()
	return false
end

function modifier_dawnbreaker_luminosity_custom_buff:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.heal = self:GetAbility():GetSpecialValueFor( "heal_pct" )
	self.radius = self:GetAbility():GetSpecialValueFor( "heal_radius" )
	self.crit = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.allyheal = self:GetAbility():GetSpecialValueFor( "allied_healing_pct" )
	self.creepheal = self:GetAbility():GetSpecialValueFor( "heal_from_creeps" )
    self.count = self:GetAbility():GetSpecialValueFor( "attack_count" )
	if not IsServer() then return end
    self:SetStackCount(self.count)
	self.passive = false
	self.total_heal = 0
	self.allies = {}
	self:PlayEffects1()
end

function modifier_dawnbreaker_luminosity_custom_buff:OnDestroy()
	if not IsServer() then return end
    local modifier_dawnbreaker_luminosity_custom = self.parent:FindModifierByName("modifier_dawnbreaker_luminosity_custom")
    if modifier_dawnbreaker_luminosity_custom then
        modifier_dawnbreaker_luminosity_custom:SetStackCount(0)
    end
	if not self.passive then
		SendOverheadEventMessage( nil, OVERHEAD_ALERT_HEAL, self.parent, self.total_heal, self.parent:GetPlayerOwner() )
		local allyheal = self.total_heal * self.allyheal/100
		for ally,_ in pairs(self.allies) do
			SendOverheadEventMessage( nil, OVERHEAD_ALERT_HEAL, ally, allyheal, self.parent:GetPlayerOwner() )
		end
	end
	self.passive = false
	self.total_heal = 0
	self.allies = {}
end

function modifier_dawnbreaker_luminosity_custom_buff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}
end

function modifier_dawnbreaker_luminosity_custom_buff:GetModifierPreAttack_CriticalStrike(params)
    local bonus = 0
    if self:GetParent():HasModifier("modifier_dawnbreaker_5") then
        bonus = self:GetAbility().modifier_dawnbreaker_5[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_5")]
    end
    self.record = params.record
	return self.crit + bonus
end

function modifier_dawnbreaker_luminosity_custom_buff:OnTakeDamage(params)
	if not IsServer() then return end
    local pass = false
    if self.record and params.record == self.record then
        pass = true
        self.record = nil
    end
    if pass then
        if self.parent:PassivesDisabled() then
            self.passive = true
            if self.parent:HasModifier( "modifier_dawnbreaker_fire_wreath_custom" ) then return end
            self:Destroy()
            return
        end
        local heal = params.damage * self.heal / 100
        if params.unit:IsCreep() then
            heal = heal * self.creepheal/100
        end
        self.parent:HealWithParams(heal, self.ability, false, true, self.parent, false)
        self.total_heal = self.total_heal + heal
        local allies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
        heal = heal * self.allyheal / 100
        for _,ally in pairs(allies) do
            if ally ~= self.parent then
                ally:HealWithParams(heal, self.ability, false, true, self.parent, false)
                self.allies[ally] = true
                self:PlayEffects2( params.unit, ally )
            end
        end
        self:PlayEffects2( params.unit, self.parent )
        if self.parent:HasModifier( "modifier_dawnbreaker_fire_wreath_custom" ) then return end
	    self:Destroy()
    end
end

function modifier_dawnbreaker_luminosity_custom_buff:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self.parent then return end
    if params.attacker:GetTeamNumber() == params.target:GetTeamNumber() then return end
    local modifier_dawnbreaker_luminosity_custom_buff_animate = self:GetParent():FindModifierByName("modifier_dawnbreaker_luminosity_custom_buff_animate")
    if modifier_dawnbreaker_luminosity_custom_buff_animate then
        modifier_dawnbreaker_luminosity_custom_buff_animate:Destroy()
    end
	if self.parent:PassivesDisabled() then
		self.passive = true
		if self.parent:HasModifier( "modifier_dawnbreaker_fire_wreath_custom" ) then return end
		self:Destroy()
		return
	end
	params.target:EmitSound("Hero_Dawnbreaker.Luminosity.Strike")
    if self:GetParent():HasModifier("modifier_dawnbreaker_9") then
        local dawnbreaker_solar_guardian_custom = self:GetParent():FindAbilityByName("dawnbreaker_solar_guardian_custom")
        local modifier_dawnbreaker_9_buff = self:GetParent():FindModifierByName("modifier_dawnbreaker_9_buff")
        if dawnbreaker_solar_guardian_custom and dawnbreaker_solar_guardian_custom:GetLevel() > 0 then
            if modifier_dawnbreaker_9_buff and modifier_dawnbreaker_9_buff:GetStackCount() >= self:GetAbility().modifier_dawnbreaker_9[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_9")] then
                modifier_dawnbreaker_9_buff:SetStackCount(0)
                dawnbreaker_solar_guardian_custom:FastPulse(self:GetParent():GetAbsOrigin())
            end
        end
    end
end

function modifier_dawnbreaker_luminosity_custom_buff:PlayEffects1()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_luminosity_attack_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_weapon_core_fx", Vector(0,0,0), true)
	ParticleManager:SetParticleControlEnt( effect_cast, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_weapon_core_fx", Vector(0,0,0), true )
	self:AddParticle( effect_cast, false, false, -1, false, false )
	self.parent:EmitSound("Hero_Dawnbreaker.Luminosity.PowerUp")
end

function modifier_dawnbreaker_luminosity_custom_buff:PlayEffects2( target, ally )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_luminosity.vpcf", PATTACH_POINT_FOLLOW, ally )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, ally, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 1, target:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	ally:EmitSound("Hero_Dawnbreaker.Luminosity.Heal")
end

modifier_dawnbreaker_luminosity_custom_buff_animate = class({})
function modifier_dawnbreaker_luminosity_custom_buff_animate:IsHidden() return true end
function modifier_dawnbreaker_luminosity_custom_buff_animate:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
	}
end
function modifier_dawnbreaker_luminosity_custom_buff_animate:GetActivityTranslationModifiers()
    return "crit_buff"
end