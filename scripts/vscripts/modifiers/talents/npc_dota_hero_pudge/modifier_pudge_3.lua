--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_pudge_3=class({})

function modifier_pudge_3:IsHidden() return true end
function modifier_pudge_3:IsPurgable() return false end
function modifier_pudge_3:IsPurgeException() return false end
function modifier_pudge_3:RemoveOnDeath() return false end

function modifier_pudge_3:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local pudge_rot_bomb = self:GetParent():FindAbilityByName("pudge_rot_bomb")
	if pudge_rot_bomb then
		pudge_rot_bomb:SetLevel(1)
		pudge_rot_bomb:SetHidden(false)
	end
end

function modifier_pudge_3:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end