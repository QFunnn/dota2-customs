--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_winter_wyvern_winters_curse_custom", "heroes/npc_dota_hero_winter_wyvern_custom/winter_wyvern_winters_curse_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_winter_wyvern_winters_curse_custom_aggro", "heroes/npc_dota_hero_winter_wyvern_custom/winter_wyvern_winters_curse_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_winter_wyvern_winters_curse_custom_attack_speed", "heroes/npc_dota_hero_winter_wyvern_custom/winter_wyvern_winters_curse_custom", LUA_MODIFIER_MOTION_NONE)

winter_wyvern_winters_curse_custom = class({})
winter_wyvern_winters_curse_custom.modifier_winter_wyvern_3 = {0,65}
winter_wyvern_winters_curse_custom.modifier_winter_wyvern_4 = {-20,-40}
winter_wyvern_winters_curse_custom.modifier_winter_wyvern_7 = 0.5

function winter_wyvern_winters_curse_custom:CastFilterResultTarget( hTarget )
    if hTarget:GetTeamNumber() == self:GetCaster():GetTeamNumber() and not self:GetCaster():HasModifier("modifier_winter_wyvern_7") then
        return UF_FAIL_FRIENDLY
    end
    if not IsServer() then return UF_SUCCESS end
    local nResult = UnitFilter(
        hTarget,
        self:GetAbilityTargetTeam(),
        self:GetAbilityTargetType(),
        self:GetAbilityTargetFlags(),
        self:GetCaster():GetTeamNumber()
    )
    if nResult ~= UF_SUCCESS then
        return nResult
    end
    return UF_SUCCESS
end

function winter_wyvern_winters_curse_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_winter_wyvern_4") then
        bonus = self.modifier_winter_wyvern_4[self:GetCaster():GetTalentLevel("modifier_winter_wyvern_4")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function winter_wyvern_winters_curse_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function winter_wyvern_winters_curse_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/wyvern_winters_curse.vpcf", context)
    PrecacheResource("particle", "particles/status_fx/status_effect_wyvern_curse_buff.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/wyvern_winters_curse_overhead.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/wyvern_winters_curse_ground.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/wyvern_winters_curse_start.vpcf", context)
end

function winter_wyvern_winters_curse_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
    if target:TriggerSpellAbsorb(self) then return end
	self:GetCaster():EmitSound("Hero_Winter_Wyvern.WintersCurse.Cast")
	target:EmitSound("Hero_Winter_Wyvern.WintersCurse.Target")
    if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        target:Purge(true, false, false, false, false)
    end
    local duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_winter_wyvern_7") then
        duration = duration + self.modifier_winter_wyvern_7
    end
    local radius = self:GetSpecialValueFor("radius")
    local max_duration = self:GetSpecialValueFor("max_duration")
    local bonus_duration_per_hero = self:GetSpecialValueFor("bonus_duration_per_hero")
    local bonus_duration_per_creep = self:GetSpecialValueFor("bonus_duration_per_creep")
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false )
    for _, unit in pairs(units) do
        if unit ~= target then
            if unit:IsRealHero() then
                duration = math.min(duration + bonus_duration_per_hero, max_duration)
            else
                duration = math.min(duration + bonus_duration_per_creep, max_duration)
            end
        end
    end
    target:AddNewModifier(self:GetCaster(), self, "modifier_winter_wyvern_winters_curse_custom", {duration = duration * (1-target:GetStatusResistance())})
end

modifier_winter_wyvern_winters_curse_custom = class({})
function modifier_winter_wyvern_winters_curse_custom:IsPurgable() return false end
function modifier_winter_wyvern_winters_curse_custom:IsPurgeException() return false end

function modifier_winter_wyvern_winters_curse_custom:IsAura()
    return true
end

function modifier_winter_wyvern_winters_curse_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_winter_wyvern_winters_curse_custom:GetAuraEntityReject(target)
    if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() or self:GetParent() == target then
        return true
    end
    return false
end

function modifier_winter_wyvern_winters_curse_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_winter_wyvern_winters_curse_custom:GetAuraDuration()
    return 0
end

function modifier_winter_wyvern_winters_curse_custom:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_winter_wyvern_winters_curse_custom:GetModifierAura()
    return "modifier_winter_wyvern_winters_curse_custom_aggro"
end

function modifier_winter_wyvern_winters_curse_custom:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_winter_wyvern_winters_curse_custom:CheckState()
    if self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        return
        {
            [MODIFIER_STATE_ROOTED] = true,
        }
    end
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_FROZEN] = true,
        [MODIFIER_STATE_ATTACK_ALLIES] = true,
    }
end

function modifier_winter_wyvern_winters_curse_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_AVOID_DAMAGE,
        MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT,
        MODIFIER_PROPERTY_DISABLE_HEALING,
        MODIFIER_EVENT_ON_ATTACK_START,
		 
    }
end

function modifier_winter_wyvern_winters_curse_custom:OnAttackStart(params)
    if not IsServer() then return end
    if params.target ~= self:GetParent() then return end
    if params.attacker:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then return end
    if not self:GetCaster():HasModifier("modifier_winter_wyvern_3") then return end
    params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_winter_wyvern_winters_curse_custom_attack_speed", {duration = 4})
end

function modifier_winter_wyvern_winters_curse_custom:OnAttackLanded(params)
    if not IsServer() then return end
    if params.target ~= self:GetParent() then return end
    if params.attacker:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then return end
    if not self:GetCaster():HasModifier("modifier_winter_wyvern_3") then return end
    params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_winter_wyvern_winters_curse_custom_attack_speed", {duration = 4})
