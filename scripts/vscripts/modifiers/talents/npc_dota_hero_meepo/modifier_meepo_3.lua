--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_meepo_3=class({})

function modifier_meepo_3:IsHidden() return true end
function modifier_meepo_3:IsPurgable() return false end
function modifier_meepo_3:IsPurgeException() return false end
function modifier_meepo_3:RemoveOnDeath() return false end

function modifier_meepo_3:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:Swap("aghanim_shard", "aghanim_shard_charge")
end

function modifier_meepo_3:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_meepo_3:Swap(name1, name2)
	if not IsServer() then return end
	local ability1 = self:GetParent():FindAbilityByName(name1)
	local ability2 = self:GetParent():FindAbilityByName(name2)
	ability1:SetHidden(true)
	ability2:SetHidden(false)
	self:GetParent():SwapAbilities(name1, name2, false, true)
end