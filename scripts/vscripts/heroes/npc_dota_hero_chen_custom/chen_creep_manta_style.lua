--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_chen_creep_manta_style_invulnerable", "heroes/npc_dota_hero_chen_custom/chen_creep_manta_style", LUA_MODIFIER_MOTION_NONE)

chen_creep_manta_style = class({})

function chen_creep_manta_style:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():EmitSound("DOTA_Item.Manta.Activate")
    self:GetCaster():Purge(false, true, false, false, false)
    if not self:GetCaster():IsRealHero() then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_chen_creep_manta_style_invulnerable", {duration = 0.1})
    ProjectileManager:ProjectileDodge(self:GetCaster())
end

modifier_chen_creep_manta_style_invulnerable = class({})
function modifier_chen_creep_manta_style_invulnerable:IsHidden()     return true end
function modifier_chen_creep_manta_style_invulnerable:IsPurgable()   return false end
function modifier_chen_creep_manta_style_invulnerable:GetEffectName()
    return "particles/items2_fx/manta_phase.vpcf"
end

function modifier_chen_creep_manta_style_invulnerable:OnDestroy()
    if not IsServer() then return end
    if not self:GetParent():IsAlive() then return end
    if not self:GetAbility() then return end
    if self:GetParent() == self:GetCaster() then
        self:GetParent():Stop()
    end

    local all_illusions = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED  , FIND_ANY_ORDER, false) 
    for _,i in ipairs(all_illusions) do
        if i.manta and i.manta == true then 
            i:ForceKill(false)
        end
    end

    local illusion_damage = self:GetAbility():GetSpecialValueFor("illusion_damage") - 100
    local illusion_incoming_damage = self:GetAbility():GetSpecialValueFor("illusion_incoming_damage") - 100
    local damage = self:GetAbility():GetSpecialValueFor("images_do_damage_percent_melee")

    local illusions = CreateIllusions(self:GetCaster(), self:GetCaster(), {
        outgoing_damage = illusion_damage,
        incoming_damage = illusion_incoming_damage,
        bounty_base     = self:GetCaster():GetLevel()*2, 
        bounty_growth   = nil,
        outgoing_damage_structure   = nil,
        outgoing_damage_roshan      = nil,
        duration        = self:GetAbility():GetSpecialValueFor("duration")
    }, 
    self:GetAbility():GetSpecialValueFor("illusion_count"), 108, true, true)

    for _, illusion in pairs(illusions) do
    	illusion.manta = true
    	illusion:RemoveGesture(ACT_DOTA_SPAWN)
    end
end

function modifier_chen_creep_manta_style_invulnerable:CheckState()
    return 
    {
        [MODIFIER_STATE_INVULNERABLE]       = true,
        [MODIFIER_STATE_NO_HEALTH_BAR]      = true,
        [MODIFIER_STATE_STUNNED]            = true,
        [MODIFIER_STATE_OUT_OF_GAME]        = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION]  = true
    }
end