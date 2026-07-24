--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chaos_knight_7=class({})

function modifier_chaos_knight_7:IsHidden() return true end
function modifier_chaos_knight_7:IsPurgable() return false end
function modifier_chaos_knight_7:IsPurgeException() return false end
function modifier_chaos_knight_7:RemoveOnDeath() return false end

function modifier_chaos_knight_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():SwapAbilities("chaos_knight_phantasm_custom", "chaos_knight_chaos_walk", false, true)
    local chaos_knight_chaos_walk = self:GetParent():FindAbilityByName("chaos_knight_chaos_walk")
    if chaos_knight_chaos_walk then
        chaos_knight_chaos_walk:SetLevel(self:GetStackCount())
    end
    local chaos_knight_phantasm_custom = self:GetParent():FindAbilityByName("chaos_knight_phantasm_custom")
    if chaos_knight_phantasm_custom then
        chaos_knight_phantasm_custom:SetHidden(true)
        chaos_knight_phantasm_custom:SetActivated(false)
    end
end

function modifier_chaos_knight_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local chaos_knight_chaos_walk = self:GetParent():FindAbilityByName("chaos_knight_chaos_walk")
    if chaos_knight_chaos_walk then
        chaos_knight_chaos_walk:SetLevel(self:GetStackCount())
    end
end