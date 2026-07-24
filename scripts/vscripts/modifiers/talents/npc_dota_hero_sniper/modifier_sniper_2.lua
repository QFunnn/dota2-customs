--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_sniper_2=class({})

function modifier_sniper_2:IsHidden() return true end
function modifier_sniper_2:IsPurgable() return false end
function modifier_sniper_2:IsPurgeException() return false end
function modifier_sniper_2:RemoveOnDeath() return false end

function modifier_sniper_2:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_sniper_2:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_sniper_2:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BASE_OVERRIDE,
    }
end

function modifier_sniper_2:GetModifierAttackSpeedBaseOverride()
    return 1.5
end