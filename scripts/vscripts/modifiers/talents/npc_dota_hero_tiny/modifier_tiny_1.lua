--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tiny_1=class({})

function modifier_tiny_1:IsHidden() return true end
function modifier_tiny_1:IsPurgable() return false end
function modifier_tiny_1:IsPurgeException() return false end
function modifier_tiny_1:RemoveOnDeath() return false end

function modifier_tiny_1:OnCreated()
    self.bonus = 1
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_tiny_1:OnRefresh()
    self.bonus = 1
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_tiny_1:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_tiny_1:GetModifierPreAttack_BonusDamage()
    return self:GetCaster():GetMaxHealth() / 100 * self.bonus
end