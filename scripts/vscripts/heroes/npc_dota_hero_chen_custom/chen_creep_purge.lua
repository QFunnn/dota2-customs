--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_chen_creep_purge", "heroes/npc_dota_hero_chen_custom/chen_creep_purge", LUA_MODIFIER_MOTION_NONE )

chen_creep_purge = class({})

function chen_creep_purge:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    if target:TriggerSpellAbsorb(self) then return end
    if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        target:Purge(false, true, false, true, true)
    else
        target:AddNewModifier(self:GetCaster(), self, "modifier_chen_creep_purge", {duration = self:GetSpecialValueFor("duration")})
        target:Purge(true, false, false, false, false)
        ApplyDamage({attacker = self:GetCaster(), victim = target, ability = self, damage = self:GetSpecialValueFor("damage"), damage_type = self:GetAbilityDamageType()})
    end
    local effect = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_purge.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:ReleaseParticleIndex( effect )
    target:EmitSound("n_creep_SatyrTrickster.Cast")
end

modifier_chen_creep_purge = class({})

function modifier_chen_creep_purge:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_chen_creep_purge:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("slow")
end