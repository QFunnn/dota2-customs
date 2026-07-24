--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeletaura", "abilities/npc_skelet_aura.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeletaura_cd", "abilities/npc_skelet_aura.lua", LUA_MODIFIER_MOTION_NONE)



npc_skelet_aura = class({})


function npc_skelet_aura:Precache(context)
PrecacheResource( "particle", "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_hands_glow.vpcf", context )

end


function npc_skelet_aura:OnSpellStart()
if not IsServer() then return end

self:GetCaster():EmitSound("Hero_OgreMagi.Bloodlust.Target")
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_skeletaura", {duration = self:GetSpecialValueFor("duration")})
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_skeletaura_cd", {duration = self:GetCooldownTimeRemaining()})

end

modifier_skeletaura = class({})


function modifier_skeletaura:IsHidden() return false end

function modifier_skeletaura:IsPurgable() return true end

function modifier_skeletaura:OnCreated(table)

if not IsServer() then return end


local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
self:SetStackCount(#units)


self.effect_impact = ParticleManager:CreateParticle( "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_hands_glow.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent() )
ParticleManager:SetParticleControlEnt(self.effect_impact, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetParent():GetAbsOrigin(), true)
self:AddParticle(self.effect_impact, false, false, -1, false, false)

end

function modifier_skeletaura:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_MODEL_SCALE
    }
end
function modifier_skeletaura:GetModifierMoveSpeedBonus_Percentage() return self:GetAbility():GetSpecialValueFor("move")*self:GetStackCount()
 end
function modifier_skeletaura:GetModifierDamageOutgoing_Percentage() return self:GetAbility():GetSpecialValueFor("damage")*self:GetStackCount()
end
function modifier_skeletaura:GetModifierModelScale() return 40 end

 




modifier_skeletaura_cd = class({})

function modifier_skeletaura_cd:IsHidden() return false end
function modifier_skeletaura_cd:IsPurgable() return false end