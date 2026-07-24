--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_legion_commander_8=class({})

function modifier_legion_commander_8:IsHidden() return true end
function modifier_legion_commander_8:IsPurgable() return false end
function modifier_legion_commander_8:IsPurgeException() return false end
function modifier_legion_commander_8:RemoveOnDeath() return false end

function modifier_legion_commander_8:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_legion_commander_8:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_legion_commander_8:DeclareFunctions()
	return {
		 
	}
end

function modifier_legion_commander_8:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	self:GetParent():GiveMana(10)
end