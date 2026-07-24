--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_medusa_7=class({})

function modifier_medusa_7:IsHidden() return true end
function modifier_medusa_7:IsPurgable() return false end
function modifier_medusa_7:IsPurgeException() return false end
function modifier_medusa_7:RemoveOnDeath() return false end

function modifier_medusa_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_medusa_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_medusa_7:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE
    }
end

function modifier_medusa_7:GetModifierProcAttack_BonusDamage_Pure(params)
    if not IsServer() then return end
    ApplyDamage({victim = params.target, attacker = self:GetParent(), damage = self:GetParent():GetMaxHealth() / 100 * 0.7, damage_type = DAMAGE_TYPE_PURE})
    return 0
end