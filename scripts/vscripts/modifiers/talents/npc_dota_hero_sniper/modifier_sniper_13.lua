--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_sniper_13=class({})

function modifier_sniper_13:IsHidden() return true end
function modifier_sniper_13:IsPurgable() return false end
function modifier_sniper_13:IsPurgeException() return false end
function modifier_sniper_13:RemoveOnDeath() return false end

function modifier_sniper_13:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_sniper_13:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_sniper_13:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
    }
end

function modifier_sniper_13:GetActivityTranslationModifiers()
    if self:GetStackCount() == 3 then
        return "ultimate_scepter"
    end
end