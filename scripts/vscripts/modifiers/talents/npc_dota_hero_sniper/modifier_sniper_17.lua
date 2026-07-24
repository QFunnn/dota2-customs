--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_sniper_17=class({})

function modifier_sniper_17:IsHidden() return true end
function modifier_sniper_17:IsPurgable() return false end
function modifier_sniper_17:IsPurgeException() return false end
function modifier_sniper_17:RemoveOnDeath() return false end

function modifier_sniper_17:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("sniper_headshot_custom", "sniper_flashbang_grenade", false, true)
    local sniper_flashbang_grenade = self:GetCaster():FindAbilityByName("sniper_flashbang_grenade")
    if sniper_flashbang_grenade then
        sniper_flashbang_grenade:SetLevel(self:GetStackCount())
        sniper_flashbang_grenade:SetHidden(false)
    end
end

function modifier_sniper_17:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local sniper_flashbang_grenade = self:GetCaster():FindAbilityByName("sniper_flashbang_grenade")
    if sniper_flashbang_grenade then
        sniper_flashbang_grenade:SetLevel(self:GetStackCount())
        sniper_flashbang_grenade:SetHidden(false)
    end
end

function modifier_sniper_17:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end

function modifier_sniper_17:GetModifierSpellAmplify_Percentage()
    if self:GetCaster():HasModifier("modifier_sniper_3") and self:GetCaster():HasModifier("modifier_sniper_10") and self:GetCaster():HasModifier("modifier_sniper_16") and self:GetCaster():HasModifier("modifier_sniper_17") then
        return 50
    end
end