--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_aghanim_bath_bubble_debuff", "heroes/npc_dota_hero_meepo_custom/aghanim_bath_bubble", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_aghanim_bath_bubble_buff", "heroes/npc_dota_hero_meepo_custom/aghanim_bath_bubble", LUA_MODIFIER_MOTION_NONE )

aghanim_bath_bubble = class({})

aghanim_bath_bubble.modifier_meepo_18 = {-33,-66,-99}

function aghanim_bath_bubble:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_winter_wyvern.vsndevts", context )
    PrecacheResource( "particle_folder", "particles/creatures/aghanim/", context )
    PrecacheResource( "particle", "particles/econ/taunts/snapfire/snapfire_taunt_bubble.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_meepo.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_meepo.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_meepo.vpcf", context)
end

function aghanim_bath_bubble:CastFilterResultTarget( hTarget )
    if hTarget and hTarget:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        if not self:GetCaster():HasModifier("modifier_meepo_18") then
            return UF_FAIL_FRIENDLY
        end
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

function aghanim_bath_bubble:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    local duration = self:GetSpecialValueFor("duration")

    if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        self:GetCaster():EmitSound("woda_aghanim_bubble_cast")
        target:AddNewModifier(self:GetCaster(), self, "modifier_aghanim_bath_bubble_buff", {duration = duration * (1-target:GetStatusResistance())})
        return
    end

    if target:TriggerSpellAbsorb(self) then return end
    self:GetCaster():EmitSound("woda_aghanim_bubble_cast")
    target:AddNewModifier(self:GetCaster(), self, "modifier_aghanim_bath_bubble_debuff", {duration = duration * (1-target:GetStatusResistance())})
end

modifier_aghanim_bath_bubble_debuff = class({})

function modifier_aghanim_bath_bubble_debuff:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/econ/taunts/snapfire/snapfire_taunt_bubble.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
    self:AddParticle(particle, false, false, -1, false, false)
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ice_slide", {})
    self.lop_damage = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_aghanim_bath_bubble_debuff:OnDestroy()
    if not IsServer() then return end
    ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = self.lop_damage, damage_type = DAMAGE_TYPE_MAGICAL})
    self:GetParent():RemoveModifierByName("modifier_ice_slide")
    self:GetParent():EmitSound("woda_aghanim_bubble_explosion")
end

function modifier_aghanim_bath_bubble_debuff:CheckState()
    return 
    {
        [MODIFIER_STATE_MUTED] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_FLYING] = true,
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
    }
end

function modifier_aghanim_bath_bubble_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
    }
end

function modifier_aghanim_bath_bubble_debuff:GetOverrideAnimation()
    return ACT_DOTA_FLAIL
end

modifier_aghanim_bath_bubble_buff = class({})

function modifier_aghanim_bath_bubble_buff:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/econ/taunts/snapfire/snapfire_taunt_bubble.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
    self:AddParticle(particle, false, false, -1, false, false)
    self:GetParent():AddNewModifier(self:GetCaster(), nil, "modifier_ice_slide", {})
    self.lop_damage = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_aghanim_bath_bubble_buff:OnDestroy()
    if not IsServer() then return end
    self:GetParent():Heal(self.lop_damage, self:GetAbility())
    self:GetParent():RemoveModifierByName("modifier_ice_slide")
    self:GetParent():EmitSound("woda_aghanim_bubble_explosion")
end

function modifier_aghanim_bath_bubble_buff:CheckState()
    return 
    {
        [MODIFIER_STATE_MUTED] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_FLYING] = true,
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
    }
end

function modifier_aghanim_bath_bubble_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
    }
end

function modifier_aghanim_bath_bubble_buff:GetModifierIncomingDamage_Percentage()
    return self:GetAbility().modifier_meepo_18[self:GetCaster():GetTalentLevel("modifier_meepo_18")]
end

function modifier_aghanim_bath_bubble_buff:GetOverrideAnimation()
    return ACT_DOTA_FLAIL
end