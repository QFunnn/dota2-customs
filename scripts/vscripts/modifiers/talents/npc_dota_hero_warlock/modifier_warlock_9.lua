--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_warlock_9=class({})

function modifier_warlock_9:IsHidden() return true end
function modifier_warlock_9:IsPurgable() return false end
function modifier_warlock_9:IsPurgeException() return false end
function modifier_warlock_9:RemoveOnDeath() return false end

function modifier_warlock_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("warlock_shadow_word_custom", "warlock_permanent_immolation_custom", false, true)
    local warlock_permanent_immolation_custom = self:GetCaster():FindAbilityByName("warlock_permanent_immolation_custom")
    if warlock_permanent_immolation_custom then
        Timers:CreateTimer(FrameTime(), function()
            warlock_permanent_immolation_custom:SetLevel(self:GetStackCount())
        end)
        warlock_permanent_immolation_custom:SetHidden(false)
    end
end

function modifier_warlock_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local warlock_permanent_immolation_custom = self:GetCaster():FindAbilityByName("warlock_permanent_immolation_custom")
    if warlock_permanent_immolation_custom then
        warlock_permanent_immolation_custom:SetLevel(self:GetStackCount())
        warlock_permanent_immolation_custom:SetHidden(false)
    end
end