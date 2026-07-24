--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_treant_seed", "abilities/npc_treant_seed", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_treant_seed_cd", "abilities/npc_treant_seed", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_treant_seed_slow", "abilities/npc_treant_seed", LUA_MODIFIER_MOTION_NONE)

npc_treant_seed = class({})

function npc_treant_seed:OnSpellStart()

    if not IsServer() then
        return
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_treant_seed_cd", {duration = self:GetCooldownTimeRemaining()})

    if self:GetCursorTarget():TriggerSpellAbsorb( self ) then return end   

    self:GetCursorTarget():EmitSound("Hero_Treant.LeechSeed.Target")
    local seed_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_leech_seed.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
  ParticleManager:SetParticleControl(seed_particle, 1, self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_attack1")))
  ParticleManager:SetParticleControlEnt(seed_particle, 0, self:GetCursorTarget(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCursorTarget():GetAbsOrigin(), true)
  ParticleManager:ReleaseParticleIndex(seed_particle)

    self:GetCursorTarget():AddNewModifier(self:GetCaster(), self, "modifier_treant_seed", {duration = self:GetSpecialValueFor("duration")*(1 - self:GetCursorTarget():GetStatusResistance())})

end



modifier_treant_seed = class({})

function modifier_treant_seed:IsPurgable() return true end

function modifier_treant_seed:IsHidden() return false end


function modifier_treant_seed:OnCreated(table)
self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("interval"))
self:OnIntervalThink()
end


function modifier_treant_seed:OnIntervalThink()
if not IsServer() then return end
  self.damage_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_leech_seed_damage_pulse.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(self.damage_particle)

    self:GetParent():EmitSound("Hero_Treant.LeechSeed.Tick")
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_treant_seed_slow", {duration = self:GetAbility():GetSpecialValueFor("slow_duration")})
    self:GetParent():Purge(true, false, false, false, false)
end

modifier_treant_seed_slow = class({})

function modifier_treant_seed_slow:IsHidden() return false end
function modifier_treant_seed_slow:IsPurgable() return true end

function modifier_treant_seed_slow:DeclareFunctions() return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_treant_seed_slow:GetModifierMoveSpeedBonus_Percentage() return -self:GetAbility():GetSpecialValueFor("slow") end



modifier_treant_seed_cd = class({})

function modifier_treant_seed_cd:IsHidden() return false end
function modifier_treant_seed_cd:IsPurgable() return false end