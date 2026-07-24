--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_status_effect_thinker_custom = class({})
function modifier_status_effect_thinker_custom:IsHidden() return true end
function modifier_status_effect_thinker_custom:IsPurgable() return false end
function modifier_status_effect_thinker_custom:RemoveOnDeath() return false end
function modifier_status_effect_thinker_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_status_effect_thinker_custom:AddCustomTransmitterData() 
return 
{
    name = self.name, 
    priority = self.priority
}
end
function modifier_status_effect_thinker_custom:HandleCustomTransmitterData( data ) 
self.name = data.name 
self.priority = data.priority
end

function modifier_status_effect_thinker_custom:StatusEffectPriority() return self.priority end
function modifier_status_effect_thinker_custom:GetStatusEffectName() return self.name end

function modifier_status_effect_thinker_custom:OnCreated(params)
if not IsServer() then return end
self.name = params.name
self.priority = params.priority
self:SetHasCustomTransmitterData(true)
end