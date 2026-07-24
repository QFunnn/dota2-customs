--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chaos_knight_19=class({})

function modifier_chaos_knight_19:IsHidden() return true end
function modifier_chaos_knight_19:IsPurgable() return false end
function modifier_chaos_knight_19:IsPurgeException() return false end
function modifier_chaos_knight_19:RemoveOnDeath() return false end

function modifier_chaos_knight_19:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local chaos_knight_chaos_strike_custom = self:GetParent():FindAbilityByName("chaos_knight_chaos_strike_custom")
    if chaos_knight_chaos_strike_custom then
        chaos_knight_chaos_strike_custom:SetLevel(0)
        chaos_knight_chaos_strike_custom:SetActivated(false)
    end
    self:GetParent():SwapAbilities("chaos_knight_chaos_strike_custom", "chaos_knight_chaos_king_bar", false, true)
    local chaos_knight_chaos_king_bar = self:GetParent():FindAbilityByName("chaos_knight_chaos_king_bar")
    if chaos_knight_chaos_king_bar then
        chaos_knight_chaos_king_bar:SetLevel(self:GetStackCount())
    end
end

function modifier_chaos_knight_19:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local chaos_knight_chaos_king_bar = self:GetParent():FindAbilityByName("chaos_knight_chaos_king_bar")
    if chaos_knight_chaos_king_bar then
        chaos_knight_chaos_king_bar:SetLevel(self:GetStackCount())
    end
end