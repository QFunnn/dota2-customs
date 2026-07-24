--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_medusa_16=class({})

function modifier_medusa_16:IsHidden() return true end
function modifier_medusa_16:IsPurgable() return false end
function modifier_medusa_16:IsPurgeException() return false end
function modifier_medusa_16:RemoveOnDeath() return false end

function modifier_medusa_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local medusa_split_shot_custom = self:GetParent():FindAbilityByName("medusa_split_shot_custom")
    if medusa_split_shot_custom then
        medusa_split_shot_custom:SetHidden(true)
        medusa_split_shot_custom:SetLevel(0)
        self:GetParent():RemoveModifierByName("modifier_medusa_split_shot_custom")
    end
end

function modifier_medusa_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_medusa_16:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_medusa_16:GetModifierPreAttack_BonusDamage()
    return self:GetParent():GetManaRegen() * 0.8
end