--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_satyr_slow", "abilities/npc_satyr_purge", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_satyr_purge_cd", "abilities/npc_satyr_purge", LUA_MODIFIER_MOTION_NONE)

npc_satyr_purge = class({})

function npc_satyr_purge:OnSpellStart()

    if not IsServer() then
        return
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_satyr_purge_cd", {duration = self:GetCooldownTimeRemaining()})

    if self:GetCursorTarget():TriggerSpellAbsorb( self ) then return end   

    self:GetCursorTarget():Purge(true, false, false, false, false)
    self:GetCursorTarget():EmitSound("n_creep_SatyrTrickster.Cast")
    local effect = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_purge.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCursorTarget())
    self:GetCursorTarget():AddNewModifier(self:GetCaster(), self, "modifier_satyr_slow", {duration = self:GetSpecialValueFor("duration")*(1 - self:GetCursorTarget():GetStatusResistance())})

end



modifier_satyr_slow = class({})

function modifier_satyr_slow:IsPurgable() return true end

function modifier_satyr_slow:IsHidden() return false end


function modifier_satyr_slow:OnCreated(table)
self.slow = -1*self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_satyr_slow:DeclareFunctions()

  return 
{

         MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
         MODIFIER_PROPERTY_TOOLTIP
}

end


 
function modifier_satyr_slow:OnTooltip() return self.slow end


function modifier_satyr_slow:GetModifierMoveSpeedBonus_Percentage() return self.slow end
  
modifier_satyr_purge_cd = class({})

function modifier_satyr_purge_cd:IsHidden() return false end
function modifier_satyr_purge_cd:IsPurgable() return false end