end

function modifier_winter_wyvern_winters_curse_custom:GetDisableHealing()
    if self:GetCaster():HasModifier("modifier_winter_wyvern_7") and self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        return 1
    end
end

function modifier_winter_wyvern_winters_curse_custom:GetModifierAvoidDamage(params)
    if params.attacker then
        local is_wyvern = (params.attacker:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID()) or (params.attacker:HasModifier("modifier_winter_wyvern_winters_curse_custom_aggro"))
        if is_wyvern then
            return 0
        end
    end
    return 1
end

function modifier_winter_wyvern_winters_curse_custom:OnTakeDamageKillCredit(params)
    if params.target == self:GetParent() then
        if params.damage >= self:GetParent():GetHealth() then
            self:GetParent():Kill(nil, self:GetCaster())
        end
    end
end

function modifier_winter_wyvern_winters_curse_custom:GetStatusEffectName()
    return "particles/status_fx/status_effect_wyvern_curse_buff.vpcf"
end

function modifier_winter_wyvern_winters_curse_custom:OnCreated()
    if not IsServer() then return end
    local radius = self:GetAbility():GetSpecialValueFor("radius")

    local overhead_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_winter_wyvern/wyvern_winters_curse_overhead.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    self:AddParticle(overhead_fx, false, false, -1, false, false)

    local ground_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_winter_wyvern/wyvern_winters_curse_ground.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(ground_fx, 2, Vector(radius,radius,radius))
    self:AddParticle(ground_fx, false, false, -1, false, false)

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_winter_wyvern/wyvern_winters_curse.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
    
    local start_fx = ParticleManager:CreateParticle( "particles/units/heroes/hero_winter_wyvern/wyvern_winters_curse_start.vpcf", PATTACH_POINT_FOLLOW, self:GetParent() )
    ParticleManager:ReleaseParticleIndex(start_fx)
end

modifier_winter_wyvern_winters_curse_custom_aggro = class({})

function modifier_winter_wyvern_winters_curse_custom_aggro:OnCreated( kv )
    if not IsServer() then return end
    self:GetParent():SetForceAttackTarget( self:GetAuraOwner() )
    self:GetParent():MoveToTargetToAttack( self:GetAuraOwner() )
    self:StartIntervalThink(FrameTime())
end

function modifier_winter_wyvern_winters_curse_custom_aggro:OnIntervalThink( kv )
    if not IsServer() then return end
    if self:GetAuraOwner() == nil then return end
    if self:GetAuraOwner():IsNull() then return end
    if not self:GetAuraOwner():IsAlive() then
        self:Destroy()
    else
        self:GetParent():SetForceAttackTarget( self:GetAuraOwner() )
        self:GetParent():MoveToTargetToAttack( self:GetAuraOwner() )
    end
end

function modifier_winter_wyvern_winters_curse_custom_aggro:OnRemoved()
    if not IsServer() then return end
    self:GetParent():SetForceAttackTarget( nil )
end

function modifier_winter_wyvern_winters_curse_custom_aggro:CheckState()
    return
    {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_TAUNTED] = true,
        [MODIFIER_STATE_ATTACK_ALLIES] = true,
    }
end

function modifier_winter_wyvern_winters_curse_custom_aggro:GetStatusEffectName()
    return "particles/status_fx/status_effect_wyvern_curse_target.vpcf"
end

function modifier_winter_wyvern_winters_curse_custom_aggro:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_AVOID_DAMAGE,
    }
end

function modifier_winter_wyvern_winters_curse_custom_aggro:GetModifierAttackSpeedBonus_Constant()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_winter_wyvern_3") then
        bonus = self:GetAbility().modifier_winter_wyvern_3[self:GetCaster():GetTalentLevel("modifier_winter_wyvern_3")]
    end
    return self:GetAbility():GetSpecialValueFor("bonus_attack_speed") + bonus
end

function modifier_winter_wyvern_winters_curse_custom_aggro:GetModifierAvoidDamage(params)
    if params.attacker then
        local is_wyvern = (params.attacker:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID())
        if is_wyvern then
            return 0
        end
    end
    return 1
end

modifier_winter_wyvern_winters_curse_custom_attack_speed = class({})

function modifier_winter_wyvern_winters_curse_custom_attack_speed:GetTexture() return "winter_wyvern_3" end

function modifier_winter_wyvern_winters_curse_custom_attack_speed:GetStatusEffectName()
    return "particles/status_fx/status_effect_wyvern_curse_buff.vpcf"
end

function modifier_winter_wyvern_winters_curse_custom_attack_speed:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_EVENT_ON_ATTACK_START,
    }
end

function modifier_winter_wyvern_winters_curse_custom_attack_speed:OnAttackStart(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target and not params.target:HasModifier("modifier_winter_wyvern_winters_curse_custom") then
		self:Destroy()
	end
end

function modifier_winter_wyvern_winters_curse_custom_attack_speed:GetModifierAttackSpeedBonus_Constant()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_winter_wyvern_3") then
        bonus = self:GetAbility().modifier_winter_wyvern_3[self:GetCaster():GetTalentLevel("modifier_winter_wyvern_3")]
    end
    return self:GetAbility():GetSpecialValueFor("bonus_attack_speed") + bonus
end