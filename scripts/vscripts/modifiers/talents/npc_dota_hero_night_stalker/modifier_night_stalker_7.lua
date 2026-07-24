--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_night_stalker_7=class({})

function modifier_night_stalker_7:IsHidden() return true end
function modifier_night_stalker_7:IsPurgable() return false end
function modifier_night_stalker_7:IsPurgeException() return false end
function modifier_night_stalker_7:RemoveOnDeath() return false end

function modifier_night_stalker_7:OnCreated()
    self.crit_damage = 180
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_night_stalker_7:OnRefresh()
    self.crit_damage = 180
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_night_stalker_7:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE
    }
end

function modifier_night_stalker_7:GetModifierPreAttack_CriticalStrike( params )
    if not IsServer() then return end
    if RollPercentage(30) then
        return self.crit_damage
    end
end