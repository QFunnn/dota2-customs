--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_invoker_mastermind_custom", "abilities/invoker/invoker_innate_custom", LUA_MODIFIER_MOTION_NONE )


invoker_innate_custom = class({})


function invoker_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_invoker_mastermind_custom"
end

function invoker_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_invoker.vsndevts", context )
PrecacheResource( "soundfile", "soundevents/vo_custom/invoker_vo_custom.vsndevts", context ) 
end



modifier_invoker_mastermind_custom = class({})
function modifier_invoker_mastermind_custom:IsHidden() return true end
function modifier_invoker_mastermind_custom:IsPurgable() return false end
function modifier_invoker_mastermind_custom:RemoveOnDeath() return false end
function modifier_invoker_mastermind_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.exp = self.ability:GetSpecialValueFor("exp")

end


function modifier_invoker_mastermind_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_EXP_RATE_BOOST,
}
end

function modifier_invoker_mastermind_custom:GetModifierPercentageExpRateBoost()
return self.exp
end