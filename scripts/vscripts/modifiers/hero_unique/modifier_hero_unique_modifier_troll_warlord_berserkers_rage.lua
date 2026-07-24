--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_troll_warlord_berserkers_rage = class({})
function modifier_hero_unique_modifier_troll_warlord_berserkers_rage:IsHidden() return true end
function modifier_hero_unique_modifier_troll_warlord_berserkers_rage:IsPurgable() return false end
function modifier_hero_unique_modifier_troll_warlord_berserkers_rage:IsPurgeException() return false end
function modifier_hero_unique_modifier_troll_warlord_berserkers_rage:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_troll_warlord_berserkers_rage:OnCreated(params)
    self.parent = self:GetParent()
    self.ability = self:GetParent():FindAbilityByName("troll_warlord_switch_stance")
    if not IsServer() then return end
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_troll_warlord_berserkers_rage:OnIntervalThink()
    if not IsServer() then return end
    self.ability = self:GetParent():FindAbilityByName("troll_warlord_switch_stance")
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
        return
    end
    if self.ability:GetToggleState() then
        self:SetStackCount(25)
    else
        self:SetStackCount(0)
    end
    self:StartIntervalThink(0.1)
end

function modifier_hero_unique_modifier_troll_warlord_berserkers_rage:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
    }
end

function modifier_hero_unique_modifier_troll_warlord_berserkers_rage:GetModifierStatusResistanceStacking()
    return self:GetStackCount()
end