--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_emblem = class({})
function modifier_woda_emblem:IsHidden() return true end
function modifier_woda_emblem:IsPurgable() return false end
function modifier_woda_emblem:RemoveOnDeath() return false end
function modifier_woda_emblem:AllowIllusionDuplicate() return true end
function modifier_woda_emblem:OnCreated(params)
	if not IsServer() then return end
    self.status_effect = params.status_effect
    self.effect_id = params.effect_id
    self:SetHasCustomTransmitterData(true)
end

function modifier_woda_emblem:AddCustomTransmitterData() 
    return 
    {
        status_effect = self.status_effect,
        effect_id = self.effect_id,
    }
end

function modifier_woda_emblem:HandleCustomTransmitterData( data ) 
    self.status_effect = data.status_effect 
    self.effect_id = data.effect_id
end

function modifier_woda_emblem:GetStatusEffectName() 
    return self.status_effect 
end

function modifier_woda_emblem:StatusEffectPriority() 
    return 10000
end