--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dazzle_16=class({})

function modifier_dazzle_16:IsHidden() return true end
function modifier_dazzle_16:IsPurgable() return false end
function modifier_dazzle_16:IsPurgeException() return false end
function modifier_dazzle_16:RemoveOnDeath() return false end

function modifier_dazzle_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    if self:GetParent():HasModifier("modifier_dazzle_1") then return end
	self:Swap("dazzle_shallow_grave_custom", "dazzle_healing_step")
	local dazzle_healing_step = self:GetCaster():FindAbilityByName("dazzle_healing_step")
	if dazzle_healing_step then
		dazzle_healing_step:SetLevel(self:GetStackCount())
	end
end

function modifier_dazzle_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    if self:GetParent():HasModifier("modifier_dazzle_1") then return end
	local dazzle_healing_step = self:GetCaster():FindAbilityByName("dazzle_healing_step")
	if dazzle_healing_step then
		dazzle_healing_step:SetLevel(self:GetStackCount())
	end
end

function modifier_dazzle_16:Swap(name1, name2)
	if not IsServer() then return end
	local ability1 = self:GetParent():FindAbilityByName(name1)
	local ability2 = self:GetParent():FindAbilityByName(name2)
	ability1:SetHidden(true)
	ability2:SetHidden(false)
	ability2:SetLevel(ability1:GetLevel())
	self:GetParent():SwapAbilities(name1, name2, false, true)
end