--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_nevermore_1=class({})

function modifier_nevermore_1:IsHidden() return false end
function modifier_nevermore_1:IsPurgable() return false end
function modifier_nevermore_1:IsPurgeException() return false end
function modifier_nevermore_1:RemoveOnDeath() return false end

function modifier_nevermore_1:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_nevermore_1:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_nevermore_1:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true
	}
end

function modifier_nevermore_1:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end

function modifier_nevermore_1:GetModifierIncomingDamage_Percentage()
	return -10
end

function modifier_nevermore_1:GetTexture()
	return "nevermore_1"
end