--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_warlock_10=class({})

function modifier_warlock_10:IsHidden() return true end
function modifier_warlock_10:IsPurgable() return false end
function modifier_warlock_10:IsPurgeException() return false end
function modifier_warlock_10:RemoveOnDeath() return false end

function modifier_warlock_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("warlock_upheaval_custom", "warlock_flaming_fists_custom", false, true)
    local warlock_flaming_fists_custom = self:GetCaster():FindAbilityByName("warlock_flaming_fists_custom")
    if warlock_flaming_fists_custom then
        Timers:CreateTimer(FrameTime(), function()
            warlock_flaming_fists_custom:SetLevel(self:GetStackCount())
        end)
        warlock_flaming_fists_custom:SetHidden(false)
    end
end

function modifier_warlock_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local warlock_flaming_fists_custom = self:GetCaster():FindAbilityByName("warlock_flaming_fists_custom")
    if warlock_flaming_fists_custom then
        warlock_flaming_fists_custom:SetLevel(self:GetStackCount())
        warlock_flaming_fists_custom:SetHidden(false)
    end
end