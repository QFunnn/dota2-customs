--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_juggernaut_13=class({})

function modifier_juggernaut_13:IsHidden() return true end
function modifier_juggernaut_13:IsPurgable() return false end
function modifier_juggernaut_13:IsPurgeException() return false end
function modifier_juggernaut_13:RemoveOnDeath() return false end

function modifier_juggernaut_13:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_juggernaut_13:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_juggernaut_13:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }
end

function modifier_juggernaut_13:GetModifierTotalDamageOutgoing_Percentage(params)
    local target = params.target
    local origin = target:GetAbsOrigin()
    local facing = false
    local vector = self:GetParent():GetOrigin() - origin
    local center_angle = VectorToAngles( vector ).y
    local facing_angle = VectorToAngles( target:GetForwardVector() ).y
    local distance = vector:Length2D()
    facing = ( math.abs( AngleDiff(center_angle,facing_angle) ) < 85 )
    if self:GetParent():HasModifier("modifier_juggernaut_omni_slash_custom") or facing then
        return 6
    end
end