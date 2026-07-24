--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chaos_knight_21=class({})

function modifier_chaos_knight_21:IsHidden() return true end
function modifier_chaos_knight_21:IsPurgable() return false end
function modifier_chaos_knight_21:IsPurgeException() return false end
function modifier_chaos_knight_21:RemoveOnDeath() return false end

function modifier_chaos_knight_21:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():SwapAbilities("chaos_knight_phantasm_custom", "chaos_knight_berserk_eclipse", false, true)
    local chaos_knight_berserk_eclipse = self:GetParent():FindAbilityByName("chaos_knight_berserk_eclipse")
    if chaos_knight_berserk_eclipse then
        chaos_knight_berserk_eclipse:SetLevel(self:GetStackCount())
    end
    local chaos_knight_phantasm_custom = self:GetParent():FindAbilityByName("chaos_knight_phantasm_custom")
    if chaos_knight_phantasm_custom then
        chaos_knight_phantasm_custom:SetHidden(true)
        chaos_knight_phantasm_custom:SetActivated(false)
    end
end

function modifier_chaos_knight_21:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local chaos_knight_berserk_eclipse = self:GetParent():FindAbilityByName("chaos_knight_berserk_eclipse")
    if chaos_knight_berserk_eclipse then
        chaos_knight_berserk_eclipse:SetLevel(self:GetStackCount())
    end
end